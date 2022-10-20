class BeersController < ApplicationController
  def index
    @target = permit_params[:target]
    @beers = []
    beers(filter_name).each do |b|
      @beers << OpenStruct.new(id: b['id'], name: b['name'])
    end
    @pagy, @beers = pagy_array(@beers, items: 10)
  end

  def search
    @beers = []
    beers(filter_name).each do |b|
      @beers << OpenStruct.new(id: b['id'], name: b['name'])
    end
    @pagy, @beers = pagy_array(@beers, items: 10)
  end

  private

  def permit_params
    params.permit(:target, :filter, :page)
  end

  def beers(beer_name = '')
    url_string = 'https://api.punkapi.com/v2/beers?page=1&per_page=25'
    url_string << "&beer_name=#{beer_name}" if beer_name.present?

    uri_beers  = URI.parse(url_string)
    http_beers = Net::HTTP.new(uri_beers.host, uri_beers.port)
    http_beers.use_ssl = true
    http_beers.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @data_beers = JSON.parse(http_beers.get(uri_beers.request_uri).body)
  end

  def filter_name
    @filter_name ||= permit_params[:filter]
  end
end
