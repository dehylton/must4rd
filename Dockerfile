FROM alpine:latest

COPY must4rd /usr/local/bin/must4rd
COPY k3sadm-merge /usr/local/bin/k3sadm-merge
COPY k3sadm-adopt /usr/local/bin/k3sadm-adopt

RUN apk add --no-cache bash curl openssh keychain sudo openssl ncurses \
  && chmod +x /usr/local/bin/* \
  && curl -sSL https://dl.get-arkade.dev/ | sh \
  && arkade get k3sup   \
  && arkade get kubectl \
  && arkade get kubectx \
  && arkade get kubens  \
  && arkade get helm  \
  && echo 'test -f /root/.ssh/id_ed25519 || { mkdir -p /root/.ssh/ && ssh-keygen -f /root/.ssh/id_ed25519 -t ed25519 -N "" ; }' >> /root/.bashrc \
  && echo 'eval $(keychain --eval ~/.ssh/id_ed25519)' >> /root/.bashrc \
  && echo 'export PATH=/root/.arkade/bin:$PATH' >> /root/.bashrc \
  && echo 'alias kc=$(which kubectl)' >> /root/.bashrc \
  && echo 'alias kx=$(which kubectx)' >> /root/.bashrc \
  && echo 'alias kn=$(which kubens)' >> /root/.bashrc \
  && rm -f /var/cache/apk/*

CMD ["/bin/bash"]
