require 'json'

class AppController < ApplicationController
  include HTTParty

  def film
    @film = HTTParty.get(params[:url], format: :json)
    characters = @film["characters"]
    planets = @film["planets"]
    starships = @film["starships"]
    @people = []
    @planets = []
    @starships = []
    characters.each do |person|
      person_data = HTTParty.get(person, format: :json)
      @people.push({"name": person_data["name"], "url": person_data["url"]})
    end
    planets.each do |planet|
      planet_data = HTTParty.get(planet, format: :json)
      @planets.push({"name": planet_data["name"], "url": planet_data["url"]})
    end
    starships.each do |starship|
      starship_data = HTTParty.get(starship, format: :json)
      @starships.push({"name": starship_data["name"], "url": starship_data["url"]})
    end

  end

  def person
    @person = HTTParty.get(params[:url], format: :json)
    films = @person["films"]
    starships = @person["starships"]
    planet = HTTParty.get(@person["homeworld"], format: :json)
    pl_name = planet["name"]
    pl_url = planet["url"]
    @origin_planet = {"name": pl_name, "url": pl_url}
    @films = []
    @starships = []
    films.each do |film|
      film_data = HTTParty.get(film, format: :json)
      @films.push({"name": film_data["title"], "url": film_data["url"]})
    end
    puts @films
    starships.each do |starship|
      starship_data = HTTParty.get(starship, format: :json)
      @starships.push({"name": starship_data["name"], "url": starship_data["url"]})
    end
  end

  def starship
    @starship = HTTParty.get(params[:url], format: :json)
    films = @starship["films"]
    pilots = @starship["pilots"]
    @films = []
    @pilots = []
    pilots.each do |pilot|
      pilot_data = HTTParty.get(pilot, format: :json)
      @pilots.push({"name": pilot_data["name"], "url": pilot_data["url"]})
    end
    films.each do |film|
      film_data = HTTParty.get(film, format: :json)
      @films.push({"name": film_data["title"], "url": film_data["url"]})
    end

  end

  def planet
    @planet = HTTParty.get(params[:url], format: :json)
    films = @planet["films"]
    residents = @planet["residents"]
    @films = []
    @residents = []
    residents.each do |resident|
      resident_data = HTTParty.get(resident, format: :json)
      @residents.push({"name": resident_data["name"], "url": resident_data["url"]})
    end
    films.each do |film|
      film_data = HTTParty.get(film, format: :json)
      @films.push({"name": film_data["title"], "url": film_data["url"]})
    end
  end

  def index
    data = HTTParty.get('https://swapi.co/api/films', format: :json)
    @films = data["results"]
  end
end
