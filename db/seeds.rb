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
	{name: "Táctica Local"},
	{name: "Táctica Nacional e Internacional"},
	{name: "Negocios"},
	{name: "Estados"},
	{name: "Actualidad"},
	{name: "Último Momento"},
	{name: "Denuncia Global"}
])	


	
article_content = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in qusae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Praesentium sit, quibusdam provident in quae nisi, alias exercitationem odio laudantium perferendis atque, autem quidem nobis? Aut asperiores labore iste doloribus laudantium? "

short_description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tempore architecto harum sint, cumque laboriosam, dolorum culpa voluptatum porro quae doloremque magni optio odit sunt suscipit fugit officia modi accusantium distinctio!"

article_name = "Lorem Ipsum Dolor Sit Amet"

plain_text = "Lorem ipsum dolor sit amet - consectetur adipiscing elit. Proin cursus sit amet augue ut viverra. Pellentesque pulvinar, lectus ac lacinia convallis, tortor massa tempor ante, nec consectetur arcu purus sed ipsum. Vivamus nec sapien auctor velit faucibus vehicula sed vitae justo. Fusce dolor enim, auctor at turpis id, placerat pretium sapien. Nunc vitae efficitur tellus. Sed quis vestibulum ante, sed malesuada erat. Etiam ullamcorper pharetra scelerisque. 

Nunc fringilla, sapien non porttitor tempus, tortor felis porttitor nulla, ac ullamcorper purus eros et lacus. Praesent condimentum dapibus eros id ullamcorper. Mauris blandit justo eu varius placerat. Aliquam lacus velit, mattis at arcu ac, viverra laoreet nisl. Integer eu sapien interdum, ornare risus sit amet, iaculis nulla. Sed tempus quam sed nulla maximus placerat. Donec vitae velit ut est semper tempus. Nam lacinia tempor convallis. Fusce lobortis velit eget ligula tempus, vitae vehicula risus tincidunt."

