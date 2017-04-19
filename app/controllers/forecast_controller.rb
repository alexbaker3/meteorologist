require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

url="https://api.darksky.net/forecast/83493ab6f1cfec1d5a9b9252a981fd40/#{@lat},#{@lng}"

parsed_data = JSON.parse(open(url).read)

summary = parsed_data["currently"]["summary"]

temp = parsed_data["currently"]["temperature"]

@current_temperature = temp

@current_summary = summary

over_hour=parsed_data["minutely"]["summary"]

@summary_of_next_sixty_minutes = over_hour

several_hours = parsed_data["hourly"]["summary"]

@summary_of_next_several_hours = several_hours

several_days=parsed_data["daily"]["summary"]
@summary_of_next_several_days = several_days

    render("forecast/coords_to_weather.html.erb")
  end
end
