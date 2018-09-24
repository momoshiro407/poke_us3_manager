class SpeciesGroupsController < ApplicationController
  def index
    @species_group = SpeciesGroup.find_by(species_number: 407)
  end
end
