class SpeicesGroupsController < ApplicationController
  def index
    @speices_group = SpeicesGroup.find_by(speices_number: 407)
  end
end
