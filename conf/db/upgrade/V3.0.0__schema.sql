alter table VmNicVO modify vmInstanceUuid varchar(32) NULL COMMENT 'vm instance uuid';
alter table VmNicVO modify internalName varchar(128) NULL;

ALTER TABLE VmNicVO modify vmInstanceUuid VARCHAR(32) NULL COMMENT 'vm instance uuid';
ALTER TABLE VmNicVO modify internalName VARCHAR(128) NULL;

CREATE TABLE `AliyunProxyVpcVO` (
  `uuid` VARCHAR(32) NOT NULL,
  `status` VARCHAR(32) NOT NULL,
  `vpcName` VARCHAR(32) DEFAULT NULL,
  `cidrBlock` VARCHAR(128) NOT NULL,
  `vRouterUuid` VARCHAR(32) NOT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `lastOpDate` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `createDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `isDefault` tinyint(1) unsigned DEFAULT 0,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `uuid` (`uuid`),
  CONSTRAINT `fkAliyunProxyVpcVOVmInstanceEO` FOREIGN KEY (`vRouterUuid`) REFERENCES `VmInstanceEO` (`uuid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `AliyunProxyVSwitchVO` (
    `uuid` VARCHAR(32) NOT NULL,
    `vpcL3NetworkUuid` VARCHAR(32) NOT NULL,
    `aliyunProxyVpcUuid` VARCHAR(32) NOT NULL,
    `status` VARCHAR(32) NOT NULL,
    `isDefault` tinyint(1) unsigned DEFAULT 0,
    CONSTRAINT `fkAliyunProxyVSwitchVOAliyunProxyVpcVO` FOREIGN KEY (`aliyunProxyVpcUuid`) REFERENCES `AliyunProxyVpcVO` (`uuid`) ON DELETE CASCADE,
    CONSTRAINT `fkAliyunProxyVSwitchVOL3NetworkEO` FOREIGN KEY (`vpcL3NetworkUuid`) REFERENCES `L3NetworkEO` (`uuid`) ON DELETE CASCADE
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `IscsiServerVO` (
  `uuid` VARCHAR(32) NOT NULL,
  `ip` VARCHAR(64) NOT NULL,
  `port` smallint unsigned DEFAULT 3260,
  `state` VARCHAR(32) NOT NULL,
  `chapUserName` VARCHAR(256) DEFAULT NULL,
  `chapUserPassword` VARCHAR(256) DEFAULT NULL,
  `lastOpDate` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `createDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`uuid`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `IscsiServerClusterRefVO` (
  `id` bigint unsigned NOT NULL UNIQUE AUTO_INCREMENT,
  `clusterUuid` VARCHAR(32) NOT NULL,
  `iscsiServerUuid` VARCHAR(32) NOT NULL,
  `lastOpDate` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `createDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  CONSTRAINT `fkIscsiServerClusterRefVOIscsiServerVO` FOREIGN KEY (`iscsiServerUuid`) REFERENCES IscsiServerVO (`uuid`) ON DELETE CASCADE,
  CONSTRAINT `fkIscsiServerClusterRefVOClusterEO` FOREIGN KEY (`clusterUuid`) REFERENCES ClusterEO (`uuid`) ON DELETE CASCADE
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `IscsiTargetVO` (
  `uuid` VARCHAR(32) NOT NULL,
  `iqn` VARCHAR(256) NOT NULL,
  `state` VARCHAR(32) NOT NULL,
  `iscsiServerUuid` VARCHAR(32) NOT NULL,
  `lastOpDate` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `createDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`uuid`),
  CONSTRAINT `fkIscsiTargetVOIscsiServerVO` FOREIGN KEY (`iscsiServerUuid`) REFERENCES IscsiServerVO (`uuid`) ON DELETE CASCADE
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `IscsiLunVO` (
  `uuid` VARCHAR(32) NOT NULL,
  `wwid` VARCHAR(256) NOT NULL,
  `vendor` VARCHAR(256) DEFAULT NULL,
  `model` VARCHAR(256) DEFAULT NULL,
  `wwn` VARCHAR(256) DEFAULT NULL,
  `serial` VARCHAR(256) DEFAULT NULL,
  `hctl` VARCHAR(64) DEFAULT NULL,
  `type` VARCHAR(128) NOT NULL,
  `path` VARCHAR(128) DEFAULT NULL,
  `size` bigint unsigned NOT NULL,
  `iscsiTargetUuid` VARCHAR(32) NOT NULL,
  `multipathDeviceUuid` VARCHAR(32) DEFAULT NULL,
  `lastOpDate` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `createDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`uuid`),
  CONSTRAINT `fkIscsiLunVOIscsiTargetVO` FOREIGN KEY (`iscsiTargetUuid`) REFERENCES IscsiTargetVO (`uuid`) ON DELETE CASCADE
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;
