# README

This README would normally document whatever steps are necessary to get the
application up and running.

### Database Setup

You need to create your own database and add update entries to the config/application.yml

### Start Rails Server

You need to run rails server on the 5000 port, So you can use rails s -p 5000

### This application provides following -

USER CRUD APIs

Mocking API for the assign project to the user.

Autocomplete search basis on the project and skills

- [GET] http://localhost:5000/api/projects/autocomplete (To fetch the projects basis on the user input)

- [GET] http://localhost:5000/api/skills/autocomplete (To fetch the projects skills on the user input)

API to fetching and filtering the team_members (with pagination)

- [GET] http://localhost:5000/api/team_members (To fetch the team_members details with filtering and pagination)

### Assumption

I've created the single team and all the team_members belongs to that team only. I've created the route as `team_members` instead of `team` (`/api/team` to `/api/team_members`)

### Note

There are some CRUD APIs which are not consumed by front-end react application like user CRUD  & Mocking APIs.

