INSERT INTO book_copy
VALUES 
('The Da Vinci Code','Dan Brown','Mystery Thriller',TRUE,689,1,4,DEFAULT,1,"9780385504201"),
('The Da Vinci Code','Dan Brown','Mystery Thriller',FALSE,689,1,1,DEFAULT,2,"9780385504201"),
('The Da Vinci Code','Dan Brown','Mystery Thriller',TRUE,689,1,5,DEFAULT,3,"9780385504201"),
('Harry Potter and the Philosopher\'s Stone','J. K. Rowling','Fantasy',TRUE,309,5,3,DEFAULT,2,"9780747532743"),
('Harry Potter and the Philosopher\'s Stone','J. K. Rowling','Fantasy',TRUE,309,5,1,DEFAULT,1,"9780747532743"),
('The Hobbit','	J. R. R. Tolkien','High fantasy',TRUE,310,2,5,DEFAULT,1,"9780547928227"),
('The Hobbit','	J. R. R. Tolkien','High fantasy',TRUE,310,2,5,DEFAULT,2,"9780547928227"),
('The Lion, the Witch and the Wardrobe','C. S. Lewis','Children\'s fantasy',FALSE,208,1,2,DEFAULT,1,"9780001857018"),
('The Lion, the Witch and the Wardrobe','C. S. Lewis','Children\'s fantasy',TRUE,208,1,3,DEFAULT,2,"9780001857018"),
('The Bridges of Madison County','Robert James Waller','Romance novel',TRUE,192,1,4,DEFAULT,1,"9780446364492"),
('The Bridges of Madison County','Robert James Waller','Romance novel',FALSE,192,1,3,DEFAULT,2,"9780446364492"),
('Black Beauty','Anna Sewell','Novel',FALSE,255,1,5,DEFAULT,1,"9781613821008"),
('Black Beauty','Anna Sewell','Novel',TRUE,255,1,3,DEFAULT,2,"9781613821008"),
('Charlotte\'s Web','E. B. White','Children\'s literature',TRUE,192,1,4,DEFAULT,1,"9780062658753"),
('Charlotte\'s Web','E. B. White','Children\'s literature',TRUE,192,1,3,DEFAULT,2,"9780062658753"),
('Charlotte\'s Web','E. B. White','Children\'s literature',FALSE,192,1,3,DEFAULT,3,"9780062658753"),
('To Kill a Mockingbird','Harper Lee','Southern Gothic',FALSE,281,1,4,DEFAULT,1,"9780446310789"),
('To Kill a Mockingbird','Harper Lee','Southern Gothic',TRUE,281,1,1,DEFAULT,2,"9780446310789"),
('To Kill a Mockingbird','Harper Lee','Southern Gothic',FALSE,281,1,3,DEFAULT,3,"9780446310789"),
('To Kill a Mockingbird','Harper Lee','Southern Gothic',FALSE,281,1,4,DEFAULT,4,"9780446310789")
;
/*
  `Title` varchar(32) NOT NULL,
  `Author` varchar(32) NOT NULL,
  `Genre` varchar(32) DEFAULT NULL,
  `Availability` tinyint(1) NOT NULL,
  `Page_No` mediumint unsigned NOT NULL,
  `Edition` tinyint unsigned DEFAULT NULL,
  `Condition` tinyint NOT NULL,
  `Renewal` tinyint unsigned NOT NULL DEFAULT (0),
  `Copy_num` tinyint unsigned NOT NULL,
  `ISBN` char(17) NOT NULL,
  */
  
  INSERT INTO Member
  VALUES
  ('Jeremiah Mojang','6900720420','123 Any Street, APT 6',95926,'Chico','CA',0,'4767718464004078',NULL),
  ('Max King','6900719356',NULL,NULL,NULL,NULL,1,'4767718464694209',3.50),
  ('Cole Hothead','6900719369',NULL,NULL,NULL,'CA',0,'4767818474664511',1.20),
  ('Carson Lucasarts','6900712420',NULL,94536,'Fremont','CA',2,'4767818474664511',5.20),
  ('Evan Dynamix','6900713609','111 Hollywood Blvd',90001,'Los Angeles','CA',3,'4767818474664511',10.55),
  ('John Valve','6900715776','North Campus',92612,'Irvine','CA',0,'4767818474664511',NULL)
  ;
  /*`Name` varchar(32) NOT NULL,
  `Library_ID` char(10) NOT NULL,
  `Street` varchar(32) DEFAULT NULL,
  `Zip_Code` decimal(6,0) DEFAULT NULL,
  `City` varchar(32) DEFAULT NULL,
  `State` varchar(2) DEFAULT NULL,
  `Strike_Count` decimal(1,0) NOT NULL,
  `Payment_Method` varchar(32) NOT NULL,
  `Outstanding_Balance` decimal(4,2) DEFAULT NULL,*/
  
INSERT INTO Check_Out
VALUES
("6900720420",'2021/04/20',"9780385504201",2),
("6900720420",'2021/04/20',"9780446364492",2),
("6900713609",'2021/4/21',"9780446364492",2),
("6900715776",'2021/4/21',"9781613821008",1),
("6900712420",'2021/4/21',"9780062658753",3),
("6900719369",'2021/4/21',"9780446310789",1),
("6900712420",'2021/4/21',"9780446310789",3),
("6900715776",'2021/4/21',"9780446310789",4),
("6900719356",'2021/04/11',"9780001857018",1)
;
/*`Library_ID` char(10) NOT NULL,
  `Checkout_date` date NOT NULL DEFAULT (curdate()),
  `ISBN` char(17) NOT NULL,
  `Copy_num` tinyint unsigned NOT NULL,*/
  
  INSERT INTO Overdue_Books
  VALUES
  ('6900719356','9780001857018',1)
  ;
  /*`Library_ID` char(10) NOT NULL,
  `ISBN` char(17) NOT NULL,
  `Copy_num` tinyint unsigned NOT NULL,*/
  
  INSERT INTO Preferences
  VALUES
  ("6900720420","Genre","Romance novel"),
  ("6900720420","Genre","Mystery Thriller"),
  ("6900719356","Genre","Fantasy")
  ;
  /*`Library_ID` char(10) NOT NULL,
  `type` varchar(32) DEFAULT NULL,
  `value` varchar(32) DEFAULT NULL,*/