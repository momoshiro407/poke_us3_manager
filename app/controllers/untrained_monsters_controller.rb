class UntrainedMonstersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :correct_user_untrained_monster, only: [:show, :destroy]

  def new
    @untrained_monster = UntrainedMonster.new
  end

  def create
    species_group = SpeciesGroup.find(params[:species_group_id])
    @untrained_monster = species_group.untrained_monsters.build(untrained_monster_params)
    @untrained_monster.nickname = species_group.species_name if @untrained_monster.nickname.blank?
    if @untrained_monster.save
      log_in @untrained_monster.species_group.user
      flash[:success] = '育成予定ポケモンを作成しました'
      redirect_to species_group_untrained_monster_path(species_group.id)
    else
      flash[:danger]
      render 'new'
    end
  end

  def edit
    @untrained_monster = UntrainedMonster.find(params[:id])
  end

  def update
    @untrained_monster = UntrainedMonster.find(params[:id])
    @untrained_monster.assign_attributes(untrained_monster_params)
    species_group = @untrained_monster.species_group
    @untrained_monster.nickname = species_group.species_name if @untrained_monster.nickname.blank?
    if @untrained_monster.save
      flash[:success] = '育成データを更新しました'
      redirect_to species_group_untrained_monster_path(species_group.id)
    else
      flash[:danger]
      render 'edit'
    end
  end

  def show
    @untrained_monster = UntrainedMonster.find(params[:id])
  end

  def destroy
    @untrained_monster = UntrainedMonster.find(params[:id])
    @untrained_monster.destroy
    flash[:success] = 'データを削除しました'
    redirect_to request.referrer
  end

  private

  def untrained_monster_params
    params.require(:untrained_monster).permit(:nickname, :gender, :level, :ability, :nature, :characteristic,
                                    :type1, :type2, :move1, :move2, :move3, :move4, :held_item, :combat_rules,
                                    :is_colored, :hp_statistics, :attack_statistics, :defense_statistics,
                                    :sp_attack_statistics, :sp_defense_statistics, :speed_statistics,
                                    :hp_individual, :attack_individual, :defense_individual, :sp_attack_individual,
                                    :sp_defense_individual, :speed_individual, :hp_effort, :attack_effort,
                                    :defense_effort, :sp_attack_effort, :sp_defense_effort, :speed_effort, :memo
    )
  end

  def correct_user_untrained_monster
    untrained_monster = UntrainedMonster.find(params[:id])
    redirect_to(root_url) unless current_user?(untrained_monster.species_group.user)
  end

end
