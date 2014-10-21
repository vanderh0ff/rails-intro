class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie::ALLRATINGS
    session[:sortby] = params[:sortby] if params[:sortby] != nil
    @sortby = session[:sortby]
    @filter = []
    if (params[:ratings])
      params[:ratings].each_key { |key|
        @filter.push(key)
      }
      @movies = Movie.find(:all,:order=>@sortby,:conditions=>{:rating=>@filter})
      session[:ratings] = Hash[@filter.zip(@filter)]
    else
      if (session[:ratings])
        flash.keep
        redirect_to movies_path(:sort=>session[:sortby],:ratings=>session[:ratings])
      end
      @movies = Movie.all(:order=>@sortby)
    end
  end
  
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
