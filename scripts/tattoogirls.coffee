# Tattoo Girls
#
# tattoo_girls - s2

libxmljs    = require("libxmljs");

Array::shuffle = -> @sort -> 0.5 - Math.random()

module.exports = (robot) ->
  robot.respond /tattoo_girls/i, (msg) ->
    send_tattoo_girls msg, false, (text)->
      msg.send text


send_tattoo_girls= (msg, location, callback)->
  tattoo_girls_url = "http://fuckyeahtattoosbetweenboobs.tumblr.com/api/read?num=100&type=photo"
  msg.http( tattoo_girls_url ).get() (error, response, body)->
    return callback "Sorry, something went wrong" if error
    console.log("try get tattoo girls, code is #{response.statusCode}")
    if response.statusCode == 302
      location = response.headers['location']
      return send_tattoo_girls( msg, location, callback )

    callback get_tattoo_image(body, "//photo-url[@max-width='500']")

get_tattoo_image = (body, selector)->
  parser = libxmljs.parseXmlString(body);
  parser.find(selector).shuffle()[0].text()