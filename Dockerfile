FROM rbac-police-builder:latest as builder
RUN  cd /rbac-police && go build

FROM alpine:latest
RUN mkdir /opt/rbac-police && mkdir /.kube
COPY --from=builder /rbac-police/ /opt/rbac-police/
COPY --from=builder /kubectl /opt/rbac-police/kubectl
COPY config /.kube

ENV HOME="/"
RUN chmod g+rwX /opt/rbac-police

RUN chown -R 1001:root /opt/rbac-police/ && chmod g+rwX /opt/rbac-police/
ENV PATH="/opt/rbac-police:$PATH"
RUN chown -R 1001:root /.kube

WORKDIR /opt/rbac-police
USER 1001
ENTRYPOINT [ "/opt/rbac-police/rbac-police", "eval", "lib/" ]
