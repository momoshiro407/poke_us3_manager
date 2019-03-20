class TotalEffortValuesValidator < ActiveModel::Validator
  def validate(record)
    # 努力値の合計が510以下であることをチェック
    total = (record.hp_effort || 0) + (record.attack_effort || 0) + (record.defense_effort || 0) +
        (record.sp_attack_effort || 0) + (record.sp_defense_effort || 0) + (record.speed_effort || 0)
    record.errors[:hp_effort] << "努力値は合計#{Constants::TOTAL_EFFORT_LIMIT}以下になるように設定してください！" if total > Constants::TOTAL_EFFORT_LIMIT
  end
end