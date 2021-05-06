```mysql
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `Member`;
CREATE TABLE `Member` (
    `Name` VARCHAR(32) NOT NULL,
    `Library_ID` CHAR(10) PRIMARY KEY,
    `Street` VARCHAR(32),
    `Zip_Code` DECIMAL(6),
    `City` VARCHAR(32),
    `State` CHAR(2),
    `Strike_Count` TINYINT UNSIGNED NOT NULL DEFAULT(0) CHECK (`Strike_Count` BETWEEN 0 AND 3), -- assuming baseball
    `Payment_Method` VARCHAR(32) NOT NULL,
    `Outstanding_Balance` DECIMAL(4,2) CHECK (`Outstanding_Balance` BETWEEN 0.00 AND 100.00)
        /* constrain between $0.00 & $99.99 */
);
DROP TABLE IF EXISTS `Preferences`;
CREATE TABLE `Preferences` (
    `Library_ID` CHAR(10) NOT NULL, -- FK
    `type` VARCHAR(32), -- assuming text description
    `value` VARCHAR(32), -- assuming text description/not sure what type
    KEY (`Library_ID`),
    FOREIGN KEY (`Library_ID`) REFERENCES `Member`(`Library_ID`)
);
DROP TABLE IF EXISTS `Book_Copy`;
CREATE TABLE `Book_Copy` (
    `Title` VARCHAR(255) NOT NULL,
    `Author` VARCHAR(255) NOT NULL,
    `Genre` VARCHAR(128), -- how large?
    `Availability` BOOLEAN NOT NULL DEFAULT TRUE,
    `Page_No` MEDIUMINT UNSIGNED NOT NULL,
    `Edition` TINYINT UNSIGNED DEFAULT NULL,
    `Condition` TINYINT NOT NULL CHECK(`Condition` BETWEEN 0 AND 5), -- amazon review scale
--  `Renewal` TINYINT UNSIGNED NOT NULL DEFAULT(0) CHECK (`Renewal` BETWEEN 0 AND 5), -- times renewed
    `Copy_num` TINYINT UNSIGNED NOT NULL CHECK (`Copy_num` > 0),
    `ISBN` CHAR(17) NOT NULL,
    PRIMARY KEY(`ISBN`, `Copy_num`) -- only ISBN OR Copy_num must be unique
);
DROP TABLE IF EXISTS `Check_Out`;
CREATE TABLE `Check_Out` (
    `Library_ID` CHAR(10) NOT NULL, -- FK
    `Checkout_date` DATE NOT NULL DEFAULT(CURRENT_DATE),
    `ISBN` CHAR(17) NOT NULL, -- FK
    `Copy_num` TINYINT UNSIGNED NOT NULL, -- FK
    `Renewal` TINYINT UNSIGNED NOT NULL DEFAULT(0) CHECK (`Renewal` BETWEEN 0 AND 4), -- times renewed
    PRIMARY KEY (`Library_ID`, `ISBN`, `Copy_num`, `Checkout_date`), -- Now Primary Key, added cDT
    FOREIGN KEY (`Library_ID`) REFERENCES `Member`(`Library_ID`),
    FOREIGN KEY (`ISBN`, `Copy_num`) REFERENCES `Book_Copy`(`ISBN`, `Copy_num`)
);
DROP TABLE IF EXISTS `Overdue_Books`;
CREATE TABLE `Overdue_Books` (
    `Library_ID` CHAR(10) NOT NULL, -- FK
    `ISBN` CHAR(17) NOT NULL, -- FK
    `Copy_num` TINYINT UNSIGNED NOT NULL, -- FK
    PRIMARY KEY (`Library_ID`, `ISBN`, `Copy_num`),
    UNIQUE KEY `Overdue_books` (`ISBN`,`Copy_num`), -- valid multi-valued attribute
    FOREIGN KEY (`Library_ID`) REFERENCES `Member`(`Library_ID`),
    FOREIGN KEY (`ISBN`, `Copy_num`) REFERENCES `Book_Copy`(`ISBN`, `Copy_num`)
);
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
```
