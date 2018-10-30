class MonstersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  before_action :correct_user_monster, only: [:show]

  def new
    @monster = Monster.new
  end

  def create
    species_group = SpeciesGroup.find(params[:species_group_id])
    @monster = species_group.monsters.build(monster_params)
    if @monster.save
      log_in @monster.species_group.user
      flash[:success] = '育成済みポケモンを作成しました'
      redirect_to @monster.species_group
    else
      flash[:danger]
      render 'new'
    end
  end

  def edit
    @monster = Monster.find(params[:id])
  end

  def update
    @monster = Monster.find(params[:id])
    if @monster.update_attributes(monster_params)
      flash[:success] = '育成データを更新しました'
      redirect_to @monster.species_group
    else
      flash[:danger]
      render 'edit'
    end
  end

  def show
    @monster = Monster.find(params[:id])
  end

  private

  def monster_params
    params.require(:monster).permit(:nickname, :gender, :level, :ability, :nature, :characteristic,
                                    :type1, :type2, :move1, :move2, :move3, :move4, :held_item, :combat_rules,
                                    :is_colored, :hp_statistics, :attack_statistics, :defense_statistics,
                                    :sp_attack_statistics, :sp_defense_statistics, :speed_statistics,
                                    :hp_individual, :attack_individual, :defense_individual, :sp_attack_individual,
                                    :sp_defense_individual, :speed_individual, :hp_effort, :attack_effort,
                                    :defense_effort, :sp_attack_effort, :sp_defense_effort, :speed_effort, :memo
    )
  end

  def correct_user_monster
    monster = Monster.find(params[:id])
    redirect_to(root_url) unless current_user?(monster.species_group.user)
  end

end
