# Prisma Migrate for PlanetScale

[Prisma](https://www.prisma.io) and [PlanetScale](https://planetscale.com) have some helpful documentation to get you started. What they don't offer are examples of how a migration might be run in production. This repo aims to add some ready-made free-to-use scripts to get you migratin'.

## Existing Documentation

If this is your first time integrating Prisma with PlanetScale, follow their existing documentation. When you're ready to start migrating in production, then come back here.

* [Using Prisma with a PlanetScale database #7292](https://github.com/prisma/prisma/issues/7292)
* [Automatic Prisma Migrations](https://docs.planetscale.com/tutorials/automatic-prisma-migrations)

## Pre-Requisites

To use the contained scripts, you'll need to create a service token using the Planetscale CLI and give it the following permissions for the database you want to migrate. **Note:** You must complete this step using the CLI. It seems the PlanetScale Web UI is unreliable at setting these permissions.

* `connect_branch`
* `create_branch`
* `create_deploy_request`
* `delete_branch`
* `read_branch`

## Gotchas'

* Setting PlanetScale service token permissions via the Web UI is unreliable. The permissions will appear, but they won't work with the CLI.
* Repeatedly creating and deleting a PlanetScale branch of the same name will introduce CLI connection issues. These scripts use the date or a short-sha to dodge this issue.
* The PlanetScale's CLI creates an environmental variable `DATABASE_URL` when using the `pscale connect` command. This variable will overwrite any existing variable of the same name. This behavior can cause some [head-scratching](https://github.com/prisma/prisma/issues/7341).
* The PlanetScale CLI doesn't allow pull-requests to be created despite having the correct permissions.
* The PlanetScale CLI `connect` command doesn't wait for a newly created branch to be available, it just fails to connect. These scripts wait 10 seconds to side-step this issue.
