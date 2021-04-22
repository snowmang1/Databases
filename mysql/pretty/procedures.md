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
-- get due date from ISBN and C_n
DROP PROCEDURE IF EXISTS `getDueDate`;
CREATE PROCEDURE `getDueDate`(in bID char(17), cID tinyint unsigned)
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