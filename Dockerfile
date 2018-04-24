FROM jrottenberg/ffmpeg:latest
MAINTAINER Jonathan Stucklen <stuckj@gmail.com>

# Install the latest comchap
RUN curl https://raw.githubusercontent.com/BrettSheleski/comchap/master/comchap > /usr/bin/comchap \
  && chmod +x /usr/bin/comchap

# Install the latest comskip
RUN apt-get update \
  && apt-get install -y autoconf libtool git build-essential libargtable2-dev libavformat-dev libsdl1.2-dev \
  && git clone git://github.com/erikkaashoek/Comskip \
  && cd Comskip \
  && ./autogen.sh \
  && ./configure \
  && make \
  && make install \
  && cd .. \
  && rm -rf Comskip \
  && apt-get remove -y autoconf libtool git build-essential libargtable2-dev libavformat-dev libsdl1.2-dev \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

# TODO: Run whatever script you write to automate this. :-P

# For now, just run bash
ENTRYPOINT ["/bin/bash"]
