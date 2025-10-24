from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib import messages


def register_view(request):
    """
    User registration view.
    Creates a new user with username (Roll No) and password.
    """
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        password2 = request.POST.get('password2')
        
        if password != password2:
            messages.error(request, 'Passwords do not match!')
            return render(request, 'register.html')
        
        if User.objects.filter(username=username).exists():
            messages.error(request, 'Username already exists!')
            return render(request, 'register.html')
        
        # Create user
        user = User.objects.create_user(username=username, password=password)
        user.save()
        
        messages.success(request, 'Registration successful! Please login.')
        return redirect('login')
    
    return render(request, 'register.html')


def login_view(request):
    """
    User login view.
    Authenticates user with username and password.
    """
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        
        user = authenticate(request, username=username, password=password)
        
        if user is not None:
            login(request, user)
            return redirect('home')
        else:
            messages.error(request, 'Invalid username or password!')
    
    return render(request, 'login.html')


@login_required
def home_view(request):
    """
    Home page view after successful login.
    Displays: Hello! [username] How are you
    Where [username] comes from the login.username column in the database.
    """
    return render(request, 'home.html', {'user': request.user})


def logout_view(request):
    """
    Logout view.
    """
    logout(request)
    messages.success(request, 'Logged out successfully!')
    return redirect('login')
