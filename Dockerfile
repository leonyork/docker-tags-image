ARG CURL_VERSION
FROM curlimages/curl:${CURL_VERSION}

USER root
RUN apk add --no-cache jq
COPY tags.sh /bin/
RUN chmod 755 /bin/tags.sh

USER curl_user
WORKDIR /home/curl_user/

ENTRYPOINT [ "/bin/tags.sh" ]