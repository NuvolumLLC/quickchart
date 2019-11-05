#!/bin/bash -e

docker stop quickchart || true
docker rm quickchart || true
docker run --name 'quickchart' -d --restart always -p 3000:80 ianw/quickchart
