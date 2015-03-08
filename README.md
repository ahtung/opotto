# pot

[![Circle CI](https://circleci.com/gh/dunyakirkali/pot.png?circle-token=f174742eaf65e547a254e8a3df6d511704ac8ab4)](https://circleci.com/gh/dunyakirkali/pot)
[![Code Climate](https://codeclimate.com/repos/54fc9f43e30ba014cc00061f/badges/c03a260249793e92c75c/gpa.svg)](https://codeclimate.com/repos/54fc9f43e30ba014cc00061f/feed)
[![Test Coverage](https://codeclimate.com/repos/54fc9f43e30ba014cc00061f/badges/c03a260249793e92c75c/coverage.svg)](https://codeclimate.com/repos/54fc9f43e30ba014cc00061f/feed)

## Development

``` foreman start -f Procfile.dev -e Procfile.dev.env ```

## Test

``` foreman run rspec -e Procfile.dev.env  ```

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

