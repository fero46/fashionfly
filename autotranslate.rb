require 'easy_translate'

EasyTranslate.api_key = 'x'

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




def create_categories categories, language = :english 
  result = []
  sleep(1)
  for category in categories
    has_childrend = category.is_a?(Hash)
    item = {}
    item[:name] = EasyTranslate.translate(category[:name], from: :german, to: language)
    puts item
    if has_childrend
      item[:categories] = create_categories(category[:categories], language)
    else
      item[:categories] = EasyTranslate.translate(category[:categories], from: :german, to: language) 
    end
  end
end

EasyTranslate.translate("Das ist ein Test", from: :german, to: :english)

#puts create_categories(german_categories)