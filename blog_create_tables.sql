# Before running, create the schema named BlogApplication.
# Or just create the schema if necessary.
CREATE SCHEMA IF NOT EXISTS BlogApplication;
USE BlogApplication;

DROP TABLE IF EXISTS Reshares;
DROP TABLE IF EXISTS BlogComments;
DROP TABLE IF EXISTS BlogPosts;
DROP TABLE IF EXISTS BlogUsers;
DROP TABLE IF EXISTS Administrators;
DROP TABLE IF EXISTS Persons;

CREATE TABLE Persons (
  UserName VARCHAR(255),
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  CONSTRAINT pk_Persons_UserName 
	PRIMARY KEY (UserName)
);

CREATE TABLE Administrators (
  UserName VARCHAR(255),
  LastLogin TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_Administrators_UserName
    PRIMARY KEY (UserName),
  CONSTRAINT fk_Administrators_UserName
    FOREIGN KEY (UserName)
    REFERENCES Persons(UserName)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE BlogUsers (
  UserName VARCHAR(255),
  DoB TIMESTAMP NOT NULL,
  StatusLevel ENUM ('novice', 'intermediate', 'advanced'),
  CONSTRAINT pk_BlogUsers_UserName
    PRIMARY KEY (UserName),
  CONSTRAINT fk_BlogUsers_UserName
    FOREIGN KEY (UserName)
    REFERENCES Persons(UserName)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE BlogPosts (
  PostId INT AUTO_INCREMENT,
  Title VARCHAR(255) NOT NULL,
  Picture LONGBLOB,
  Content LONGTEXT,
  Published BOOLEAN DEFAULT FALSE,
  Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UserName VARCHAR(255),
  CONSTRAINT pk_BlogPosts_PostId PRIMARY KEY (PostID),
  CONSTRAINT fk_BlogPosts_UserName
    FOREIGN KEY (UserName)
    REFERENCES BlogUsers(UserName)
    ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE BlogComments (
  CommentId INT AUTO_INCREMENT,
  Content VARCHAR(255) NOT NULL,
  Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UserName VARCHAR(255),
  PostId INT,
  CONSTRAINT pk_BlogComments_CommentId PRIMARY KEY (CommentId),
  CONSTRAINT fk_BlogComments_UserName FOREIGN KEY (UserName)
    REFERENCES BlogUsers(UserName)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_BlogComments_PostId FOREIGN KEY (PostId)
    REFERENCES BlogPosts(PostId)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Reshares (
  ReshareId INT AUTO_INCREMENT,
  UserName VARCHAR(255),
  PostId INT,
  Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_Reshares_ReshareId
    PRIMARY KEY (ReshareId),
  CONSTRAINT fk_Reshares_UserName
    FOREIGN KEY (UserName)
    REFERENCES BlogUsers(UserName)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_Reshares_PostId FOREIGN KEY (PostId)
    REFERENCES BlogPosts(PostId)
    ON UPDATE CASCADE ON DELETE SET NULL
);

