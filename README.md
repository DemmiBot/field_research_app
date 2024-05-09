# SurveyDM app

### Figma: https://www.figma.com/file/DONkjpP2sNxQQm9fuo8V13/Projeto-Pesquisa-App?type=design&node-id=0%3A1&mode=design&t=x0gn7yP51czxJ4Am-1

### Run in postman

Easily copy the postman workspace for API endpoint testing!

[<img src="https://run.pstmn.io/button.svg" alt="Run In Postman" style="width: 128px; height: 32px;">](https://god.gw.postman.com/run-collection/19908095-7755153a-48a3-41b4-8850-7a6f901d5271?action=collection%2Ffork&source=rip_markdown&collection-url=entityId%3D19908095-7755153a-48a3-41b4-8850-7a6f901d5271%26entityType%3Dcollection%26workspaceId%3D54d25f1d-8807-4819-9592-ebfc13f8c872)

https://education.github.com/git-cheat-sheet-education.pdf

###Docker and database:

To facilitate the testing and development of the project, we need to have a convenient way of testing database functionality. This can be achieved trough a docker container.
To do this run the following on a cmd **after installing docker**:

    docker pull postgres
    docker run --name my-postgres-container -e POSTGRES_PASSWORD=Alleck@2024 -e POSTGRES_DB=teste-api -p 5432:5432 -d postgres

### Todo

:white_check_mark: JWT Auth *(Only for certain methods)*  
:white_check_mark: Dynamic table creation  
:x: Secure register method  
:heavy_exclamation_mark: User CRUD *(Partially overwriten by auth methods)*  
:white_check_mark: Polls CRUD  
