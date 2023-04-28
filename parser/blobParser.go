package parser

import (
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"fmt"

	"celestia-data-collector/dbproc"
	mytypes "celestia-data-collector/types"

	"github.com/cosmos/cosmos-sdk/types/tx"
	"github.com/rollkit/rollkit/types"
)

func BlobParser(sBlob Blob, strCoreHeight string) {
	mshdBlob := sBlob.Data
	decodedMshdBlob, err := base64.StdEncoding.DecodeString(mshdBlob)
	if err != nil {
		fmt.Println(err)
		return
	}
	if len(mshdBlob) < 512 {
		fmt.Println("decodedMshdBlob []byte length < 512. ", len(mshdBlob))
		return
	}
	// Height: 153061, TX: 1, BLOB: 1
	// github.com/rollkit/rollkit@v0.7.4/types/serialization.go:27
	// panic: runtime error: invalid memory address or nil pointer dereference
	var block types.Block
	err = block.UnmarshalBinary(decodedMshdBlob)
	if err != nil {
		fmt.Println(err)
		return
	}

	// fmt.Println(sBlob.NamespaceID)
	// decodedNID, err := base64.StdEncoding.DecodeString(sBlob.NamespaceID)
	// fmt.Println(hex.EncodeToString(decodedNID))
	// fmt.Println(sBlob.ShareVersion)

	// fmt.Println(block.SignedHeader.Hash().String())
	// fmt.Println(block.SignedHeader.AggregatorsHash.String())
	// fmt.Println(block.SignedHeader.AppHash.String())
	// fmt.Println(block.SignedHeader.ChainID())
	// fmt.Println(block.SignedHeader.ConsensusHash.String())
	// fmt.Println(block.SignedHeader.DataHash.String())
	// fmt.Println(block.SignedHeader.Height())
	// fmt.Println(block.SignedHeader.LastCommitHash.String())
	// fmt.Println(block.SignedHeader.LastHeaderHash.String())
	// fmt.Println(block.SignedHeader.Time().Unix())
	// fmt.Println(block.SignedHeader.Validators.GetProposer().Address)
	// fmt.Println(len(block.SignedHeader.Validators.Validators))
	// fmt.Println(block.SignedHeader.Version.App)
	// fmt.Println(block.SignedHeader.Version.Block)

	// txs := block.Data.ToProto().GetTxs()
	// fmt.Println(len(txs))
	// fmt.Println(strCoreHeight)
	var row mytypes.BlobsRow
	row.BlockHash = block.SignedHeader.Hash().String()
	row.ChainId = block.SignedHeader.ChainID()
	row.Height = block.SignedHeader.Height()
	row.HeightCore = strCoreHeight
	decodedNID, err := base64.StdEncoding.DecodeString(sBlob.NamespaceID)
	row.Nid = hex.EncodeToString(decodedNID)
	row.NidBase64 = sBlob.NamespaceID
	row.ShareVersion = sBlob.ShareVersion
	row.Time = block.SignedHeader.Time().Unix()
	txs := block.Data.ToProto().GetTxs()
	row.TxCnt = len(txs)
	if block.SignedHeader.Validators.IsNilOrEmpty() {
		row.ValidatorCnt = 0
	} else {
		row.ValidatorCnt = len(block.SignedHeader.Validators.Validators)
	}
	row.VersionApp = block.SignedHeader.Version.App
	row.VersionBlock = block.SignedHeader.Version.Block
	row.BlobBase64 = mshdBlob
	//fmt.Println(mshdBlob)
	//fmt.Println(len(mshdBlob))

	dbproc.InsertBlobs(row)

	return
}

func TxsParser(sBlob Blob, strCoreHeight string) {
	mshdBlob := sBlob.Data
	decodedMshdBlob, err := base64.StdEncoding.DecodeString(mshdBlob)
	if err != nil {
		fmt.Println(err)
		return
	}
	if len(mshdBlob) < 512 {
		fmt.Println("decodedMshdBlob []byte length < 512")
		return
	}
	var block types.Block
	err = block.UnmarshalBinary(decodedMshdBlob)
	if err != nil {
		fmt.Println(err)
		return
	}

	txs := block.Data.ToProto().GetTxs()
	decodedNID, err := base64.StdEncoding.DecodeString(sBlob.NamespaceID)

	for _, txData := range txs {
		fmt.Println("============================ tx ============================")
		//nid, Height, Chain Id, txHash, (Status), Time, Fee, Gas, Memo, Message
		//fmt.Println(block.SignedHeader.ChainID())
		//fmt.Println(block.SignedHeader.Height())
		//fmt.Println(hex.EncodeToString(decodedNID))
		//fmt.Println(sBlob.NamespaceID)
		//fmt.Println(block.SignedHeader.Time().Unix())
		var row mytypes.RollupTxRow
		row.ChainId = block.SignedHeader.ChainID()
		row.Height = block.SignedHeader.Height()
		row.Nid = hex.EncodeToString(decodedNID)
		row.NidBase64 = sBlob.NamespaceID
		row.Time = block.SignedHeader.Time().Unix()

		h := sha256.New()
		h.Write(txData)
		bs := hex.EncodeToString(h.Sum(nil))
		//fmt.Printf(bs)
		row.TxHash = bs

		var txRaw tx.TxRaw
		err := txRaw.Unmarshal(txData)

		var txBody tx.TxBody
		err = txBody.Unmarshal(txRaw.BodyBytes)
		//fmt.Println(txBody.GetMemo())
		row.Memo = txBody.GetMemo()

		msgs := txBody.GetMessages()
		for _, msg := range msgs {
			//fmt.Println(msg.GetValue())
			fmt.Println(msg.GetTypeUrl())
			row.TypeUrl = msg.GetTypeUrl()
		}

		var txAuth tx.AuthInfo
		err = txAuth.Unmarshal(txRaw.AuthInfoBytes)
		if err != nil {
			fmt.Println(err)
			continue
		}
		//fmt.Println(txAuth.GetFee().GetAmount())
		//fmt.Println(txAuth.GetFee().GetGasLimit())
		row.FeeAmount = txAuth.GetFee().GetAmount().String()
		row.FeeGasLimit = txAuth.GetFee().GetGasLimit()
		// fmt.Println(txAuth.GetSignerInfos())
		// signerinfos := txAuth.SignerInfos
		// for _, signerinfo := range signerinfos {
		// 	signerinfo.GetPublicKey()
		// }
		dbproc.InsertRollupTx(row)
	}
	return
}
