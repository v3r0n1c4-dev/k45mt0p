FROM ghcr.io/linuxserver/baseimage-selkies:debiantrixie

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="b3h1m0th"

# title
ENV TITLE="b3h1m0th"

RUN \
  echo "**** add icon ****" && \
  curl https://raw.githubusercontent.com/theharumph/harpchecks/main/img/harpburn.png -o /usr/share/selkies/www/icon.png && \
  echo "**** install packages ****" && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt install -y --no-install-recommends \
    firefox-esr \
    wget \
    gstreamer1.0-pipewire \
    firefox-esr-l10n-all \
    elementary-xfce-icon-theme \
    greybird-gtk-theme \
    libxfce4ui-utils \
    mousepad \
    thunar \
    xfce4-appfinder \
    xfce4-panel \
    xfce4-session \
    xfce4-settings \
    xfce4-taskmanager \
    xfce4-terminal \
    xfconf \
    xfdesktop4 \
    xfwm4 && \
  wget -q https://github.com/rustdesk/rustdesk/releases/download/1.4.2/rustdesk-1.4.2-x86_64.deb && \
  dpkg -i rustdesk-1.4.2-x86_64.deb && \
  apt-get install -f -y && \
  echo "**** xfce tweaks ****" && \
#  sed -i \
#    's#^Exec=.*#Exec=/usr/local/bin/wrapped-chromium#g' \
#    /usr/share/applications/chromium.desktop && \
  mv \
    /usr/bin/exo-open \
    /usr/bin/exo-open-real && \
  mv \
    /usr/bin/thunar \
    /usr/bin/thunar-real && \
  rm -f \
    /etc/xdg/autostart/xscreensaver.desktop && \
  echo "**** cleanup ****" && \
  apt autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/* \
    rustdesk-1.4.2-x86_64.deb
  

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
