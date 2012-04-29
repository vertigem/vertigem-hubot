# Beautiful Naked Ladies
#
# beautiful_naked_ladies - s2

libxmljs    = require("libxmljs");

Array::shuffle = -> @sort -> 0.5 - Math.random()

module.exports = (robot) ->
  robot.respond /beautiful_naked_ladies/i, (msg) ->
    send_beautiful_naked_ladies msg, false, (text)->
      msg.send text


send_beautiful_naked_ladies= (msg, location, callback)->
  beautiful_naked_ladies = "http://beautifulnakedladies.tumblr.com/api/read?num=100&type=photo"
  msg.http( beautiful_naked_ladies ).get() (error, response, body)->
    return callback "Sorry, something went wrong" if error
    console.log("try get beautiful naked ladies, code is #{response.statusCode}")
    if response.statusCode == 302
      location = response.headers['location']
      return send_beautiful_naked_ladies( msg, location, callback )

    callback get_beautiful_naked_ladies_image(body, "//photo-url[@max-width='500']")

get_beautiful_naked_ladies_image = (body, selector)->
  parser = libxmljs.parseXmlString(body);
  parser.find(selector).shuffle()[0].text()