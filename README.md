# docker-playwright-lambda

[![badge](https://github.com/umihico/docker-playwright-lambda/actions/workflows/demo-test.yml/badge.svg)](https://github.com/umihico/docker-playwright-lambda/actions/workflows/demo-test.yml)
[![badge](https://github.com/umihico/docker-playwright-lambda/actions/workflows/auto-update.yml/badge.svg)](https://github.com/umihico/docker-playwright-lambda/actions/workflows/auto-update.yml)

This is minimum demo of chrome automation by Node.js and playwright in AWS Lambda

This image goes with these versions. [These are automatically updated and tested everyday.](https://github.com/umihico/docker-playwright-lambda/actions)

- Node.js v22.15.1
- Chromium 140.0.7339.16
- Playwright 1.55.0

## Running the demo

```bash
$ npm install -g serverless@^3 # skip this line if you have already installed Serverless Framework
$ export AWS_REGION=ap-northeast-1 # You can specify region or skip this line. us-east-1 will be used by default.
$ sls create --template-url "https://github.com/umihico/docker-playwright-lambda/tree/main" --path docker-playwright-lambda && cd $_
$ sls deploy
$ sls invoke --function demo # Yay! You will get texts of example.com
```

## Side Projects

Are you interested in **Python** or **Selenium**? Please check out [docker-selenium-lambda](https://github.com/umihico/docker-selenium-lambda)

If you don't want to create functions each time for each purpose, Please check out [pythonista-chromeless](https://github.com/umihico/pythonista-chromeless)
