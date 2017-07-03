CREATE TABLE public.tb_bbs_notice (
	notice_seq int4 NOT NULL,
	title varchar NOT NULL,
	reg_dt timestamp NULL,
	reg_usr varchar NULL,
	mod_dt timestamp NULL,
	mod_usr varchar NULL,
	content varchar NULL,
	expose_from timestamp NULL,
	expose_to timestamp NULL,
	CONSTRAINT tb_bbs_notice_pk PRIMARY KEY (notice_seq)
);

CREATE TABLE public.tb_code_master (
	cd varchar NOT NULL,
	catgr varchar(20) NOT NULL,
	cd_nm varchar(500) NOT NULL,
	cd_id varchar(500) NULL,
	sort_no int4 NULL DEFAULT 0,
	use_yn bpchar(1) NULL,
	cre_usr varchar(500) NOT NULL,
	cre_dt date NOT NULL,
	mod_usr varchar(500) NOT NULL,
	mod_dt date NOT NULL,
	remark varchar(4000) NULL,
	CONSTRAINT pk_tb_code_master PRIMARY KEY (cd,catgr)
);

CREATE TABLE public.tb_login_his (
	access_dt timestamp NOT NULL,
	user_seq int4 NOT NULL,
	log_type varchar NULL,
	req_ip varchar(36) NULL,
	req_device varchar(64) NULL,
	seq int4 NOT NULL,
	CONSTRAINT tb_login_his_pk PRIMARY KEY (seq)
);

CREATE TABLE public.tb_menu_info (
	menu_sq int4 NOT NULL,
	menu_nm varchar(64) NOT NULL,
	menu_url varchar(255) NULL,
	menu_desc varchar(1000) NULL,
	menu_content varchar(4000) NULL,
	menu_order int4 NULL,
	use_yn bpchar(1) NULL,
	parent_sq int4 NULL,
	menu_id varchar(64) NULL,
	CONSTRAINT tb_menu_info_pk PRIMARY KEY (menu_sq)
);

CREATE TABLE public.tb_user_auth (
	auth_sq int4 NOT NULL,
	user_no int4 NULL,
	user_type varchar(20) NULL,
	menu_sq int4 NULL,
	auth_c bpchar(1) NULL,
	auth_r bpchar(1) NULL,
	auth_u bpchar(1) NULL,
	auth_d bpchar(1) NULL,
	CONSTRAINT pk_tb_usre_auth PRIMARY KEY (auth_sq)
);

CREATE TABLE public.tb_user_info (
	user_seq int4 NOT NULL,
	user_id varchar(500) NOT NULL,
	user_name varchar(500) NULL,
	phone varchar(11) NULL,
	password varchar(4000) NULL,
	birthday bpchar(8) NULL,
	user_type varchar(20) NULL,
	use_yn bpchar(1) NULL,
	cre_usr varchar(500) NULL,
	cre_dt date NULL,
	mod_usr varchar(500) NULL,
	mod_dt date NULL,
	note varchar(1000) NULL,
	CONSTRAINT pk_tb_user_info PRIMARY KEY (user_seq)
);


INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100000', '0', '기준코드', '1', 1, '1', 'admin', '2016-11-08', 'admin', '2016-11-08', NULL);
INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100017', '100000', '사용자구분', '_USER_TYPE_', 1, '1', 'devqed', '2016-11-08', 'devqed', '2016-11-08', NULL);
INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100019', '100017', '관리자', '5000000000', 1, '1', 'devqed', '2016-11-08', 'devqed', '2016-11-08', NULL);
INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100026', '100000', '성별구분', '_SEX_', 1, '1', 'devqed', '2016-11-08', 'devqed', '2016-11-08', NULL);
INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100031', '100026', '남성', 'M', 1, '1', 'devqed', '2016-11-08', 'devqed', '2016-11-08', NULL);
INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100030', '100026', '여성', 'F', 1, '1', 'devqed', '2016-11-08', 'devqed', '2016-11-08', NULL);
INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100385', '100500', '대기', '500050', 1, '1', 'wsbaek', '2016-11-29', 'wsbaek', '2016-11-29', NULL);
INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100500', '100000', '진행상태', '_STATUS_', 1, '1', 'wsbaek', '2016-11-10', 'wsbaek', '2016-11-10', NULL);
INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100501', '100500', '접수', '500001', 1, '1', 'wsbaek', '2016-11-10', 'wsbaek', '2016-11-10', NULL);
INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100502', '100500', '완료', '500090', 1, '1', 'wsbaek', '2016-11-10', 'wsbaek', '2016-11-10', NULL);
INSERT INTO public.tb_code_master
(cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark)
VALUES('100400', '100017', '사용자', '5114000000', 1, '1', 'devqed', '2017-01-13', 'devqed', '2017-06-09', NULL);



