```mysql
DELIMITER ;;
-- getName: given a LibraryID, return a name
SET GLOBAL log_bin_trust_function_creators = 1;;
DROP FUNCTION IF EXISTS `getName`;;
CREATE FUNCTION `getName`(lID char(10)) RETURNS VARCHAR(32)
-- lID is Library_ID, returns Name1 as Name
BEGIN
    DECLARE `Name1` VARCHAR(32) DEFAULT "N/A";
    SELECT `Name` INTO `Name1` FROM `Member` WHERE `Library_ID` = lID;
    RETURN `Name1`;
END;;
DELIMITER ;
```
```mysql
DELIMITER ;;
-- get DueDate by CheckDate
SET GLOBAL log_bin_trust_function_creators = 1;;
DROP FUNCTION IF EXISTS `getDDbCD`;;
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
END;;
DELIMITER ;
```
```mysql
DELIMITER ;;
-- get Time_overdue from Check_Out
SET GLOBAL log_bin_trust_function_creators = 1;;
DROP FUNCTION IF EXISTS `getTimeOverdue`;;
CREATE FUNCTION `getTimeOverdue`(lID char(10), bID char(17), cID tinyint unsigned) RETURNS int
-- lID is Library_ID, bID is ISBN, cID is Copy_num, returns number of days overdue
BEGIN
    DECLARE `DUE` DATE DEFAULT NULL;
    DECLARE `CHECK` DATE DEFAULT NULL;
    IF (SELECT COUNT(*) FROM `Overdue_Books` WHERE `Library_ID`=lID AND `ISBN`=bID AND `Copy_num`=cID)>0 THEN
        SELECT `Checkout_date` INTO `CHECK` FROM `Check_Out` WHERE `Library_ID`=lID AND `Copy_num`=cID AND `ISBN`=bID;
        SET `DUE` = getDDbCD(bID,cID,`CHECK`);
        RETURN DATEDIFF(curdate(),`DUE`);
    ELSE
        RETURN 0;
    END IF;
END;;
DELIMITER ;
```
```mysql
DELIMITER ;;
-- get Amount_owed from Check_Out
SET GLOBAL log_bin_trust_function_creators = 1;;
DROP FUNCTION IF EXISTS `getOwed`;;
CREATE FUNCTION `getOwed`(lID char(10), bID char(17), cID tinyint unsigned) RETURNS DECIMAL(5,2)
-- lID is Library_ID, bID is ISBN, cID is Copy_num, returns amount owed for a given overdue book in dollars
BEGIN
    DECLARE `timeOD` INT DEFAULT getTimeOverdue(lID,bID,cID);
    DECLARE `amtOwed` DECIMAL(5,2) DEFAULT 0.00;
    IF `timeOD`>0 THEN
        SET `amtOwed` = `timeOD`*4.2;
        RETURN `amtOwed`;
    ELSE
        RETURN `amtOwed`;
    END IF;
END;;
DELIMITER ;
```
```mysql
DELIMITER ;;
-- get Outstanding_Balance
DROP FUNCTION IF EXISTS `getBalance`;;
CREATE FUNCTION `getBalance`(lID char(10)) RETURNS DECIMAL(5,2)
-- gets a Member's Outstanding Balance
-- requires Member's Library_ID
BEGIN
    DECLARE `amtOwed` DECIMAL(5,2) DEFAULT 0.00;
    DECLARE `counter` TINYINT UNSIGNED DEFAULT 0;
    SELECT COUNT(*) INTO `counter` FROM `Overdue_Books` WHERE `Library_ID`=lID;
    IF `counter`>0 THEN
        SELECT SUM(getOwed(`Library_ID`,`ISBN`,`Copy_num`)) INTO `amtOwed` FROM `Check_Out` WHERE `Library_ID`=lID;
    END IF;
    RETURN `amtOwed`;
END;;
DELIMITER ;
```
