packtpub-slack-robot
====================

Allows you to get the Packtpub free book of the day.

Installation
============

1) Clone Repo
2) npm install
3) Get Slack api key at https://SLACKCHANNEL.slack.com/services/new/bot
4) Configure the api key as shown inn example file config.EXAMPLE.js but rename it config.js
5) Execute the script:

    coffee automatic_sending.coffee

6) Add the bot to the channel/group you want it to be, write something and take note of the ChannelID
7) configure that ChannelID in config.js
8) Execute the script:

    coffee automatic_sending.coffee

9) Configure it to execute once a day with crontab




