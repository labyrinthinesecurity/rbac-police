FROM alpine:latest

RUN apk add --no-cache git make musl-dev go curl

RUN cd / && git clone https://github.com/PaloAltoNetworks/rbac-police

ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin
RUN cd /rbac-police && go install
RUN cd / && curl -LOl https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
