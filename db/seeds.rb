# encoding: UTF-8
germany = Scope.where(country_code: 'DE', locale:'de').first_or_create
usa =Scope.where(country_code: 'US', locale:'en').first_or_create
brittish = Scope.where(country_code: 'GB', locale:'gb-en').first_or_create
canadian = Scope.where(country_code: 'CA', locale:'ca-en').first_or_create
australien = Scope.where(country_code: 'AU', locale:'au-en').first_or_create
turkey = Scope.where(country_code: 'TR', locale:'tr').first_or_create


Configuration.where(key: 'default_country_code', value: 'de').first_or_create

colors =["e7db9c", "ffff02", "7cfe6f", "ffdfef", "ffdfef", 
         "2ed0cd", "b9531c", "f4cb62", "c61cd0", "ff0000",
         "ffffff", "2c2bd1", "d4d4d4", "ffc702", "000000",
         "019e13", "c5e1fd", "ff59ae", "77858f"]

for color in colors
  Colorization.where(name: "##{color}").first_or_create
end

delete_all_categories = true

if delete_all_categories 
  Category.destroy_all
  FashionFlyEditor::Category.destroy_all
end

german_outfits = [
  {
    name: 'Damenoutfits',
    categories: ['Abendmode', 'Business', 'Club & Party', 'Freizeit', 'Sport']
  },
  {
    name: 'Herrenoutfits',
    categories: ['Club & Party','Business', 'Freizeit', 'Sport']
  }  
]

english_outfits = [
  {
    name: "Women's outfits",
    categories: ['Evening', 'Business', 'Club & Party', 'Casual', 'Sport']
  },
  {
    name: "Men's outfits",
    categories: ['Business', 'Club & Party', 'Casual', 'Sport']
  }  
]

turkish_outfits = [
  {
    name: "Kadın kıyafetler",
    categories: ['Akşam', 'İş', 'Club & Parti', 'Günlük', 'Spor']
  },
  {
    name: "Erkek kıyafetler",
    categories: ['İş', 'Club & Parti', 'Günlük', 'Spor']
  }  
]

