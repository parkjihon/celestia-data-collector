/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `celestia-rollup-explorer` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `celestia-rollup-explorer`;

CREATE TABLE IF NOT EXISTS `core_blocks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `block_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chain_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `height` bigint NOT NULL DEFAULT '0',
  `time` varchar(64) NOT NULL DEFAULT '0',
  `proposer_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tx_cnt` int unsigned NOT NULL DEFAULT '0',
  `blob_cnt` int unsigned NOT NULL DEFAULT '0',
  `square_size` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `height` (`height`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `blobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nid_base64` varchar(16) NOT NULL DEFAULT '',
  `nid` varchar(16) NOT NULL DEFAULT '',
  `share_version` int unsigned DEFAULT null,
  `block_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chain_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `height` bigint NOT NULL DEFAULT '0',
  `height_core` bigint NOT NULL DEFAULT '0',
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `version_app` int unsigned NOT NULL DEFAULT '0',
  `version_block` int unsigned NOT NULL DEFAULT '0',
  `validator_cnt` int unsigned NOT NULL DEFAULT '0',
  `tx_cnt` int unsigned NOT NULL DEFAULT '0',
  `blob_base64` varchar(4096) COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nid_height` (`nid`, `height`),
  KEY `nid` (`nid`),
  KEY `block_hash` (`block_hash`),
  KEY `height_core` (`height_core`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `rollup_txs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nid_base64` varchar(16) NOT NULL DEFAULT '',
  `nid` varchar(16) NOT NULL DEFAULT '',
  `chain_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `height` bigint(20) unsigned NOT NULL,
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `txhash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `memo` tinytext COLLATE utf8mb4_unicode_ci,
  `type_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fee_amount` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fee_gas_limit` int unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `txhash` (`txhash`),
  KEY `nid` (`nid`),
  KEY `nid_height` (`nid`,`height`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;





CREATE TABLE IF NOT EXISTS `account` (
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hex_addr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_ts` bigint NOT NULL DEFAULT '0',
  `admin_memo` tinytext COLLATE utf8mb4_unicode_ci,
  `admin_alias` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_ts` bigint DEFAULT NULL,
  PRIMARY KEY (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `account_tag` (
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`account`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `address_mapping` (
  `crescent_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cosmos_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`crescent_address`), 
  KEY `cosmos_address` (`cosmos_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `airdrop_claimed` (
  `owner` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `airdrop_id` int NOT NULL DEFAULT '1',
  `initial_claimable_coins` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `claimable_coins` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `claimed_conditions` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `height` bigint NOT NULL DEFAULT '0',
  `timestamp` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `airdrop_claimed_recover` (
  `owner` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `airdrop_id` int NOT NULL DEFAULT '1',
  `initial_claimable_coins` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `claimable_coins` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `claimed_conditions` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `height` bigint NOT NULL DEFAULT '0',
  `timestamp` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `airdrop_result` (
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dex_claimable_amount` decimal(30,6) NOT NULL,
  `boost_claimable_amount` decimal(30,6) NOT NULL,
  `claimable_score` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `delegation_amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deposit_multiplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `swap_multiplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `vote_multiplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`address`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `balance` (
  `hex_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(40,0) NOT NULL DEFAULT '0',
  `update_height` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`hex_addr`,`denom`) USING BTREE,
  KEY `FK_54` (`hex_addr`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `balance_recover` (
  `hex_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(40,0) NOT NULL DEFAULT '0',
  `update_height` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`hex_addr`,`denom`) USING BTREE,
  KEY `FK_54` (`hex_addr`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `chain` (
  `chain_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_nm` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `chain_logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ibc_send_ch` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ibc_recv_ch` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exponent` int NOT NULL,
  `derivation_path` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bech32_prefix_acc` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bech32_config` json DEFAULT NULL,
  `ws_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ws_endpoint_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grpc_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `grpc_endpoint_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rest_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rest_endpoint_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disabled` int unsigned NOT NULL,
  `coin_type` int NOT NULL DEFAULT '118',
  `gas_price_step_json` json DEFAULT NULL,
  `currencies` json DEFAULT NULL,
  `fee_currencies` json DEFAULT NULL,
  `stake_currency` json DEFAULT NULL,
  `features` json DEFAULT NULL,
  PRIMARY KEY (`chain_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `chart_data` (
  `uid` bigint NOT NULL AUTO_INCREMENT,
  `pair_id` bigint NOT NULL,
  `resolution` varchar(5) NOT NULL,
  `ts_sec` bigint NOT NULL,
  `update_ts_sec` bigint NOT NULL,
  `h` double NOT NULL DEFAULT '0',
  `l` double NOT NULL DEFAULT '0',
  `c` double NOT NULL DEFAULT '0',
  `o` double NOT NULL DEFAULT '0',
  `v` double unsigned NOT NULL DEFAULT '0',
  `cnt` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `unique_key` (`pair_id`,`resolution`,`ts_sec`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS `chart_init_pair`(
	IN `pair_id` BIGINT
)
    COMMENT 'add lastest bar for new pair. price is initialized with pairs lastprice'
BEGIN
DECLARE Price DECIMAL(40,18);
SELECT P.last_price INTO Price FROM pair P WHERE P.pair_id=pair_id;

IF NOT isnull(Price) AND Price != 0.0 THEN
  CALL chart_insert(pair_id, UNIX_TIMESTAMP(), Price, Price, 0);
End IF;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `chart_insert`(
	IN `pair_id` BIGINT,
	IN `ts_sec` BIGINT,
	IN `C` DOUBLE,
	IN `O` DOUBLE,
	IN `last_ts_sec` BIGINT
)
    COMMENT 'called if new 1m bar open'
BEGIN
DECLARE WeekdayIdx INT;
DECLARE DayIdx INT;
DECLARE LastSunday DATE;
DECLARE FirstDay DATE;
DECLARE H DOUBLE;
DECLARE L DOUBLE;
DECLARE CNT INT;

SET H = GREATEST(O,C);
SET L = LEAST(O,C);

SET WeekdayIdx = DAYOFWEEK(FROM_UNIXTIME(ts_sec)) - 1;
SET DayIdx = DAYOFMONTH(FROM_UNIXTIME(ts_sec));

SET LastSunday = DATE_SUB(FROM_UNIXTIME(ts_sec), INTERVAL WeekdayIdx DAY );
SET FirstDay = DATE_SUB(FROM_UNIXTIME(ts_sec), INTERVAL DayIdx DAY );

SELECT COUNT(*) INTO CNT FROM chart_data WHERE pair_id=pair_id and resolution="1D" and ts_sec=(floor(ts_sec / 86400 ) * 86400);

INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "1", (floor(ts_sec /60)*60) , ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
IF MOD(ts_sec,300)=0 OR ts_sec - last_ts_sec >= 300 THEN 
	INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "5", (floor(ts_sec / 300 ) * 300), ts_sec,O,H,L,C) ON DUPLICATE  KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
	IF MOD(ts_sec,1800)=0 OR ts_sec - last_ts_sec >= 1800 THEN 
		INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "30", (floor(ts_sec / 1800 ) * 1800), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
		IF MOD(ts_sec,3600)=0 OR ts_sec - last_ts_sec >= 3600 THEN 
			INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "60", (floor(ts_sec / 3600 ) * 3600), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
			IF MOD(ts_sec,14400) OR ts_sec - last_ts_sec >= 14400 THEN 			
				INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "240",  (floor(ts_sec / 14400) * 14400), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
					IF MOD(ts_sec,86400) OR ts_sec - last_ts_sec >= 86400 THEN 
						INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "1D",(floor(ts_sec / 86400 ) * 86400), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
						IF UNIX_TIMESTAMP(LastSunday) >= last_ts_sec THEN
							INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "1W",  UNIX_TIMESTAMP(LastSunday), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
						END IF;						
						IF UNIX_TIMESTAMP(FirstDay) >= last_ts_sec THEN
							INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "1M",  UNIX_TIMESTAMP(FirstDay), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
						END IF;												
					END IF;												
			END IF;
		END IF;
	END IF;
END IF;

IF CNT = 0 THEN
	INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "5", (floor(ts_sec / 300 ) * 300), ts_sec,O,H,L,C) ON DUPLICATE  KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
	INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "30", (floor(ts_sec / 1800 ) * 1800), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
	INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "60", (floor(ts_sec / 3600 ) * 3600), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
	INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "240",  (floor(ts_sec / 14400) * 14400), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
	INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "1D",(floor(ts_sec / 86400 ) * 86400), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
	INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "1W",  UNIX_TIMESTAMP(LastSunday), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
	INSERT INTO chart_data (`pair_id`,`resolution`,`ts_sec`, `update_ts_sec`,`o`,`h`,`l`,`c`) VALUES (pair_id, "1M",  UNIX_TIMESTAMP(FirstDay), ts_sec,O,H,L,C) ON DUPLICATE KEY UPDATE `update_ts_sec`=VALUES(`update_ts_sec`);
END IF;	
END//
DELIMITER ;
CREATE TABLE IF NOT EXISTS `config` (
  `conf_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conf_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `update_ts` bigint NOT NULL DEFAULT '0',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`conf_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `config_default` (
  `conf_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conf_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_ts` bigint unsigned DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`conf_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `delegations_all` (
  `delegator_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `validator_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `delegator_shares` decimal(40,18) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `denom` (
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `chain_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticker_nm` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ibc_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT '0',
  `exponent` int NOT NULL DEFAULT '6',
  PRIMARY KEY (`denom`),
  KEY `FK_166` (`chain_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `denom_chains` (
  `cre_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `chain_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ibc_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `disabled` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`cre_denom`,`chain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `denom_price` (
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `price_oracle` double unsigned DEFAULT NULL,
  `update_ts` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `denom_price_time_series` (
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `height` bigint NOT NULL DEFAULT '0',
  `price_oracle` double unsigned NOT NULL DEFAULT '0',
  `timestamp_ty` timestamp,
  PRIMARY KEY (`denom`,`height`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `farm_current_reward` (
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reward_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `epoch` bigint NOT NULL DEFAULT '0',
  `reward_diff` decimal(40,18) NOT NULL DEFAULT '0.000000000000000000',
  `rewarded_total_stake` decimal(40,0) NOT NULL DEFAULT '0',
  `rewarded_oracle_price` double NOT NULL DEFAULT '0',
  `update_height` bigint NOT NULL DEFAULT '0',
  `update_ts` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`denom`,`reward_denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `farm_historical_reward` (
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'noname',
  `reward_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reward_amount` decimal(40,18) NOT NULL DEFAULT '0.000000000000000000',
  `epoch` bigint NOT NULL,
  `update_height` bigint NOT NULL,
  `update_ts` bigint NOT NULL,
  `rewarded_oracle_price` double NOT NULL DEFAULT '0',
  `reward_diff` decimal(40,18) DEFAULT '0.000000000000000000',
  `ts_diff` bigint DEFAULT '0',
  `rewarded_total_stake` decimal(40,0) DEFAULT '0',
  PRIMARY KEY (`denom`,`reward_denom`,`epoch`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `farm_plan` (
  `plan_id` bigint unsigned NOT NULL DEFAULT '0',
  `pool_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reward_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reward_amount` decimal(40,0) DEFAULT NULL,
  `farming_pool_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `termination_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `plan_type` int NOT NULL DEFAULT '0',
  `start_timestamp` bigint NOT NULL DEFAULT '0',
  `end_timestamp` bigint NOT NULL DEFAULT '0',
  `last_dist_timestamp` bigint DEFAULT NULL,
  `terminated` int NOT NULL DEFAULT '0',
  `height` bigint DEFAULT NULL,
  `insufficient` int DEFAULT '0',
  PRIMARY KEY (`plan_id`,`pool_denom`,`reward_denom`),
  KEY `start_datetime` (`start_timestamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
DELIMITER //
CREATE PROCEDURE `farm_plan_balance_check`()
    COMMENT 'check if farming pool has enough rewards'
BEGIN
UPDATE
	farm_plan as farm_planDB,
	(SELECT P.plan_id, P.reward_denom, IF( SUM(P.reward_amount) <= IFNULL(B.amount,0), 0, 1 ) AS insufficient 
	 FROM farm_plan P Left join account A ON A.address = P.farming_pool_addr LEFT JOIN balance B ON A.hex_addr=B.hex_addr AND B.denom = P.reward_denom 
	 WHERE P.plan_type=2 AND P.`terminated`=0 GROUP BY plan_id, reward_denom) N
SET
	farm_planDB.insufficient = N.insufficient
WHERE farm_planDB.plan_id = N.plan_id AND farm_planDB.reward_denom = N.reward_denom;

UPDATE
	farm_plan as farm_planDB,
	(SELECT P.plan_id, MAX(P.insufficient) as max_amt FROM farm_plan P WHERE P.plan_type=2 AND P.`terminated`=0 GROUP BY P.plan_id) N
SET farm_planDB.insufficient = N.max_amt
WHERE farm_planDB.plan_id = N.plan_id;

END//
DELIMITER ;
CREATE TABLE IF NOT EXISTS `farm_reward_dist` (
  `dist_uid` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pool_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `dist_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dist_amount` decimal(40,0) NOT NULL DEFAULT '0',
  `height` bigint(20) NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL,
  PRIMARY KEY (`dist_uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS `farm_staking` (
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_epoch` bigint(20) NOT NULL DEFAULT '0',
  `amount` decimal(40,0) NOT NULL DEFAULT '0',
  `queue_amount` decimal(40,0) NOT NULL DEFAULT '0',
  `update_height` bigint(20) NOT NULL DEFAULT '0',
  `update_ts` bigint(20) NOT NULL,
  PRIMARY KEY (`owner`,`denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `farm_staking_recover` (
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_epoch` bigint(20) NOT NULL DEFAULT '0',
  `amount` decimal(30,0) NOT NULL DEFAULT '0',
  `queue_amount` decimal(30,0) NOT NULL DEFAULT '0',
  `update_height` bigint(20) NOT NULL DEFAULT '0',
  `update_ts` bigint(20) NOT NULL,
  PRIMARY KEY (`owner`,`denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS `farm_staking_total` (
  `denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(40,0) NOT NULL DEFAULT '0',
  `update_height` bigint(20) NOT NULL,
  `update_ts` bigint(20) NOT NULL,
  `reserve_hex_addr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`denom`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS `farm_unharvest_reward` (
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pool_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reward_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reward_amount` decimal(40,0) NOT NULL DEFAULT '0',
  `height` bigint(20) NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`owner`,`pool_denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `farm_unharvest_reward_recover` (
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pool_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reward_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reward_amount` decimal(40,0) NOT NULL DEFAULT '0',
  `height` bigint NOT NULL DEFAULT '0',
  `timestamp` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`owner`,`pool_denom`,`reward_denom`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `google_certs` (
  `kid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `e` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `n` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `gov_proposal` (
  `proposal_id` int(11) NOT NULL,
  `proposal_obj` json DEFAULT NULL,
  `tally_obj` json DEFAULT NULL,
  `proposer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `proposal_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `height` bigint(20) NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL DEFAULT '0',
  `deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`proposal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `gov_vote` (
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `proposal_id` bigint(20) unsigned NOT NULL,
  `vote_option` json NOT NULL,
  `height` bigint(20) unsigned NOT NULL DEFAULT '0',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`owner`,`proposal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/* If active ts is 0, the farm is disabled */
CREATE TABLE IF NOT EXISTS `liquid_farm` (
  `pool_id` bigint NOT NULL,
  `pool_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lf_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_deposit_amount` decimal(54,0) unsigned NOT NULL DEFAULT '0',
  `min_bid_amount` decimal(54,0) unsigned NOT NULL DEFAULT '0',
  `fee_rate` decimal(36,18) unsigned NOT NULL DEFAULT '0.0',
  `farming_addr` varchar(255) DEFAULT NULL,
  `active_ts` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`pool_id`),
  KEY (`pool_denom`),
  KEY (`lf_denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `liquid_farm_auction` (
  `pool_id` bigint NOT NULL,
  `auction_id` bigint NOT NULL,
  `bid_coin_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `pay_reserve_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `start_ts` bigint NOT NULL,
  `end_ts` bigint NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `winning_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `winning_amount` decimal(40,0) unsigned NOT NULL,
  `fee_rate` decimal(24,18) unsigned NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`pool_id`,`auction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `liquid_farm_auction_fee` (
  `pool_id` bigint NOT NULL DEFAULT '0',
  `auction_id` bigint NOT NULL,
  `fee_denom` varchar(255) NOT NULL,
  `fee_amount` decimal(40,0) unsigned NOT NULL,
  PRIMARY KEY (`pool_id`,`auction_id`,`fee_denom`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `liquid_farm_auction_reward` (
  `pool_id` bigint NOT NULL DEFAULT '0',
  `auction_id` bigint NOT NULL,
  `reward_denom` varchar(255) NOT NULL,
  `reward_amount` decimal(40,0) unsigned NOT NULL,
  PRIMARY KEY (`pool_id`,`auction_id`,`reward_denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `liquid_farm_auction_reward_history` (
  `pool_id` int NOT NULL,
  `auction_id` int NOT NULL,
  `bidding_value` decimal(45,12) NOT NULL,
  `reward_value` decimal(45,12) NOT NULL,
  PRIMARY KEY (`pool_id`,`auction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `liquid_farm_compound_reward` (
  `pool_id` bigint NOT NULL,
  `amount` decimal(45,0) unsigned NOT NULL,
  `update_height` bigint DEFAULT NULL,
  `update_ts` bigint DEFAULT NULL,
  PRIMARY KEY (`pool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `liquid_farm_compound_reward_recover` (
  `pool_id` bigint NOT NULL,
  `amount` decimal(45,0) unsigned NOT NULL,
  `update_height` bigint DEFAULT NULL,
  `update_ts` bigint DEFAULT NULL,
  PRIMARY KEY (`pool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `liquid_farm_historical_adjust` (
  `pool_id` bigint NOT NULL,
  `auction_cnt` bigint NOT NULL DEFAULT '0',
  `avg_percent` decimal(20,6) NOT NULL DEFAULT '1.000000',
  `update_ts` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`pool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `liquid_staking` (
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(40,0) NOT NULL,
  `bonded_amount` decimal(40,0) NOT NULL,
  `height` bigint unsigned NOT NULL DEFAULT '0',
  `timestamp` bigint unsigned NOT NULL DEFAULT '0',
  `txhash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`owner`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `liquid_unstaking` (
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unbonding_amount` decimal(40,0) NOT NULL DEFAULT '0',
  `amount` decimal(40,0) NOT NULL,
  `complete_ts_sec` bigint NOT NULL DEFAULT '0',
  `height` bigint unsigned NOT NULL,
  `timestamp` bigint unsigned NOT NULL,
  `txhash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`owner`,`complete_ts_sec`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lpfarm_farm` (
  `farm_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reward_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_farming_amount` decimal(45,0) NOT NULL DEFAULT '0',
  `period` bigint NOT NULL DEFAULT '0',
  `reward_current_amt` decimal(63,18) NOT NULL DEFAULT '0',
  `reward_outstanding_amt` decimal(63,18) NOT NULL DEFAULT '0',
  `update_height` bigint NOT NULL DEFAULT '0',
  `update_ts` bigint NOT NULL DEFAULT '0',
  `pair_farming_ratio` decimal(20,12) NOT NULL DEFAULT '0.000000000000',
  PRIMARY KEY (`farm_denom`,`reward_denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lpfarm_farm_recover` (
  `farm_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reward_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_farming_amount` decimal(45,0) NOT NULL DEFAULT '0',
  `period` bigint NOT NULL DEFAULT '0',
  `reward_current_amt` decimal(63,18) NOT NULL DEFAULT '0',
  `reward_outstanding_amt` decimal(63,18) NOT NULL DEFAULT '0',
  `update_height` bigint NOT NULL DEFAULT '0',
  `update_ts` bigint NOT NULL DEFAULT '0',
  `pair_farming_ratio` decimal(20,12) NOT NULL DEFAULT '0.000000000000',
  PRIMARY KEY (`farm_denom`,`reward_denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lpfarm_historical_reward` (
  `denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'noname',
  `reward_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `period` bigint NOT NULL,
  `reward_amount` decimal(63,18) NOT NULL DEFAULT '0.000000000000000000',
  `update_height` bigint NOT NULL,
  `update_ts` bigint NOT NULL,
  PRIMARY KEY (`denom`,`reward_denom`,`period`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lpfarm_historical_reward_recover` (
  `denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'noname',
  `reward_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `period` bigint NOT NULL,
  `reward_amount` decimal(63,18) NOT NULL DEFAULT '0.000000000000000000',
  `update_height` bigint NOT NULL,
  `update_ts` bigint NOT NULL,
  PRIMARY KEY (`denom`,`reward_denom`,`period`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;






CREATE TABLE IF NOT EXISTS `lpfarm_plan` (
  `plan_id` bigint NOT NULL DEFAULT '0',
  `target_pair_id` bigint NOT NULL DEFAULT '0',
  `target_pool_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reward_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reward_amount_per_day` decimal(40,0) DEFAULT NULL,
  `farming_src_addr` varchar(255) NOT NULL DEFAULT '0',
  `termination_addr` varchar(255) NOT NULL DEFAULT '0',
  `start_ts` bigint NOT NULL DEFAULT '0',
  `end_ts` bigint NOT NULL DEFAULT '0',
  `private_yn` int NOT NULL DEFAULT '0',
  `terminated` int NOT NULL DEFAULT '0',
  `update_height` bigint NOT NULL DEFAULT '0',
  `insufficient` int(11) DEFAULT '0',  
  PRIMARY KEY (`plan_id`,`target_pair_id`,`target_pool_denom`,`reward_denom`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* defaule insufficient is 0. check only private plan */
DELIMITER //
CREATE PROCEDURE `lpfarm_plan_balance_check`()
BEGIN
UPDATE
	lpfarm_plan as farm_planDB,
	(SELECT P.plan_id, P.reward_denom, IF( SUM(P.reward_amount_per_day) <= IFNULL(B.amount,0), 0, 1 ) AS insufficient 
	 FROM lpfarm_plan P Left join account A ON A.address = P.farming_src_addr LEFT JOIN balance B ON A.hex_addr=B.hex_addr AND B.denom = P.reward_denom 
	 WHERE P.private_yn=1 AND P.`terminated`=0 GROUP BY plan_id, reward_denom) N
SET
	farm_planDB.insufficient = N.insufficient
WHERE farm_planDB.plan_id = N.plan_id AND farm_planDB.reward_denom = N.reward_denom;

UPDATE
	lpfarm_plan as farm_planDB,
	(SELECT P.plan_id, MAX(P.insufficient) as max_amt FROM lpfarm_plan P WHERE P.private_yn=1 AND P.`terminated`=0 GROUP BY P.plan_id) N
SET farm_planDB.insufficient = N.max_amt
WHERE farm_planDB.plan_id = N.plan_id;

END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `lpfarm_position` (
  `farmer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stake_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stake_amount` decimal(45,0) NOT NULL DEFAULT '0',
  `start_height` bigint NOT NULL DEFAULT '0',
  `previous_period` bigint unsigned NOT NULL DEFAULT '0',
  `update_height` bigint NOT NULL DEFAULT '0',
  `update_ts` bigint NOT NULL,
  PRIMARY KEY (`farmer`,`stake_denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `lpfarm_position_recover` (
  `farmer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stake_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stake_amount` decimal(45,0) NOT NULL DEFAULT '0',
  `start_height` bigint NOT NULL DEFAULT '0',
  `previous_period` bigint unsigned NOT NULL DEFAULT '0',
  `update_height` bigint NOT NULL DEFAULT '0',
  `update_ts` bigint NOT NULL,
  PRIMARY KEY (`farmer`,`stake_denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;





CREATE TABLE IF NOT EXISTS `lsv_event` (
  `eid` bigint NOT NULL AUTO_INCREMENT,
  `addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `height` bigint NOT NULL DEFAULT '0',
  `timestamp` bigint NOT NULL DEFAULT '0',
  `penalty_point` tinyint NOT NULL DEFAULT '0',
  `ref_warning_eid` bigint NOT NULL DEFAULT '0',
  `confirmed` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'n',
  `confirm_id` varchar(255) NOT NULL DEFAULT 'n',
  `confirmed_ts` bigint NOT NULL DEFAULT '0',
  `confirmed_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '-',
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'n',
  `json` json DEFAULT NULL,
  PRIMARY KEY (`eid`),
  KEY `addr_ts` (`addr`,`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `lsv_info` (
  `addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `valoper_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `valcons_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `start_height` bigint NOT NULL DEFAULT '0',
  `admin_lsv_start_ts` bigint DEFAULT '0',
  `admin_lsv_end_ts` bigint DEFAULT '0',
  `admin_lsv_active` bigint NOT NULL DEFAULT '0',
  `tombstoned` tinyint NOT NULL DEFAULT '0',
  `missing_block_counter` bigint DEFAULT '0',
  `del_shares` decimal(40,18) DEFAULT NULL,
  `tokens` decimal(30,0) DEFAULT NULL,
  `update_ts` bigint DEFAULT NULL,
  `jailed_height` bigint DEFAULT NULL,
  `jail_until_ts` bigint NOT NULL DEFAULT '0',
  `alias` varchar(50) DEFAULT NULL,
  `commission` decimal(26,18) DEFAULT NULL,
  `commission_update_ts` bigint DEFAULT NULL,
  `val_hex_addr` varchar(255) DEFAULT NULL,
  `pp_propose_cnt` bigint DEFAULT NULL,
  `pp_tx_cnt` bigint DEFAULT NULL,
  `pp_start_height` bigint DEFAULT NULL,
  `pp_commit_cnt` bigint DEFAULT NULL,
  `pp_end_height` bigint DEFAULT NULL,
  `pp_update_ts` bigint DEFAULT NULL,
  `pp_check_ts` bigint DEFAULT NULL,
  `last_commit_ts` bigint DEFAULT NULL,
  `index_height` bigint DEFAULT NULL,
  PRIMARY KEY (`addr`),
  UNIQUE KEY `valoper_addr` (`valoper_addr`),
  UNIQUE KEY `valcon_addr` (`valcons_addr`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `metric_record` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_str` varchar(50) NOT NULL DEFAULT '',
  `type_int` int(11) DEFAULT NULL,
  `var_str` varchar(5000) DEFAULT '',
  `var_int` bigint(20) DEFAULT NULL,
  `height` bigint(20) NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `type_time` (`type_str`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `pair` (
  `pair_id` bigint(20) NOT NULL,
  `base_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quote_denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `escrow_addr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_price` decimal(40,18) DEFAULT NULL,
  `current_batch` bigint(20) DEFAULT NULL,
  `whitelisted` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`pair_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `pair_orderbook` (
  `pair_id` bigint NOT NULL DEFAULT '0',
  `prec` int NOT NULL DEFAULT '3',
  `json` varchar(40000) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `timestamp` bigint NOT NULL,
  `base_price` decimal(40,18) DEFAULT NULL,
  PRIMARY KEY (`pair_id`,`prec`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `pool` (
  `pool_id` bigint unsigned NOT NULL DEFAULT '0',
  `pair_id` bigint unsigned NOT NULL DEFAULT '0',
  `reserve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pool_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `disabled` tinyint NOT NULL DEFAULT '0',
  `created_height` bigint NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '0',
  `staking_reserve_hex_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pool_type` int NOT NULL DEFAULT '0',
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_price` decimal(40,18) DEFAULT NULL,
  `max_price` decimal(40,18) DEFAULT NULL,
  /*`delayed_base_trans` decimal(45,18) NOT NULL DEFAULT '0.000000000000000000',
  `delayed_quote_trans` decimal(45,18) NOT NULL DEFAULT '0.000000000000000000',
  */
  PRIMARY KEY (`pool_id`),
  UNIQUE KEY `pool_denom` (`pool_denom`),
  KEY `pair_id` (`pair_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `pool_calc` (
	`denom` VARCHAR(255) NULL COLLATE 'utf8mb4_unicode_ci',
	`price_oracle` DOUBLE NULL,
	`apr` DOUBLE NULL,
	`rewards_per_day` JSON NULL
) ENGINE=MyISAM;

CREATE TABLE `pool_denom_price` (
	`pool_id` BIGINT(20) UNSIGNED NOT NULL,  
	`pool_denom` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`price_oracle` DOUBLE NULL,
	`bcre_amount` DOUBLE NULL,
	`bcre_price` DOUBLE NULL,
	`update_ts` BIGINT(20) UNSIGNED NULL
) ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS `pool_price` (
  `pool_id` bigint NOT NULL,
  `price` decimal(40,18) NOT NULL,
  `update_height` bigint NOT NULL DEFAULT '0',
  `update_ts` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`pool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `stat_account_top` (
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `usd_value` double NOT NULL DEFAULT '0',
  `balance_last_update` bigint NOT NULL DEFAULT '0',
  `update_timestamp` bigint NOT NULL DEFAULT '0',
  `update_height` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `stat_ibc_daily` (
  `start_timestamp` bigint NOT NULL DEFAULT '0',
  `counter_ch` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `inout_usd_value` double NOT NULL DEFAULT '0',
  `update_ts` bigint NOT NULL,
  PRIMARY KEY (`start_timestamp`,`counter_ch`,`denom`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELIMITER //
CREATE PROCEDURE `stat_ibc_update`()
BEGIN
DECLARE LastTs BIGINT;
DECLARE CurTs BIGINT;
DECLARE StartTs BIGINT;

SET CurTS=  UNIX_TIMESTAMP();
SET StartTs=(floor(CurTS / 86400 ) * 86400);

SELECT MAX(start_timestamp) INTO LastTs FROM stat_ibc_daily;

# day pass. update yesterday
IF LastTS+86400 = StartTS THEN
	Insert Into stat_ibc_daily (start_timestamp, counter_ch, denom, inout_usd_value, update_ts)
	(SELECT  (floor(commit_ts / 86400000000 ) * 86400) as commitTs, IF(send_chain_id="crescent-1",recv_ch,send_ch) AS ch, denom, floor(sum(usd_value * IF(send_chain_id="crescent-1",1,-1))) as VOL,CurTs FROM tx_ibc_transfer WHERE commit_ts >= LastTs*1000000 AND usd_value > 0 GROUP BY commitTs, ch, recv_ch) 
	ON DUPLICATE KEY UPDATE `inout_usd_value`=VALUES(`inout_usd_value`),`update_ts`=VALUES(`update_ts`) ;
END IF;

#Update today info
Insert Into stat_ibc_daily (start_timestamp, counter_ch, denom, inout_usd_value, update_ts)
(SELECT  (floor(commit_ts / 86400000000 ) * 86400) as commitTs, IF(send_chain_id="crescent-1",recv_ch,send_ch) AS ch, denom, floor(sum(usd_value * IF(send_chain_id="crescent-1",1,-1))) as VOL,CurTs FROM tx_ibc_transfer WHERE commit_ts >= StartTs*1000000 AND usd_value > 0 GROUP BY commitTs, ch, recv_ch) 
ON DUPLICATE KEY UPDATE `inout_usd_value`=VALUES(`inout_usd_value`),`update_ts`=VALUES(`update_ts`) ;
END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `stat_rank_balance` (
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `usd_value` double NOT NULL,
  `update_ts` bigint NOT NULL,
  `last_act_height` bigint NOT NULL,
  PRIMARY KEY (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `stat_rank_balance_module` (
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `usd_value` double NOT NULL,
  `update_ts` bigint NOT NULL,
  `last_act_height` bigint NOT NULL,
  PRIMARY KEY (`owner`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

DELIMITER //
CREATE PROCEDURE `stat_rank_balance_module_update`()
BEGIN
DECLARE CurTs BIGINT;

SET CurTS=  UNIX_TIMESTAMP();

TRUNCATE TABLE stat_rank_balance_module;

#Update currect top 200
Insert Into stat_rank_balance_module (owner, usd_value, update_ts, last_act_height)
(SELECT A.address, SUM(B.amount * GREATEST(ifnull(DP.price_oracle,0)/ POW(10,D.exponent),IFNULL(PDP.price_oracle,0)) ) AS TOTAL, CurTs,MAX(B.update_height) FROM balance_recover B LEFT JOIN denom D ON D.denom=B.denom LEFT JOIN denom_price DP ON B.denom=DP.denom LEFT JOIN pool_denom_price PDP ON B.denom = PDP.pool_denom JOIN account A ON A.hex_addr = B.hex_addr WHERE length(B.hex_addr) > 40  group BY B.hex_addr order by TOTAL DESC LIMIT 0,50) 
ON DUPLICATE KEY UPDATE `usd_value`=VALUES(`usd_value`),`update_ts`=VALUES(`update_ts`),last_act_height=VALUES(`last_act_height`) ;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `stat_rank_balance_update`()
BEGIN
DECLARE CurTs BIGINT;

SET CurTS=  UNIX_TIMESTAMP();

TRUNCATE TABLE stat_rank_balance;

#Update currect top 200
Insert Into stat_rank_balance (owner, usd_value, update_ts, last_act_height)
(SELECT A.address, SUM(B.amount * GREATEST(ifnull(DP.price_oracle,0)/ POW(10,D.exponent),IFNULL(PDP.price_oracle,0)) ) AS TOTAL, CurTs,MAX(B.update_height) FROM balance_recover B LEFT JOIN denom D ON D.denom=B.denom LEFT JOIN denom_price DP ON B.denom=DP.denom LEFT JOIN pool_denom_price PDP ON B.denom = PDP.pool_denom JOIN account A ON A.hex_addr = B.hex_addr WHERE length(B.hex_addr)<= 40  group BY B.hex_addr order by TOTAL DESC LIMIT 0,100) 
ON DUPLICATE KEY UPDATE `usd_value`=VALUES(`usd_value`),`update_ts`=VALUES(`update_ts`),last_act_height=VALUES(`last_act_height`) ;
END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `stat_rank_farming` (
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `usd_value` double DEFAULT NULL,
  `update_ts` bigint DEFAULT NULL,
  `last_act_height` bigint DEFAULT NULL,
  PRIMARY KEY (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELIMITER //
CREATE PROCEDURE `stat_rank_farming_update`()
BEGIN
DECLARE CurTs BIGINT;

TRUNCATE TABLE stat_rank_farming;

SET CurTS=  UNIX_TIMESTAMP();

#Update currect top 200
Insert Into stat_rank_farming (owner, usd_value, update_ts, last_act_height)
(SELECT farmer, sum(S.stake_amount* PDP.price_oracle) AS TOTAL_STAKE, CurTs, MAX(S.update_height) FROM lpfarm_position S LEFT JOIN pool_denom_price PDP ON S.stake_denom = PDP.pool_denom GROUP BY S.farmer ORDER BY TOTAL_STAKE DESC LIMIT 0,200) 
ON DUPLICATE KEY UPDATE `usd_value`=VALUES(`usd_value`),`update_ts`=VALUES(`update_ts`),last_act_height=VALUES(`last_act_height`) ;
END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `stat_tvl_daily` (
  `start_timestamp` bigint NOT NULL DEFAULT '0',
  `pool` bigint NOT NULL DEFAULT '0',
  `usd_value` double NOT NULL DEFAULT '0',
  `update_timestamp` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`start_timestamp`,`pool`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELIMITER //
CREATE PROCEDURE `stat_tvl_update`()
BEGIN
DECLARE CurTs BIGINT;
DECLARE StartTs BIGINT;


SET CurTS=  UNIX_TIMESTAMP();
SET StartTs=(floor(CurTS / 86400 ) * 86400);

#Update today tvl
Insert Into stat_tvl_daily (start_timestamp, pool, usd_value, update_timestamp)
(SELECT StartTs,P.pool_id, floor(T.amount * IFNULL(PO.price_oracle,0.0)) AS tvl, CurTS 
		FROM pool P  
		left join pair PA  ON PA.pair_id = P.pair_id 		
 	   LEFT JOIN total_supply T ON P.pool_denom= T.denom 
		LEFT JOIN pool_denom_price PO ON PO.pool_denom = P.pool_denom 
	WHERE P.disabled= 0 AND PA.whitelisted=1) ON DUPLICATE KEY UPDATE `usd_value`=VALUES(`usd_value`),`update_timestamp`=VALUES(`update_timestamp`) ;

END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `stat_vol_daily` (
  `start_timestamp` bigint NOT NULL DEFAULT '0',
  `pair` bigint NOT NULL DEFAULT '0',
  `usd_vol` float NOT NULL DEFAULT '0',
  `update_timestamp` bigint NOT NULL,
  PRIMARY KEY (`start_timestamp`,`pair`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELIMITER //
CREATE PROCEDURE `stat_vol_update`()
BEGIN
DECLARE LastTs BIGINT;
DECLARE CurTs BIGINT;
DECLARE StartTs BIGINT;


SET CurTS=  UNIX_TIMESTAMP();
SET StartTs=(floor(CurTS / 86400 ) * 86400);

#SELECT MAX(start_timestamp) INTO LastTs FROM stat_vol_daily;

# day pass. update yesterday
SET LastTs = StartTs - 86400;
Insert Into stat_vol_daily (start_timestamp, pair, usd_vol, update_timestamp)
(SELECT LastTs,pair_id, floor(SUM(usd_vol)),CurTs FROM tx_swap_filled WHERE TIMESTAMP >= LastTs*1000000 AND TIMESTAMP < StartTs AND usd_vol>0 GROUP BY pair_id) ON DUPLICATE KEY UPDATE `usd_vol`=VALUES(`usd_vol`),`update_timestamp`=VALUES(`update_timestamp`);


#Update today info
Insert Into stat_vol_daily (start_timestamp, pair, usd_vol, update_timestamp)
(SELECT StartTs,pair_id, floor(SUM(usd_vol)),CurTs FROM tx_swap_filled WHERE TIMESTAMP >= StartTs*1000000 AND usd_vol>0 GROUP BY pair_id) ON DUPLICATE KEY UPDATE `usd_vol`=VALUES(`usd_vol`),`update_timestamp`=VALUES(`update_timestamp`) ;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `stat_vol_update_all`()
BEGIN
DECLARE CurTs BIGINT;

TRUNCATE stat_vol_daily;

SET CurTS=  UNIX_TIMESTAMP();

#Update today info
Insert Into stat_vol_daily (start_timestamp, pair, usd_vol, update_timestamp)
SELECT (floor(timestamp / 86400000000 ) * 86400) as filledStartTs,pair_id, floor(SUM(usd_vol)),CurTS FROM tx_swap_filled WHERE usd_vol>0 GROUP BY filledStartTs, pair_id;

END//
DELIMITER ;


CREATE TABLE IF NOT EXISTS `time_height` (
  `chain_id` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trace_yn` enum('Y','N') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `height` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ts` bigint(20) unsigned NOT NULL,
  `timeout` bigint(20) unsigned NULL,
  PRIMARY KEY (`chain_id`,`trace_yn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `time_height_ibc` (
  `chain_id` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trace_yn` enum('Y','N') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `height` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ts` bigint(20) unsigned NOT NULL,
  `timeout` bigint(20) unsigned NULL,
  PRIMARY KEY (`chain_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `total_supply` (
  `denom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(40,0) NOT NULL DEFAULT '0',
  `update_height` bigint(20) NOT NULL,
  PRIMARY KEY (`denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tx_event` (
  `eid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `txhash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_addr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alarmed` enum('Y','N') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `height` bigint(20) unsigned NOT NULL,
  `timestamp_us` bigint(20) unsigned NOT NULL DEFAULT '0',
  `evt_type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evt_group` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `result` json DEFAULT NULL,
  `tx_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`eid`),
  KEY `txhash` (`txhash`),
  KEY `owenr_addr` (`owner_addr`) USING BTREE,
  KEY `evt_group` (`evt_group`),
  KEY `owner_alarmed` (`owner_addr`,`alarmed`),
  KEY `owner_time` (`owner_addr`,`timestamp_us`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tx_event_ibc` (
  `eid` bigint unsigned NOT NULL AUTO_INCREMENT,
  `txhash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alarmed` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `height` bigint unsigned NOT NULL,
  `timestamp_us` bigint unsigned NOT NULL DEFAULT '0',
  `evt_type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `evt_group` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `result` json DEFAULT NULL,
  `tx_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`eid`),
  KEY `txhash` (`txhash`),
  KEY `owenr_addr` (`owner_addr`) USING BTREE,
  KEY `evt_group` (`evt_group`),
  KEY `owner_alarmed` (`owner_addr`,`alarmed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tx_ibc_transfer` (
  `unikey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `txhash_br` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `txhash_recv` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `txhash_result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(40,0) NOT NULL DEFAULT '0',
  `sender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `commit_height` int unsigned NOT NULL,
  `recv_height` int unsigned DEFAULT NULL,
  `result_height` int unsigned DEFAULT NULL,
  `pkt_seq` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_ch` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recv_ch` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `broadcast_ts` bigint NOT NULL,
  `commit_ts` bigint unsigned DEFAULT NULL,
  `recv_ts` bigint unsigned DEFAULT NULL,
  `result_ts` bigint unsigned DEFAULT NULL,
  `send_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_chain_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `usd_value` double DEFAULT NULL,
  PRIMARY KEY (`unikey`),
  UNIQUE KEY `txhash_br` (`txhash_br`),
  KEY `denom_idx` (`denom`),
  KEY `owner_idx` (`owner`),
  KEY `owner_status_idx` (`owner`,`status`),
  KEY `commit_ts_idx` (`owner`,`commit_ts`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tx_ibc_transfer_ibcmon` (
  `unikey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `txhash_br` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `txhash_recv` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `txhash_result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(40,0) NOT NULL DEFAULT '0',
  `sender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `commit_height` int unsigned NOT NULL,
  `recv_height` int unsigned DEFAULT NULL,
  `result_height` int unsigned DEFAULT NULL,
  `pkt_seq` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_ch` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recv_ch` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `broadcast_ts` bigint NOT NULL,
  `commit_ts` bigint unsigned DEFAULT NULL,
  `recv_ts` bigint unsigned DEFAULT NULL,
  `result_ts` bigint unsigned DEFAULT NULL,
  `send_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_chain_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `usd_value` double DEFAULT '0',
  PRIMARY KEY (`unikey`),
  UNIQUE KEY `txhash_br` (`txhash_br`),
  KEY `denom_idx` (`denom`),
  KEY `owner_idx` (`owner`),
  KEY `owner_status_idx` (`owner`,`status`),
  KEY `commit_ts_idx` (`owner`,`commit_ts`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tx_pool_deposit` (
  `pool_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `req_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) DEFAULT NULL,
  `accepted_a_amount` decimal(40,0) DEFAULT NULL,
  `accepted_b_amount` decimal(40,0) DEFAULT NULL,
  `denom_a` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `denom_b` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_a_amount` decimal(40,0) DEFAULT NULL,
  `deposit_b_amount` decimal(40,0) DEFAULT NULL,
  `minted_pool_amount` decimal(40,0) DEFAULT NULL,
  `timestamp` bigint DEFAULT NULL,
  `height` bigint DEFAULT NULL,
  `txhash` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usd_value` double unsigned DEFAULT NULL,
  PRIMARY KEY (`pool_id`,`req_id`),
  KEY `address` (`owner`) USING BTREE,
  KEY `time` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE IF NOT EXISTS `tx_pool_withdraw` (
  `pool_id` bigint unsigned NOT NULL,
  `req_id` bigint unsigned NOT NULL,
  `offer_pool_amount` decimal(40,0) NOT NULL DEFAULT '0',
  `withdraw_a_amount` decimal(40,0) DEFAULT '0',
  `withdraw_b_amount` decimal(40,0) DEFAULT '0',
  `denom_a` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `denom_b` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `status` int unsigned NOT NULL DEFAULT '0',
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `height` bigint unsigned NOT NULL,
  `timestamp` bigint unsigned NOT NULL,
  `txhash` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `usd_value` double DEFAULT '0',
  PRIMARY KEY (`pool_id`,`req_id`),
  KEY `time` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE IF NOT EXISTS `tx_swap_filled` (
  `fid` bigint NOT NULL AUTO_INCREMENT,
  `pair_id` bigint NOT NULL DEFAULT '0',
  `req_id` bigint NOT NULL DEFAULT '0',
  `batch_id` int NOT NULL DEFAULT '0',
  `status` int NOT NULL,
  `offer_amount` decimal(40,0) DEFAULT '0',
  `demand_amount` decimal(40,0) DEFAULT '0',
  `timestamp` bigint NOT NULL DEFAULT '0',
  `height` bigint NOT NULL DEFAULT '0',
  `offer_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `demand_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double DEFAULT NULL,
  `swapped_base_amount` decimal(40,0) DEFAULT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_oracle_price` double DEFAULT '0',
  `usd_vol` double DEFAULT '0',
  `update_height` bigint unsigned DEFAULT '0',
  PRIMARY KEY (`fid`),
  KEY `key` (`pair_id`,`req_id`,`batch_id`) USING BTREE,
  KEY `timestamp` (`timestamp`),
  KEY `owner_ts` (`owner`,`timestamp`),
  KEY `pair_ts` (`pair_id`,`timestamp`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE IF NOT EXISTS `tx_swap_filled_recover` (
  `fid` bigint NOT NULL AUTO_INCREMENT,
  `pair_id` bigint NOT NULL DEFAULT '0',
  `req_id` bigint NOT NULL DEFAULT '0',
  `batch_id` int NOT NULL DEFAULT '0',
  `status` int NOT NULL,
  `offer_amount` decimal(40,0) DEFAULT '0',
  `demand_amount` decimal(40,0) DEFAULT '0',
  `timestamp` bigint NOT NULL DEFAULT '0',
  `height` bigint NOT NULL DEFAULT '0',
  `offer_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `demand_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double DEFAULT NULL,
  `swapped_base_amount` decimal(40,0) DEFAULT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_oracle_price` double DEFAULT '0',
  `usd_vol` double DEFAULT '0',
  `update_height` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fid`),
  KEY `key` (`pair_id`,`req_id`,`batch_id`) USING BTREE,
  KEY `timestamp` (`timestamp`),
  KEY `owner_ts` (`owner`,`timestamp`),
  KEY `pair_ts` (`pair_id`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tx_swap_req` (
  `pair_id` bigint NOT NULL DEFAULT '0',
  `req_id` bigint NOT NULL DEFAULT '0',
  `txhash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_ts` bigint NOT NULL DEFAULT '0',
  `height` bigint NOT NULL DEFAULT '0',
  `order_price` double NOT NULL DEFAULT '0',
  `open_base_amount` decimal(40,0) DEFAULT '0',
  `filled_base_amount` decimal(40,0) DEFAULT '0',
  `offer_amount` decimal(40,0) NOT NULL DEFAULT '0',
  `offer_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` bigint NOT NULL DEFAULT '0',
  `demand_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `direction` int NOT NULL,
  `remain_offer_amount` decimal(40,0) DEFAULT NULL,
  `demand_received_amount` decimal(40,0) DEFAULT NULL,
  `update_height` bigint DEFAULT '0',
  `order_type` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`pair_id`,`req_id`) USING BTREE,
  KEY `txhash` (`txhash`),
  KEY `owner_idx` (`owner`,`status`) USING BTREE,
  KEY `owner_ts_idx` (`owner`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `tx_swap_req_recover` (
  `pair_id` bigint NOT NULL DEFAULT '0',
  `req_id` bigint NOT NULL DEFAULT '0',
  `txhash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_ts` bigint NOT NULL DEFAULT '0',
  `height` bigint NOT NULL DEFAULT '0',
  `order_price` double NOT NULL DEFAULT '0',
  `open_base_amount` decimal(40,0) DEFAULT '0',
  `filled_base_amount` decimal(40,0) DEFAULT '0',
  `offer_amount` decimal(40,0) NOT NULL DEFAULT '0',
  `offer_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` bigint NOT NULL DEFAULT '0',
  `demand_denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `direction` int NOT NULL,
  `remain_offer_amount` decimal(40,0) DEFAULT '0',
  `demand_received_amount` decimal(40,0) DEFAULT '0',
  `update_height` bigint DEFAULT NULL,
  PRIMARY KEY (`pair_id`,`req_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `validators_db` (
  `operator_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `moniker` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cex` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;










DELIMITER //
CREATE TRIGGER `denom_price_before_insert` BEFORE INSERT ON `denom_price` FOR EACH ROW BEGIN
	DECLARE cur_height BIGINT DEFAULT 0;
	SELECT height INTO cur_height FROM time_height WHERE chain_id="crescent-1" and trace_yn="N";
	INSERT INTO denom_price_time_series  (`denom`, `height`, `price_oracle`, `timestamp_ty`)  VALUES( NEW.denom, cur_height, NEW.price_oracle, CURRENT_TIMESTAMP());	
END//
DELIMITER ;





SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `farm_historical_reward_BEFORE_INSERT` BEFORE INSERT ON `farm_historical_reward` FOR EACH ROW BEGIN
  DECLARE old_value DECIMAL(40,18) DEFAULT 0.0;
  DECLARE total_stake_amount DECIMAL(40,0) DEFAULT 0;
	DECLARE old_ts BIGINT DEFAULT 0.0;
	DECLARE oracle_price DOUBLE DEFAULT 0.0;
	SELECT reward_amount, update_ts INTO old_value, old_ts FROM farm_historical_reward WHERE denom=NEW.denom and reward_denom=NEW.reward_denom ORDER BY epoch DESC LIMIT 1;
	SELECT D.price_oracle INTO oracle_price FROM denom_price D WHERE D.denom=NEW.reward_denom;
	SELECT amount INTO total_stake_amount FROM farm_staking_total WHERE denom=NEW.denom; 
	SET NEW.reward_diff = NEW.reward_amount - old_value;
	SET NEW.ts_diff = NEW.update_ts - old_ts;
	SET NEW.rewarded_oracle_price = oracle_price;
	SET NEW.rewarded_total_stake = total_stake_amount;
	INSERT INTO farm_current_reward  (`denom`, `reward_denom`, `epoch`, `reward_diff`,`rewarded_total_stake`,`rewarded_oracle_price`,`update_height`, `update_ts`)  VALUES( NEW.denom, NEW.reward_denom, NEW.epoch, NEW.reward_diff, NEW.rewarded_total_stake, NEW.rewarded_oracle_price, NEW.update_height, New.update_ts) ON duplicate key update epoch = NEW.epoch, reward_diff = NEW.reward_diff, rewarded_total_stake = NEW.rewarded_total_stake, rewarded_oracle_price=NEW.rewarded_oracle_price, update_height=NEW.update_height,update_ts=NEW.update_ts;	
#   INSERT INTO farm_current_reward  (`denom`, `reward_denom`, `epoch`, `reward_diff`,`rewarded_total_stake`,`rewarded_oracle_price`,`update_height`, `update_ts`)  VALUES( NEW.denom, NEW.reward_denom, NEW.epoch, NEW.reward_diff, NEW.rewarded_total_stake, NEW.rewarded_oracle_price, NEW.update_height, New.update_ts) ;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

DELIMITER //
CREATE TRIGGER `liquid_farm_auction_before_insert` BEFORE INSERT ON `liquid_farm_auction` FOR EACH ROW BEGIN
DECLARE RewardValue DECIMAL(45,12);
DECLARE WinningValue DECIMAL(45,12);

IF NEW.winning_addr != "" THEN
   SELECT SUM( RW.reward_amount * DP.price_oracle / pow(10,D.exponent)) INTO RewardValue FROM liquid_farm_auction_reward RW LEFT JOIN denom_price DP ON DP.denom = RW.reward_denom LEFT JOIN denom D ON D.denom=RW.reward_denom WHERE RW.pool_id = NEW.pool_id AND RW.auction_id=NEW.auction_id; 
   SELECT NEW.winning_amount * PP.price_oracle INTO WinningValue FROM pool_denom_price PP WHERE PP.pool_denom = NEW.bid_coin_denom;

	INSERT INTO liquid_farm_auction_reward_history (`pool_id`,`auction_id`,`bidding_value`, `reward_value`) VALUES (NEW.pool_id, NEW.auction_id, WinningValue, RewardValue) ON DUPLICATE KEY UPDATE `bidding_value`=VALUES(`bidding_value`), `reward_value`=VALUES(`reward_value`);
END IF;


END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER `liquid_farm_auction_reward_history_after_insert` AFTER INSERT ON `liquid_farm_auction_reward_history` FOR EACH ROW BEGIN

   DECLARE avg_ratio DECIMAL(45,18);
   DECLARE sumcnt DECIMAL(45,0);
   DECLARE new_ratio DECIMAL(45,18);
   SELECT auction_cnt, avg_percent INTO sumcnt, avg_ratio FROM liquid_farm_historical_adjust WHERE pool_id = NEW.pool_id;
   
   IF ISNULL(sumcnt) THEN
      SET sumcnt = 0;
   END IF;
   

   SET new_ratio = NEW.bidding_value / NEW.reward_value;
   IF new_ratio > 1.0 THEN
      SET new_ratio = 1.0;
   END IF;

   IF sumcnt = 0 THEN
      SET avg_ratio = new_ratio;
   ELSE
     SET avg_ratio = avg_ratio * 0.7 + new_ratio * 0.3;
   END IF;
   SET sumcnt = sumcnt+1;
   
   insert into liquid_farm_historical_adjust (pool_id, auction_cnt, avg_percent, update_ts ) VALUES ( NEW.pool_id, sumcnt, avg_ratio, UNIX_TIMESTAMP()) ON DUPLICATE KEY UPDATE `avg_percent`=VALUES(avg_percent), `auction_cnt`=VALUES(`auction_cnt`);
   
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
DELIMITER //
CREATE TRIGGER `liquid_farm_auction_before_insert` BEFORE INSERT ON `liquid_farm_auction` FOR EACH ROW BEGIN
DECLARE RewardValue DECIMAL(45,12);
DECLARE WinningValue DECIMAL(45,12);

IF NEW.winning_addr != "" THEN
   SELECT SUM( RW.reward_amount * DP.price_oracle / pow(10,D.exponent)) INTO RewardValue FROM liquid_farm_auction_reward RW LEFT JOIN denom_price DP ON DP.denom = RW.reward_denom LEFT JOIN denom D ON D.denom=RW.reward_denom WHERE RW.pool_id = NEW.pool_id AND RW.auction_id=NEW.auction_id; 
   SELECT NEW.winning_amount * PP.price_oracle INTO WinningValue FROM pool_denom_price PP WHERE PP.pool_denom = NEW.bid_coin_denom;

	INSERT INTO liquid_farm_auction_reward_history (`pool_id`,`auction_id`,`bidding_value`, `reward_value`) VALUES (NEW.pool_id, NEW.auction_id, WinningValue, RewardValue) ON DUPLICATE KEY UPDATE `bidding_value`=VALUES(`bidding_value`), `reward_value`=VALUES(`reward_value`);
END IF;


END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER `liquid_farm_auction_reward_history_after_insert` AFTER INSERT ON `liquid_farm_auction_reward_history` FOR EACH ROW BEGIN

   DECLARE avg_ratio DECIMAL(45,18);
   DECLARE sumcnt DECIMAL(45,0);
   DECLARE new_ratio DECIMAL(45,18);
   SELECT auction_cnt, avg_percent INTO sumcnt, avg_ratio FROM liquid_farm_historical_adjust WHERE pool_id = NEW.pool_id;
   
   IF ISNULL(sumcnt) THEN
      SET sumcnt = 0;
   END IF;
   

   SET new_ratio = NEW.bidding_value / NEW.reward_value;
   IF new_ratio > 1.0 THEN
      SET new_ratio = 1.0;
   END IF;

   IF sumcnt = 0 THEN
      SET avg_ratio = new_ratio;
   ELSE
     SET avg_ratio = avg_ratio * 0.7 + new_ratio * 0.3;
   END IF;
   SET sumcnt = sumcnt+1;
   
   insert into liquid_farm_historical_adjust (pool_id, auction_cnt, avg_percent, update_ts ) VALUES ( NEW.pool_id, sumcnt, avg_ratio, UNIX_TIMESTAMP()) ON DUPLICATE KEY UPDATE `avg_percent`=VALUES(avg_percent), `auction_cnt`=VALUES(`auction_cnt`);
   
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
DELIMITER //
CREATE TRIGGER `liquid_farm_auction_before_insert` BEFORE INSERT ON `liquid_farm_auction` FOR EACH ROW BEGIN
DECLARE RewardValue DECIMAL(45,12);
DECLARE WinningValue DECIMAL(45,12);

IF NEW.winning_addr != "" THEN
   SELECT SUM( RW.reward_amount * DP.price_oracle / pow(10,D.exponent)) INTO RewardValue FROM liquid_farm_auction_reward RW LEFT JOIN denom_price DP ON DP.denom = RW.reward_denom LEFT JOIN denom D ON D.denom=RW.reward_denom WHERE RW.pool_id = NEW.pool_id AND RW.auction_id=NEW.auction_id; 
   SELECT NEW.winning_amount * PP.price_oracle INTO WinningValue FROM pool_denom_price PP WHERE PP.pool_denom = NEW.bid_coin_denom;

	INSERT INTO liquid_farm_auction_reward_history (`pool_id`,`auction_id`,`bidding_value`, `reward_value`) VALUES (NEW.pool_id, NEW.auction_id, WinningValue, RewardValue) ON DUPLICATE KEY UPDATE `bidding_value`=VALUES(`bidding_value`), `reward_value`=VALUES(`reward_value`);
END IF;


END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER `liquid_farm_auction_reward_history_after_insert` AFTER INSERT ON `liquid_farm_auction_reward_history` FOR EACH ROW BEGIN

   DECLARE avg_ratio DECIMAL(45,18);
   DECLARE sumcnt DECIMAL(45,0);
   DECLARE new_ratio DECIMAL(45,18);
   SELECT auction_cnt, avg_percent INTO sumcnt, avg_ratio FROM liquid_farm_historical_adjust WHERE pool_id = NEW.pool_id;
   
   IF ISNULL(sumcnt) THEN
      SET sumcnt = 0;
   END IF;
   

   SET new_ratio = NEW.bidding_value / NEW.reward_value;
   IF new_ratio > 1.0 THEN
      SET new_ratio = 1.0;
   END IF;

   IF sumcnt = 0 THEN
      SET avg_ratio = new_ratio;
   ELSE
     SET avg_ratio = avg_ratio * 0.7 + new_ratio * 0.3;
   END IF;
   SET sumcnt = sumcnt+1;
   
   insert into liquid_farm_historical_adjust (pool_id, auction_cnt, avg_percent, update_ts ) VALUES ( NEW.pool_id, sumcnt, avg_ratio, UNIX_TIMESTAMP()) ON DUPLICATE KEY UPDATE `avg_percent`=VALUES(avg_percent), `auction_cnt`=VALUES(`auction_cnt`);
   
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
DELIMITER //
CREATE TRIGGER `liquid_farm_auction_before_insert` BEFORE INSERT ON `liquid_farm_auction` FOR EACH ROW BEGIN
DECLARE RewardValue DECIMAL(45,12);
DECLARE WinningValue DECIMAL(45,12);

IF NEW.winning_addr != "" THEN
   SELECT SUM( RW.reward_amount * DP.price_oracle / pow(10,D.exponent)) INTO RewardValue FROM liquid_farm_auction_reward RW LEFT JOIN denom_price DP ON DP.denom = RW.reward_denom LEFT JOIN denom D ON D.denom=RW.reward_denom WHERE RW.pool_id = NEW.pool_id AND RW.auction_id=NEW.auction_id; 
   SELECT NEW.winning_amount * PP.price_oracle INTO WinningValue FROM pool_denom_price PP WHERE PP.pool_denom = NEW.bid_coin_denom;

	INSERT INTO liquid_farm_auction_reward_history (`pool_id`,`auction_id`,`bidding_value`, `reward_value`) VALUES (NEW.pool_id, NEW.auction_id, WinningValue, RewardValue) ON DUPLICATE KEY UPDATE `bidding_value`=VALUES(`bidding_value`), `reward_value`=VALUES(`reward_value`);
END IF;


END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER `liquid_farm_auction_reward_history_after_insert` AFTER INSERT ON `liquid_farm_auction_reward_history` FOR EACH ROW BEGIN

   DECLARE avg_ratio DECIMAL(45,18);
   DECLARE sumcnt DECIMAL(45,0);
   DECLARE new_ratio DECIMAL(45,18);
   SELECT auction_cnt, avg_percent INTO sumcnt, avg_ratio FROM liquid_farm_historical_adjust WHERE pool_id = NEW.pool_id;
   
   IF ISNULL(sumcnt) THEN
      SET sumcnt = 0;
   END IF;
   

   SET new_ratio = NEW.bidding_value / NEW.reward_value;
   IF new_ratio > 1.0 THEN
      SET new_ratio = 1.0;
   END IF;

   IF sumcnt = 0 THEN
      SET avg_ratio = new_ratio;
   ELSE
     SET avg_ratio = avg_ratio * 0.7 + new_ratio * 0.3;
   END IF;
   SET sumcnt = sumcnt+1;
   
   insert into liquid_farm_historical_adjust (pool_id, auction_cnt, avg_percent, update_ts ) VALUES ( NEW.pool_id, sumcnt, avg_ratio, UNIX_TIMESTAMP()) ON DUPLICATE KEY UPDATE `avg_percent`=VALUES(avg_percent), `auction_cnt`=VALUES(`auction_cnt`);
   
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tx_ibc_transfer_before_insert` BEFORE INSERT ON `tx_ibc_transfer` FOR EACH ROW BEGIN
   DECLARE p DOUBLE DEFAULT 0.0;
   DECLARE expo int DEFAULT 1;
   SELECT DP.price_oracle, D.exponent INTO p,expo FROM denom_price DP LEFT JOIN denom D ON DP.denom = D.denom WHERE DP.denom = NEW.denom;
   SET NEW.usd_value = NEW.amount * p / POW(10,expo);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tx_ibc_transfer_ibcmon_before_insert` BEFORE INSERT ON `tx_ibc_transfer_ibcmon` FOR EACH ROW BEGIN
   DECLARE p DOUBLE DEFAULT 0.0;
   DECLARE expo int DEFAULT 1;
   SELECT DP.price_oracle, D.exponent INTO p,expo FROM denom_price DP LEFT JOIN denom D ON DP.denom = D.denom WHERE DP.denom = NEW.denom;
   SET NEW.usd_value = NEW.amount * p / POW(10,expo);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

DELIMITER //
CREATE TRIGGER `tx_pool_deposit_before_update` BEFORE UPDATE ON `tx_pool_deposit` FOR EACH ROW BEGIN
   DECLARE p DOUBLE DEFAULT 0.0;
   IF NOT isnull(NEW.minted_pool_amount) THEN
		SELECT price_oracle INTO p FROM pool_denom_price WHERE pool_id = NEW.pool_id;
		SET NEW.usd_value = NEW.minted_pool_amount * p;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER `tx_pool_withdraw_before_insert` BEFORE INSERT ON `tx_pool_withdraw` FOR EACH ROW BEGIN
   DECLARE p DOUBLE DEFAULT 0.0;
  	SELECT price_oracle INTO p FROM pool_denom_price WHERE pool_id = NEW.pool_id;
	SET NEW.usd_value = NEW.offer_pool_amount * p;
END//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `tx_swap_filled_before_insert` BEFORE INSERT ON `tx_swap_filled` FOR EACH ROW BEGIN
   DECLARE op DOUBLE DEFAULT 0.0;
   DECLARE expo int DEFAULT 1;
	IF NEW.swapped_base_amount > 0 THEN

		SELECT DP.price_oracle, D.exponent INTO op,expo FROM pair P LEFT JOIN denom D ON P.base_denom = D.denom LEFT JOIN denom_price DP ON DP.denom = P.base_denom WHERE P.pair_id = NEW.pair_id;
		SET NEW.base_oracle_price = op;
		SET NEW.usd_vol = NEW.swapped_base_amount * op / POW(10,expo);
	END IF;
END//
DELIMITER ;
/*
select `O`.`pool_denom` AS `denom`,`O`.`price_oracle` AS `price_oracle`,
  sum((( if(R.target_pair_id>0, pair_farming_ratio,  1) * ((`R`.`reward_amount_per_day` * `RP`.`price_oracle`) / pow(10,`D`.`exponent`))) * 36500) / greatest(ifnull(`LPF`.`total_farming_amount`,1000000000),1000000000)) / `O`.`price_oracle` AS `apr`,
	json_arrayagg(json_object('planId',`R`.`plan_id`,'pairPlan', if(R.target_pair_id > 0 , 1, 0), 'rewardAmount', (`R`.`reward_amount_per_day` * (1000000000000/ pow(10,`D`.`exponent`)) / greatest(ifnull(`LPF`.`total_farming_amount`,1000000000),1000000000)),'rewardDenom',`R`.`reward_denom`,'start',`R`.`start_ts`,'end',`R`.`end_ts`)) AS `rewards_per_day`
   from `lpfarm_plan` `R` 
	 left join `denom` `D` on((`D`.`denom` = `R`.`reward_denom`)) 
	left join `pool` `P` on((`P`.`pool_denom` = `R`.`target_pool_denom`) or P.pair_id = `R`.`target_pair_id`) 
      left join `pool_denom_price` `O` on((`O`.`pool_denom` = `P`.pool_denom))  
	left join `denom_price` `RP` on((`RP`.`denom` = `R`.`reward_denom`)) 
	LEFT JOIN ( SELECT distinct farm_denom, total_farming_amount, pair_farming_ratio from lpfarm_farm ) as LPF ON LPF.farm_denom = P.pool_denom  
	WHERE ((`R`.`terminated` = 0) and (`R`.`start_ts` <= unix_timestamp()) and (`R`.`end_ts` > unix_timestamp()) and (`D`.`whitelisted` = 1) and (`R`.`insufficient` = 0)) group by `O`.`pool_denom`
*/
DROP TABLE IF EXISTS `pool_calc`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `pool_calc` AS select `O`.`pool_denom` AS `denom`,`O`.`price_oracle` AS `price_oracle`,(sum((((if((`R`.`target_pair_id` > 0),`LPF`.`pair_farming_ratio`,1) * ((`R`.`reward_amount_per_day` * `RP`.`price_oracle`) / pow(10,`D`.`exponent`))) * 36500) / greatest(ifnull(`LPF`.`total_farming_amount`,1000000000),1000000000))) / `O`.`price_oracle`) AS `apr`,json_arrayagg(json_object('planId',`R`.`plan_id`,'pairPlan',if((`R`.`target_pair_id` > 0),1,0),'rewardAmount',ifnull(((if((`R`.`target_pair_id` > 0),`LPF`.`pair_farming_ratio`,1) * (`R`.`reward_amount_per_day` * (1000000000000 / pow(10,`D`.`exponent`)))) / greatest(ifnull(`LPF`.`total_farming_amount`,1000000000),1000000000)),0.0),'rewardDenom',`R`.`reward_denom`,'start',`R`.`start_ts`,'end',`R`.`end_ts`)) AS `rewards_per_day` from (((((`lpfarm_plan` `R` left join `denom` `D` on((`D`.`denom` = `R`.`reward_denom`))) left join `pool` `P` on(((`P`.`pool_denom` = `R`.`target_pool_denom`) or (`P`.`pair_id` = `R`.`target_pair_id`)))) left join `pool_denom_price` `O` on((`O`.`pool_denom` = `P`.`pool_denom`))) left join `denom_price` `RP` on((`RP`.`denom` = `R`.`reward_denom`))) left join (select distinct `lpfarm_farm`.`farm_denom` AS `farm_denom`,`lpfarm_farm`.`total_farming_amount` AS `total_farming_amount`,`lpfarm_farm`.`pair_farming_ratio` AS `pair_farming_ratio` from `lpfarm_farm`) `LPF` on((`LPF`.`farm_denom` = `P`.`pool_denom`))) where ((`R`.`terminated` = 0) and (`R`.`start_ts` <= unix_timestamp()) and (`R`.`end_ts` > unix_timestamp()) and (`D`.`whitelisted` = 1) and (`R`.`insufficient` = 0)) group by `O`.`pool_denom`;

DROP TABLE IF EXISTS `pool_denom_price`;
CREATE ALGORITHM=UNDEFINED DEFINER=admin@'%' SQL SECURITY DEFINER VIEW `pool_denom_price` AS select  `P`.`pool_id` AS `pool_id`,`P`.`pool_denom` AS `pool_denom`,(sum(((`B`.`amount` * ifnull(`D`.`price_oracle`,0.0)) / ifnull(pow(10,`DD`.`exponent`),1.0))) / `T`.`amount`) AS `price_oracle`,sum(((`B`.`amount` * if((`B`.`denom` = 'ubcre'),1.0,0.0)) / ifnull(pow(10,`DD`.`exponent`),1.0))) AS `bcre_amount`,sum(if((`B`.`denom` = 'ubcre'),`D`.`price_oracle`,0)) AS `bcre_price`,max(`D`.`update_ts`) AS `update_ts` from (((((`pool` `P` left join `account` `A` on((`A`.`address` = `P`.`reserve_address`))) join `balance` `B` on((`B`.`hex_addr` = `A`.`hex_addr`))) left join `denom_price` `D` on((`D`.`denom` = `B`.`denom`))) left join `denom` `DD` on((`D`.`denom` = `DD`.`denom`))) left join `total_supply` `T` on((`T`.`denom` = `P`.`pool_denom`))) group by `P`.`pool_id`;


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

CREATE TABLE IF NOT EXISTS `referral` (
  `id` bigint(20) NOT NULL,
  `addr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tier` int NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `created_ts` bigint NOT NULL DEFAULT '0',
  `updated_ts` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `addr` (`addr`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `referral_revenue` (
  `referral_id` bigint(20) NOT NULL,
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(40,0) NOT NULL DEFAULT '0',
  `created_ts` bigint NOT NULL DEFAULT '0',
  `updated_ts` bigint DEFAULT NULL,
  PRIMARY KEY (`referral_id`,`denom`) USING BTREE,
  KEY `referral_id` (`referral_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `denom_metadata` (
  `denom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coingecko_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
