# Hubot Status
#
# are you ok? - check if hubot is OK
Array::shuffle = -> @sort -> 0.5 - Math.random()

module.exports = (robot) ->
  robot.respond /are you ok\?/i, (msg) ->
    messages = ["I believe Yes!", "Maybe!", "I am OK, honey!", "What you doing? Talk with a bot? oh man..."]

    msg.send messages.shuffle()[0]