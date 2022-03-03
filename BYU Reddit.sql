CREATE TABLE "USER"
(
  UserName varchar NOT NULL,
  Password varchar NOT NULL,
  Email varchar NOT NULL,
  Phone varchar,
  Role varchar NOT NULL,
  Bio varchar,
  UserID serial NOT NULL,
  PRIMARY KEY (UserID),
  UNIQUE (UserName)
);

CREATE TABLE "COMMUNITY"
(
  CommunityName varchar NOT NULL,
  Description varchar,
  CommunityID serial NOT NULL,
  CreateDate date NOT NULL,
  PRIMARY KEY (CommunityID),
  UNIQUE (CommunityName)
);

CREATE TABLE "POST"
(
  PostID serial NOT NULL,
  PostContent varchar NOT NULL,
  VoteScore INT NOT NULL,
  PostDateTime timestamp NOT NULL,
  CommunityID serial NOT NULL,
  UserID serial NOT NULL,
  PRIMARY KEY (PostID),
  FOREIGN KEY (UserID) REFERENCES "USER"(UserID),
  FOREIGN KEY (CommunityID) REFERENCES "COMMUNITY"(CommunityID)
);

CREATE TABLE "MEMBEROF"
(
  CommunityRole varchar NOT NULL,
  RelationID serial NOT NULL,
  UserID serial NOT NULL,
  CommunityID serial NOT NULL,
  PRIMARY KEY (RelationID),
  FOREIGN KEY (UserID) REFERENCES "USER"(UserID),
  FOREIGN KEY (CommunityID) REFERENCES "COMMUNITY"(CommunityID),
  UNIQUE (UserID, CommunityID)
);

CREATE TABLE "COMMENT"
(
  CommentID serial NOT NULL,
  CommentText varchar NOT NULL,
  VoteScore INT NOT NULL,
  CommentDateTime timestamp NOT NULL,
  UserID serial NOT NULL,
  PostID serial NOT NULL,
  Parent_CommentID serial,
  PRIMARY KEY (CommentID),
  FOREIGN KEY (UserID) REFERENCES "USER"(UserID),
  FOREIGN KEY (PostID) REFERENCES "POST"(PostID),
  FOREIGN KEY (Parent_CommentID) REFERENCES "COMMENT"(CommentID)
);