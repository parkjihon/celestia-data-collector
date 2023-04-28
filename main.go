package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strconv"
	"time"

	"celestia-data-collector/dbproc"
	parser "celestia-data-collector/parser"
)

const (
	CHECK_LATEST_HEIGHT_INTERVAL = 1000
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("You should choose 'recover [start-height] [end-height]' or 'start'")
		return
	}
	if os.Args[1] == "recover" {
		if len(os.Args) < 4 {
			fmt.Println("please select start&end height")
			return
		}
		cnt, err := strconv.Atoi(os.Args[2])
		if err != nil {
			fmt.Println(err)
			return
		}
		cnt_max, err := strconv.Atoi(os.Args[3])
		if err != nil {
			fmt.Println(err)
			return
		}
		for {
			// GET request
			resp, err := http.Get("http://54.200.185.48:26657/block?height=" + strconv.Itoa(cnt))
			if err != nil {
				fmt.Println(err)
			}

			defer resp.Body.Close()

			// print result
			data, err := ioutil.ReadAll(resp.Body)
			if err != nil {
				fmt.Println(err)
			}

			// store 'block' of celestia-app
			sQueryBlockResult := parser.UnmarshalBlock(data)
			parser.BlockParser(sQueryBlockResult)

			for _, blob := range sQueryBlockResult.Result.Block.Data.Blobs {
				//fmt.Printf("================= %s ==============\n", sQueryBlockResult.Result.Block.Header.Height)
				// store each 'blobs' of target block
				parser.BlobParser(blob, sQueryBlockResult.Result.Block.Header.Height)

				// blob is a block of a certain dApp, so blob.Data need to be seperated to extract Transactions of dApp.
				// store each 'transactions' of target dApp at certain block.
				parser.TxsParser(blob, sQueryBlockResult.Result.Block.Header.Height)
			}
			cnt++
			if cnt > cnt_max {
				time.Sleep(time.Second)
				return
			}
			//time.Sleep(time.Second)
		} // end for statement
	} else {
		// get latest core-height stored in db
		height := dbproc.GetLatestHeightFromDB()
		fmt.Println("LATEST HEIGHT STORED IN DB: ", height)

		curHeight := 0
		prevHeight := 0
		for {
			// GET request
			resp, err := http.Get("http://54.200.185.48:26657/block")
			if err != nil {
				fmt.Println(err)
			}
			defer resp.Body.Close()

			// print result
			data, err := ioutil.ReadAll(resp.Body)
			if err != nil {
				fmt.Println(err)
			}

			sQueryBlockResult := parser.UnmarshalBlock(data)
			curHeight, err = strconv.Atoi(sQueryBlockResult.Result.Block.Header.Height)
			if err != nil {
				fmt.Println(err)
			}
			if curHeight == prevHeight {
				time.Sleep(time.Millisecond * CHECK_LATEST_HEIGHT_INTERVAL)
				continue
			}
			prevHeight = curHeight

			// store 'block' of celestia-app
			parser.BlockParser(sQueryBlockResult)

			for _, blob := range sQueryBlockResult.Result.Block.Data.Blobs {
				//fmt.Printf("================= %s ==============\n", sQueryBlockResult.Result.Block.Header.Height)
				// store each 'blobs' of target block
				parser.BlobParser(blob, sQueryBlockResult.Result.Block.Header.Height)

				// blob is a block of a certain dApp, so blob.Data need to be seperated to extract Transactions of dApp.
				// store each 'transactions' of target dApp at certain block.
				parser.TxsParser(blob, sQueryBlockResult.Result.Block.Header.Height)
			}
		} // end for statement
	} // end if os.Args[1] == "recover"
}
