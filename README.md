# pot

[![Circle CI](https://circleci.com/gh/dunyakirkali/pot.svg?style=svg)](https://circleci.com/gh/dunyakirkali/pot)

## Development

``` foreman start -f Procfile.dev ```

## Test

``` rspec  ```

## Deploy

Once a PullRequest is merged into the master branch, Github will trigger a build on Magnu-CI,
whih then triggers Github command to deploy to heroku.
