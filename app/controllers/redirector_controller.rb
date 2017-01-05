class RedirectorController < ApplicationController

  def appentwickler
    redirect_to 'http://www.appentwickler-finden.de/'
    return
  end

  def programmierer
    redirect_to 'http://www.programmierer-hamburg.com/'
    return
  end

  def internetagentur
    redirect_to 'http://www.hansehype.de/'
    return
  end
end
