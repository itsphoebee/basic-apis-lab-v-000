require 'pry'
class RepositoriesController < ApplicationController

  def foursquare
    begin
      @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
        req.params['client_id'] = '8cb54fc357265938ea13'
        req.params['client_secret'] = '76bdecf0fb2bfd27af332b2f49ad6d4563032f35'
        req.params['q'] = params[:query]
        req.options.timeout = 100
        binding.pry
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @repos = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end

  def github_search
  end
end
