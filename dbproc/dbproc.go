package dbproc

import (
	"database/sql"
	"fmt"
	"log"

	"celestia-data-collector/types"

	_ "github.com/go-sql-driver/mysql"
)

func InsertCoreBlock(row types.CoreBlocksRow) {
	// sql.DB 객체 생성
	db, err := sql.Open("mysql", "root:password@tcp(127.0.0.1:3306)/celestia-rollup-explorer")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// INSERT INTO member (NAME, price, cnt) VALUES ('kim', 1000, 0)
	// ON DUPLICATE KEY UPDATE
	// 	price = price * 2,
	// 	cnt = cnt + 1;
	// `id` int unsigned NOT NULL AUTO_INCREMENT,
	// `block_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	// `chain_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	// `height` bigint NOT NULL DEFAULT '0',
	// `time` varchar(64) NOT NULL DEFAULT '0',
	// `proposer_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	// `tx_cnt` int unsigned NOT NULL DEFAULT '0',
	// `blob_cnt` int unsigned NOT NULL DEFAULT '0',
	// `square_size` int unsigned NOT NULL DEFAULT '0',

	// create Prepared Statement
	stmt, err := db.Prepare(
		"INSERT INTO core_blocks (block_hash, chain_id, height, time, proposer_address, tx_cnt, blob_cnt, square_size) " +
			" VALUES (?,?,?,?,?,?,?,?)")
	checkError(err)
	defer stmt.Close()

	// exec Prepared Statement
	_, err = stmt.Exec(
		row.BlockHash,
		row.ChainId,
		row.Height,
		row.Time,
		row.ProposerAddress,
		row.TxCnt,
		row.BlobCnt,
		row.SquareSize) //Placeholder params
	checkError(err)
}

func InsertBlobs(row types.BlobsRow) {
	// sql.DB 객체 생성
	db, err := sql.Open("mysql", "root:password@tcp(127.0.0.1:3306)/celestia-rollup-explorer")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// create Prepared Statement
	stmt, err := db.Prepare("INSERT INTO blobs (nid_base64, nid, share_version, block_hash, chain_id, height, height_core, " +
		"time, version_app, version_block, validator_cnt, tx_cnt, blob_base64) " +
		"VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)")
	checkError(err)
	defer stmt.Close()

	// exec Prepared Statement
	_, err = stmt.Exec(
		row.NidBase64,
		row.Nid,
		row.ShareVersion,
		row.BlockHash,
		row.ChainId,
		row.Height,
		row.HeightCore,
		row.Time,
		row.VersionApp,
		row.VersionBlock,
		row.ValidatorCnt,
		row.TxCnt,
		row.BlobBase64) //Placeholder params
	checkError(err)
}

func InsertRollupTx(row types.RollupTxRow) {
	// sql.DB 객체 생성
	db, err := sql.Open("mysql", "root:password@tcp(127.0.0.1:3306)/celestia-rollup-explorer")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// create Prepared Statement
	stmt, err := db.Prepare("INSERT INTO rollup_txs (nid_base64, nid, chain_id, height, time, txhash, memo, " +
		"type_url, fee_amount, fee_gas_limit) " +
		"VALUES (?,?,?,?,?,?,?,?,?,?)")
	checkError(err)
	defer stmt.Close()

	// exec Prepared Statement
	_, err = stmt.Exec(
		row.NidBase64,
		row.Nid,
		row.ChainId,
		row.Height,
		row.Time,
		row.TxHash,
		row.Memo,
		row.TypeUrl,
		row.FeeAmount,
		row.FeeGasLimit) //Placeholder params
	checkError(err)
}

func GetLatestHeightFromDB() (height int64) {
	db, err := sql.Open("mysql", "root:password@tcp(127.0.0.1:3306)/celestia-rollup-explorer")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = db.QueryRow("SELECT max(height) FROM core_blocks").Scan(&height)
	checkError(err)
	return
}

func checkError(err error) {
	if err != nil {
		fmt.Println(err)
	}
}
