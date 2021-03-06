#!/bin/bash

set -ex

# apt update
# apt install -y libdbus-1-dev pxz zsync

[ -e /opt ] || mkdir /opt
cd /opt
rm -rf mycroft
git clone --depth=1 --branch=dev https://github.com/MycroftAI/mycroft-core.git mycroft

cd mycroft

export TERM=xterm
echo '{"use_branch": "dev", "auto_update": true}' > .dev_opts.json
bash dev_setup.sh --allow-root

# This chowns and crap via sudo. Utterly useless for us because sudo will not
# work when the plasmoid starts it. Instead we'll chown elsewhere.
rm scripts/prepare-msm.sh
ln -s /bin/true scripts/prepare-msm.sh
cp mycroft/skills/__main__.py mycroft/skills/main.py
mkdir skills

find -iname *.o | xargs rm -v
find -iname *.lo | xargs rm -v
find -iname *.c | xargs rm -v
find -iname *.h | xargs rm -v
cd mimic
find -iname .libs | xargs rm -rv
cd ..

source .venv/bin/activate
msm default || true # install default skills

# cd ..
# tar -cf mycroft-core.tar mycroft-core
# rm -rf mycroft-core
# pxz -9 mycroft-core.tar

# zsyncmake mycroft-core.tar.xz


# on user phablet

# wget https://metadata.neon.kde.org/.mycroft/mycroft-core.tar.xz
# tar -xf mycroft-core
#
# mkdir /var/log/mycroft
# chown phablet /var/log/mycroft
#
# sudo apt install libportaudio2 python3-arrow flac jq libfann2 libjack0 libjq1 libonig4 libout123-0 libportaudiocpp0 mpg123
