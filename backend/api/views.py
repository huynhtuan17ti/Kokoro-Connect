from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from src import data
from src.definition import QueryStatusString, QueryStatus

class LogInApiView(APIView):
    def post(self, request, *args, **kwargs):
        response_data = {}
        try:
            username = request.data.get('username')
            password = request.data.get('password')
            response_data = data.login(username, password)
        except Exception as e:
            return Response({
                'Status': QueryStatusString(QueryStatus.FAILED), 
                'Error': e
                }, status=status.HTTP_400_BAD_REQUEST
            )
        return Response(response_data, status = status.HTTP_200_OK)

class LogOutApiView(APIView):
    def post(self, request, *args, **kwargs):
        response_data = {}
        
        try:
            sessionid = request.data.get('sessionid')
            userid = request.data.get('userid')
            print(userid)
            response_data = data.logout(userid, sessionid)
        except Exception as e:
            print(e)
            return Response({
                'Status': QueryStatusString(QueryStatus.FAILED), 
                'Error': e
                }, status=status.HTTP_400_BAD_REQUEST
            )
        return Response(response_data, status = status.HTTP_200_OK)
    
class SignUpApiView(APIView):
    def post(self, request, *args, **kwargs):
        try:
            usernmae, fullname, email, phone, password = [request.data.get(_) for _ in ['username', 'fullname', 'email', 'phone', 'password']]
            print(usernmae, fullname, email, phone, password)
            response_data = data.signup(usernmae, fullname, email, phone, password)
        except Exception as hehe:
            return Response({'Status': QueryStatusString(QueryStatus.FAILED), 'Error': str(hehe)}, status=status.HTTP_400_BAD_REQUEST)
        
        return Response(response_data, status = status.HTTP_200_OK)

class HomeScreenApiView(APIView):
    def get(self, request, *args, **kwargs):
        return Response(data.load_all_projects(), status=status.HTTP_200_OK)

class ProfileScreenApiView(APIView):
    def get(self, request, *args, **kwargs):
        response_data = {}
        try:
            userid, sessionid = request.META.get('HTTP_USERID'), request.META.get('HTTP_SESSIONID')
            response_data = data.load_user_profile(userid, sessionid)
        except Exception as e:
            print(e)
            return Response({'Status': QueryStatusString(QueryStatus.FAILED), 'Error': e}, status=status.HTTP_400_BAD_REQUEST)
        return Response(response_data, status=status.HTTP_200_OK)


class SearchScreenApiView(APIView):
    def get(self, request, hastag, *args, **kwargs):
        try:
            response_data = data.load_all_projects_by_hashtag(hastag)
        except Exception as e:
            return Response({'Status': QueryStatusString(QueryStatus.FAILED), 'Error': e}, status=status.HTTP_400_BAD_REQUEST)
        return Response(response_data, status=status.HTTP_200_OK)


class PostScreenApiView(APIView):
    def post(self, request, *args, **kwargs):
        response_data = {}
        try:
            sessionid, author, title, description, tag, location, expectation = [request.data.get(_) for _ in ['sessionid', 'author', 'title', 'description', 'tag', 'location', 'expectation']]
            response_data = data.start_project(sessionid, author, title, description, tag, location, expectation)
        except Exception as e:
            return Response({'Status': QueryStatusString(QueryStatus.FAILED), 'Error': e}, status = status.HTTP_400_BAD_REQUEST)
        
        return Response(response_data, status=status.HTTP_200_OK)