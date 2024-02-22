# field_research_app

## https://education.github.com/git-cheat-sheet-education.pdf

    git remote add origin (url)
    git fetch --all
    git checkout main

## How to request:

After getting access to the project's vpn:

26.146.172.113:8080/(method)

## Checklist

### Frontend
    *Insert checklist*

### Backend

:heavy_exclamation_mark: JWT Auth *(Only for certain methods)*  
:x: Dynamic table creation  
:x: Secure register method  
:heavy_exclamation_mark: User CRUD *(Partially overwriten by auth methods)*  
:white_check_mark: Research CRUD  


## Docs

### Frontend
    *Insert Documentation*

### Backend

#### Controllers:

Auth controller:  
  
    (POST)/auth/login:  
    {
        login: "(login)",
        password: "(password)"
    }

    (POST)/register:
    {
        login: "(login)",
        password: "(password)",
        role: "ADMIN"/"USER"
    }

Research Controller:
  
    (CRUD)/polls [/{id}]
    {
        name: "(name)",
        description: "(description)",
        status: "OPEN"/"CLOSED"
    }

User Controller:  

    (CRUD)/users [/{id}]
    {
        name: "(name)",
        description: "(description)",
        status: "OPEN"/"CLOSED"
    }
