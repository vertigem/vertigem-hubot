# Augusta
#
# O que tem hoje na Rua Augusta? - s2

augusta_party_url = "http://augustaapp.com/festas.json"
module.exports = (robot) ->
  robot.hear /^O que tem hoje na Rua Augusta\?/i, (message) ->
    message.http( augusta_party_url ).get() (error, response, body)->
      get_parties body, (text)->
        message.send text

get_parties = (body, callback)->
  parties = JSON.parse(body)
  return callback "Hoje nada!" if parties.today.length == 0
  callback "#{party.name}\n#{party.flyer_url}" for party in parties.today
