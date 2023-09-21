FROM docker.io/library/golang:1.21-bookworm as builder

WORKDIR /opt/source

ARG VERSION=3.27.0
RUN git clone https://github.com/alist-org/alist.git . \
        --branch v${VERSION} \
        --config advice.detachedHead=false \
        --depth 1 \
        --recurse-submodules \
        --single-branch \
    && bash build.sh release docker

FROM gcr.io/distroless/base-debian12:nonroot

WORKDIR /opt/alist

COPY --from=builder /opt/source/bin/alist /usr/bin/alist

VOLUME /opt/alist/data
EXPOSE 5244 5245

ENTRYPOINT [ "/usr/bin/alist" ]
CMD [ "server", "--data", "/opt/alist/data", "--no-prefix" ]
