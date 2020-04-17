FROM alpine
WORKDIR /usr/local/src/build
COPY --chown=0:0 . .
RUN sh download.sh && tar -zxp -f archlinux-bootstrap-*-x86_64.tar.gz -C / && rm *.tar.gz *.tar.gz.md5
RUN sh repack.all.sh | xargs rm -Rf
RUN rm -Rf download.sh repack.*

RUN apk add --update --no-cache sed
RUN sed -i -r -z 's|\n#([[]multilib[]])\n#|\n\1\n|' /root.x86_64/etc/pacman.conf
RUN sed -i -r 's|^#(Server = https://mirrors\.kernel\.org)|\1|' /root.x86_64/etc/pacman.d/mirrorlist

FROM scratch
COPY --from=0 /root.x86_64/ /
COPY --from=0 /usr/local/src/build /usr/local/src/build

ENV LC_ALL=C
ENTRYPOINT /usr/local/src/build/assemble.sh
