require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) {("A".."Z").to_a.sample}
  end

  def score
    @answer = params[:answer]
    @english = english_word?(@answer)
    @valid_word = valid?(@answer)
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def valid?(word)
    attepted_word = word.upcase.chars
    @rangeletters = params[:letters]
    attepted_word.each do |letter|
      if @rangeletters.include?(letter)
         @rangeletters.delete(letter)
      else
        return false
      end
    end
  end
end
