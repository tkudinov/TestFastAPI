#!/bin/bash
set -e

: ${TWS_MAJOR_VERSION}
: ${TWSUSERID}
: ${TWSPASSWORD}
: ${FIXUSER}
: ${FIXPW}
: ${IB_PORT}
: ${API_PORT}

/opt/ibc/twsstart.sh
/opt/ibc/gatewaystart.sh ${TWS_MAJOR_VERSION} --ibc-ini=/opt/ibc/ibc.ini --java-path=/opt/ibc/IBC.jar --user=${TWSUSERID} --pw=${TWSPASSWORD}


echo "Waiting 15 seconds for IB Gateway to initialize..."
sleep 15
echo "Starting FastAPI server on port ${API_PORT}..."
exec uvicorn app:app --host 0.0.0.0 --port ${API_PORT}
