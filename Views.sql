--Feed
CREATE VIEW feed AS
 SELECT DISTINCT "USER".userid,
    "USER".username,
    "USER".profilepicture,
    "POST".postid,
    "POST".communityid,
    "POST".userid AS posterid,
    "POST".title AS posttitle,
    "POST".content AS postcontent,
    "POST".postdatetime,
    "POST".votescore,
    "COMMUNITY".communityname,
    "COMMUNITY".communitypicture,
    comment_totals.num_comments
   FROM "USER"
     JOIN "MEMBEROF" ON "MEMBEROF".userid = "USER".userid
     JOIN "COMMUNITY" ON "MEMBEROF".communityid = "COMMUNITY".communityid
     JOIN "POST" ON "COMMUNITY".communityid = "POST".communityid
     LEFT JOIN comment_totals ON comment_totals.postid = "POST".postid
  ORDER BY "POST".votescore DESC
 LIMIT 20;

--POST
CREATE VIEW post AS
 SELECT DISTINCT "POST".postid,
    "POST".title AS posttitle,
    "POST".votescore AS post_votescore,
    "POST".postdatetime,
    "POST".content AS postcontent,
    "USER".username AS poster_username,
    "USER".profilepicture,
    comment_totals.num_comments,
    "COMMENT".commentid,
    "COMMENT".commenttext,
    "COMMENT".votescore AS comment_votescore,
    "COMMENT".parent_commentid,
    "COMMENT".userid AS commentorid,
    user_comments.username AS commenter
   FROM "POST"
     JOIN "USER" ON "POST".userid = "USER".userid
     LEFT JOIN "COMMENT" ON "COMMENT".postid = "POST".postid
     LEFT JOIN user_comments ON user_comments.commentid = "COMMENT".commentid
     LEFT JOIN comment_totals ON comment_totals.postid = "POST".postid;


--Community
CREATE VIEW community AS
 SELECT DISTINCT "POST".postid,
    "POST".postdatetime,
    "POST".title AS posttitle,
    "POST".content AS postcontent,
    "USER".username AS poster_username,
    "USER".profilepicture AS poster_picture,
    "POST".votescore,
    "COMMUNITY".communityid,
    "COMMUNITY".communityname,
    "COMMUNITY".description,
    "COMMUNITY".communitypicture,
    comment_totals.num_comments
   FROM "COMMUNITY"
     LEFT JOIN "POST" ON "POST".communityid = "COMMUNITY".communityid
     LEFT JOIN "USER" ON "POST".userid = "USER".userid
     LEFT JOIN comment_totals ON comment_totals.postid = "POST".postid
  ORDER BY "POST".votescore DESC;

--EXPLORE
CREATE VIEW explore AS
 SELECT DISTINCT "POST".postid,
    "POST".title AS posttitle,
    "POST".votescore,
    "POST".postdatetime,
    "POST".communityid,
    "POST".content AS postcontent,
    "COMMUNITY".communityname,
    "COMMUNITY".communitypicture,
    "USER".userid,
    "USER".username AS poster_username,
    comment_totals.num_comments
   FROM "POST"
     JOIN "USER" ON "USER".userid = "POST".userid
     JOIN "COMMUNITY" ON "COMMUNITY".communityid = "POST".communityid
     LEFT JOIN comment_totals ON comment_totals.postid = "POST".postid
  ORDER BY "POST".votescore DESC
 LIMIT 20;

--comment_totals
CREATE VIEW comment_totals AS
 SELECT "COMMENT".postid,
    count("COMMENT".postid) AS num_comments
   FROM "COMMENT"
  GROUP BY "COMMENT".postid;

--user_comments
CREATE VIEW user_comments AS
 SELECT "COMMENT".commentid,
    "USER".username
   FROM "COMMENT"
     JOIN "USER" ON "USER".userid = "COMMENT".userid;



---------UNUSED VIEWS----------

--Community search
CREATE VIEW search_community AS
SELECT communityname
FROM "COMMUNITY"
ORDER BY levenshtein(communityname, 'dope')
LIMIT 5;

--Post search
CREATE VIEW search_post AS
SELECT postcontent
FROM "POST"
ORDER BY levenshtein(postcontent, 'dope')
LIMIT 5;

--User search
CREATE VIEW search_user AS
SELECT username
FROM "USER"
ORDER BY levenshtein(username, 'n8')
LIMIT 5;

