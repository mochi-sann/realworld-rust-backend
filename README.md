# ![RealWorld Example App](logo.png)

> ### [YOUR_FRAMEWORK] codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the [RealWorld](https://github.com/gothinkster/realworld) spec and API.


### [Demo](https://demo.realworld.io/)&nbsp;&nbsp;&nbsp;&nbsp;[RealWorld](https://github.com/gothinkster/realworld)


This codebase was created to demonstrate a fully fledged fullstack application built with **[YOUR_FRAMEWORK]** including CRUD operations, authentication, routing, pagination, and more.

We've gone to great lengths to adhere to the **[YOUR_FRAMEWORK]** community styleguides & best practices.

For more information on how to this works with other frontends/backends, head over to the [RealWorld](https://github.com/gothinkster/realworld) repo.


# How it works

> Describe the general architecture of your app here

# Getting started

> npm install, npm start, etc.

```bash
Error: postgres: scanning system variables: pq: SSL is not enabled on the server

atlas schema inspect -u "postgres://postgres:postgres@0.0.0.0:5432/app-db?sslmode=disable"


atlas schema inspect \
  --url "postgres://postgres:postgres@localhost:5432/app-db?search_path=public&sslmode=disable" \
  --format '{{ sql . }}' >  schema/schema.sql

atlas migrate diff create_todos \
  --dir "file://migrations" \
  --to "file://schema/schema.sql" \
  --dev-url "postgres://postgres:postgres@localhost:5432/app-db?search_path=public&sslmode=disable"

atlas migrate push app \
  --dev-url "postgres://postgres:postgres@localhost:5432/app-db?search_path=public&sslmode=disable"

atlas migrate apply --env local

```