turkish_categories = [
  {
    name: 'Kadın',
    categories:[
      {
        name: 'Elbiseler',
        categories: ['Mini', 'Uzun', 'Gündüz', 'Gece']
      },
      {
        name: 'Tişörtler ve üstler',
        categories: ['Tişörtler ', 'Gömlek', 'Spor', 'Kazaklar', 'Hırkalar']
      },
      {
        name: 'Pantolonlar',
        categories: ['Dar', 'Düz', 'Şalvar ', 'Streç', 'Sport', 'Jeans', 'Slim', 'Denim tayt']
      },
      {
        name: 'Etekler',
        categories: ['Mini', 'Midi', 'Maksi']
      },
      {
        name: 'Manto ve Ceketler',
        categories: ['Deri', 'Blazer', 'Montlar', 'Şik', 'Bolerolar', 'Jile', 'Spor']
      },
      {
        name: 'Ayakkabı',
        categories: ['Bot', 'Spor Ayakkabı', 'Çizme', 'Topuklu Ayakkabı', 'Babet/Düz Ayakkabı', 'Sneakers', 'Terlik/Sandalet', 'Günlük', 'Ev', 'Comfort', 'Outdoor']
      },
      {
        name: 'Çanta',
        categories: ['Günlük', 'Omuz Çanta', 'Sirt Çanta', 'Abiye Çanta', 'Spor Çanta', 'Seyahat Çanta', 'Makyaj Çanta']
      },
      {
        name: 'Aksesuar',
        categories: ['Cüzdan', 'Cüzdan', 'Şal', 'Şapka', 'Kemer', 'Elviden', 'Güneş Gözlüğü', 'Diğerleri']
      },
      {
        name: 'Takı',
        categories: ['Kolye', 'Bileklik', 'Küpe', 'Yüzük', 'Saç Aksesuarı', 'Kulak Aksesuarı', 'Halhal']
      },
      {
        name: 'Güzellik',
        categories: ['Ruj', 'Göz Makyajı', 'Makyajı', 'Oje', 'Parfüm', 'Vücut Bakımı', 'Saç Bakımı', 'Yüz Bakımı', 'Güneş Bakımı']
      },
      {
        name: 'Mayo',
        categories: ['Bikini', 'Bikini Üstleri', 'Bikini Altları', 'Mayolar']
      }
    ]
  },
  {
    name: 'Men',
    categories:[
      {
        name: 'Tişörtler ve üstler',
        categories: ['Tişörtler','Pololsr', 'Gömlek', 'Kazaklar', 'Hırkalar']
      },
      {
        name: 'Pantolonlar',
        categories: ['Jeans', 'Bermuda', 'Pantolon', 'Spor']
      },
      {
        name: 'Manto ve Ceketler',
        categories: ['Jackets', 'Montlar', 'Deri', 'Blazer']
      },
      {
        name: 'Takım',
        categories: ['Takım Ceketler', 'Takım Pantolonlar', 'Takım Yelekler', 'Takım Kombin']        
      },
      {
        name: 'Spor giyim',
        categories: ['Üst', 'Alt', 'Koşu Pantolon', 'Spor Şort']        
      },
      {
        name: 'Ayakkabı',
        categories: ['Bot', 'Spor Ayakkabı', 'Günlük', 'Klasik', 'Outdoor', 'Klasik Ayakkabı', 'Terlik/Sandalet', 'Loafer', 'Ev']
      },
      {
        name: 'Çanta',
        categories: ['Omuz', 'Evrak', 'Bel', 'Sırt']
      },
      {
        name: 'Aksesuar',
        categories: ['Cüzdan', 'Kemer','Şal', 'Şapka', 'Bere', 'Atkı', 'Elviden', 'Matara', 'Güneş Gözlüğü', 'Diğerleri']
      },
      {
        name: 'Takı',
        categories: ['Saat', 'Bilezikler', 'Zincirler', 'Yüzük']
      },
      {
        name: 'Güzellik',
        categories: ['Parfüm', 'Saç Bakımı', 'Yüz Bakımı', 'Güneş Bakımı']
      },
      {
        name: 'Mayolar',
        categories: ['Mayo', 'Şort']
      }
    ]
  }
]


