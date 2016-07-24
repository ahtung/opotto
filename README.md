# pot

![](https://img.shields.io/badge/Ruby-2.2.4-green.svg)
![](https://img.shields.io/badge/Rails-5.0.0-green.svg)
[![Circle CI](https://circleci.com/gh/ahtung/opotto/tree/master.svg?style=shield&circle-token=917522f32c616b7c174960bc0fe3dbe95d510501)](https://circleci.com/gh/ahtung/opotto/tree/master)
[![Coverage Status](https://coveralls.io/repos/github/ahtung/opotto/badge.svg?branch=master&t=VAscs6)](https://coveralls.io/github/ahtung/opotto?branch=master)


## Development

``` foreman start -f Procfile.dev -e Procfile.dev.env ```

## Tasks

    foreman run -e Procfile.dev.env rake spec
    foreman run -e Procfile.dev.env rake style
    foreman run -e Procfile.dev.env rake security
    foreman run -e Procfile.dev.env rake quality

### Documentation

Run ``` yard ``` and open docs with ``` open doc/index.html ```

### Sitemap

Run ``` foreman run -e Procfile.dev.env rake sitemap:refresh ``` and it ill be uploaded to the ``` opotto-devbucket ``` on S3

## Test

Run unit tests with ``` rspec ```

## Deploy

### Auto

Once a PullRequest is merged into the master branch, Github will trigger a build on CircleCI.
CircleCI will do ``` circle.yml ``` and eventually deploy to heroku.

### Manual

    ./script/staging/deploy
    ./script/production/deploy


## Mails

visit ``` localhost:1080 ```
