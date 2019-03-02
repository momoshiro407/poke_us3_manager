class UntrainedMonstersController < ApplicationController
  include StatusCalculater

  before_action :logged_in_user, only: [:new, :create]
  before_action :correct_user_untrained_monster, only: [:show, :destroy]

  def new
    @untrained_monster = UntrainedMonster.new
    @species = Species.find_by(number: SpeciesGroup.find(params[:species_group_id]).species_number)
    base_status = BaseStatus.find_by(species_id: @species.id)
    base_status_abilities = BaseStatusAbility.where(base_status_id: base_status.id)
    @abilities = get_abilities(base_status_abilities)
  end

  def create
    species_group = SpeciesGroup.find(params[:species_group_id])
    create_params = untrained_monster_params
    create_params['base_status_id'] ||= BaseStatus.find_by(species_id: Species.find_by(number: species_group.species_number).id).id
    @untrained_monster = species_group.untrained_monsters.build(create_params)
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
    @species = Species.find_by(number: @untrained_monster.species_group.species_number)
    base_status_abilities = BaseStatusAbility.where(base_status_id: @untrained_monster.base_status_id)
    @abilities = get_abilities(base_status_abilities)
  end

  def update
    @untrained_monster = UntrainedMonster.find(params[:id])
    update_params = untrained_monster_params
    update_params['base_status_id'] ||= @untrained_monster.base_status_id
    if @untrained_monster.update_attributes(update_params)
      flash[:success] = '育成データを更新しました'
      redirect_to species_group_untrained_monster_path(@untrained_monster.species_group.id)
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

  def change_abilities_select_untrained
    base_status_abilities = BaseStatusAbility.where(base_status_id: params[:base_status_id])
    @abilities = get_abilities(base_status_abilities)
  end

  def set_calculated_status_untrained
    @statuses = status_calculate(params)
  end

  private

  def untrained_monster_params
    params.require(:untrained_monster).permit(:nickname, :gender, :level, :ability_id, :nature_id, :characteristic_id,
                                    :type1, :type2, :move1, :move2, :move3, :move4, :held_item, :combat_rule,
                                    :is_colored, :hp_statistics, :attack_statistics, :defense_statistics,
                                    :sp_attack_statistics, :sp_defense_statistics, :speed_statistics,
                                    :hp_individual, :attack_individual, :defense_individual, :sp_attack_individual,
                                    :sp_defense_individual, :speed_individual, :hp_effort, :attack_effort,
                                    :defense_effort, :sp_attack_effort, :sp_defense_effort, :speed_effort, :memo, :base_status_id
    )
  end

  def correct_user_untrained_monster
    untrained_monster = UntrainedMonster.find(params[:id])
    redirect_to(root_url) unless current_user?(untrained_monster.species_group.user)
  end

  def get_abilities(base_status_abilities)
    abilities = []
    base_status_abilities.each do |base_status_ability|
      abilities << Ability.find(base_status_ability.ability_id)
    end
    return abilities
  end

end