superadmins = User.create([
		{first_name: "Ilse", last_name: "Alejo", email: "ilse@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin"},
		{first_name: "Eugenio", last_name: "Lujambio", email: "eugenio@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin", banners_permission: true, user_permission: true, create_articles_permission: true},
		{first_name: "Eugenio", last_name: "Lujambio", email: "eugenio@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin", banners_permission: true},
		{first_name: "Osmar", last_name: "Ramírez", email: "osmar@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "superadmin", banners_permission: true},
		{first_name: "Erwin", last_name: "Ayvar", email: "erwin.ayvar@globalmedia.mx", password: "globalmediatest", password_confirmation: "globalmediatest", role: "superadmin", banners_permission: true},
		{first_name: "Luis", last_name: "González", email: "luis.gonzalez@gmnet.com.mx", password: "globalmediatest", password_confirmation: "globalmediatest", role: "superadmin", banners_permission: true},

		{first_name: "Nats", last_name: "Ramírez", email: "nats@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "admin"},
		{first_name: "Carlos", last_name: "Ramírez", email: "carlos@nuva.rocks", password: "qwerty123", password_confirmation: "qwerty123", role: "admin", banners_permission: true}
	])

placeholder_note = '{"ops":[{"attributes":{"bold":true},"insert":"Lorem ipsum dolor sit amet - "},{"insert":"consectetur adipiscing elit. Proin cursus sit amet augue ut viverra. Pellentesque pulvinar, lectus ac lacinia convallis, tortor massa tempor ante, nec consectetur arcu purus sed ipsum. Vivamus nec sapien auctor velit faucibus vehicula sed vitae justo. Fusce dolor enim, auctor at turpis id, placerat pretium sapien. Nunc vitae efficitur tellus. Sed quis vestibulum ante, sed malesuada erat. Etiam ullamcorper pharetra scelerisque. \n\nNunc fringilla, sapien non porttitor tempus, tortor felis porttitor nulla, ac ullamcorper purus eros et lacus. Praesent condimentum dapibus eros id ullamcorper. Mauris blandit justo eu varius placerat. Aliquam lacus velit, mattis at arcu ac, viverra laoreet nisl. Integer eu sapien interdum, ornare risus sit amet, iaculis nulla. Sed tempus quam sed nulla maximus placerat. Donec vitae velit ut est semper tempus. Nam lacinia tempor convallis. Fusce lobortis velit eget ligula tempus, vitae vehicula risus tincidunt.\n\n"},{"insert":{"tweet":"854793360145600512"}},{"insert":"\n"}]}'

short_lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus sit amet augue ut viverra. Pellentesque pulvinar, lectus ac lacinia convallis, tortor massa tempor ante, nec consectetur arcu purus sed ipsum."
hashtags = "#duarte #poltica"

images = [
"http://www.metmuseum.org/toah/images/hb/hb_62.24.jpg", 
"https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1280px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg", 
"http://www.metmuseum.org/toah/images/hb/hb_1993.132.jpg", 
"https://upload.wikimedia.org/wikipedia/commons/b/b4/Vincent_Willem_van_Gogh_128.jpg", 
"https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Gustav_Klimt_046.jpg/1023px-Gustav_Klimt_046.jpg", 
"https://upload.wikimedia.org/wikipedia/commons/8/84/Gustav_Klimt_046.jpg",
"https://s-media-cache-ak0.pinimg.com/originals/8d/02/13/8d0213fd171c553b0da0f98b856d050d.jpg",
"http://www.sothebys.com/content/dam/stb/lots/L14/L14006/812L14006_7H7HW.jpg",
"http://1.bp.blogspot.com/-ii9a2EoLT7A/VVIMzFF27fI/AAAAAAAEcR0/8jXHWFmJtWw/s1600/Claude%2BMonet%2BLetters%2BTutt%27Art%40%2B(53).jpg",
"https://s-media-cache-ak0.pinimg.com/originals/8d/b1/e9/8db1e9ceb968f84843ddcbc8a750d0e4.jpg",
"https://upload.wikimedia.org/wikipedia/commons/1/1f/Michelangelo%27s_Pieta_5450_cropncleaned_edit.jpg",
"http://www.wallpaperawesome.com/wallpapers-awesome/wallpapers-famous-painting-artist-painter-brush-oil-on-canvas-awesome/wallpaper-painting-of-famous-painters-4.jpg",
"https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Gustav_Klimt_046.jpg/1023px-Gustav_Klimt_046.jpg", 
"https://upload.wikimedia.org/wikipedia/commons/8/84/Gustav_Klimt_046.jpg",
"https://s-media-cache-ak0.pinimg.com/originals/8d/02/13/8d0213fd171c553b0da0f98b856d050d.jpg",
"http://www.sothebys.com/content/dam/stb/lots/L14/L14006/812L14006_7H7HW.jpg",
"http://1.bp.blogspot.com/-ii9a2EoLT7A/VVIMzFF27fI/AAAAAAAEcR0/8jXHWFmJtWw/s1600/Claude%2BMonet%2BLetters%2BTutt%27Art%40%2B(53).jpg",
"https://s-media-cache-ak0.pinimg.com/originals/8d/b1/e9/8db1e9ceb968f84843ddcbc8a750d0e4.jpg",
"https://upload.wikimedia.org/wikipedia/commons/1/1f/Michelangelo%27s_Pieta_5450_cropncleaned_edit.jpg",
"http://www.wallpaperawesome.com/wallpapers-awesome/wallpapers-famous-painting-artist-painter-brush-oil-on-canvas-awesome/wallpaper-painting-of-famous-painters-4.jpg",
"https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Gustav_Klimt_046.jpg/1023px-Gustav_Klimt_046.jpg", 
"https://upload.wikimedia.org/wikipedia/commons/8/84/Gustav_Klimt_046.jpg",
"https://s-media-cache-ak0.pinimg.com/originals/8d/02/13/8d0213fd171c553b0da0f98b856d050d.jpg",
"http://www.sothebys.com/content/dam/stb/lots/L14/L14006/812L14006_7H7HW.jpg",
"http://1.bp.blogspot.com/-ii9a2EoLT7A/VVIMzFF27fI/AAAAAAAEcR0/8jXHWFmJtWw/s1600/Claude%2BMonet%2BLetters%2BTutt%27Art%40%2B(53).jpg",
"https://s-media-cache-ak0.pinimg.com/originals/8d/b1/e9/8db1e9ceb968f84843ddcbc8a750d0e4.jpg",
"https://upload.wikimedia.org/wikipedia/commons/1/1f/Michelangelo%27s_Pieta_5450_cropncleaned_edit.jpg",
"http://www.wallpaperawesome.com/wallpapers-awesome/wallpapers-famous-painting-artist-painter-brush-oil-on-canvas-awesome/wallpaper-painting-of-famous-painters-4.jpg"
]
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
				image: images[i], 
				image_thumbnail: images[i],
				draft: 1,
				published: true,
				video_url: "https://www.youtube.com/watch?v=Mh5LY4Mz15o"
			}
		])
	end
end

