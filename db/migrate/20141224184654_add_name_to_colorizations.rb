class AddNameToColorizations < ActiveRecord::Migration[4.2]
  def change
    add_column :colorizations, :word, :string
    add_column :colorizations, :oposite_color, :string 
    Colorization.where(name: "#e7db9c").first_or_create.update(word:"Zombie", oposite_color: '#00000')
    Colorization.where(name: "#ffff02").first_or_create.update(word:"Aqua", oposite_color: '#00000')
    Colorization.where(name: "#7cfe6f").first_or_create.update(word:"Screamin' Green", oposite_color: '#00000')
    Colorization.where(name: "#ffdfef").first_or_create.update(word:"Pale Rose", oposite_color: '#00000')
    Colorization.where(name: "#2ed0cd").first_or_create.update(word:"Turquoiseapprox", oposite_color: '#00000')
    Colorization.where(name: "#b9531c").first_or_create.update(word:"Orange Roughy", oposite_color: '#00000')
    Colorization.where(name: "#f4cb62").first_or_create.update(word:"Cream Can", oposite_color: '#00000')
    Colorization.where(name: "#c61cd0").first_or_create.update(word:"Purple Heart", oposite_color: '#00000')
    Colorization.where(name: "#ff0000").first_or_create.update(word:"Red", oposite_color: '#00000')
    Colorization.where(name: "#ffffff").first_or_create.update(word:"White", oposite_color: '#00000')
    Colorization.where(name: "#2c2bd1").first_or_create.update(word:"Governor Bay", oposite_color: '#00000')
    Colorization.where(name: "#d4d4d4").first_or_create.update(word:"Alto", oposite_color: '#00000')
    Colorization.where(name: "#ffc702").first_or_create.update(word:"Supernova", oposite_color: '#00000')
    Colorization.where(name: "#000000").first_or_create.update(word:"Black", oposite_color: '#ffffff')
    Colorization.where(name: "#019e13").first_or_create.update(word:"Japanese Laurel", oposite_color: '#00000')
    Colorization.where(name: "#c5e1fd").first_or_create.update(word:"French Pass", oposite_color: '#00000')
    Colorization.where(name: "#ff59ae").first_or_create.update(word:"Hot Pink", oposite_color: '#00000')
    Colorization.where(name: "#77858f").first_or_create.update(word:"Slate Gray", oposite_color: '#00000')
  end
end
