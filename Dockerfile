FROM python:3.9-slim

RUN apt update && \
    apt install -y openjdk-17-jre-headless wget unzip bash && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y procps
RUN apt-get update && apt-get install -y xterm

WORKDIR /opt

RUN mkdir -p ibgateway && cd ibgateway && \
    wget -O ibgateway-installer.sh https://download2.interactivebrokers.com/installers/ibgateway/latest-standalone/ibgateway-latest-standalone-linux-x64.sh && \
    chmod u+x ibgateway-installer.sh && \
    # Run the installer in quiet mode. If the installer returns a non-zero code on success, ignore it.
    ./ibgateway-installer.sh -q || echo "IB Gateway installer finished."

RUN wget -O IBController.zip https://github.com/IbcAlpha/IBC/releases/download/3.22.0/IBCLinux-3.22.0.zip && \
    unzip IBController.zip -d ibc && rm IBController.zip

COPY ibc.ini /opt/ibc/ibc.ini

RUN chmod -R +x /opt/ibc

COPY start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

COPY app.py /opt/app.py

RUN pip install fastapi uvicorn requests


EXPOSE 4001 8000

ENV TWSUSERID=user
ENV TWSPASSWORD=12345
ENV FIXUSER=admin
ENV FIXPW=12345
ENV TWS_MAJOR_VERSION=10.35
ENV IB_PORT=4001
ENV API_PORT=8000
ENV IB_GATEWAY_HOST=localhost

ENTRYPOINT ["/opt/start.sh"]