articles_new = Article.create([
			{		
				name: "Corea del Norte lanza misil",
				note: placeholder_note,
				short_description: short_lorem,
				plain_text: plain_text,
				hashtags_names: hashtags, 
				global_recommendation:  false, 
				highlight:  false, 
				articable_type:  "Section", 
				articable_id: Section.first.id, 
				image: images[1], 
				image_thumbnail: images[1],
				draft: 1,
				published: true
			},
			{		
				name: "Trump le dice no al muro",
				note: placeholder_note,
				short_description: short_lorem,
				plain_text: plain_text,
				hashtags_names: hashtags, 
				global_recommendation:  false, 
				highlight:  false, 
				articable_type:  "Section", 
				articable_id: Section.first.id, 
				image: images[1], 
				image_thumbnail: images[1],
				draft: 1,
				published: true
			},
			{		
				name: "Muere David Bowie",
				note: placeholder_note,
				short_description: short_lorem,
				plain_text: plain_text,
				hashtags_names: hashtags, 
				global_recommendation:  false, 
				highlight:  false, 
				articable_type:  "Section", 
				articable_id: Section.first.id, 
				image: images[1], 
				image_thumbnail: images[1],
				draft: 1,
				published: true
			},
			{		
				name: "Conflicto en medio oriente",
				note: placeholder_note,
				short_description: short_lorem,
				plain_text: plain_text,
				hashtags_names: hashtags, 
				global_recommendation:  false, 
				highlight:  false, 
				articable_type:  "Section", 
				articable_id: Section.first.id, 
				image: images[1], 
				image_thumbnail: images[1],
				draft: 1,
				published: true
			},
			{		
				name: "Cierran 254 empresas Pyme en SLP",
				note: placeholder_note,
				short_description: short_lorem,
				plain_text: plain_text,
				hashtags_names: hashtags, 
				global_recommendation:  false, 
				highlight:  false, 
				articable_type:  "Section", 
				articable_id: Section.first.id, 
				image: images[1], 
				image_thumbnail: images[1],
				draft: 1,
				published: true
			},
			{		
				name: "Encuentran eslabón en la cadena evolutiva",
				note: placeholder_note,
				short_description: short_lorem,
				plain_text: plain_text,
				hashtags_names: hashtags, 
				global_recommendation:  false, 
				highlight:  false, 
				articable_type:  "Section", 
				articable_id: Section.first.id, 
				image: images[1], 
				image_thumbnail: images[1],
				draft: 1,
				published: true
			},
			{		
				name: "Dan a conocer nuevos impuestos",
				note: placeholder_note,
				short_description: short_lorem,
				plain_text: plain_text,
				hashtags_names: hashtags, 
				global_recommendation:  false, 
				highlight:  false, 
				articable_type:  "Section", 
				articable_id: Section.first.id, 
				image: images[1], 
				image_thumbnail: images[1],
				draft: 1,
				published: true
			}

		])

articles = Article.all


articles.each do |article|
	article.update_attributes(user: superadmins[0])
	p "updated article user"
end
p "----------------------"
p articles.count 
p articles[1].id
p articles[2].id
p articles[3].id
p articles[4].id
p articles[5].id
p articles[6].id
p articles[7].id
p "----------------------"

highlights = Highlight.create([
	{
		order: 1,
		article: articles_new[1]
	},
	{
		order: 2,
		article: articles_new[2]
	},
	{
		order: 3,
		article: articles_new[3]
	},
	{
		order: 4,
		article: articles_new[4]
	},
	{
		order: 5,
		article: articles_new[5]
	},
	{
		order: 6,
		article: articles_new[6]
	}
])

keywords = Keyword.create([
	{ keyword: "Duarte" },
	{ keyword: "Politica" },
	{ keyword: "Corea del Norte" },
	{ keyword: "Trump" }
])

investigation = Relationship.create({
	name: "Duarte se escapa",
	image: images[15],
	description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
	relationship_type: "Investigation",
})
investigation_articles = ArticleRelationship.create([
	{
		article_id: articles[0].id,
		articable_id: investigation.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[1].id,
		articable_id: investigation.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[2].id,
		articable_id: investigation.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[3].id,
		articable_id: investigation.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[4].id,
		articable_id: investigation.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[5].id,
		articable_id: investigation.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[6].id,
		articable_id: investigation.id,
		articable_type: "Relationship"
	}
]) 

