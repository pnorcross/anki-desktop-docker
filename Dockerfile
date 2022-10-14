FROM lsiobase/rdesktop-web:focal


 RUN \
  apt-get update && \
  apt-get install -y anki wget zstd xdg-utils && \
  dpkg --remove anki && \
  wget https://github.com/ankitects/anki/releases/download/2.1.54/anki-2.1.54-linux-qt5.tar.zst && \
  tar --use-compress-program=unzstd -xvf anki-2.1.54-linux-qt5.tar.zst && \
  cd anki-2.1.54-linux-qt5 && ./install.sh &&  cd .. && \
  rm -rf anki-2.1.54-linux-qt5 anki-2.1.54-linux-qt5.tar.zst && \
  apt-get clean && \
  mkdir -p /config/.local/share && \
  ln -s /config/app/Anki  /config/.local/share/Anki  && \
  ln -s /config/app/Anki2 /config/.local/share/Anki2

VOLUME "/config/app" 

COPY root/ /
