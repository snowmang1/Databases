```mysql
SET GLOBAL event_scheduler = ON;
DROP EVENT IF EXISTS `updateBalance`;
CREATE EVENT `updateBalance`
    ON SCHEDULE EVERY 1 DAY STARTS CURRENT_TIMESTAMP
    ON COMPLETION PRESERVE
DO
    UPDATE `Member`
    SET
        `Outstanding_Balance`= getBalance(`Library_ID`);
```
