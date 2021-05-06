```mysql
-- show quantity from ISBN
DROP PROCEDURE IF EXISTS `showQuantity`;
CREATE PROCEDURE `showQuantity`(in bkId char(17))
BEGIN
    SELECT `Title`, COUNT(*) AS `Quantity`
    FROM `Book_Copy` WHERE `ISBN`=bkId GROUP BY `Title`;
END;
```
```mysql
-- show available copies by condition from ISBN
DROP PROCEDURE IF EXISTS `showAvalCopies`;
CREATE PROCEDURE `showAvalCopies`(in bkId char(17))
BEGIN
    SELECT `Copy_num` AS `Available Copies`, `Condition`
    FROM `Book_Copy` WHERE `ISBN`=bkId AND `Availability` is true ORDER BY `Condition` desc;
END;
```
```mysql
-- show due date from ISBN and C_n
DROP PROCEDURE IF EXISTS `showDueDates`;
CREATE PROCEDURE `showDueDates`(in bID char(17), in cID tinyint unsigned)
-- bID is ISBN, cID is Copy_num
BEGIN
    CALL getRenewal(bID,cID,@MULTIPLIER);
    SET @MULTIPLIER = @MULTIPLIER+1;
    IF @MULTIPLIER<1 THEN
        SET @MULTIPLIER=1;
    END IF;
    SELECT `Checkout_date`, DATE(ADDDATE(`Checkout_date`, INTERVAL 7*@MULTIPLIER DAY)) AS `Due_date`
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
    CALL getRenewal(bID,cID,@MULTIPLIER);
    SET @MULTIPLIER=@MULTIPLIER+1;
    IF @MULTIPLIER<=0 THEN
        SET @MULTIPLIER=1;
    END IF;
    SET due=(SELECT DATE(ADDDATE(MAX(`Checkout_date`), INTERVAL 7*@MULTIPLIER DAY)) FROM `Check_Out` WHERE
             (`ISBN`=bID AND `Copy_num`=cID) LIMIT 1);
END;
```
```mysql
-- get latest checkout date from ISBN and C_n
DROP PROCEDURE IF EXISTS `getCheckDate`;
CREATE PROCEDURE `getCheckDate`(in bID char(17), in cID tinyint unsigned, out checkout date)
-- bID is ISBN, cID is Copy_num, date is returned Checkout_date
BEGIN
    SET checkout=(SELECT MAX(`Checkout_date`) FROM `Check_Out` WHERE `ISBN`=bID AND `Copy_num`=cID LIMIT 1);
END;
```
```mysql
-- get Renewal from latest Check_Out given: bID, cID
DROP PROCEDURE IF EXISTS `getRenewal`;
CREATE PROCEDURE `getRenewal`(in bID char(17), in cID tinyint unsigned, out renew tinyint unsigned)
-- bID is ISBN, cID is Copy_num, times renewed (Renewal) is returned as int
BEGIN
    IF (SELECT COUNT(*) FROM `Check_Out` WHERE `ISBN`=bID AND `Copy_num`=cID)>0 THEN
        SELECT `Renewal` INTO renew FROM `Check_Out` WHERE
        (
            `Checkout_date` IN (SELECT MAX(`Checkout_date`) FROM `Check_Out` WHERE
                (
                    `ISBN`=bID AND `Copy_num`=cID
                ))
        )LIMIT 1;
    ELSE
        SET renew=0;
    END IF;
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
-- show all books from Book_Copy with a certain genre
DROP PROCEDURE IF EXISTS `showAllFromGenre`;
CREATE PROCEDURE `showAllFromGenre`(in gen varchar(128))
-- gen is Genre
BEGIN
	SELECT `ISBN`, `Title`, `Copy_num`, `Availability` FROM `Book_Copy` WHERE `Genre` = gen;
END;
```
```mysql
-- show Check_Out Table
DROP PROCEDURE IF EXISTS `showCheckOut`;
CREATE PROCEDURE `showCheckOut`()
-- prints all data from Check_Out attaching Names to Library_IDs
-- ordered by checkout_date
BEGIN
    SELECT
        C.`Library_ID`,
        `getName`(C.`Library_ID`) AS `Name`,
        C.`ISBN`,
        B.`Title`,
        B.`Author`,
        C.`Copy_num`,
        C.`Checkout_date`,
        getDDbCD(C.`ISBN`,C.`Copy_num`,C.`Checkout_date`) AS `Due_date`,
        C.`Renewal` AS `Renewed`
    FROM 
        `Check_Out` AS C,
        `Book_Copy` AS B
    WHERE
    (
        B.`ISBN` = C.`ISBN`
    AND B.`Copy_num` = C.`Copy_num`
    )
    ORDER BY C.`Checkout_date`;
END;
```
## Report Procedures
```mysql
-- show list of authors sorted by popularity
DROP PROCEDURE IF EXISTS `showPopAuth`;
CREATE PROCEDURE `showPopAuth`()
-- prints 2 columns:
-- Author name, popularity rating
-- 2nd col is # of checkout's where author's book was checked out
BEGIN
    Select
        B.`Author`,
        COUNT(C.`ISBN`) AS `Popularity`
    FROM
        `Book_Copy` AS B,
        `Check_Out` AS C
    WHERE
    (
        B.`ISBN` = C.`ISBN`
    AND B.`Copy_num` = C.`Copy_num`
    )GROUP BY `Author`
    ORDER BY `Popularity` DESC;
END;
```
```mysql
-- show list of books sorted by popularity
DROP PROCEDURE IF EXISTS `showPopBook`;
CREATE PROCEDURE `showPopBook`()
-- prints 2 cols: Book Title, pop. rating
-- pop. rating is number of times book was checked out
BEGIN
    SELECT
        B.`Title`,
        COUNT(C.`ISBN`) AS `Popularity`
    FROM
        `Book_Copy` AS B,
        `Check_Out` AS C
    WHERE
    (
        B.`ISBN` = C.`ISBN`
    AND B.`Copy_num` = C.`Copy_num`
    )GROUP BY `Title`
    ORDER BY `Popularity` DESC;
END;
```
