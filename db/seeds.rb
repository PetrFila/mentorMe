# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Skill.destroy_all

Skill.create!([
  {name: 'HTML'},
  {name: 'CSS'},
  {name: 'Sass'},
  {name: 'WordPress'},
  {name: 'JavaScript'},
  {name: 'jQuery`'},
  {name: 'Meteor'},
  {name: 'angularJS'},
  {name: 'nodeJS'},
  {name: 'React'},
  {name: 'vueJS'},
  {name: 'PHP'},
  {name: 'Python'},
  {name: 'Ruby'},
  {name: 'Rails'},
  {name: 'Java'},
  {name: 'C++'},
  {name: 'C'},
  {name: 'C#'},
  {name: '.Net'},
  {name: 'iOS'},
  {name: 'Android'},
  {name: 'SQL'},
  {name: 'MySQL'},
  {name: 'MongoDB'},
  {name: 'PostgreSQL'},
  {name: 'Git'}
  ])

  p "created #{Skill.count} skills"