english_categories = [
  {
    name: 'Women',
    categories:[
      {
        name: 'Dresses',
        categories: ['Causal Dresses', 'Evening Growns', 'Strapless Dresses', 'Cocktail Dresses', 'Maxi Dresses', 'Shift Dresses', 'Party Dresses', 'Knitted Dresses']
      },
      {
        name: 'Tops & Shirts',
        categories: ['Tops', 'T-Shirts', 'Blouses & Shirts', 'Jumpers', 'Cardigans', 'Vests', 'Longsleeves', 'Hoodies', 'Tunics']
      },
      {
        name: 'Bottoms',
        categories: ['Jeans', 'Chino Pants', 'Trousers', 'Capri Pants', 'Shorts', 'Leggings', 'Overalls']
      },
      {
        name: 'Skirts',
        categories: ['Mini Skirts', 'Midi Skirts', 'Maxi Skirts']
      },
      {
        name: 'Coats & Jackets',
        categories: ['Jackets', 'Coats', 'Blazers']
      },
      {
        name: 'Shoes',
        categories: ['Ballerinas', 'Heels', 'Lace-Up Shoes', 'Sneakers', 'Boots', 'Sandals', 'Ankle Boots', 'Overknee Boots', 'Wedges']
      },
      {
        name: 'Bags',
        categories: ['Handbags', 'Crossbody Bags', 'Cases & Wallets', 'Backpacks', 'Clutches']
      },
      {
        name: 'Accessories',
        categories: ['Belts', 'Sunglasses', 'Scarves & Shawls', 'Hats & Caps', 'Gloves', 'Tights/Socks', 'Other Accessories']
      },
      {
        name: 'Jewellery',
        categories: ['Bracelets', 'Necklaces', 'Earrings', 'Rings', 'Watches', 'Pendants']
      },
      {
        name: 'Beauty',
        categories: ['Lipstick', 'Eye Make-Up', 'Make-Up', 'Nail Polish', 'Fragrance', 'Body Care', 'Hair Care', 'Face Care', 'Sun Care']
      },
      {
        name: 'Swimwear',
        categories: ['Bikinis', 'Bikini-Tops', 'Bikini Bottoms', 'Swimsuits']
      }
    ]
  },
  {
    name: 'Men',
    categories:[
      {
        name: 'Tops & Shirts',
        categories: ['T-Shirts','Poloshirts', 'Shirts', 'Pullovers', 'Cardigans', 'Hoodies', 'Longsleeves']
      },
      {
        name: 'Bottoms',
        categories: ['Jeans', 'Pants', 'Shorts']
      },
      {
        name: 'Coats & Jackets',
        categories: ['Jackets', 'Coats']
      },
      {
        name: 'Suits',
        categories: ['Suit Jackes', 'Suit Pants', 'Suits Vests', 'Combinations']        
      },
      {
        name: 'Sportswear',
        categories: ['Upper Parts', 'Bottom Parts', 'Jogging Pants', 'Sportshorts']        
      },
      {
        name: 'Shoes',
        categories: ['Sneaker', 'Boots', 'Lace-Up Shoes', 'Mokassins & Slippers', 'Open Toe Shoes']
      },
      {
        name: 'Bags',
        categories: ['Crossbody Bags', 'Briefcases', 'Backpacks']
      },
      {
        name: 'Accessories',
        categories: ['Belts', 'Scarves & Shawls', 'Hats & Caps', 'Gloves', 'Ties', 'Cases & Wallets', 'Sunglasses']
      },
      {
        name: 'Jewellery',
        categories: ['Watches', 'Bracelets', 'Chains', 'Rings']
      },
      {
        name: 'Beauty',
        categories: ['Fragrance', 'Hair Care', 'Face Care', 'Body Care']
      },
      {
        name: 'Swimwear',
        categories: ['Trunks', 'Boardshorts']
      }
    ]
  }
]
german_categories = [
  {
    name: 'Damenmode',
    categories:[
      {
        name: 'Kleider',
        categories: ['Causal Kleider', 'Abendkleider', 'Bustierkleider', 'Etuikleider', 'Maxikleider', 'Minikleider', 'Partykleider', 'Strickkleider']
      },
      {
        name: 'Oberteile',
        categories: ['Tops', 'T-Shirts', 'Blusen', 'Pullover', 'Cardigans', 'Westen', 'Longsleeves', 'Kapuzenpullover', 'Tuniken']
      },
      {
        name: 'Hosen',
        categories: ['Jeans', 'Chino Hosen', 'Stoffhosen', 'Caprihosen', 'Short & Bermdas', 'Leggins', 'Overalls']
      },
      {
        name: 'Röcke',
        categories: ['Kurze Röcke', 'Mittellange Röcke', 'Lange Röcke']
      },
      {
        name: 'Jacke & Mäntel',
        categories: ['Jacken', 'Mäntel', 'Blazer']
      },
      {
        name: 'Schuhe',
        categories: ['Ballerinas', 'Pumps', 'Schnürschuhe', 'Sneaker', 'Stiefel', 'Sandalen', 'Ankle Boots', 'Overknees', 'Stiefeletten']
      },
      {
        name: 'Taschen',
        categories: ['Handtaschen', 'Umhängetaschen', 'Etuis & Geldbörsen', 'Rucksäcke', 'Clutches']
      },
      {
        name: 'Accessoires',
        categories: ['Gürtel', 'Sonnenbrillen', 'Schals', 'Tücher', 'Hüte & Caps', 'Handschuhe', 'Strümpfe/Strumpfhosen', 'Sonstiges']
      },
      {
        name: 'Schmuchk',
        categories: ['Armschmuck', 'Haslketten', 'Ohrringe', 'Ringe', 'Uhren', 'Anhänger']
      },
      {
        name: 'Beauty',
        categories: ['Lippenstift', 'Augen Make-Up', 'Augen Make-Up', 'Nagellack', 'Parfüm', 'Körperpflege', 'Haarpflege', 'Gesichtspflege', 'Sonnenpflege']
      },
      {
        name: 'Bademode',
        categories: ['Bikinies', 'Bikini-Tops', 'Pants', 'Badeanzüge']
      }
    ]
  },
  {
    name: 'Herrenmode',
    categories:[
      {
        name: 'Oberteile',
        categories: ['Shirts','Poloshirts', 'Hemden', 'Pullover', 'Strickjacken', 'Kapuzenpullover', 'Langarmshirts']
      },
      {
        name: 'Hosen',
        categories: ['Jeans', 'Stoffhosen', 'Shorts']
      },
      {
        name: 'Jacken & Mäntel',
        categories: ['Jacken', 'Mäntel', 'Sakkos']
      },
      {
        name: 'Anzüge',
        categories: ['Anzugsakkos', 'Anzughose', 'Anzugwesten', 'Kombination']        
      },
      {
        name: 'Sportbekleidung',
        categories: ['Funktionsoberteile', 'Funktionshosen', 'Jogginghosen', 'Sporthosen']        
      },
      {
        name: 'Schuhe',
        categories: ['Sneaker', 'Boots', 'Schnürschuhe', 'Mokassins & Slipper', 'Offene Schuhe']
      },
      {
        name: 'Taschen',
        categories: ['Umhängetaschen', 'Aktentaschen', 'Rucksäcke']
      },
      {
        name: 'Accessoires',
        categories: ['Gürtel', 'Schals', 'Mützen & Caps', 'Handschuhe', 'Krawatten & Fliegen', 'Geldbörsen & Etuis', 'Sonnenbrillen']
      },
      {
        name: 'Schmuck',
        categories: ['Uhren', 'Armbänder', 'Ketten', 'Ringe']
      },
      {
        name: 'Beauty',
        categories: ['Parfürm', 'Harrpflege', 'Gesichtspflege', 'Körperpflege']
      },
      {
        name: 'Bademode',
        categories: ['Badehosen', 'Boardshorts']
      }
    ]
  }
]

