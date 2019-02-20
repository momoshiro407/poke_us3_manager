module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Poke US3 Manager'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def get_enum_array(recode)
    pluralized = recode.to_s.pluralize
    base = Code.send(pluralized)
    enum_key = Code.send("#{pluralized}_i18n")
    base.keys.map { |k| [enum_key[k], base[k]]}
  end

  def get_enum_key_by_number(recode, number)
    return if number.nil?
    i18n_enums = get_enum_array(recode)
    i18n_enums.each_with_index do |i18n_enum, index|
      return i18n_enum[0] if index == number
    end
  end

  def get_enum_value_by_number(recode, number)
    return if number.nil?
    i18n_enums = get_enum_array(recode)
    i18n_enums.each_with_index do |i18n_enum, index|
      return i18n_enum[1] if index == number
    end
  end

  def get_all_abilities_of_species(species_id)
    base_statuses_abilities = BaseStatusAbility.joins(base_status: :species).where("species.id = ?", species_id)
    abilities = []
    base_statuses_abilities.each do |base_statuses_ability|
      ability = Ability.find(base_statuses_ability.ability_id)
      abilities << [ability.ability_name, ability.id]
    end
    return abilities
  end
end
