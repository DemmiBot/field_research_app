# field_research_app

# RUN IN POSTMAN IS HERE!!!

Easily copy the postman workspace for API endpoint testing!

[<img src="https://run.pstmn.io/button.svg" alt="Run In Postman" style="width: 128px; height: 32px;">](https://god.gw.postman.com/run-collection/19908095-7755153a-48a3-41b4-8850-7a6f901d5271?action=collection%2Ffork&source=rip_markdown&collection-url=entityId%3D19908095-7755153a-48a3-41b4-8850-7a6f901d5271%26entityType%3Dcollection%26workspaceId%3D54d25f1d-8807-4819-9592-ebfc13f8c872)

## https://education.github.com/git-cheat-sheet-education.pdf

    git remote add origin (url)
    git fetch --all
    git checkout main

## Docker and database:

To facilitate the testing and development of the project, we need to have a convenient way of testing database functionality. This can be achieved trough a docker container.
To do this run the following on a cmd **after installing docker**:

    docker pull postgres
    docker run --name my-postgres-container -e POSTGRES_PASSWORD=Alleck@2024 -e POSTGRES_DB=teste-api -p 5432:5432 -d postgres


## How to request ( REMOVED ):

After getting access to the project's vpn:

26.146.172.113:8080/(method)

## Checklist

### Frontend
    *Insert checklist*

### Backend

:white_check_mark: JWT Auth *(Only for certain methods)*  
:white_check_mark: Dynamic table creation  
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
  
    (POST)/polls
    {
        name: "(name)",
        description: "(description)",
        status: "OPEN"/"CLOSED"
        options: [
            {
                "optionName": "(name)",
                "optionType": "(postgresql data type alias)" /*Table 8.1 in https://www.postgresql.org/docs/current/datatype.html*/
            }, {}...
        ]
    }

Description: This endpoint inserts a new entry in the polls table, and creates a new table with the option list as columns.

    (GET)/polls // Gets polls from polls table

    (GET)/polls/single?name=(poll name) // Gets data from a specific table. Name is slug of poll name (eg: pesquisa_de_tabatinga_2028)

    (GET)/polls/{id} // Gets data from a single entry in polls table

User Controller:  

    (CRUD)/users [/{id}]
    {
        name: "(name)",
        description: "(description)",
        status: "OPEN"/"CLOSED"
    }
