# field_research_app

## https://education.github.com/git-cheat-sheet-education.pdf

    git remote add origin (url)
    git fetch --all
    git checkout main

## Docker and database:

To facilitate the testing and development of the project, we need to have a convenient way of testing database functionality. This can be achieved trough a docker container.
To do this run the following on a **cmd after installing docker**:

    docker pull postgres
    docker run --name my-postgres-container -e POSTGRES_PASSWORD=Alleck@2024 -e POSTGRES_DB=teste-api -p 5432:5432 -d postgres


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

Auth Controller:  
  
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
