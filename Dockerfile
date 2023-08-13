FROM ubuntu:22.04 AS build

RUN apt-get update && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y ca-certificates build-essential pkg-config libudev-dev curl\
    && rm -rf /var/lib/apt/lists/* 

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN . $HOME/.cargo/env && cargo install cargo-deb

COPY . /opt/xbnet

RUN . $HOME/.cargo/env && cd /opt/xbnet && cargo build --release && cargo deb
RUN mkdir -p /opt/xbnet/build && cp /opt/xbnet/target/debian/*.deb /opt/xbnet/build && cp /opt/xbnet/target/release/xbnet /opt/xbnet/build/xbnet-$(dpkg --print-architecture)
# RUN apt install /opt/xbnet/target/debian/xbnet_1.1.0_amd64.deb

FROM scratch AS export
COPY --from=build /opt/xbnet/build /