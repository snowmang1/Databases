```mysql
-- update availability on check out
DROP TRIGGER IF EXISTS `update_aval`;
CREATE TRIGGER `update_aval` AFTER INSERT
    ON `Check_Out` FOR EACH ROW
BEGIN
    CALL getDueDate(NEW.ISBN, NEW.Copy_num, @DUE);
    IF @DUE>=curdate() THEN
        UPDATE `Book_Copy`
        SET
            `Availability` = false
        WHERE
            `ISBN` = NEW.ISBN AND
            `Copy_num` = NEW.Copy_num AND
            `Availability` = true;
    END IF;
END;
```
```mysql
-- restrict check_out if book is not available
DROP TRIGGER IF EXISTS `isAval`;
CREATE TRIGGER `isAval` BEFORE INSERT
    ON `Check_Out` FOR EACH ROW
BEGIN
    SELECT COUNT(*) INTO @COUNT FROM `Book_Copy` WHERE `ISBN` = NEW.ISBN AND
        `Copy_num` = NEW.Copy_num AND `Availability` = 0;
    IF @COUNT>0 THEN
        CALL getDueDate(NEW.ISBN, NEW.Copy_num, @DUE);
        CALL getCheckDate(NEW.ISBN, NEW.Copy_num, @CHECK);
        CALL getNewDueDate(NEW.ISBN, NEW.Copy_num, NEW.Checkout_date, @NEWDUE);
        IF (@DUE>=NEW.Checkout_date AND @CHECK<=NEW.Checkout_date) OR @NEWDUE>=@CHECK THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot Check_Out Unavailable Item.';
        END IF;
    END IF;
END;
```
```mysql
-- Check_Out(Checkout_date) cannot be in the future
DROP TRIGGER IF EXISTS `checkDateConstraint`;
CREATE TRIGGER `checkDateConstraint` BEFORE INSERT
    ON `Check_Out` FOR EACH ROW
BEGIN
    IF NEW.Checkout_date>CURRENT_DATE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Checkout_date is Constrained to Past and Present Dates.';
    END IF;
END;
```
[May need to add DELIMITERS](https://www.mysqltutorial.org/mysql-triggers/mysql-after-insert-trigger/)
```mysql
-- Member cannot check out a book when Strike_Count = 3
CREATE TRIGGER `threeStrikeConstraint` BEFORE INSERT ON `Check_Out` FOR EACH ROW
BEGIN
    CALL getStrikeCount(NEW.Library_ID, @STRIKES);
    IF 3 = @STRIKES THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot Check Out Book When Member Has Three Strikes.';
    END IF;
END;
```
