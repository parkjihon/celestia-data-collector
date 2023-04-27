package types

type CoreBlocksRow struct {
	//Id int `db:"id"`
	BlockHash       string `db:"block_hash"`
	ChainId         string `db:"chain_id"`
	Height          string `db:"height"`
	Time            string `db:"time"`
	ProposerAddress string `db:"proposer_address"`
	TxCnt           int    `db:"tx_cnt"`
	BlobCnt         int    `db:"blob_cnt"`
	SquareSize      string `db:"square_size"`
}

type BlobsRow struct {
	//Id int `db:"id"`
	NidBase64    string `db:"nid_base64"`
	Nid          string `db:"nid"`
	ShareVersion int64  `db:"share_version"`
	BlockHash    string `db:"block_hash"`
	ChainId      string `db:"chain_id"`
	Height       int64  `db:"height"`
	HeightCore   string `db:"height_core"`
	Time         int64  `db:"time"`
	VersionApp   uint64 `db:"version_app"`
	VersionBlock uint64 `db:"version_block"`
	ValidatorCnt int    `db:"validator_cnt"`
	TxCnt        int    `db:"tx_cnt"`
	BlobBase64   string `db:"blob_base64"`
}

type RollupTxRow struct {
	//Id int `db:"id"`
	NidBase64   string `db:"nid_base64"`
	Nid         string `db:"nid"`
	ChainId     string `db:"chain_id"`
	Height      int64  `db:"height"`
	TxHash      string `db:"txhash"`
	Time        int64  `db:"time"`
	Memo        string `db:"memo"`
	TypeUrl     string `db:"type_url"`
	FeeAmount   string `db:"fee_amount"`
	FeeGasLimit uint64 `db:"fee_gas_limit"`
}
