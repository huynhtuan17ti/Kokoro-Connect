import enum

class QueryStatus(enum.Enum):
    SUCCESSFULLY = 1
    FAILED = 2
    REJECTED = 3 # bad request
    EMPTY_DATA = 4
    
def QueryStatusString(a: QueryStatus):
    if a == QueryStatus.SUCCESSFULLY:
        return 'SUCCESSFULLY'
    
    if a == QueryStatus.FAILED:
        return 'FAILED'
    
    if a == QueryStatus.REJECTED:
        return 'REJECTED'
    
    if a == QueryStatus.EMPTY_DATA:
        return 'EMPTY_DATA'

AVATAR_PATH = '../data/avatar'
PROJECT_IMAGE_PATH = '../data/project-images'