FROM alpine:latest

COPY must4rd /usr/local/bin/must4rd
COPY k3sadm-kubeconfig-merge /usr/local/bin/k3sadm-kubeconfig-merge
COPY k3sadm-k3os-get-cluster /usr/local/bin/k3sadm-k3os-get-cluster

RUN apk add --no-cache bash curl openssh keychain sudo openssl ncurses \
  && chmod +x /usr/local/bin/* \
  && chmod +x /usr/local/bin/must4rd \
  && curl -sLS https://get.k3sup.dev | sh \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl \
  && for F in kubectx kubens ; do G=/usr/local/bin/${F} ; curl -o ${G} https://raw.githubusercontent.com/ahmetb/kubectx/master/${F} ; chmod +x ${G} ; done \
  && curl -sSL https://dl.get-arkade.dev/ | sh \
  && curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash \
  && mkdir -p /root/.ssh/ && ssh-keygen -f /root/.ssh/id_rsa -t ed25519 -N '' \
  && echo 'eval $(keychain --eval ~/.ssh/id_rsa)' >> /root/.bashrc \
  && echo 'alias kc=$(which kubectl)' >> /root/.bashrc \
  && echo 'export PATH=/root/.arkade/bin:$PATH' >> /root/.bashrc \
  && rm -f /var/cache/apk/*

CMD ["/bin/bash"]
