```mysql
DROP TABLE IF EXISTS `Member`;
CREATE TABLE Member (
    Name VARCHAR(32) NOT NULL,
    Library_ID CHAR(10) PRIMARY KEY,
    Street VARCHAR(32),
    Zip_Code DECIMAL(6),
    City VARCHAR(32),
    State VARCHAR(2),
    Strike_Count DECIMAL(1) NOT NULL, -- assuming strikes < 10
    Payment_Method VARCHAR(32) NOT NULL, -- credit card details?
    Outstanding_Balance DECIMAL(4,2) CHECK (Outstanding_Balance >= 0)
        -- constrain between $0.00 & $99.99
);
DROP TABLE IF EXISTS `Preferences`;
CREATE TABLE Preferences (
    Library_ID CHAR(10) NOT NULL, -- FK
    type VARCHAR(32), -- assuming text description
    value VARCHAR(32), -- assuming text description/not sure what type
    PRIMARY KEY (Library_ID),
    FOREIGN KEY (Library_ID) REFERENCES Member(Library_ID)
);
DROP TABLE IF EXISTS `Book_Copy`;
CREATE TABLE Book_Copy (
    Title VARCHAR(32) NOT NULL,
    Author VARCHAR(32) NOT NULL,
    Genre VARCHAR(32), -- how large?
    Availability BOOLEAN NOT NULL,
    Page_No MEDIUMINT UNSIGNED NOT NULL,
    Edition TINYINT UNSIGNED,
    `Condition` TINYINT NOT NULL CHECK(`Condition` BETWEEN 0 AND 5), -- amazon review scale
    Renewal TINYINT UNSIGNED NOT NULL DEFAULT(0) CHECK (Renewal BETWEEN 0 AND 5), -- times renewed
    Copy_num TINYINT UNSIGNED NOT NULL CHECK (Copy_num > 0),
    ISBN CHAR(17) NOT NULL,
    PRIMARY KEY(ISBN, Copy_num) -- only ISBN OR Copy_num must be unique
);
DROP TABLE IF EXISTS `Check_Out`;
CREATE TABLE Check_Out (
    Library_ID CHAR(10) NOT NULL, -- FK
    Checkout_date DATE NOT NULL DEFAULT(CURRENT_DATE),
-- Due_date DATE DEFAULT NULL,
    ISBN CHAR(17) NOT NULL, -- FK
    Copy_num TINYINT UNSIGNED NOT NULL, -- FK
    PRIMARY KEY (Library_ID, ISBN, Copy_num),
    FOREIGN KEY (Library_ID) REFERENCES Member(Library_ID),
    FOREIGN KEY (ISBN, Copy_num) REFERENCES Book_Copy(ISBN, Copy_num)
);
DROP TABLE IF EXISTS Overdue_Books;
CREATE TABLE Overdue_Books (
    Library_ID CHAR(10) NOT NULL, -- FK
    ISBN CHAR(17) NOT NULL, -- FK
    Copy_num TINYINT UNSIGNED NOT NULL, -- FK
    PRIMARY KEY (Library_ID, ISBN, Copy_num),
    FOREIGN KEY (Library_ID) REFERENCES Member(Library_ID),
    FOREIGN KEY (ISBN, Copy_num) REFERENCES Book_Copy(ISBN, Copy_num)
);
```