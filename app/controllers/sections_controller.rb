class SectionsController < ApplicationController

  def index
    @sections = Section.includes(:teacher, :classroom).all
  end

  # TODO: implement rest of the CRUD if needed
end
