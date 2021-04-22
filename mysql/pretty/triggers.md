```mysql
-- update availability on check out
DROP TRIGGER IF EXISTS `update_aval`;
CREATE TRIGGER `update_aval` AFTER INSERT
    ON `Check_Out` FOR EACH ROW
BEGIN
    UPDATE `Book_Copy`
    SET
        `Availability` = false
    WHERE
        `ISBN` = NEW.ISBN AND
        `Copy_num` = NEW.Copy_num AND
        `Availability` = true;
END;
```
[May need to add DELIMITERS](https://www.mysqltutorial.org/mysql-triggers/mysql-after-insert-trigger/)