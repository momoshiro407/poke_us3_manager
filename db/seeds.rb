require "net/http"
require "uri"

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



## json形式の性格データをDBに投入する ###
Nature.transaction do
  (1..25).each do |index|
    uri = URI.parse("https://pokeapi.co/api/v2/nature/#{index}")
    json = Net::HTTP.get(uri)
    data = JSON.parse(json)

    corrected_statuses = []
    [data['increased_stat'], data['decreased_stat']].each_with_index do |stat, index|
      if stat.nil?
        corrected_statuses[index] = 0
      else
        case stat['name']
        when 'attack'
          corrected_statuses[index] = 1
        when 'defense'
          corrected_statuses[index] = 2
        when 'special-attack'
          corrected_statuses[index] = 3
        when 'special-defense'
          corrected_statuses[index] = 4
        when 'speed'
          corrected_statuses[index] = 5
        end
      end
    end

    Nature.create(id: index, name: data['names'][0]['name'], up_status: corrected_statuses[0], down_status: corrected_statuses[1])
  end
end
p "#{Nature.all.size}種類の性格データを登録しました。"



### json形式の個性データをDBに投入する ###
json = ActiveSupport::JSON.decode(File.read(Rails.root.join('db', 'json', 'characteristic_data.json')))
Characteristic.transaction do
  json.each do |data|
    Characteristic.create(id: data['no'], name: data['name'])
  end
end
p "#{Characteristic.all.size}種類の個性データを登録しました。"



## json形式の持ち物データをDBに投入する ###
  # item_groupデータ投入
ItemGroup.create(id: 1, name: '一般') # API No.12
ItemGroup.create(id: 2, name: 'こだわり系') # API No.13
ItemGroup.create(id: 3, name: '自分に影響') # API No.15
ItemGroup.create(id: 4, name: '特定タイプに有効') # API No.19
ItemGroup.create(id: 5, name: '特定種族に有効') # API No.18
ItemGroup.create(id: 6, name: 'プレート') # API No.17
ItemGroup.create(id: 7, name: 'メモリ') # API No.45
ItemGroup.create(id: 8, name: 'きのみ（努力値降下）') # API No.2
ItemGroup.create(id: 9, name: 'きのみ（状態異常回復）') # API No.3
ItemGroup.create(id: 10, name: 'きのみ（HP・PP回復）') # API No.4
ItemGroup.create(id: 11, name: 'きのみ（相手にダメージ）') # API No.4
ItemGroup.create(id: 12, name: 'きのみ（能力上昇）') # API No.5
ItemGroup.create(id: 13, name: 'きのみ（HP回復または混乱）') # API No.6
ItemGroup.create(id: 14, name: 'きのみ（ダメージ半減）') # API No.7
ItemGroup.create(id: 15, name: 'きのみ（効果なし）') # API No.8
ItemGroup.create(id: 16, name: 'メガストーン') # API No.44
ItemGroup.create(id: 17, name: 'Zストーン') # API No.46
p "#{ItemGroup.all.size}種類の持ち物グループデータを登録しました。"



  # itemデータ投入&item_groupとの紐付け
item_categories_number = [12, 13, 15, 19, 18, 17, 45, 2, 3, 4, 4, 5, 6, 7, 8, 44, 46]
ActiveRecord::Base.transaction do
  item_categories_number.each_with_index do |item_category, i|
    next if i == 10 # 「きのみ（相手にダメージ）」は「きのみ（HP・PP回復）」のグループに入っているので読み込み時は飛ばす
    item_attribute_uri = URI.parse("https://pokeapi.co/api/v2/item-category/#{item_category}/")
    json = Net::HTTP.get(item_attribute_uri)
    item_attribute_data = JSON.parse(json)
    (0..item_attribute_data['items'].size - 1).each_with_index do |j|
      item_uri = URI.parse(item_attribute_data['items'][j]['url'])
      json = Net::HTTP.get(item_uri)
      item_data = JSON.parse(json)
      item_name = item_data['names'][1]['name']
      Item.create(name: item_name)
      ItemNameGroup.create(item_id: Item.last.id, item_group_id: ItemGroup.find(i + 1).id)
    end
    p "item-category#{item_category}終了"
  end
end
  # 一部の持ち物に紐付くitem_groupを変更
Item.find_by(name: 'ヒメリのみ').item_name_groups.update(item_group_id: 10)
Item.find_by(name: 'オレンのみ').item_name_groups.update(item_group_id: 10)
Item.find_by(name: 'オボンのみ').item_name_groups.update(item_group_id: 10)
Item.find_by(name: 'ジャポのみ').item_name_groups.update(item_group_id: 11)
Item.find_by(name: 'レンブのみ').item_name_groups.update(item_group_id: 11)
Item.find_by(name: 'アッキのみ').item_name_groups.update(item_group_id: 12)
Item.find_by(name: 'タラプのみ').item_name_groups.update(item_group_id: 12)
p "#{Item.all.size}種類の持ち物データを登録しました。"
