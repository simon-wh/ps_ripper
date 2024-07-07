FROM ubuntu:24.04

ARG TOOLS_PATH=/tools

# Prepare directory for tools
RUN mkdir ${TOOLS_PATH}
WORKDIR ${TOOLS_PATH}

RUN apt update && apt install -y cdrdao cdparanoia python3 gddrescue git udev eject

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

RUN git clone https://github.com/simon-wh/ps_ripper.git

ENV PATH="${TOOLS_PATH}/ps_ripper:${PATH}"

WORKDIR ${TOOLS_PATH}/ps_ripper


CMD tail -f /dev/null
