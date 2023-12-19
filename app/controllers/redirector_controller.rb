# frozen_string_literal: true

class RedirectorController < ApplicationController
  def appentwickler
    redirect_to 'http://www.appentwickler-finden.de/'
    nil
  end

  def programmierer
    redirect_to 'http://www.programmierer-hamburg.com/'
    nil
  end

  def internetagentur
    redirect_to 'http://www.hansehype.de/'
    nil
  end
end
