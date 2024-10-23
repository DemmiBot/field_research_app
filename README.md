# SurveyDM app

![Logo lindona splash](https://github.com/DemmiBot/field_research_app/assets/79986449/e0e46b05-b396-4a58-a44c-dd5d3eb2ec7b)

![GitHub repo size](https://img.shields.io/github/repo-size/demmibot/field_research_app?style=for-the-badge)
![GitHub language count](https://img.shields.io/github/languages/count/demmibot/field_research_app?style=for-the-badge)
![GitHub top language](https://img.shields.io/github/languages/top/demmibot/field_research_app?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/demmibot/field_research_app?style=for-the-badge)
![Bitbucket open issues](https://img.shields.io/bitbucket/issues/demmibot/field_research_app?style=for-the-badge)
![Bitbucket open pull requests](https://img.shields.io/bitbucket/pr-raw/demmibot/field_research_app?style=for-the-badge)


> SurveyDM is a prototype app for creating interactive surveys and submiting data to such.

### Objectives

The next commits will focus on rounding up the app and implementing new functionalities:

- [x] Simple form creation endpoints;
- [x] User creation and login security with OAuth and JWT;
- [x] Mobile UI prototype;
- [ ] Organizational instance support;
- [ ] Submitter id column in poll submit;
- [ ] Geographical data support for surveys;

## ✏️ Figma: https://www.figma.com/file/DONkjpP2sNxQQm9fuo8V13/Projeto-Pesquisa-App?type=design&node-id=0%3A1&mode=design&t=x0gn7yP51czxJ4Am-1

## 🤝 Contributors

To everyone who helped in the development of this app: Thank you!

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

To facilitate the testing and development of the project, we needed a convenient way of testing database functionality. This could be achieved through a docker container.
To do this run the following on a cmd **after installing docker**:

    docker pull postgres
    docker run --name my-postgres-container -e POSTGRES_PASSWORD=Alleck@2024 -e POSTGRES_DB=teste-api -p 5432:5432 -d postgres