globalcomplaint = Relationship.create({
	name: "Denuncia Global",
	image: images[10],
	description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
	relationship_type: "Complaint",
})
globalcomplaint_articles = ArticleRelationship.create([
	{
		article_id: articles[10].id,
		articable_id: globalcomplaint.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[11].id,
		articable_id: globalcomplaint.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[12].id,
		articable_id: globalcomplaint.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[13].id,
		articable_id: globalcomplaint.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[14].id,
		articable_id: globalcomplaint.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[15].id,
		articable_id: globalcomplaint.id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[16].id,
		articable_id: globalcomplaint.id,
		articable_type: "Relationship"
	}
]) 

collaborators = Relationship.create([
	{
		name: "Pablo Lujambio",
		image: images[3],
		description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
		relationship_type: "Collaborator",
	},
	{
		name: "Plumas Nacionales",
		image: images[4],
		description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
		relationship_type: "Collaborator",
	},
	{
		name: "Erwin Ayvar",
		image: images[4],
		description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
		relationship_type: "Collaborator",
	},
	{
		name: "Luis González",
		image: images[4],
		description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
		relationship_type: "Collaborator",
	},
	{
		name: "Osmar Oramas",
		image: images[4],
		description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
		relationship_type: "Collaborator",
	}
])

collaborator_articles = ArticleRelationship.create([
	{
		article_id: articles[20].id,
		articable_id: collaborators[0].id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[21].id,
		articable_id: collaborators[0].id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[22].id,
		articable_id: collaborators[1].id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[23].id,
		articable_id: collaborators[2].id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[24].id,
		articable_id: collaborators[3].id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[25].id,
		articable_id: collaborators[4].id,
		articable_type: "Relationship"
	},
	{
		article_id: articles[26].id,
		articable_id: collaborators[1].id,
		articable_type: "Relationship"
	}
]) 
stations_image = "https://cdn.dribbble.com/users/482851/screenshots/2717061/radio.gif"
stations_image_2 = "https://cdn.dribbble.com/users/229993/screenshots/2924148/spaceradio4dr.jpg"
stations_name = "Estación "
stream_url = "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p"
playlist_image = "https://images.8tracks.com/cover/i/008/729/179/bedcovers1-8272.jpg?rect=0,0,540,540&q=98&fm=jpg&fit=max"
playlist = "https://open.spotify.com/user/spotifycharts/playlist/37i9dQZEVXbO3qyFxbkOE1"
for i in 0..7
	stations = Station.create([
		{
			name: stations_name  + (0...6).map { ('a'..'z').to_a[rand(26)] }.join,
			image: stations_image,
			stream_url: stream_url, 
			playlist_1: playlist,
			playlist_1_image: playlist_image,
			playlist_2: playlist,
			playlist_2_image: playlist_image,
			playlist_3: playlist,
			playlist_3_image: playlist_image,
			playlist_4: playlist,
			playlist_4_image: playlist_image
		}
	])
end
for i in 0..3
	stations = Station.create([
		{
			name: stations_name  + (0...6).map { ('a'..'z').to_a[rand(26)] }.join,
			image: stations_image_2,
			stream_url: "http://184.72.239.149/vod/mp4:BigBuckBunny_115k.mov/playlist.m3u8",
			video: true
		}
	])
end

timetable_image = "http://www.sothebys.com/content/dam/sothebys-pages/blogs/ModernImpressions/2017/2/klimt-bauerngarten_banner.jpg.webrend.1920.350.jpeg"
for i in 0..7
	Timetable.create(
		name: "Programa Eterno",
		image: timetable_image,
		streaming_hour: Time.now.beginning_of_day,
		end_streaming_hour: Time.now.end_of_day,
		monday: true, 
		tuesday: true, 
		wednesday: true, 
		thursday: true, 
		friday: true, 
		saturday: true, 
		sunday: true, 
		broadcasters: "Lalalala",
		broadcaster_image: timetable_image,
		station_id: Station.first.id
	)
end

User.all.each do |user|
	user.update_attributes(
		banners_permission: true, 
		create_articles_permission: true, 
		video_complaints_permission: true, 
		hits_permission: true, 
		destroy_articles_permission: true, 
		radio_stations_permission: true, 
		remote_controls_permission: true, 
		user_permission: true, 
		is_news_chief: true
	)
end


authors = Author.create([
	{name: "Ninguno", logo: images[3]},
	{name: "J.K Rowling", logo: images[3]},
	{name: "Harry Potter", logo: images[3]},
	{name: "Hermione Granger", logo: images[3]},
	{name: "Ron Weasley", logo: images[3]},
	{name: "Fred Weasley", logo: images[3]},
	{name: "George Weasley", logo: images[3]},
	{name: "Ginny Weasley", logo: images[3]},
])





