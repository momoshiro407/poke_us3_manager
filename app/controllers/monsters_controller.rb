class MonstersController < ApplicationController
  include StatusCalculater

  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  before_action :correct_user_monster, only: [:show, :destroy]

  def new
    @monster = Monster.new
    @species = Species.find_by(number: SpeciesGroup.find(params[:species_group_id]).species)
    base_status = BaseStatus.find_by(species_id: @species.id)
    base_status_abilities = BaseStatusAbility.where(base_status_id: base_status.id)
    @abilities = get_abilities(base_status_abilities)
    @item_groups = ItemGroup.all
  end

  def create
    # TODO: @species, @abilities, @item_groupsを再取得しないとnew再描画でエラーになるが、煩雑なので要リファクタリング
    species_group = SpeciesGroup.find(params[:species_group_id])
    create_params = monster_params
    create_params['base_status_id'] ||= BaseStatus.find_by(species_id: species_group.species.id).id
    @monster = species_group.monsters.build(create_params)
    @species = species_group.species
    base_status = BaseStatus.find_by(species_id: @species.id)
    base_status_abilities = BaseStatusAbility.where(base_status_id: base_status.id)
    @abilities = get_abilities(base_status_abilities)
    @item_groups = ItemGroup.all
    if @monster.save
      log_in @monster.species_group.user
      flash[:success] = '育成済みポケモンを作成しました'
      redirect_to species_group_monster_path(species_group.id)
    else
      flash[:danger]
      render 'new'
    end
  end

  def edit
    @monster = Monster.find(params[:id])
    @species = Species.find_by(number: @monster.species)
    base_status_abilities = BaseStatusAbility.where(base_status_id: @monster.base_status_id)
    @abilities = get_abilities(base_status_abilities)
    @item_groups = ItemGroup.all
  end

  def update
    # TODO: @species, @abilities, @item_groupsを再取得しないとedit再描画でエラーになるが、煩雑なので要リファクタリング
    @monster = Monster.find(params[:id])
    @species = Species.find_by(number: @monster.species)
    base_status_abilities = BaseStatusAbility.where(base_status_id: @monster.base_status_id)
    @abilities = get_abilities(base_status_abilities)
    @item_groups = ItemGroup.all
    if @monster.update_attributes(monster_params)
      flash[:success] = '育成データを更新しました'
      redirect_to species_group_monster_path(@monster.species_group.id)
    else
      flash[:danger]
      render 'edit'
    end
  end

  def show
    @monster = Monster.find(params[:id])
    @base_status = BaseStatus.find(@monster.base_status_id)
    @base_status_mega = BaseStatus.where(species_id: @base_status.species_id, form_kind: 1)
    @types =  @base_status.types.map {|type| type}
  end

  def destroy
    @monster = Monster.find(params[:id])
    @monster.destroy
    flash[:success] = 'データを削除しました'
    redirect_to request.referrer
  end

  def change_abilities_select
    base_status_abilities = BaseStatusAbility.where(base_status_id: params[:base_status_id])
    @abilities = get_abilities(base_status_abilities)
  end

  def set_calculated_status
    @statuses = status_calculate(params)
  end

  private

  def monster_params
    params.require(:monster).permit(:nickname, :gender, :level, :ability_id, :nature_id, :characteristic_id,
                                    :type1, :type2, :move1, :move2, :move3, :move4, :held_item_id, :combat_rule,
                                    :is_colored, :hp_statistics, :attack_statistics, :defense_statistics,
                                    :sp_attack_statistics, :sp_defense_statistics, :speed_statistics,
                                    :hp_individual, :attack_individual, :defense_individual, :sp_attack_individual,
                                    :sp_defense_individual, :speed_individual, :hp_effort, :attack_effort,
                                    :defense_effort, :sp_attack_effort, :sp_defense_effort, :speed_effort, :memo, :base_status_id
    )
  end

  def correct_user_monster
    monster = Monster.find(params[:id])
    redirect_to(root_url) unless current_user?(monster.species_group.user)
  end

  def get_abilities(base_status_abilities)
    abilities = []
    base_status_abilities.each do |base_status_ability|
      abilities << Ability.find(base_status_ability.ability_id)
    end
    return abilities
  end

end
