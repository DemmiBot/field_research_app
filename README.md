# SurveyDM app

![Logo lindona splash](https://github.com/DemmiBot/field_research_app/assets/79986449/e0e46b05-b396-4a58-a44c-dd5d3eb2ec7b)

![GitHub repo size](https://img.shields.io/github/repo-size/demmibot/field_research_app?style=for-the-badge)
![GitHub language count](https://img.shields.io/github/languages/count/demmibot/field_research_app?style=for-the-badge)
![GitHub top language](https://img.shields.io/github/languages/top/demmibot/field_research_app?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/demmibot/field_research_app?style=for-the-badge)
![Bitbucket open issues](https://img.shields.io/bitbucket/issues/demmibot/field_research_app?style=for-the-badge)
![Bitbucket open pull requests](https://img.shields.io/bitbucket/pr-raw/demmibot/field_research_app?style=for-the-badge)


> App para geração e preenchimento de formulários a-lá google forms.

### Objetivos

O projeto ainda está em desenvolvimento e as próximas atualizações serão voltadas nas seguintes tarefas:

- [x] Geração e desenvolvimento de formulários
- [x] Implementação frontend mobile
- [ ] Implementação frontend web
- [ ] Testes unitários e git actions
- [ ] Expansão de tipos de dados
- [ ] Remodelagem de banco de dados utilizando relações ao invés de EAV (Entity-Attribute-Value, pesquise baby)
- [ ] Funcionalidades extras de gerênciamento de usuários e extração de resultados
- [ ] Simplificação de deploy para disponibilizar instalação
- [ ] ?
- [ ] Rounding-up everything else

<!--
## 💻 Pré-requisitos

Antes de começar, verifique se você atendeu aos seguintes requisitos:

- Você instalou a versão mais recente de `<linguagem / dependência / requeridos>`
- Você tem uma máquina `<Windows / Linux / Mac>`. Indique qual sistema operacional é compatível / não compatível.
- Você leu `<guia / link / documentação_relacionada_ao_projeto>`.
-->

## ✏️ Figma: https://www.figma.com/file/DONkjpP2sNxQQm9fuo8V13/Projeto-Pesquisa-App?type=design&node-id=0%3A1&mode=design&t=x0gn7yP51czxJ4Am-1

## Run in postman

Easily copy the postman workspace for API endpoint testing!

[<img src="https://run.pstmn.io/button.svg" alt="Run In Postman" style="width: 128px; height: 32px;">](https://god.gw.postman.com/run-collection/19908095-7755153a-48a3-41b4-8850-7a6f901d5271?action=collection%2Ffork&source=rip_markdown&collection-url=entityId%3D19908095-7755153a-48a3-41b4-8850-7a6f901d5271%26entityType%3Dcollection%26workspaceId%3D54d25f1d-8807-4819-9592-ebfc13f8c872)

## 🚀 Pre-requisites

1. Docker
2. Mongosh

## 📫 How to contribute

Feel free to fork and send your suggestions of course!

[How to make a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

## 🤝 Contributors

We're grateful for the time and effort put in by the main contributors of the repository:

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/DemmiBot" title="Github Alleck">
        <img src="https://avatars.githubusercontent.com/u/79986449?s=96&v=4" width="100px;" alt="Foto do Alleck no GitHub"/><br>
        <sub>
          <b>Alleck Luka</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/gabrieelfelix" title="Github Gabriel">
        <img src="https://avatars.githubusercontent.com/u/102039571?v=4" width="100px;" alt="Foto do Mark Zuckerberg"/><br>
        <sub>
          <b>Gabriel Felix</b>
        </sub>
      </a>
    </td>
  </tr>
</table>

<!--
## 📝 Licença

Esse projeto está sob licença. Veja o arquivo [LICENÇA](LICENSE.md) para mais detalhes. (ajustar)
-->

## Docker and database:

To facilitate the testing and development of the project, we need to have a convenient way of testing database functionality. This can be achieved through a docker container.

After making sure docker is running, run the following on any terminal  
**(make sure to change at least the password under ROOT_PASSWORD)**:

    docker run -d \
    --name pollsapp-mongo \
    -e MONGO_INITDB_ROOT_USERNAME=admin \
    -e MONGO_INITDB_ROOT_PASSWORD=yourpassword \
    -e MONGO_INITDB_DATABASE=pollsapp \
    -p 27017:27017 \
    -v mongodb_data:/data/db \
    mongo:latest