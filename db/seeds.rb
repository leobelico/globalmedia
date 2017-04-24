# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sections = Section.first_or_create([
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

plain_text = "Lorem ipsum dolor sit amet - consectetur adipiscing elit. Proin cursus sit amet augue ut viverra. Pellentesque pulvinar, lectus ac lacinia convallis, tortor massa tempor ante, nec consectetur arcu purus sed ipsum. Vivamus nec sapien auctor velit faucibus vehicula sed vitae justo. Fusce dolor enim, auctor at turpis id, placerat pretium sapien. Nunc vitae efficitur tellus. Sed quis vestibulum ante, sed malesuada erat. Etiam ullamcorper pharetra scelerisque. 

Nunc fringilla, sapien non porttitor tempus, tortor felis porttitor nulla, ac ullamcorper purus eros et lacus. Praesent condimentum dapibus eros id ullamcorper. Mauris blandit justo eu varius placerat. Aliquam lacus velit, mattis at arcu ac, viverra laoreet nisl. Integer eu sapien interdum, ornare risus sit amet, iaculis nulla. Sed tempus quam sed nulla maximus placerat. Donec vitae velit ut est semper tempus. Nam lacinia tempor convallis. Fusce lobortis velit eget ligula tempus, vitae vehicula risus tincidunt."

superadmins = User.create([
		{first_name: "Ilse", last_name: "Alejo", email: "ilse@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin"},
		{first_name: "Eugenio", last_name: "Lujambio", email: "eugenio@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin"},
		{first_name: "Eugenio", last_name: "Lujambio", email: "eugenio@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin"},
		{first_name: "Osmar", last_name: "Ramírez", email: "osmar@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin"},
		{first_name: "Osmar", last_name: "Ramírez", email: "osmar@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin"},
		{first_name: "Erwin", last_name: "Ayvar", email: "erwin.ayvar@globalmedia.mx", password: "globalmediatest", password_confirmation: "globalmediatest", role: "superadmin"},

		{first_name: "Nats", last_name: "Ramírez", email: "nats@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "admin"},
		{first_name: "Carlos", last_name: "Ramírez", email: "carlos@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "admin"}
	])

placeholder_note = '{"ops":[{"attributes":{"bold":true},"insert":"Lorem ipsum dolor sit amet - "},{"insert":"consectetur adipiscing elit. Proin cursus sit amet augue ut viverra. Pellentesque pulvinar, lectus ac lacinia convallis, tortor massa tempor ante, nec consectetur arcu purus sed ipsum. Vivamus nec sapien auctor velit faucibus vehicula sed vitae justo. Fusce dolor enim, auctor at turpis id, placerat pretium sapien. Nunc vitae efficitur tellus. Sed quis vestibulum ante, sed malesuada erat. Etiam ullamcorper pharetra scelerisque. \n\nNunc fringilla, sapien non porttitor tempus, tortor felis porttitor nulla, ac ullamcorper purus eros et lacus. Praesent condimentum dapibus eros id ullamcorper. Mauris blandit justo eu varius placerat. Aliquam lacus velit, mattis at arcu ac, viverra laoreet nisl. Integer eu sapien interdum, ornare risus sit amet, iaculis nulla. Sed tempus quam sed nulla maximus placerat. Donec vitae velit ut est semper tempus. Nam lacinia tempor convallis. Fusce lobortis velit eget ligula tempus, vitae vehicula risus tincidunt.\n\n"},{"insert":{"tweet":"854793360145600512"}},{"insert":"\n"}]}'

short_lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus sit amet augue ut viverra. Pellentesque pulvinar, lectus ac lacinia convallis, tortor massa tempor ante, nec consectetur arcu purus sed ipsum."
hashtags = "#duarte #poltica"

sections.each do |section|
	for i in 0..20
		article = Article.create([
			{		
				name: ("Lorem ipsum dolor sit amet, consectetur adipiscing elit cont") + (0...4).map { ('a'..'z').to_a[rand(26)] }.join,
				note: placeholder_note,
				short_description: short_lorem,
				plain_text: plain_text,
				hashtags_names: hashtags, 
				global_recommendation:  false, 
				highlight:  false, 
				articable_type:  "Section", 
				articable_id: section.id, 
				image: "https://upload.wikimedia.org/wikipedia/commons/8/84/Gustav_Klimt_046.jpg", 
				image_thumbnail: "http://www.sothebys.com/content/dam/sothebys-pages/blogs/ModernImpressions/2017/2/klimt-bauerngarten_banner.jpg.webrend.1920.350.jpeg"
			}
		])
	end
end
Article.all.each do |article|
	article.update_attributes(user: superadmins[0])
	p "updated article user"
end


