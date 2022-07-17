from django.urls import path, include
from .views import (
    LogInApiView, SignUpApiView, HomeScreenApiView, 
    ProfileScreenApiView, SearchScreenApiView, PostScreenApiView, LogOutApiView
)

urlpatterns = [
    path('login/', LogInApiView.as_view()),
    path('signup/', SignUpApiView.as_view()),
    path('home-screen/', HomeScreenApiView.as_view()),
    path('profile-screen/', ProfileScreenApiView.as_view()),
    path('search/<str:hastag>/', SearchScreenApiView.as_view()),
    path('post-screen/', PostScreenApiView.as_view()),
    path('logout/', LogOutApiView.as_view())
]