#!/bin/bash

./binary.test -SystemTest=true -test.coverprofile=system.out &

curl http://localhost:9999/randompair
curl http://localhost:9999/randompair

sleep 5

kill %1