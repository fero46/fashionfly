class RedirectorController < ApplicationController

  def appentwickler
    redirect_to 'www.appentwickler-finden.de/'
  end

  def programmierer
    redirect_to 'www.programmierer-hamburg.com/'
  end

  def internetagentur
    redirect_to 'www.hansehype.de/'
  end
end
