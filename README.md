# pot

[![Circle CI](https://circleci.com/gh/dunyakirkali/pot.png?circle-token=f174742eaf65e547a254e8a3df6d511704ac8ab4)](https://circleci.com/gh/dunyakirkali/pot)
[![PullReview stats](https://www.pullreview.com/github/dunyakirkali/pot/badges/master.svg?token=7e7aa54dc544690452872d70b20e4465)](https://www.pullreview.com/github/dunyakirkali/pot/reviews/master)


## Development

``` foreman start -f Procfile.dev -e Procfile.dev.env ```

## Test

``` rspec  ```

## Deploy

Once a PullRequest is merged into the master branch, Github will trigger a build on CircleCI,
which then triggers Github to deploy to heroku.

## Documentation

Generate docs with ``` yard ```
Open docs with ``` open doc/index.html ```

## Security

Test with ``` brakeman -o report.html ```
Open docs with ``` open report.html ```


## Mails

visit ``` localhost:1080 ```

