## Book_Copy Data
```mysql
INSERT INTO book_copy
VALUES 
('The Da Vinci Code','Dan Brown','Mystery Thriller',DEFAULT,689,1,4,1,"9780385504201"),
('The Da Vinci Code','Dan Brown','Mystery Thriller',DEFAULT,689,1,1,2,"9780385504201"),
('The Da Vinci Code','Dan Brown','Mystery Thriller',DEFAULT,689,1,5,3,"9780385504201"),
('Harry Potter and the Philosopher\'s Stone','J. K. Rowling','Fantasy',DEFAULT,309,5,3,2,"9780747532743"),
('Harry Potter and the Philosopher\'s Stone','J. K. Rowling','Fantasy',DEFAULT,309,5,1,1,"9780747532743"),
('The Hobbit','	J. R. R. Tolkien','High fantasy',DEFAULT,310,2,5,1,"9780547928227"),
('The Hobbit','	J. R. R. Tolkien','High fantasy',DEFAULT,310,2,5,2,"9780547928227"),
('The Lion, the Witch and the Wardrobe','C. S. Lewis','Children\'s fantasy',DEFAULT,208,1,2,1,"9780001857018"),
('The Lion, the Witch and the Wardrobe','C. S. Lewis','Children\'s fantasy',DEFAULT,208,1,3,2,"9780001857018"),
('The Bridges of Madison County','Robert James Waller','Romance novel',DEFAULT,192,1,4,1,"9780446364492"),
('The Bridges of Madison County','Robert James Waller','Romance novel',DEFAULT,192,1,3,2,"9780446364492"),
('Black Beauty','Anna Sewell','Novel',DEFAULT,255,1,5,1,"9781613821008"),
('Black Beauty','Anna Sewell','Novel',DEFAULT,255,1,3,2,"9781613821008"),
('Charlotte\'s Web','E. B. White','Children\'s literature',DEFAULT,192,1,4,1,"9780062658753"),
('Charlotte\'s Web','E. B. White','Children\'s literature',DEFAULT,192,1,3,2,"9780062658753"),
('Charlotte\'s Web','E. B. White','Children\'s literature',DEFAULT,192,1,3,3,"9780062658753"),
('To Kill a Mockingbird','Harper Lee','Southern Gothic',DEFAULT,281,1,4,1,"9780446310789"),
('To Kill a Mockingbird','Harper Lee','Southern Gothic',DEFAULT,281,1,1,2,"9780446310789"),
('To Kill a Mockingbird','Harper Lee','Southern Gothic',DEFAULT,281,1,3,3,"9780446310789"),
('To Kill a Mockingbird','Harper Lee','Southern Gothic',DEFAULT,281,1,4,4,"9780446310789");
```
## Member Data
```mysql
INSERT INTO Member
VALUES
('Jeremiah Mojang','6900720420','123 Any Street, APT 6',95926,'Chico','CA',0,'4767718464004078',NULL),
('Max King','6900719356',NULL,NULL,NULL,NULL,1,'4767718464694209',3.50),
('Cole Hothead','6900719369',NULL,NULL,NULL,'CA',0,'4767818474664511',1.20),
('Carson Lucasarts','6900712420',NULL,94536,'Fremont','CA',2,'4767818474664511',5.20),
('Evan Dynamix','6900713609','111 Hollywood Blvd',90001,'Los Angeles','CA',3,'4767818474664511',10.55),
('John Valve','6900715776','North Campus',92612,'Irvine','CA',0,'4767818474664511',NULL);
```
## Check_Out Data
```mysql
INSERT INTO Check_Out
VALUES
("6900720420",'2021/04/30',"9780385504201",2,DEFAULT),
("6900720420",'2021/04/30',"9780446364492",2,DEFAULT),
("6900715776",'2021/4/30',"9781613821008",1,1),
("6900712420",'2021/4/30',"9780062658753",3,DEFAULT)
("6900719369",'2021/4/30',"9780446310789",1,DEFAULT);
("6900712420",'2021/4/30',"9780446310789",3,DEFAULT),
("6900719356",'2021/04/21',"9780001857018",1,2),
("6900715776",'2021/4/30',"9780446310789",4,DEFAULT);
```
## Overdue_Books Data
```mysql
INSERT INTO Overdue_Books
VALUES
('6900719356','9780001857018',1);
```
## Preferences Data
```mysql
INSERT INTO Preferences
VALUES
("6900720420","Genre","Romance novel"),
("6900720420","Genre","Mystery Thriller"),
("6900719356","Genre","Fantasy");
```