INSERT INTO public.tb_menu_info
(menu_sq, menu_nm, menu_url, menu_desc, menu_content, menu_order, use_yn, parent_sq, menu_id)
VALUES(3, '게시판', NULL, NULL, NULL, 1, '1', NULL, 'checkNotice');
INSERT INTO public.tb_menu_info
(menu_sq, menu_nm, menu_url, menu_desc, menu_content, menu_order, use_yn, parent_sq, menu_id)
VALUES(23, '공지사항', '/bbs/notice.do', NULL, NULL, 1, '1', 3, 'notice');
INSERT INTO public.tb_menu_info
(menu_sq, menu_nm, menu_url, menu_desc, menu_content, menu_order, use_yn, parent_sq, menu_id)
VALUES(7, '사용자관리', '/sm/user.do', NULL, NULL, 1, '1', 13, 'systemMgrUser');
INSERT INTO public.tb_menu_info
(menu_sq, menu_nm, menu_url, menu_desc, menu_content, menu_order, use_yn, parent_sq, menu_id)
VALUES(8, '권한관리', '/sm/userauth.do', NULL, NULL, 2, '1', 13, 'systemMgrUserAuth');
INSERT INTO public.tb_menu_info
(menu_sq, menu_nm, menu_url, menu_desc, menu_content, menu_order, use_yn, parent_sq, menu_id)
VALUES(9, '메뉴관리', '/sm/menu.do', NULL, NULL, 3, '1', 13, 'systemMgrMenuInfo');
INSERT INTO public.tb_menu_info
(menu_sq, menu_nm, menu_url, menu_desc, menu_content, menu_order, use_yn, parent_sq, menu_id)
VALUES(5, '공통코드관리', '/sm/code.do', NULL, NULL, 2, '1', 13, 'systemMgrCode');
INSERT INTO public.tb_menu_info
(menu_sq, menu_nm, menu_url, menu_desc, menu_content, menu_order, use_yn, parent_sq, menu_id)
VALUES(6, '접속이력관리', '/sm/history/login.do', NULL, NULL, 4, '1', 13, 'systemMgrHisLogin');
INSERT INTO public.tb_menu_info
(menu_sq, menu_nm, menu_url, menu_desc, menu_content, menu_order, use_yn, parent_sq, menu_id)
VALUES(13, '시스템관리', NULL, NULL, NULL, 6, '1', NULL, NULL);


INSERT INTO public.tb_user_auth
(auth_sq, user_no, user_type, menu_sq, auth_c, auth_r, auth_u, auth_d)
VALUES(402, NULL, '5000000000', 23, '1', '1', '1', '1');
INSERT INTO public.tb_user_auth
(auth_sq, user_no, user_type, menu_sq, auth_c, auth_r, auth_u, auth_d)
VALUES(403, NULL, '5000000000', 7, '1', '1', '1', '1');
INSERT INTO public.tb_user_auth
(auth_sq, user_no, user_type, menu_sq, auth_c, auth_r, auth_u, auth_d)
VALUES(2, NULL, '5000000000', 8, '1', '1', '1', '1');
INSERT INTO public.tb_user_auth
(auth_sq, user_no, user_type, menu_sq, auth_c, auth_r, auth_u, auth_d)
VALUES(400, NULL, '5000000000', 5, '1', '1', '1', '1');
INSERT INTO public.tb_user_auth
(auth_sq, user_no, user_type, menu_sq, auth_c, auth_r, auth_u, auth_d)
VALUES(401, NULL, '5000000000', 9, '1', '1', '1', '1');
INSERT INTO public.tb_user_auth
(auth_sq, user_no, user_type, menu_sq, auth_c, auth_r, auth_u, auth_d)
VALUES(404, NULL, '5000000000', 6, '1', '1', '1', '1');
INSERT INTO public.tb_user_auth
(auth_sq, user_no, user_type, menu_sq, auth_c, auth_r, auth_u, auth_d)
VALUES(405, NULL, '5000000000', 26, '1', '1', '1', '1');
INSERT INTO public.tb_user_auth
(auth_sq, user_no, user_type, menu_sq, auth_c, auth_r, auth_u, auth_d)
VALUES(406, NULL, '5000000000', 29, '1', '1', '1', '1');


INSERT INTO public.tb_user_info
(user_seq, user_id, user_name, phone, password, birthday, user_type, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, note)
VALUES(3, 'admin', '관리자', '01012345678', '3e0a3501a65b4a7bf889c6f180cc6e35747e5aaff931cc90b760671efa09aeac', '20021012', '5000000000', '1', 'adimn', '2017-06-08', 'adimn', '2017-06-08', '슈퍼관리자 야호호호홍~');
INSERT INTO public.tb_user_info
(user_seq, user_id, user_name, phone, password, birthday, user_type, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, note)
VALUES(4, 'user1', '유저1', '01011112222', '3e0a3501a65b4a7bf889c6f180cc6e35747e5aaff931cc90b760671efa09aeac', '20171101', '5114000000', '1', 'admin', '2017-06-09', 'admin', '2017-06-09', 'user1 유저1');

