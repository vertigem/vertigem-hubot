# Fuck Yeah Red Hair
#
# redhair - s2
# ruiva   - alias to readhair

libxmljs    = require("libxmljs");
sys         = require "sys"

Array::shuffle = -> @sort -> 0.5 - Math.random()

module.exports = (robot) ->
  robot.respond /redhair|ruiva/i, (msg) ->
    send_redhair msg, false, (text)->
      msg.send text


send_redhair= (msg, location, callback)->
  fuckyeahredhair_url = "http://fuckyeahredhair.tumblr.com/api/read?num=100&type=photo"
  msg.http( fuckyeahredhair_url ).get() (error, response, body)->
    return callback "Sorry, something went wrong" if error
    console.log("try get redhair, code is #{response.statusCode}")
    if response.statusCode == 302
      location = response.headers['location']
      return send_redhair( msg, location, callback )

    callback get_redhair_image(body, "//photo-url[@max-width='500']")

get_redhair_image = (body, selector)->
  parser = libxmljs.parseXmlString(body);
  parser.find(selector).shuffle()[0].text()