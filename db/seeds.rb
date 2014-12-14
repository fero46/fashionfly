germany = Scope.where(country_code: 'DE', locale:'de').first_or_create
usa =Scope.where(country_code: 'US', locale:'en').first_or_create
brittish = Scope.where(country_code: 'GB', locale:'gb-en').first_or_create
canadian = Scope.where(country_code: 'CA', locale:'ca-en').first_or_create
australien = Scope.where(country_code: 'AU', locale:'au-en').first_or_create
turkey = Scope.where(country_code: 'TR', locale:'TR').first_or_create


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
  Category.where(scope_id: germany.id).destroy_all
end


english_categories = [
  {
     name: 'Ladies Fashion',
     categories: [
       {
         name: 'clothes',
         categories: ['Causal clothes', 'Evening Dresses', 'Bustier Dress', 'Shift', 'Maxi Dresses', 'Mini Dress', 'Party Dresses', 'knitted dresses']
       },
       {
         name: 'Tops'
         categories: ['Tops', 'T-Shirts', 'Blouses', 'sweater', 'Cardigans', 'west', 'Longsleeves', 'Hoodie', 'tunics']
       },
       {
         name: 'pants'
         categories: ['jeans', 'chinos' 'pants' 'Capri pants', 'Short & Bermdas', 'leggings', 'overalls']
       },
       {
         name: 'skirts'
         categories: ['Short skirts', 'Skirts', 'Skirts']
       },
       {
         name: 'Jackets & Coats'
         categories: ['jackets', 'coats', 'Blazer']
       },
       {
         name: 'shoes'
         categories: ['Ballerinas', 'Pumps', 'Lace', 'sneaker', 'Boots', 'Sandals', 'Ankle Boots', 'Thigh', 'Boots']
       },
       {
         name: 'bags'
         categories: ['handbags', 'Shoulder Bag', 'Cases & Wallets', 'backpacks', 'clutches']
       },
       {
         name: 'accessories'
         categories: ['belt', 'Sunglasses', 'scarves', 'linen', 'Hats & Caps', 'Gloves', 'stockings / tights', 'Other']
       },
       {
         name: 'Schmuchk'
         categories: ['Arm', 'Haslketten', 'earrings', 'Rings', 'watches', 'followers']
       },
       {
         name: 'Beauty'
         categories: ['Lipstick', 'Eye Make-Up', 'Eye Make-Up', 'nail polish', 'Perfume', 'personal care', 'Hair Care', 'Face Care', 'Sun Care']
       },
       {
         name: 'Swimwear'
         categories: ['Bikinies', 'Bikini Tops', 'Pants', 'swimsuits']
       }
     ]
   },
   {
     name: 'Menswear'
     categories: [
       {
         name: 'Tops'
         categories: ['Shirts', 'polo shirts', 'shirts', 'sweater', 'sweaters', 'Hoodie', 'Long Sleeve']
       },
       {
         name: 'pants'
         categories: ['jeans', 'pants', 'Shorts']
       },
       {
         name: 'Jackets & Coats'
         categories: ['jackets', 'coats', 'jackets']
       },
       {
         name: 'Suits'
         categories: ['suit jackets',' suit trousers', 'Suit West ',' combination ']
       },
       {
         name: 'Sportswear'
         categories: ['function Tops', 'Functional Pants', 'Joggers', 'sports pants']
       },
       {
         name: 'shoes'
         categories: ['sneaker', 'Boots', 'Lace', 'moccasins and slippers', 'Open shoes']
       },
       {
         name: 'bags'
         categories: ['shoulder bags', 'briefcases', 'backpacks']
       },
       {
         name: 'accessories'
         categories: ['belt', 'scarves', 'Hats & Caps', 'Gloves', 'Ties & Bow', 'Purses', 'sunglasses']
       },
       {
         name: 'Jewelry'
         categories: ['watches', 'bracelets', 'chains', 'Rings']
       },
       {
         name: 'Beauty'
         categories: ['Parfürm', 'Harr care', 'Face Care', 'personal care']
       },
       {
         name: 'Swimwear'
         categories: ['swimwear', 'Board Shorts']
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

usa =Scope.where(country_code: 'US', locale:'en').first_or_create
brittish = Scope.where(country_code: 'GB', locale:'gb-en').first_or_create
canadian = Scope.where(country_code: 'CA', locale:'ca-en').first_or_create
australien = Scope.where(country_code: 'AU', locale:'au-en').first_or_create
turkey = Scope.where(country_code: 'TR', locale:'TR').first_or_create

create_categories germany,german_categories
create_categories usa,english_categories
create_categories brittish,english_categories
create_categories canadian,english_categories
create_categories australien,english_categories
create_categories turkey,english_categories



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
