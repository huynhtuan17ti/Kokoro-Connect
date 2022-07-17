from .utils import cookie, loadjson, loadimage_b64, is_secured_password, randstr

import pyodbc 
import hashlib
from .definition import QueryStatus, QueryStatusString, AVATAR_PATH, PROJECT_IMAGE_PATH
import os
from datetime import datetime


def getconnection():
    DRIVER_NAME = "SQL SERVER"
    getconnection.connection = None
    connection_string = f"""
        DRIVER={{{DRIVER_NAME}}};
        SERVER=DESKTOP-KNN01L8;
        DATABASE=IU_hackathon_db;
        Trusted_Connection=yes;
    """
    if not getconnection.connection:
        getconnection.connection = pyodbc.connect(connection_string)
    return getconnection.connection

def isvalid_cookie(userid, cookie):
    connection = getconnection()
    cursor = connection.cursor()
    query = "select from cookies where userid = ? and cookie = ?"
    cursor.execute(query, (userid, cookie))
    
    row = cursor.fetchone()
    if row is not None:
        return {"Status": QueryStatusString(QueryStatus.SUCCESSFULLY) if row[3] == True else QueryStatusString(QueryStatus.SUCCESSFULLY)}
    return {"Status": QueryStatusString(QueryStatus.FAILED)}

def deploy_cookie(userid, cookie):
    try:
        connection = getconnection()
        cursor = connection.cursor()
        query = "insert into cookies values(?, ?, ?, ?)"
        cursor.execute(query, (userid, cookie, datetime.now(), 1))
        connection.commit()
    except:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    
    return {"Status": QueryStatusString(QueryStatus.SUCCESSFULLY)}
    
def logout(userid, cookie):
    if not isvalid_cookie(userid, cookie):
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    
    try:
        connection = getconnection()
        cursor = connection.cursor()
        query = "update from cookie set status = 0 where userid = ? and cookie = ?"
        cursor.execute(query, (userid, cookie))
        connection.commit()
    except:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    return {"Status": QueryStatusString(QueryStatus.SUCCESSFULLY)}

def login(username, password):
    '''
    @param:
        - username: string
        - password: string (raw)
    return:
        {
            "STATUS": ""
            "SessionID": ""
            "UserInfo": {
            return {"Status": QueryStatusString(QueryStatus.FAILED)}    "username": username,
                "image": image,
                "FullName": name,
                "AccountType": 0/1
            }
        }
    '''
    
    password = hashlib.sha256(password.encode('utf-8')).hexdigest()
    connection = getconnection()
    
    cursor = connection.cursor()
    query_account = "select * from users where users.username = ? and users.password = ?"
    cursor.execute(query_account, (username, password))
    
    account_row = cursor.fetchone()
    if not account_row:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    
    id, username = account_row[0], account_row[1]
    
    querry_info = "select fullname, avatar, status from user_info where userid = ?"
    cursor.execute(querry_info, (id, ))
    
    info_row = cursor.fetchone()
    if not info_row:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    
    sessionid = cookie(username)
    deploy_cookie(id, sessionid)

    fullname, avatar, status = info_row

    if avatar is not None:
        avatar = loadimage_b64(os.path.join(AVATAR_PATH, avatar))
    
    return_value = {
        "Status": QueryStatusString(QueryStatus.SUCCESSFULLY),
        "SessionID": sessionid,
        "UserInfo": {
            "username": username,
            "image": avatar,
            "fullname": fullname,
            "type": status
        }
    }
    
    return return_value

def __check_existing_account(username):
    connection = getconnection()
    cursor = connection.cursor()
    query = 'select * from users where username = ?'
    cursor.execute(query, (username, ))
    
    row = cursor.fetchone()
    return row is not None

def signup(username, fullname, email, phone, password):
    if not is_secured_password(password):
        return {"Status": QueryStatusString(QueryStatus.REJECTED)} 
    
    if __check_existing_account(username):
        return {"Status": QueryStatusString(QueryStatus.FAILED)}

    id = randstr(10)
    password = hashlib.sha256(password)
    connection = getconnection()
    cursor = connection.cursor()
    query_udate_users = 'insert into users values (?, ?, ?)'
    query_update_userinfo = 'insert into user_info (userid, fullname, email, phonenumber) values(?, ?, ?, ?)'
    try:
        cursor.execute(query_udate_users, (id, username, password))
        cursor.execute(query_update_userinfo, (id, fullname, email, phone, password))
        connection.commit()
    except:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    
    return {"Status": QueryStatusString(QueryStatus.SUCCESSFULLY)}

