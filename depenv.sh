#!/bin/bash
if ("$params.ENVIRONMENT = AUS")
then
        echo "deploying to $ENVIRONMENT"
elif ($ENVIRONMENT = EU)
then
        echo "Deploying to $ENVIRONMENT"
elif ($ENVIRONMENT = USA)
then
        echo "Deploying to $ENVIRONMENT"
fi
