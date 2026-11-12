# Meta-Genome frontend

React frontend for [meta-genome.org](https://meta-genome.org), built with [Vite](https://vite.dev/). It plots data from the [Flask API](https://github.com/Meta-Genome-Org/metag_flask_api) at `api.meta-genome.org`.

## Scripts

### `npm start`

Runs the development server at [http://localhost:3000](http://localhost:3000), reloading on changes.

The API only allows requests from `https://meta-genome.org` (CORS), so the graph won't load data from `localhost` unless you run the API locally with `CORS_ORIGIN=http://localhost:3000`.

### `npm run build`

Builds the production site into `build/`.

### `npm run preview`

Serves the contents of `build/` locally, to check a production build.

## Docker

The `dockerfile` builds the site with Node, then serves `build/` with nginx (`conf/subsite.conf`). CI builds it and pushes it to GHCR, and it's deployed from `Meta-Genome-Org/private-deployment`.
