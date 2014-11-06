germany = Scope.where(country_code: 'DE', locale:'de').first_or_create
Scope.where(country_code: 'US', locale:'en-us').first_or_create
Scope.where(country_code: 'GB', locale:'en').first_or_create
Configuration.where(key: 'default_country_code', value: 'de').first_or_create

colors =["e7db9c", "ffff02", "7cfe6f", "ffdfef", "ffdfef", 
         "2ed0cd", "b9531c", "f4cb62", "c61cd0", "ff0000",
         "ffffff", "2c2bd1", "d4d4d4", "ffc702", "000000",
         "019e13", "c5e1fd", "ff59ae", "77858f"]

for color in colors
  Colorization.where(name: "##{color}").first_or_create
end

delete_all_categories = false

if delete_all_categories 
  Category.where(scope_id: germany.id).destroy_all
end

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

#create_categories germany,german_categories

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
