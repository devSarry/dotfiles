FROM fedora:42

LABEL maintainer="TechDufus <https://techdufus.com>"

ARG USER=techdufus
ARG group=techdufus
ARG uid=1000

ENV TZ="America/Chicago"
ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"

USER root

RUN dnf -y upgrade --refresh && \
  dnf -y install \
  sudo \
  curl \
  git \
  gnupg2 \
  glibc-langpack-en \
  tzdata \
  wget \
  ncurses && \
  dnf clean all

RUN groupadd --gid ${uid} ${group} && \
  useradd --uid ${uid} --gid ${group} --create-home --home-dir /home/${USER} --shell /bin/bash ${USER}

RUN mkdir -p /etc/sudoers.d && \
  touch /etc/sudoers.d/${USER} && \
  echo "%${group} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER} && \
  chmod 0440 /etc/sudoers.d/${USER} && \
  groupadd -f docker && \
  usermod -aG docker ${USER}

RUN chown -R ${USER}:${group} /home/${USER}
USER ${USER}

COPY --chown=${USER}:${group} bin/dotfiles /home/${USER}/dotfiles

RUN \
  mkdir -p /home/${USER}/.ansible-vault && \
  touch /home/${USER}/.ansible-vault/vault.secret && \
  echo '$vault_secret' > /home/${USER}/.ansible-vault/vault.secret

# RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/devSarry/dotfiles/main/bin/dotfiles)"
RUN git clone --quiet https://github.com/devSarry/dotfiles.git /home/${USER}/.dotfiles
COPY --chown=${USER}:${group} ansible.cfg /home/${USER}/.dotfiles/ansible.cfg
RUN bash -c "/home/${USER}/dotfiles"

RUN rm ~/.ansible-vault/vault.secret

# CMD []
#
# ENTRYPOINT ["/bin/bash"]