'''
"title": "TITLE",
"author": "Name",
"description": "Bla bla",
"tag": "TAG",
"location": "HCM city",
"upvotes": 12
'''
def load_all_projects():
    connection = getconnection()
    cursor = connection.cursor()
    query = 'select projectid, title, author, caption, tag, location, upvotes from project'
    cursor.execute(query)
    rows = cursor.fetchall()
    
    if not rows:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    
    return_value = {
        "Status": QueryStatusString(QueryStatus.SUCCESSFULLY),
        "project_list": []
    }
    
    for row in rows:
        return_value['project_list'].append({
            "projectid": row[0],
            "title": row[1],
            "author": row[2],
            "description": row[3],
            "tag": row[4],
            "location": row[5],
            "upvotes": row[6]
            }
        )
    
    return return_value

def load_project_images(projectid):
    query = 'select image from project_images where projectid = ?'
    connection = getconnection()
    cursor = connection.cursor()
    cursor.execute(query, (projectid, ))
    rows = cursor.fetchall()
    
    if not rows:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    
    return_value = {
        "Status": QueryStatusString(QueryStatus.SUCCESSFULLY),
        "images": []
    }
    
    for row in rows:
        path = os.path.join(PROJECT_IMAGE_PATH, row[0])
        return_value['images'].append(loadimage_b64(path))
    return return_value

def load_all_projects_by_hashtag(hastag):
    connection = getconnection()
    cursor = connection.cursor()
    query = 'select projectid, title, author, caption, tag, location, upvotes from project where tag = ?'
    cursor.execute(query, (hastag, ))
    rows = cursor.fetchall()
    
    if not rows:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    
    return_value = {
        "Status": QueryStatusString(QueryStatus.SUCCESSFULLY),
        "project_list": []
    }
    
    for row in rows:
        return_value['project_list'].append({
            "projectid": row[0],
            "title": row[1],
            "author": row[2],
            "description": row[3],
            "tag": row[4],
            "location": row[5],
            "upvotes": row[6]
            }
        )
    
    return return_value

def load_user_profile(userid, sessionid):
    if not isvalid_cookie(userid, sessionid):
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    
    connection = getconnection()
    cursor = connection.cursor()
    
    return_value = {}
    
    try:
        query_get_username = 'select username from users where userid = ?'
        cursor.execute(query_get_username, (userid, ))
        row = cursor.fetchone()
        
        if row is None:
            raise "User profile not found"
        
        return_value['username'] = row[0]
        
        query_get_profile = 'select fullname, email, phonenumber, avatar from user_info where userid = ?'
        cursor.execute(query_get_profile, (userid, ))
        row = cursor.fetchone()
        
        fullname, email, phonenumber, avatar = row
        
        if row is None:
            raise "User profile not found"
        
        if row[3] is not None:
            avatar = loadimage_b64(avatar)
        
        return_value['fullname'] = fullname
        return_value['email'] = email
        return_value['phonenumber'] = phonenumber
        return_value['avatar'] = avatar
        return_value['Status'] = QueryStatusString(QueryStatus.SUCCESSFULLY)
    except:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    
    return return_value

'''
{
	"title": "TITLE",z
	"author": "Name",
	"description": "Bla bla",
	"tag": "TAG",
	"location": "HCM city",
	"upvotes": 0
}
'''
def start_project(sessionid, author, title, description, tag, location, expectation):
    if not isvalid_cookie(author, sessionid):
        return {"Status": QueryStatusString(QueryStatus.REJECTED)}
    
    connection = getconnection()
    cursor = connection.cursor()
    projectid = randstr(10)
    try:
        query = 'insert into project(projectid, author, title, caption, tag, location, expectation) values(?, ?, ?, ?, ?, ?, ?)'
        cursor.execute(query, (projectid, author, title, description, tag, location, expectation))
        connection.commit()
    except:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    return {"Status": QueryStatusString(QueryStatus.SUCCESSFULLY)}

def __check_joined(userid, projectid):
    query = 'select * from project_record where userid = ? and projectid = ?'
    connection = getconnection()
    cursor = connection.cursor()
    cursor.execute(query, (userid, projectid))
    return cursor.fetchone() is not None

def join_project(userid, sessionid, projectid):
    if not isvalid_cookie(userid, sessionid) or __check_joined(userid, projectid):
        return {"Status": QueryStatusString(QueryStatus.REJECTED)}
    
    connection = getconnection()
    cursor = connection.cursor()
    try:
        query = 'insert into project_record(projectid, userid) values(?, ?)'
        cursor.execute(query, (projectid, userid))
        connection.commit()
    except:
        return {"Status": QueryStatusString(QueryStatus.FAILED)}
    return {"Status": QueryStatusString(QueryStatus.SUCCESSFULLY)}
