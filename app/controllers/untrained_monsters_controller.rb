class UntrainedMonstersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new

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

end
