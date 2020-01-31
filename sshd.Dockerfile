FROM node:8.11.1-alpine
LABEL Anik Barua <onixoni72@gmail.com>
# SSHD #################################
RUN apk update && \
    apk add openssh augeas && \
    mkdir -p ~root/.ssh /etc/authorized_keys && chmod 700 ~root/.ssh/ && \
    augtool 'set /files/etc/ssh/sshd_config/AuthorizedKeysFile ".ssh/authorized_keys /etc/authorized_keys/%u"' && \
    augtool 'set /files/etc/ssh/sshd_config/PermitRootLogin yes' && \
    augtool 'set /files/etc/ssh/sshd_config/PasswordAuthentication yes' && \
    augtool 'set /files/etc/ssh/sshd_config/Port 22' && \
    cp -a /etc/ssh /etc/ssh.cache && \
    ssh-keygen -A && \
    rm -rf /var/cache/apk/* && \
    #mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd

# SSH login fix. Otherwise user is kicked off after login
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
# SSHD END #################################
