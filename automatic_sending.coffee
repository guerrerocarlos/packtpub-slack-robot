# This is a simple example of how to use the slack-client module in CoffeeScript. It creates a
# bot that responds to all messages in all channels it is in with a reversed
# string of the text received.
#
# To run, copy your token below, then, from the project root directory:
#
# To run the script directly
#    npm install
#    node_modules/coffee-script/bin/coffee examples/simple_reverse.coffee 
#
# If you want to look at / run / modify the compiled javascript
#    npm install
#    node_modules/coffee-script/bin/coffee -c examples/simple_reverse.coffee 
#    cd examples
#    node simple_reverse.js
#

Slack = require 'slack-client'
get_book = require './get_book'
config = require './config'

token = config.token
autoReconnect = true
autoMark = true

slack = new Slack(token, autoReconnect, autoMark)

slack.on 'open', ->
  channels = []
  groups = []
  unreads = slack.getUnreadCount()

  # Get all the channels that bot is a member of
  channels = ("##{channel.name}" for id, channel of slack.channels when channel.is_member)

  # Get all groups that are open and not archived 
  groups = (group.name for id, group of slack.groups when group.is_open and not group.is_archived)

  console.log "Welcome to Slack. You are @#{slack.self.name} of #{slack.team.name}"
  console.log 'You are in: ' + channels.join(', ')
  console.log 'As well as: ' + groups.join(', ')

  messages = if unreads is 1 then 'message' else 'messages'

  console.log "You have #{unreads} unread #{messages}"

  destinationChannel = config.destinationChannel
  console.log destinationChannel
  channel = slack.getChannelGroupOrDMByID(destinationChannel)
  console.log channel

  get_book.get_book()
    .then (data) ->
        # channel.send data.image.replace(/\ /g, "%20")
        channel.send 'El libro gratuito de Packtpub hoy es: ' + data.title + ' https://www.packtpub.com/packt/offers/free-learning '


slack.on 'messag', (message) ->
  console.log 'Define variable  destinatinationChannel as: ' + message.channel

slack.on 'error', (error) ->
  console.error "Error: #{JSON.stringify(error)}"


slack.login()
