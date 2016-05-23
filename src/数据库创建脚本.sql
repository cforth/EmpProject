DROP TABLE admin PURGE ;
CREATE TABLE admin (
	aid			VARCHAR2(50),
	password	VARCHAR2(32),
	CONSTRAINT pk_aid PRIMARY KEY(aid)
) ;
-- 用户名：admin，密码：hello
INSERT INTO admin(aid,password) VALUES('admin', '5D41402ABC4B2A76B9719D911017C592');
-- 用户名：cfxyz，密码：java
INSERT INTO admin(aid,password) VALUES('cfxyz', '93F725A07423FE1C889F448B33D21F46');
COMMIT ;

ALTER TABLE emp ADD (photo VARCHAR2(50) DEFAULT 'nophoto.jpg');
ALTER TABLE emp ADD (note CLOB);