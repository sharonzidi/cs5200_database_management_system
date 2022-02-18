USE BlogApplication;

INSERT INTO Persons(UserName,FirstName,LastName)
  VALUES('Bruce','Bruce','Chhay');
INSERT INTO Persons(UserName,FirstName,LastName)
  VALUES('TT','Tony','Davidson');
INSERT INTO Persons(UserName,FirstName,LastName)
  VALUES('DK','Daniel','Kwan');
INSERT INTO Persons(UserName,FirstName,LastName)
  VALUES('James','James','Marks');
# Equivalently:
#INSERT INTO Persons(UserName,FirstName,LastName)
#  VALUES('Bruce','Bruce','Chhay'),
#  ('TT','Tony','Davidson'),
#  ('DK','Daniel','Kwan'),
#  ('James','James','Marks');


INSERT INTO Administrators(UserName)
  VALUES('Bruce');

INSERT INTO BlogUsers(UserName,DoB,StatusLevel)
  VALUES('Bruce','1990-04-01','novice');
INSERT INTO BlogUsers(UserName,DoB,StatusLevel)
  VALUES('TT','1980-06-10','intermediate');
INSERT INTO BlogUsers(UserName,DoB,StatusLevel)
  VALUES('DK','1992-02-16','novice');
INSERT INTO BlogUsers(UserName,DoB,StatusLevel)
  VALUES('James','1991-01-25','advanced');

INSERT INTO BlogPosts(Title,Content,Published,UserName)
  VALUES('Dancing Cats','cats cats cats',False,'TT');
INSERT INTO BlogPosts(Title,Content,Published,UserName)
  VALUES('Sleeping Cats','cats cats cats',False,'TT');
INSERT INTO BlogPosts(Title,Content,Published,UserName)
  VALUES('Laser Cats','cats cats cats',True,'TT');
INSERT INTO BlogPosts(Title,Content,Published,UserName)
  VALUES('Space Cats','cats cats cats',False,'TT');
INSERT INTO BlogPosts(Title,Content,Published,UserName)
  VALUES('Moar Cats','cats cats cats',True,'TT');
INSERT INTO BlogPosts(Title,Content,Published,UserName)
  VALUES('Singing Dogs','dogs dogs dogs',True,'DK');
INSERT INTO BlogPosts(Title,Content,Published,UserName)
  VALUES('Leaping Dogs','dogs dogs dogs',True,'DK');
INSERT INTO BlogPosts(Title,Content,Published,UserName)
  VALUES('Slow Turtles','turtle',False,'James');
INSERT INTO BlogPosts(Title,Content,Published,UserName)
  VALUES('Fast Turtles','turtle',False,'James');

UPDATE BlogPosts
  SET Published=True
  WHERE Title='Dancing Cats' AND UserName = 'TT';

INSERT INTO BlogComments(PostId,UserName,Content,Created)
  VALUES(1,'Bruce','Partayyy!','2015-02-01');
INSERT INTO BlogComments(PostId,UserName,Content,Created)
  VALUES(7,'James','Woof','2015-02-03');
INSERT INTO BlogComments(PostId,UserName,Content,Created)
  VALUES(5,'Bruce','Yawn','2015-02-01');
INSERT INTO BlogComments(PostId,UserName,Content,Created)
  VALUES(7,'Bruce','Adorable','2015-02-02');
INSERT INTO BlogComments(PostId,UserName,Content,Created)
  VALUES(1,'Bruce','Roar','2015-02-02');
INSERT INTO BlogComments(PostId,UserName,Content,Created)
  VALUES(2,'TT', 'First','2015-02-02');
INSERT INTO BlogComments(PostId,UserName,Content,Created)
  VALUES(6,'James','Woof','2015-02-03');
INSERT INTO BlogComments(PostId,UserName,Content,Created)
  VALUES(6,'James','Woof','2015-02-03');
INSERT INTO BlogComments(PostId,UserName,Content,Created)
  VALUES(6,'James','Woof2','2015-02-04');

INSERT INTO Reshares(UserName,PostId)
  SELECT 'James', BlogPosts.PostId
  FROM BlogPosts
  WHERE BlogPosts.Published = True;

INSERT INTO Reshares(UserName,PostId)
  VALUES('Bruce',1);
INSERT INTO Reshares(UserName,PostId)
  VALUES('DK',1);
INSERT INTO Reshares(UserName,PostId)
  VALUES('DK',3);
  
LOAD DATA INFILE '/tmp/persons.csv' INTO TABLE Persons
  FIELDS TERMINATED BY ',' ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES;

/**
You may need LOAD DATA LOCAL INFILE for Workbench 6.3, but remove LOCAL for Workbench 8.0+.
Contents of /tmp/persons.csv:
UserName,FirstName,LastName
"user1","first1","last1"
"user2","first2","last2"
"user3","first3","last3"
*/
