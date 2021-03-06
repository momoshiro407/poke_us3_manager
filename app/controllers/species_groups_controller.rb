class SpeciesGroupsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @species_group = SpeciesGroup.new
  end

  def create
    @species_group = current_user.species_groups.build(species_group_params)
    if @species_group.save
      log_in @species_group.user
      flash[:success] = '新規種族グループを作成しました'
      redirect_to @species_group.user
    else
      flash[:danger]
      render 'new'
    end
  end

  def trained_area
    correct_user_species_group
    @species_group = SpeciesGroup.find(params[:species_group_id])
    results = Monster.with_species_group(params[:species_group_id])
    results = params[:nickname].present? ? results.search_nickname(params[:nickname]) : results
    results = params[:gender].present? ? results.search_gender(params[:gender]) : results
    results = params[:ability_id].present? ? results.search_ability(params[:ability_id]) : results
    results = params[:nature_id].present? ? results.search_nature(params[:nature_id]) : results
    moves = set_move_array(params)
    moves.each do |move|
      results = move.present? ? results.search_move(move) : results
    end
    @monsters = results.includes(:species_group).paginate(page: params[:page])
  end

  def untrained_area
    correct_user_species_group
    @species_group = SpeciesGroup.find(params[:species_group_id])
    results = UntrainedMonster.with_species_group(params[:species_group_id])
    results = params[:nickname].present? ? results.search_nickname(params[:nickname]) : results
    results = params[:gender].present? ? results.search_gender(params[:gender]) : results
    results = params[:ability_id].present? ? results.search_ability(params[:ability_id]) : results
    results = params[:nature_id].present? ? results.search_nature(params[:nature_id]) : results
    moves = set_move_array(params)
    moves.each do |move|
      results = move.present? ? results.search_move(move) : results
    end
    @untrained_monsters = results.includes(:species_group).paginate(page: params[:page])
    # TODO: monsterの検索処理と丸かぶりなので後で1つにまとめる
  end

  def search
    @species_group = SpeciesGroup.find(params[:id])
    monsters = @species_group.monsters
    @q = monsters.search(search_params)
    @monsters = @q.result(distinct: true)
  end

  def monsters_transfer
    if params[:transfers].nil?
      flash[:danger] = '転送するデータにチェックを付けてください'
      redirect_to species_group_untrained_monster_url
    else
      ActiveRecord::Base.transaction do
        params[:transfers].keys.each do |transfer_id|
          untrained_monster_params = UntrainedMonster.find(transfer_id).attributes
          untrained_monster_params.delete('id')
          untrained_monster_params.delete('created_at')
          untrained_monster_params.delete('updated_at')
          monster = Monster.new(untrained_monster_params)
          if monster.save!
            UntrainedMonster.find(transfer_id).destroy!
          else
            flash[:danger] = 'エラーが発生しました'
            redirect_to species_group_untrained_monster_url
          end
        end
        flash[:success] = '育成済みページへ転送しました'
        redirect_to species_group_untrained_monster_url
      end
    end
  end

  private

  def species_group_params
    params.require(:species_group).permit(:species_id)
  end

  def correct_user_species_group
    species_group = SpeciesGroup.find(params[:species_group_id])
    redirect_to(root_url) unless current_user?(species_group.user)
  end

  def search_params
    params.require(:monsters).permit(:nickname, :gender, :ability_id, :nature_id, :move1, :move2, :move3, :move4)
  end

  def set_move_array(params)
    moves = []
    moves << params[:move1]
    moves << params[:move2]
    moves << params[:move3]
    moves << params[:move4]
  end

end
