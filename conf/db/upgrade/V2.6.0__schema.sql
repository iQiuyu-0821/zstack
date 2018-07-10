CREATE TABLE IF NOT EXISTS `CaptchaVO` (
    `uuid` VARCHAR(32) NOT NULL,
    `captcha` text NOT NULL,
    `verifyCode` VARCHAR(32) NOT NULL,
    `targetResourceUuid` VARCHAR(32) NOT NULL,
    `attempts` int(10) unsigned DEFAULT 0,
    `lastOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
    `createDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
    PRIMARY KEY (`uuid`),
    UNIQUE KEY `targetResourceUuid` (`targetResourceUuid`),
    UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;