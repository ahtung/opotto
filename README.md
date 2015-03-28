# pot

[![Circle CI](https://circleci.com/gh/dunyakirkali/pot.png?circle-token=f174742eaf65e547a254e8a3df6d511704ac8ab4)](https://circleci.com/gh/dunyakirkali/pot)

## Development

``` foreman start -f Procfile.dev -e Procfile.dev.env ```

## Tasks

    foreman run -e Procfile.dev.env rake spec
    foreman run -e Procfile.dev.env rake quality
    foreman run -e Procfile.dev.env rake style
    foreman run -e Procfile.dev.env rake security
    foreman run -e Procfile.dev.env rake doc

## Deploy

### Auto

Once a PullRequest is merged into the master branch, Github will trigger a build on CircleCI.
CircleCI will do ``` circle.yml ``` and eventually deploy to heroku.

### Manual

    ./script/staging/deploy
    ./script/production/deploy

## Documentation

Generate docs with ``` yard ```
Open docs with ``` open doc/index.html ```

## Mails

visit ``` localhost:1080 ```

