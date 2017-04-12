# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sections = Section.create([
	{name: "San Luis"},
	{name: "Seguridad"},
	{name: "Nacional"},
	{name: "Internacional"},
	{name: "Farándula"},
	{name: "Táctica"},
	{name: "Negocios"},
	{name: "Estados"},
	{name: "Actualidad"},
	{name: "Último Momento"}
	])	

article_content = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in qusae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? "

short_description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tempore architecto harum sint, cumque laboriosam, dolorum culpa voluptatum porro quae doloremque magni optio odit sunt suscipit fugit officia modi accusantium distinctio!"

article_name = "Lorem Ipsum Dolor Sit Amet"

superadmins = User.create([
		{first_name: "Ilse", last_name: "Alejo", email: "ilse@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin"},
		{first_name: "Eugenio", last_name: "Lujambio", email: "eugenio@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin"},
		{first_name: "Eugenio", last_name: "Lujambio", email: "eugenio@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin"},
		{first_name: "Osmar", last_name: "Ramírez", email: "osmar@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin"},

		{first_name: "Nats", last_name: "Ramírez", email: "nats@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "admin"},
		{first_name: "Carlos", last_name: "Ramírez", email: "carlos@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "admin"}
	])




