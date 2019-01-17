# User.create!(name: 'Example User', email: 'example@gmail.com', password: 'testpass', password_confirmation: 'testpass')
#
# 99.times do |n|
#   name = Faker::Name.name
#   email = "example-#{n + 1}@gmail.com"
#   password = 'password'
#   User.create!(name: name, email: email, password: password, password_confirmation: password)
# end


# json形式の種族データをDBに投入する
json = ActiveSupport::JSON.decode(File.read(Rails.root.join('db', 'json', 'pokemon_data.json')))
species_before_exec = Species.all.size
form_changes_before_exec = FormChange.all.size
ActiveRecord::Base.transaction do
  json.each_with_index do |data, index|
    begin
      base_species = Species.find_by(number: data['no'])
      if base_species.present?
        base_species.update(is_form_change: true) unless base_species.is_form_change == true
        form = data['isMegaEvolution'] == true ? data['name'] : data['form']
        FormChange.create(species_id: base_species.id, number: data['no'], name: base_species.name, is_mega_evolution: data['isMegaEvolution'] == true,
                          form: form, type1: data['types'][0], type2: data['types'][1],
                          ability1: data['abilities'][0], ability2: data['abilities'][1], ability3: data['hiddenAbilities'][0],
                          hit_point: data['stats']['hp'], attack: data['stats']['attack'], defense: data['stats']['defence'],
                          special_attack: data['stats']['spAttack'], special_defense: data['stats']['spDefence'], speed: data['stats']['speed'])
      else
        form = data['form'].blank? ? nil : data['form']
        Species.create(number: data['no'], name: data['name'], is_form_change: form.present?, form: form, type1: data['types'][0], type2: data['types'][1],
                       ability1: data['abilities'][0], ability2: data['abilities'][1], ability3: data['hiddenAbilities'][0],
                       hit_point: data['stats']['hp'], attack: data['stats']['attack'], defense: data['stats']['defence'],
                       special_attack: data['stats']['spAttack'], special_defense: data['stats']['spDefence'], speed: data['stats']['speed'])
      end
      p "#{index + 1}件目" if (index + 1) % 100 == 0
    rescue
      p "---- #{index + 1}件目でエラー発生！ ----"
      p data
      raise
    end
  end
end
p "#{Species.all.size + FormChange.all.size - species_before_exec - form_changes_before_exec}件のデータを登録しました。"

