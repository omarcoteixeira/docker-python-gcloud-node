# Python with Node env to run tests

Base image with:
- python 2.7.14
- node v9.7.1
- npm v5.7.1
- yarn v1.5.1
- chromedriver 2.36
- phantomjs 2.1.1

# Docker hub

[omarcoteixeira/python-gcloud-node](https://hub.docker.com/r/omarcoteixeira/python-gcloud-node/)

# Commands


## Build the image
```
docker build -t omarcoteixeira/python-gcloud-node:v1 .
```

## Push the image

```
docker push omarcoteixeira/python-gcloud-node
```
