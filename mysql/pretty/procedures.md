```mysql
-- get quantity from ISBN
DROP PROCEDURE IF EXISTS `getQuantity`;
CREATE PROCEDURE `getQuantity`(in bkId char(17))
BEGIN
    SELECT `Title`, COUNT(*) AS `Quantity`
    FROM `Book_Copy` WHERE `ISBN`=bkId GROUP BY `Title`;
END;
```
```mysql
-- get available copies by condition from ISBN
DROP PROCEDURE IF EXISTS `getAvalCopies`;
CREATE PROCEDURE `getAvalCopies`(in bkId char(17))
BEGIN
    SELECT `Copy_num` AS `Available Copies`, `Condition`
    FROM `Book_Copy` WHERE `ISBN`=bkId AND `Availability` is true ORDER BY `Condition` desc;
END;
```
```mysql
-- show due date from ISBN and C_n
DROP PROCEDURE IF EXISTS `showDueDate`;
CREATE PROCEDURE `showDueDate`(in bID char(17), in cID tinyint unsigned)
-- bID is ISBN, cID is Copy_num
BEGIN
    SET @MULTIPLIER=(SELECT `Renewal` FROM `Book_Copy` WHERE (`ISBN`=bID AND
        `Copy_num`=cID))+1;
    IF @MULTIPLIER<=0 THEN
        SET @MULTIPLIER=1;
    END IF;
    SELECT `Checkout_date`, DATE(ADDDATE(`Checkout_date`, INTERVAL 7*@MULTIPLIER DAY))
        AS `Due_date`
    FROM `Check_Out`
    WHERE `ISBN`=bID AND `Copy_num`=cID;
END;
```
```mysql
-- get due date from ISBN and C_n
DROP PROCEDURE IF EXISTS `getDueDate`;
CREATE PROCEDURE `getDueDate`(in bID char(17), in cID tinyint unsigned, out due date)
-- bID is ISBN, cID is Copy_num, date is returned due_date
BEGIN
    SET @MULTIPLIER=(SELECT `Renewal` FROM `Book_Copy` WHERE (`ISBN`=bID AND
        `Copy_num`=cID))+1;
    IF @MULTIPLIER<=0 THEN
        SET @MULTIPLIER=1;
    END IF;
    SET due=(SELECT DATE(ADDDATE(`Checkout_date`, INTERVAL 7*@MULTIPLIER DAY)) FROM `Check_Out` WHERE `ISBN`=bID AND `Copy_num`=cID LIMIT 1);
END;
```
```mysql
-- get checkout date from ISBN and C_n
DROP PROCEDURE IF EXISTS `getCheckDate`;
CREATE PROCEDURE `getCheckDate`(in bID char(17), in cID tinyint unsigned, out checkout date)
-- bID is ISBN, cID is Copy_num, date is returned Checkout_date
BEGIN
    SET checkout=(SELECT `Checkout_date` FROM `Check_Out` WHERE `ISBN`=bID AND `Copy_num`=cID LIMIT 1);
END;
```
```mysql
-- get Renewal from a Book_Copy
DROP PROCEDURE IF EXISTS `getRenewal`;
CREATE PROCEDURE `getRenewal`(in bID char(17), in cID tinyint unsigned, out renew tinyint unsigned)
-- bID is ISBN, cID is Copy_num, times renewed (Renewal) is returned as int
BEGIN
    SELECT `Renewal` INTO renew FROM `Book_Copy` WHERE (`ISBN`=bID AND `Copy_num`=cID);
END;
```
```mysql
-- get new due date
DROP PROCEDURE IF EXISTS `getNewDueDate`;
CREATE PROCEDURE `getNewDueDate`(in bID char(17), in cID tinyint unsigned, in cDT date, out dDT date)
-- bID is ISBN, cID is Copy_num, cDT is checkout_date, dDt is returned due_date
BEGIN
    CALL getRenewal(bID,cID,@RENEW);
    SET @RENEW = @RENEW + 1;
    IF @RENEW>1 THEN
        SET dDT=(DATE(ADDDATE(cDT, INTERVAL 7*@RENEW DAY)));
    ELSE
        SET dDT=(DATE(ADDDATE(cDT, INTERVAL 7*1 DAY)));
    END IF;
END;
```
```mysql
-- get Strike_Count of a Member
DROP PROCEDURE IF EXISTS `getStrikeCount`;
CREATE PROCEDURE `getStrikeCount`(in lID char(10), out strkCnt tinyint unsigned)
-- lID is Library_ID, strkCnt is returned Strike_Count
BEGIN
	SELECT `Strike_Count` INTO strkCnt FROM `Member` WHERE `Library_ID` = lID;
END;
```
```mysql
-- get all books from Book_Copy with a certain genre
DROP PROCEDURE IF EXISTS `getAllFromGenre`;
CREATE PROCEDURE `getAllFromGenre`(in gen varchar(128))
-- gen is Genre
BEGIN
	SELECT `ISBN`, `Title`, `Copy_num`, `Availability` FROM `Book_Copy` WHERE `Genre` = gen;
END;
```
