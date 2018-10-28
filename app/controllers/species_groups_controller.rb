class SpeciesGroupsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user_species_group, only: [:show]

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

  def show
    @species_group = SpeciesGroup.find(params[:id])
    results = Monster.with_species_group(params[:id])
    results = params[:nickname].present? ? results.search_nickname(params[:nickname]) : results
    results = params[:gender].present? ? results.search_gender(params[:gender]) : results
    results = params[:avility].present? ? results.search_avility(params[:avility]) : results
    results = params[:nature].present? ? results.search_nature(params[:nature]) : results
    moves = set_move_array(params)
    moves.each do |move|
      results = move.present? ? results.search_move(move) : results
    end
    @monsters = results.includes(:species_group).paginate(page: params[:page])
  end

  def search
    @species_group = SpeciesGroup.find(params[:id])
    monsters = @species_group.monsters
    @q = monsters.search(search_params)
    @monsters = @q.result(distinct: true)
  end

  private

  def species_group_params
    params.require(:species_group).permit(:species_number, :species_name)
  end

  def correct_user_species_group
    species_group = SpeciesGroup.find(params[:id])
    redirect_to(root_url) unless current_user?(species_group.user)
  end

  def search_params
    params.require(:monsters).permit(:nickname, :gender, :avility, :nature, :move1, :move2, :move3, :move4)
  end

  def set_move_array(params)
    moves = []
    moves << params[:move1]
    moves << params[:move2]
    moves << params[:move3]
    moves << params[:move4]
  end

end
