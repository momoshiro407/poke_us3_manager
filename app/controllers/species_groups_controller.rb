class SpeciesGroupsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @species_group = SpeciesGroup.new
  end

  def create
    @species_group = current_user.species_groups.build(species_group_params)
    # 入力されたspecies_numberと一致するspeciesモデルのnumberを検索し、対応するnameをspecies_nameへ格納
    @species_group.species_name = Species.find_by(number: params[:species_group][:species_number]).name
    if @species_group.save
      log_in @species_group.user
      flash[:success] = '新規種族グループを作成しました'
      redirect_to @species_group.user
    else
      flash[:danger]
      render 'new'
    end
  end

  def index
    @species_group = SpeciesGroup.find_by(species_number: 407)
  end

  private

  def species_group_params
    params.require(:species_group).permit(:species_number, :species_name)
  end
end
