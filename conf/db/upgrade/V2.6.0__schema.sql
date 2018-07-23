SET FOREIGN_KEY_CHECKS = 0;

ALTER TABLE AccountResourceRefVO ADD COLUMN `concreteResourceType` varchar(512) NOT NULL;
UPDATE AccountResourceRefVO set concreteResourceType = 'org.zstack.network.l2.vxlan.vxlanNetwork', resourceType = 'L2NetworkVO' WHERE resourceType = 'VxlanNetworkVO';
ALTER TABLE ResourceVO ADD COLUMN `concreteResourceType` varchar(512) NOT NULL;

CREATE TABLE `TwoFactorAuthenticationSecretVO` (
    `uuid` VARCHAR(32) NOT NULL,
    `secret` VARCHAR(2048) NOT NULL,
    `resourceUuid` VARCHAR(32) NOT NULL,
    `resourceType` VARCHAR(256) NOT NULL,
    `lastOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
    `createDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
    PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `CaptchaVO` (
    `uuid` VARCHAR(32) NOT NULL,
    `captcha` text NOT NULL,
    `verifyCode` VARCHAR(32) NOT NULL,
    `targetResourceIdentity` VARCHAR(256) NOT NULL,
    `attempts` int(10) unsigned DEFAULT 0,
    `lastOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
    `createDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
    PRIMARY KEY (`uuid`),
    UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- TABLES THAT ARE NOT NEEDED IN BAREMETAL V2
DELETE FROM `zstack`.`BaremetalPxeServerVO`;
DELETE FROM `zstack`.`BaremetalChassisVO`;
DELETE FROM `zstack`.`BaremetalHardwareInfoVO`;
DROP TABLE IF EXISTS `zstack`.`BaremetalConsoleProxyVO`;
DROP TABLE IF EXISTS `zstack`.`BaremetalHostBondingVO`;
DROP TABLE IF EXISTS `zstack`.`BaremetalHostCfgVO`;
DROP TABLE IF EXISTS `zstack`.`BaremetalHostNicCfgVO`;

ALTER TABLE `zstack`.`BaremetalChassisVO` ADD COLUMN `state` varchar(32) NOT NULL;
ALTER TABLE `zstack`.`BaremetalChassisVO` ADD COLUMN `zoneUuid` varchar(32) NOT NULL;
ALTER TABLE `zstack`.`BaremetalChassisVO` ADD COLUMN `clusterUuid` varchar(32) NOT NULL;
ALTER TABLE `zstack`.`BaremetalChassisVO` ADD CONSTRAINT fkBaremetalChassisVOZoneEO FOREIGN KEY (zoneUuid) REFERENCES ZoneEO (uuid) ON DELETE RESTRICT;
ALTER TABLE `zstack`.`BaremetalChassisVO` ADD CONSTRAINT fkBaremetalChassisVOClusterEO FOREIGN KEY (clusterUuid) REFERENCES ClusterEO (uuid) ON DELETE RESTRICT;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE  `zstack`.`BaremetalInstanceVO` (
    `uuid` varchar(32) NOT NULL UNIQUE,
    `name` varchar(255) NOT NULL,
    `description` varchar(2048) DEFAULT NULL,
    `internalId` bigint unsigned NOT NULL,
    `zoneUuid` varchar(32) DEFAULT NULL,
    `clusterUuid` varchar(32) DEFAULT NULL,
    `chassisUuid` varchar(32) DEFAULT NULL,
    `imageUuid` varchar(32) DEFAULT NULL,
    `platform` varchar(255) NOT NULL,
    `managementIp` varchar(255) NOT NULL,
    `username` varchar(255) NOT NULL,
    `password` varchar(255) NOT NULL,
    `port` int unsigned DEFAULT NULL,
    `state` varchar(128) NOT NULL,
    `status` varchar(128) NOT NULL,
    `lastOpDate` timestamp ON UPDATE CURRENT_TIMESTAMP,
    `createDate` timestamp,
    PRIMARY KEY  (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `zstack`.`BaremetalInstanceVO` ADD CONSTRAINT fkBaremetalInstanceVOZoneEO FOREIGN KEY (zoneUuid) REFERENCES ZoneEO (uuid) ON DELETE SET NULL;
ALTER TABLE `zstack`.`BaremetalInstanceVO` ADD CONSTRAINT fkBaremetalInstanceVOClusterEO FOREIGN KEY (clusterUuid) REFERENCES ClusterEO (uuid) ON DELETE SET NULL;
ALTER TABLE `zstack`.`BaremetalInstanceVO` ADD CONSTRAINT fkBaremetalInstanceVOBaremetalChassisVO FOREIGN KEY (chassisUuid) REFERENCES BaremetalChassisVO (uuid) ON DELETE RESTRICT;
ALTER TABLE `zstack`.`BaremetalInstanceVO` ADD CONSTRAINT fkBaremetalInstanceVOImageEO FOREIGN KEY (imageUuid) REFERENCES ImageEO (uuid) ON DELETE SET NULL;

CREATE TABLE  `zstack`.`BaremetalNicVO` (
    `uuid` varchar(32) NOT NULL UNIQUE,
    `baremetalInstanceUuid` varchar(32) NOT NULL,
    `l3NetworkUuid` varchar(32) DEFAULT NULL,
    `usedIpUuid` varchar(32) DEFAULT NULL UNIQUE,
    `mac` varchar(17) NOT NULL UNIQUE,
    `ip` varchar(128) NOT NULL,
    `netmask` varchar(128) DEFAULT NULL,
    `gateway` varchar(128) DEFAULT NULL,
    `metaData` varchar(255) DEFAULT NULL,
    `pxe` tinyint(1) unsigned DEFAULT 0,
    `lastOpDate` timestamp ON UPDATE CURRENT_TIMESTAMP,
    `createDate` timestamp,
    PRIMARY KEY  (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE `zstack`.`BaremetalNicVO` ADD CONSTRAINT fkBaremetalNicVOBaremetalInstanceVO FOREIGN KEY (baremetalInstanceUuid) REFERENCES BaremetalInstanceVO (uuid) ON DELETE CASCADE;
ALTER TABLE `zstack`.`BaremetalNicVO` ADD CONSTRAINT fkBaremetalNicVOL3NetworkEO FOREIGN KEY (l3NetworkUuid) REFERENCES L3NetworkEO (uuid) ON DELETE SET NULL;
ALTER TABLE `zstack`.`BaremetalNicVO` ADD CONSTRAINT fkBaremetalNicVOUsedIpVO FOREIGN KEY (usedIpUuid) REFERENCES UsedIpVO (uuid) ON DELETE SET NULL;

CREATE TABLE  `zstack`.`BaremetalInstanceSequenceNumberVO` (
    `id` bigint unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE  `zstack`.`BaremetalImageCacheVO` (
    `id` bigint unsigned NOT NULL UNIQUE AUTO_INCREMENT,
    `imageUuid` varchar(32) DEFAULT NULL,
    `url` varchar(1024) NOT NULL,
    `installUrl` varchar(1024) NOT NULL,
    `mediaType` varchar(64) NOT NULL,
    `size` bigint unsigned NOT NULL,
    `actualSize` bigint unsigned NOT NULL,
    `md5sum` varchar(255) NOT NULL,
    `utilization` bigint unsigned NOT NULL DEFAULT 0,
    `lastOpDate` timestamp ON UPDATE CURRENT_TIMESTAMP,
    `createDate` timestamp,
    PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE BaremetalImageCacheVO ADD CONSTRAINT fkBaremetalImageCacheVOImageEO FOREIGN KEY (imageUuid) REFERENCES ImageEO (uuid) ON DELETE SET NULL;
