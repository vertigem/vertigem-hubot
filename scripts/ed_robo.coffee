# Ed Robo
#
# amigo $suamensagem - fale com o Hubot

sys         = require "sys"

ed_robo_url = "http://www.ed.conpet.gov.br/mod_perl/bot_gateway.cgi?server=0.0.0.0%3A8085&charset_post=utf-8&charset=utf-8&pure=1&js=0&tst=1&msg="
module.exports = (robot) ->
  robot.respond /amigo (.*)$/i, (message)->
    message.http( "#{ed_robo_url}#{encodeURIComponent(message.match[1])}" ).get() (error, response, body)->
      message.send body.replace("Ed", "Hubot")