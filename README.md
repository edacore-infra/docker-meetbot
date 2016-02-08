# docker-meetbot

This is based on J J Asghar meetbot docker definition: https://github.com/jjasghar/docker-meetbot but adapted to our needs,
and grabbing the openstack meetbot which allows #startvote

This is a docker container to get [meetbot](https://wiki.debian.org/MeetBot) running and only needing your specific configurations.

## Installation

Pull the latest version of the image from the docker index. This is the recommended method of installation as it is easier to update image in the future.

```
docker pull edacoreinfra/meetbot:latest
```

Alternately you can build the image yourself.

```
git clone https://github.com/edacoreinfra/docker-meetbot.git
cd docker-meetbot
docker build -t="$USER/meetbot" .
```

## Quick Start

Run the image

```
docker run --name="meetbot-running" -d -p 81:80/tcp \
          -v /root/docker-meetbot/conf:/conf \
          -v /root/docker-meetbot/data:/data \
          -v /root/docker-meetbot/logs:/logs root/meetbot

```

It has  a `meetbot.conf` in the repo that'll connect to freenode

When you are ready for this bot to connect and you start using it i suggest
you pull down the main [meetbot](https://wiki.debian.org/MeetBot) code, and
run the _Configuring SupyBot_ section. Grab the files that are outputted, copy
them into the directory you want to use as your `/conf` directory and rename the
_<your_bot_name.conf>_ to `meetbot.conf`

You should see your bot in the IRC channel of your choosing in a few seconds.
