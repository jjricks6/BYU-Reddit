--MY FEED
CREATE VIEW feed AS
SELECT DISTINCT "USER".userid, username, "POST".postid, "POST".communityid, postcontent, postdatetime, "POST".votescore, 
(SELECT COUNT(*) FROM "COMMENT" WHERE "COMMENT".postid = "POST".postid) as num_comments
FROM "USER"
JOIN "MEMBEROF" on "MEMBEROF".userid = "USER".userid
JOIN "COMMUNITY" on "MEMBEROF".communityid = "COMMUNITY".communityid
JOIN "POST" on "COMMUNITY".communityid = "POST".communityid
JOIN "COMMENT" on "COMMENT".postid = "POST".postid
WHERE "USER".username = 'jricks32' AND (date_part('hour', current_timestamp - postdatetime)) < 24
ORDER BY votescore desc
LIMIT 20;

--POST
CREATE VIEW post AS
SELECT DISTINCT "POST".postid, postcontent, "POST".votescore as post_votescore, postdatetime, username as poster_username, 
(SELECT COUNT(*) FROM "COMMENT" WHERE "COMMENT".postid = "POST".postid) as num_comments,
commentid, commenttext, "COMMENT".votescore as comment_votescore, parent_commentid, "COMMENT".userid as commentorid,
(SELECT username FROM "USER" WHERE "COMMENT".userid = "USER".userid) as commentor_username
FROM "POST"
JOIN "USER" ON "POST".userid = "USER".userid
JOIN "COMMENT" ON "COMMENT".postid = "POST".postid;


--Community
CREATE VIEW community AS
SELECT DISTINCT "POST".postid, postdatetime, postcontent, username as poster_username, "POST".votescore, 
(SELECT COUNT(*) FROM "COMMENT" WHERE "COMMENT".postid = "POST".postid) as num_comments
FROM "COMMUNITY"
JOIN "POST" ON "POST".communityid="COMMUNITY".communityid
JOIN "USER" ON "POST".userid="USER".userid
JOIN "COMMENT" ON "COMMENT".postid="POST".postid 
WHERE communityname = 'Test Community' AND (date_part('hour', current_timestamp - postdatetime)) < 24
ORDER BY votescore desc;

--EXPLORE
CREATE VIEW explore AS
SELECT DISTINCT "POST".postid, postcontent, "POST".votescore, postdatetime, "POST".communityid, "COMMUNITY".communityname, "USER".userid, username as poster_username,
(SELECT COUNT(*) FROM "COMMENT" WHERE "COMMENT".postid = "POST".postid) as num_comments
FROM "POST"
JOIN "USER" on "USER".userid = "POST".userid
JOIN "COMMUNITY" on "COMMUNITY".communityid = "POST".communityid
JOIN "COMMENT" on "COMMENT".postid = "POST".postid
WHERE (date_part('hour', current_timestamp - postdatetime)) < 24
ORDER BY votescore desc
LIMIT 20;

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