def create_categories scope, categories, parent_id=nil
  for category in categories
    has_childrend = category.is_a?(Hash)
    if has_childrend
      parent = Category.create(scope_id: scope.id, name: category[:name] ,category_id: parent_id, main_taxon: parent_id == nil, leaf:false)
      create_categories scope,category[:categories], parent.id
    else
      Category.create(scope_id: scope.id, name: category,category_id: parent_id, main_taxon: false, leaf:true)
    end
  end
end

create_categories germany,german_categories
create_categories usa,english_categories
create_categories brittish,english_categories
create_categories canadian,english_categories
create_categories australien,english_categories
create_categories turkey, turkish_categories


def create_outfit_categories categories, parent
  parent_id = parent.id
  parent_type = parent.class.name
  for category in categories
    has_childrend = category.is_a?(Hash)
    if has_childrend
      name = category[:name]
    else
      name = category
    end
    parent = FashionFlyEditor::Category.create(name: name,
                                               parent_id: parent_id,
                                               parent_type: parent_type)
    create_outfit_categories(category[:categories], parent) if has_childrend
  end
end

create_outfit_categories german_outfits, germany
create_outfit_categories english_outfits, usa
create_outfit_categories english_outfits, brittish
create_outfit_categories english_outfits, canadian
create_outfit_categories english_outfits, australien
create_outfit_categories turkish_outfits, turkey


#### Icons
icons = Dir[Rails.root.join('db','icons').to_s+"/*"]

for icon in icons
  basename = File.basename(icon, ".png")
  id = basename.split('_')[0]
  basename = basename.gsub("#{id}_", '')
  myicon = Icon.where(id: id).first_or_initialize
  myicon.name = basename
  myicon.image = File.new(icon)
  myicon.save
end
