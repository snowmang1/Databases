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
```mysql
-- update quantity after insert of book copy
CREATE TRIGGER update_total_books AFTER INSERT
    ON Book_Copy FOR EACH ROW
BEGIN
    SET @COUNT=(SELECT COUNT(*) FROM Book_Quantity WHERE (ISBN=NEW.ISBN));
    IF @COUNT=0 THEN
        INSERT INTO Book_Quantity VALUES(NEW.ISBN, 1);
    ELSE
        UPDATE Book_Quantity
        SET
            Quantity = Quantity + 1
        WHERE ISBN = NEW.ISBN;
    END IF;
END;
```
[May need to add DELIMITERS](https://www.mysqltutorial.org/mysql-triggers/mysql-after-insert-trigger/)