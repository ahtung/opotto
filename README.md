# pot

[![Circle CI](https://circleci.com/gh/dunyakirkali/pot.svg?style=svg)](https://circleci.com/gh/dunyakirkali/pot)
[![PullReview stats](https://www.pullreview.com/github/dunyakirkali/pot/badges/master.svg?token=7e7aa54dc544690452872d70b20e4465)](https://www.pullreview.com/github/dunyakirkali/pot/reviews/master)

## Development

``` foreman start -f Procfile.dev ```

## Test

``` rspec  ```

## Deploy

Once a PullRequest is merged into the master branch, Github will trigger a build on CircleCI,
which then triggers Github to deploy to heroku.
