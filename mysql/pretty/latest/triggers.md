```mysql
-- update availability on check out
CREATE TRIGGER update_aval AFTER INSERT
    ON Check_Out FOR EACH ROW
BEGIN
    UPDATE Book_Copy
    SET
        Availability = false
    WHERE
        ISBN = NEW.ISBN AND
        Copy_num = NEW.Copy_num;
END;
```
[May need to add DELIMITERS](https://www.mysqltutorial.org/mysql-triggers/mysql-after-insert-trigger/)