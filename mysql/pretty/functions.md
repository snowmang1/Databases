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
```mysql
-- get DueDate by CheckDate
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS `getDDbCD`;
CREATE FUNCTION `getDDbCD`(bID char(17), cID tinyint unsigned, cDT date) RETURNS date
-- bID is ISBN, cID is Copy_num, cDT is Check Date, returns due date
BEGIN
    DECLARE `DUEDATE` DATE DEFAULT (DATE(ADDDATE(cDT, INTERVAL 7*1 DAY)));
    DECLARE `RENEW` tinyint unsigned;
    SELECT `Renewal` INTO `RENEW` FROM `Check_Out` WHERE `ISBN`=bID AND `Copy_num`=cID AND `Checkout_date`=cDT;
    SET `RENEW` = `RENEW` + 1;
    IF `RENEW`<1 THEN
        SET `RENEW`=1;
    END IF;
    IF (SELECT COUNT(*) FROM `Check_Out` WHERE `ISBN`=bID AND `Copy_num`=cID AND `Checkout_date`=cDT)>0 THEN
        SELECT DATE(ADDDATE(`Checkout_date`, INTERVAL 7*`RENEW` DAY)) INTO `DUEDATE` FROM `Check_Out` WHERE
            (`ISBN`=bID AND `Copy_num`=cID AND `Checkout_date`=cDT);
        RETURN `DUEDATE`;
    ELSE
        RETURN `DUEDATE`;
    END IF;
END;
```
