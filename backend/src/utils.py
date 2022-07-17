import hashlib
import random
import json
import base64
import datetime

def randstr(l: int):
    sequence = [i for i in range(10)]
    return ''.join([str(sequence[random.randint(0, len(sequence) - 1)]) for i in range(0, l)])

def cookie(username):
    RANDSTR_LENGTH = 10
    username += randstr(RANDSTR_LENGTH)
    return hashlib.sha256(username.encode('utf-8')).hexdigest()

def loadjson(filename: str):
    with open(filename, 'rb') as fp:
        return json.load(fp)

def base64_decode(str):
    str = base64.b64decode(str)
    return str.decode('utf-8')

def base64_encode(str):
    return base64.b64encode(str).decode('utf-8')
    
def loadimage_b64(filename: str):
    with open(filename, 'rb') as fp:
        return base64_encode(fp.read())
    
def is_secured_password(password: str):
    for x in ['\'', '--', '\%', ' ']:
        if x in password:
            return False
    return True