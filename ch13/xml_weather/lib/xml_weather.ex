defmodule XmlWeather do
  @moduledoc """
  Gets the weather at soem place in Texas
  """

  @url "https://w1.weather.gov/xml/current_obs/KDTO.xml"

  @doc """
  Fetches latest data and returns xml
  """
  def fetch do
    @url
    |> HTTPoison.get()
    |> handle_response
  end

  def handle_response({ _, %{status_code: status_code, body: body} }) do
    {
      status_code |> check_for_error(),
      body |> XmlToMap.naive_map()
    }
  end

  def check_for_error(200), do: :ok
  def check_for_error(_), do: :error
end
