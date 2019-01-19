# User.create!(name: 'Example User', email: 'example@gmail.com', password: 'testpass', password_confirmation: 'testpass')
#
# 99.times do |n|
#   name = Faker::Name.name
#   email = "example-#{n + 1}@gmail.com"
#   password = 'password'
#   User.create!(name: name, email: email, password: password, password_confirmation: password)
# end


### タイプデータをDBに投入する ###
Type.create(id: 1, type_name: 'ノーマル')
Type.create(id: 2, type_name: 'ほのお')
Type.create(id: 3, type_name: 'みず')
Type.create(id: 4, type_name: 'でんき')
Type.create(id: 5, type_name: 'くさ')
Type.create(id: 6, type_name: 'こおり')
Type.create(id: 7, type_name: 'かくとう')
Type.create(id: 8, type_name: 'どく')
Type.create(id: 9, type_name: 'じめん')
Type.create(id: 10, type_name: 'ひこう')
Type.create(id: 11, type_name: 'エスパー')
Type.create(id: 12, type_name: 'むし')
Type.create(id: 13, type_name: 'いわ')
Type.create(id: 14, type_name: 'ゴースト')
Type.create(id: 15, type_name: 'ドラゴン')
Type.create(id: 16, type_name: 'あく')
Type.create(id: 17, type_name: 'はがね')
Type.create(id: 18, type_name: 'フェアリー')
p "#{Type.all.size}種類のタイプデータを登録しました。"



### json形式の特性データをDBに投入する ###
require "net/http"
require "uri"

Ability.transaction do
  (1..232).each do |index|
    uri = URI.parse("https://pokeapi.co/api/v2/ability/#{index}")
    json = Net::HTTP.get(uri)
    data = JSON.parse(json)
    Ability.create(id: index, ability_name: data['names'][1]['name'])
    p "#{index}件目" if (index) % 20 == 0
  end
  Ability.create(id: 233, ability_name: 'ブレインフォース') # 2019.1時点ではブレインフォースのデータがないようなので別途追加
end
p "#{Ability.all.size}種類の特性データを登録しました。"



### json形式の種族データをDBに投入する ###
json = ActiveSupport::JSON.decode(File.read(Rails.root.join('db', 'json', 'pokemon_data.json')))
base_statuses_before_exec = BaseStatus.all.size
ActiveRecord::Base.transaction do
  json.each_with_index do |data, index|
    begin
      # speciesとbase_statusの登録
      if Species.find_by(number: data['no']).nil?
        Species.create(number: data['no'], name: data['name'], is_mega_evolution: false, is_form_change: false)
      end
      master_species = Species.find_by(number: data['no'])
      master_species.update(is_mega_evolution: true) if data['isMegaEvolution'] && !master_species.is_mega_evolution
      master_species.update(is_form_change: true) if data['form'].present? && !master_species.is_form_change
      form_kind = 2 # FC後のフォルム
      form_kind = 0 if BaseStatus.find_by(species_id: master_species.id).nil? # FC不可能な種族 or FC可能な種族のベースのフォルム
      form_kind = 1 if data['isMegaEvolution'] # メガシンカ

      case form_kind
      when 0
        form_name = data['form'].blank? ? nil : data['form']
      when 1
        form_name = data['name']
      when 2
        form_name = data['form']
      end

      BaseStatus.create(species_id: master_species.id, form_kind: form_kind, form_name: form_name,
                        hit_point: data['stats']['hp'], attack: data['stats']['attack'], defense: data['stats']['defence'],
                        special_attack: data['stats']['spAttack'], special_defense: data['stats']['spDefence'], speed: data['stats']['speed'])

      # typeとabilityの登録（base_statusとの紐付け）
      data['types'].each do |type|
        BaseStatusType.create(base_status_id: BaseStatus.last.id, type_id: Type.find_by(type_name: type).id)
      end
      # abilitisを登録してからの処理
      data['abilities'].each do |ability|
        BaseStatusAbility.create(base_status_id: BaseStatus.last.id, ability_id: Ability.find_by(ability_name: ability).id)
      end
      BaseStatusAbility.create(base_status_id: BaseStatus.last.id, ability_id: Ability.find_by(ability_name: data['hiddenAbilities']).id) unless data['hiddenAbilities'].blank?

      p "#{index + 1}件目" if (index + 1) % 100 == 0
    rescue
      p "---- #{index + 1}件目でエラー発生！ ----"
      p data
      raise
    end
  end
end
p "#{BaseStatus.all.size - base_statuses_before_exec}件の種族データを登録しました。"

