module StatusCalculater
  extend ActiveSupport::Concern

  # include do
  #   logger.info('ステータス計算中...')
  # end

  def status_calculate(cal_params)
    # input_valueに数値以外が入っている場合は例外を発生させて計算処理を無効にする
    cal_params = adjustment_values(cal_params)
    lv = cal_params[:level]
    na = cal_params[:nature_id]
    begin
      bs = set_base_status(cal_params[:base_status_id])
      statuses = []
      cal_params[:individuals].each_with_index do |ind, i|
        ef = cal_params[:efforts][i]
        if i == 0
          # HPのステータス計算 {(種族値×2＋個体値＋努力値/4)×Lv/100}＋10＋Lv
          status = ((bs[i] * 2 + ind + (ef / 4).to_i) * lv / 100).to_i + 10 + lv
        else
          # HP以外のステータス計算 [{(種族値×2＋個体値＋努力値/4)×Lv/100}＋5]×性格補正
          status = ((((bs[i] * 2 + ind + (ef / 4).to_i) * lv / 100).to_i + 5) * correction(na, i)).to_i
        end
        statuses.push(status)
      end
      return statuses
    rescue => e
      # 例外発生時の処理
      p e
    end
  end

  def set_base_status(base_status_id)
    base_status = BaseStatus.find(base_status_id)
    base_statuses = []
    base_statuses.push(base_status.hit_point)
    base_statuses.push(base_status.attack)
    base_statuses.push(base_status.defense)
    base_statuses.push(base_status.special_attack)
    base_statuses.push(base_status.special_defense)
    base_statuses.push(base_status.speed)
  end

  def correction(na, i)
    up_status = Nature.find(na).up_status
    down_status = Nature.find(na).down_status
    if i == up_status
      return 1.1
    elsif i == down_status
      return 0.9
    else
      return 1
    end
  end

  def adjustment_values(cal_params)
    cal_params[:base_status_id] = cal_params[:base_status_id].to_i
    cal_params[:individuals].map! {|ind| ind.to_i}
    cal_params[:efforts].map! {|ef| ef.blank? ? 0 : ef.to_i}
    cal_params[:level] = cal_params[:level].to_i
    cal_params[:nature_id] = cal_params[:nature_id].to_i
    return cal_params
  end

end