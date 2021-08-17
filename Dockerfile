FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

RUN mkdir /modmail
WORKDIR /modmail
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install -y git python3 python3-venv python3-pip curl cmake

RUN git clone https://github.com/chamburr/twilight-dispatch
RUN cd twilight-dispatch
RUN curl https://sh.rustup.rs -sSf -o rustup.rs && chmod +x rustup.rs && ./rustup.rs -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN cd /modmail/twilight-dispatch && cargo build --release

RUN git clone https://github.com/CHamburr/modmail
COPY requirements.txt /modmail/modmail/requirements.txt
RUN cd modmail && pip3 install -r requirements.txt

RUN echo "d"
COPY .env /modmail/twilight-dispatch
COPY config.py /modmail/modmail 
COPY runall.sh .
RUN chmod +x runall.sh

CMD ["bash", "runall.sh"]
