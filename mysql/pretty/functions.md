```mysql
-- getName: given a LibraryID, return a name
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS `getName`;
CREATE FUNCTION `getName`(lID char(10)) RETURNS VARCHAR(32)
-- lID is Library_ID, returns Name1 as Name
BEGIN
    DECLARE `Name1` VARCHAR(32) DEFAULT "N/A";
    SELECT `Name` INTO `Name1` FROM `Member` WHERE `Library_ID` = lID;
    RETURN `Name1`;
END;
```