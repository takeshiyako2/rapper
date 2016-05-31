# encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'rhymer'

get '/' do
  erb :index
end

post '/' do
  lyric = params['lyric']

  # check lyric size
  if lyric.size > 1000
    @res = 'もうちょっと短いのでたのむ！'
  else

    # make rap
    res = ''
    res_no_br = ''
    rhymer = Rhymer::Parser.new(lyric)
    rhymer.rhymes.each do |rhyme|
      res = res + [rhyme[0], rhyme[1]].join(" ") + "<br />"
      res_no_br = res_no_br + [rhyme[0], rhyme[1]].join(" ")
    end

    # show rap
    if res.size == 0
      @res = 'ラップできなかったよ。'
    else
      @res = res
      @res_no_br = res_no_br[0..100] + ".."
    end
  end

  erb :index
end
