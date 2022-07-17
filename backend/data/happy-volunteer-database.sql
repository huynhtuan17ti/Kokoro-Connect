create database IU_hackathon_db
go 

use IU_hackathon_db
go

/*
Organizer: // universities, corporations
- OrganizerID
- OrganizerName
- Description
*/

/*
use master
drop database IU_hackathon_db
go
*/

create table organization (
	organizationid varchar(10) not null,
	organizationname nvarchar(50) not null,
	description nvarchar(512) default '',
)
go

alter table organization
	add primary key (organizationid)
go

insert into organization values ('0000000000', 'Freelancer', 'People do not in any organization')
insert into organization values ('0000000001', 'Happy Volunteer', 'Tiki hackathon project')
go

/*
User
- UserID
- Username*
- Password* (SHA256 - 64 chars)
- LastTimeModifiedPassword [optional]
*/

create table users (
	userid varchar(10) not null,
	username nvarchar(50) not null,
	password varchar(70) not null,
)
go

alter table users
	add primary key (userid)
go

insert into users values('0000000000', 'admin', '1a43e85842b0020c7444059a0f81bd3eb047160e638319ecb69c275d554a67b0')
-- admin/defaultpassword

/*
User Information
- UserID*
- FullName*
- DOB
- Sex
- Avatar
- Address (optional)
- OrganizerID
- Email
- PhoneNumber*
- Status (Verified, Non-Verified) - account for organizer
*/


create table user_info (
	userid varchar(10) not null,
	fullname nvarchar(50) not null,
	dob datetime,
	sex int check (sex >= 0 and sex < 3) default 2, -- 0: male, 1:female, 2:unknown
	avatar varchar(10),
	address nvarchar(200),
	organizationid varchar(10) default '0000000000',
	email nvarchar(50),
	phonenumber nvarchar(12),
	status bit -- 1: verified, 0: not yet
)
go

alter table user_info add 
    primary key (userid),
	foreign key (userid) references users(userid),
	foreign key (organizationid) references organization(organizationid)
go

insert into user_info values ('0000000000', 'Admin', getdate(), 1, null, 'Linh Trung, Thu Duc District, HCMC', '0000000001', null, '0336371433', 0) 


/*
Project Type
- Hashtag
- TypeName (environemnt, people/social, animals)
- Description
*/

create table project_type (
	hastag nvarchar(20) not null,
	typename nvarchar(50),
	description nvarchar(300) -- detail for the type of project. ex: 
)
go

alter table project_type add 
    primary key (hastag)
go

/*
Project
- ProjectID
- Author
- Description (Caption)
- Tag
- DateCreated
- Location
- Upvotes
- Status (Opening: 1 - Closed: 0)
*/

create table project (
	projectid varchar(10) not null,
	author varchar(10),
	title nvarchar(300) not null,
	caption nvarchar(3000) not null,
    tag nvarchar(20),
	lastmodified datetime,
	location nvarchar(200),
	upvotes int check (upvotes >= 0) default 0,
	expectation int, -- number of candidates
	status bit, -- 1: Done, 0: Opening
)
go



alter table project add 
    primary key (projectid),
	foreign key (author) references users(userid),
    foreign key (tag) references project_type(hastag)
go

/*
Images:
- ProjectID
- Num
- Image
*/

create table project_images (
	projectid varchar(10) not null,
	num int not null,
	image varchar(10) -- filename
)
go

alter table project_images add
    primary key (projectid, num),
	foreign key (projectid) references project(projectid)
go

/*
Comment:
- ProjectID
- UserID
- Num
- Content
- Upvotes
*/
create table comment (
	projectid varchar(10) not null,
	userid varchar(10) not null,
	num int check(num >= 0) default 0,
	content nvarchar(512),
	upvotes int check(upvotes >= 0) default 0
)
go

alter table comment add
    primary key (projectid, userid),
	foreign key (projectid) references project(projectid),
	foreign key (userid) references users(userid)
go

/*
Project-User
- ProjectID
- UserID
- DateRegistered
- Status
*/

create table project_record (
	projectid varchar(10) not null,
	userid varchar(10) not null,
	dateregistered datetime,
	status int check(status >= 0 and status < 3) default 0
)
go

alter table project_record add 
    primary key (projectid, userid),
	foreign key (projectid) references project(projectid),
	foreign key (userid) references users(userid)
go   

create table cookies (
	userid varchar(10) not null,
	cookie varchar(64) not null,
	datecreated datetime,
	status bit
)
go

alter table cookies add 
	primary key (userid, cookie),
	foreign key (userid) references users(userid)
go

insert into project_type values ('#animal', 'For animal', 'Usually in zoo, or in the forest')
insert into project_type values ('#environment', 'For environment', 'Clean the environment')
insert into project_type values ('#people', 'For people', 'Homelesness, children in poor condition')

insert into project(projectid, title, caption, tag) values ('0000000000', 'This is a demo project', 'This is a demo caption', '#people')

select * from project where tag = '#people'