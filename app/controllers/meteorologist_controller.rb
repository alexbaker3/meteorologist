require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address}"
    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url2="https://api.darksky.net/forecast/83493ab6f1cfec1d5a9b9252a981fd40/#{latitude},#{longitude}"

    parsed_data2 = JSON.parse(open(url2).read)

    summary = parsed_data2["currently"]["summary"]

    temp = parsed_data2["currently"]["temperature"]

    @current_temperature = temp

    @current_summary = summary

over_hour=parsed_data2["minutely"]["summary"]

    @summary_of_next_sixty_minutes = over_hour

    several_hours = parsed_data2["hourly"]["summary"]

    @summary_of_next_several_hours = several_hours

    several_days=parsed_data2["daily"]["summary"]

    @summary_of_next_several_days = several_days

    render("meteorologist/street_to_weather.html.erb")
  end
end
