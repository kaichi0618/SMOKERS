class GenresController < ApplicationController
  def index
    @genre_coffee = Genre.find_by(genre_name:"喫茶店")
    @genre_cafe = Genre.find_by(genre_name:"カフェ")
    @genre_bar = Genre.find_by(genre_name:"バー")
    @genre_izakaya = Genre.find_by(genre_name:"居酒屋")
    @genre_coffees = @genre_coffee.shops
    @genre_cafes = @genre_cafe.shops
    @genre_bars = @genre_bar.shops
    @genre_izakayas = @genre_izakaya.shops
  end

  def show
    @genre = Genre.find(params[:id])
    @genres = @genre.shops
  end
end
