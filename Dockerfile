FROM fedora:42

LABEL maintainer="TechDufus <https://techdufus.com>"

ARG USER=techdufus
ARG group=techdufus
ARG uid=1000
ARG DOTFILES_SRC=/workspaces/dotfiles
ARG DOTFILES_DEST=/home/${USER}/.dotfiles

ENV TZ="America/Chicago"
ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV DOTFILES_SRC="${DOTFILES_SRC}"
ENV DOTFILES_DEST="${DOTFILES_DEST}"

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
  ncurses \
  rsync && \
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
COPY --chown=${USER}:${group} bin/dotfiles /home/${USER}/bin/dotfiles

RUN mkdir -p /home/${USER}/bin

RUN \
  mkdir -p /home/${USER}/.ansible-vault && \
  touch /home/${USER}/.ansible-vault/vault.secret && \
  echo '$vault_secret' > /home/${USER}/.ansible-vault/vault.secret

RUN mkdir -p ${DOTFILES_DEST}

COPY --chown=${USER}:${group} ansible.cfg ${DOTFILES_DEST}/ansible.cfg
COPY --chown=${USER}:${group} group_vars/all.yml.example ${DOTFILES_DEST}/group_vars/all.yml

RUN cat <<'EOF' > /home/${USER}/container-entrypoint.sh
#!/bin/bash
set -euo pipefail

src="${DOTFILES_SRC:-/workspaces/dotfiles}"
dest="${DOTFILES_DEST:-$HOME/.dotfiles}"

if [[ -d "$src" ]]; then
  mkdir -p "$dest"
  rsync -a --delete \
    --exclude '.git/' \
    --exclude '.venv/' \
    --exclude '__pycache__/' \
    --exclude '.mypy_cache/' \
    --exclude '.pytest_cache/' \
    "$src/" "$dest/"
fi

mkdir -p "$dest/group_vars"
if [[ ! -f "$dest/group_vars/all.yml" && -f "$dest/group_vars/all.yml.example" ]]; then
  cp "$dest/group_vars/all.yml.example" "$dest/group_vars/all.yml"
fi

cd "$dest"
exec "$@"
EOF

RUN chmod +x /home/${USER}/container-entrypoint.sh /home/${USER}/dotfiles /home/${USER}/bin/dotfiles

RUN rm ~/.ansible-vault/vault.secret

ENV PATH="/home/${USER}/bin:${PATH}"
WORKDIR ${DOTFILES_DEST}

ENTRYPOINT ["/home/techdufus/container-entrypoint.sh"]
CMD ["/bin/bash"]
