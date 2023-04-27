package parser

import (
	"encoding/json"
	"fmt"

	"celestia-data-collector/dbproc"
	"celestia-data-collector/types"
)

type CelestiaQueryBlock struct {
	Result struct {
		BlockId struct {
			Hash string `json:"hash"`
		} `json:"block_id"`
		Block struct {
			Header struct {
				ChainId string `json:"chain_id"`
				Height  string `json:"height"`
				Time    string `json:"time"`
				// some hashes
				ProposerAddress string `json:"proposer_address"`
			} `json:"header"`
			Data struct {
				Txs        []string `json:"txs"`
				Blobs      []Blob   `json:"blobs"`
				SquareSize string   `json:"square_size"`
			} `json:"Data"`
		} `json:"block"`
	} `json:"result"`
}

type Blob struct {
	NamespaceID  string `json:"NamespaceID"`
	Data         string `json:"Data"`
	ShareVersion int64  `json:"ShareVersion"`
}

func UnmarshalBlock(bBlock []byte) (out CelestiaQueryBlock) {
	//fmt.Printf("%s\n", string(data))
	json.Unmarshal(bBlock, &out)

	return out
}

func BlockParser(sData CelestiaQueryBlock) {
	//fmt.Printf("========== BlockParser triggered ============\n")
	var row types.CoreBlocksRow
	row.BlockHash = sData.Result.BlockId.Hash
	row.ChainId = sData.Result.Block.Header.ChainId
	row.Height = sData.Result.Block.Header.Height
	row.Time = sData.Result.Block.Header.Time
	row.ProposerAddress = sData.Result.Block.Header.ProposerAddress
	row.TxCnt = len(sData.Result.Block.Data.Txs)
	row.BlobCnt = len(sData.Result.Block.Data.Blobs)
	row.SquareSize = sData.Result.Block.Data.SquareSize

	fmt.Printf("Height: %v, TX: %v, BLOB: %v\n", row.Height, row.TxCnt, row.BlobCnt)
	dbproc.InsertCoreBlock(row)
}
