# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
List.delete_all
Sublist.delete_all
ListItem.delete_all

user = User.create(name: 'Erik', password_digest: BCrypt::Password.create('secret'))

user_2 = User.create(name: 'Susanna', password_digest: BCrypt::Password.create('secret'))

list_famous_battles = List.create(title: 'Places of Historical Battles',
description: 'Some of the big battles that took place in history from ancient history to recent day.',
remote_list_image_url: 'http://www.khoras.net/Khoras/History/History%20Pages/Historical%20Battles/Historical%20Battles.jpg',
user_id: user.id,
)

	ListItem.create(title: 'Battle of Troy (1260–1180 BC)',
	description: "In Greek mythology, the Trojan War was waged against the city of Troy by the Achaeans (Greeks) after Paris of Troy took Helen from her husband Menelaus, king of Sparta. The war is one of the most important events in Greek mythology and has been narrated through many works of Greek literature, most notably through Homer's Iliad. The Iliad relates four days in the tenth year of the decade-long siege of Troy; the Odyssey describes the journey home of Odysseus, one of the war's heroes. Other parts of the war are described in a cycle of epic poems, which have survived through fragments. Episodes from the war provided material for Greek tragedy and other works of Greek literature, and for Roman poets including Virgil and Ovid.",
	adress: '39.95721300634687, 26.239145882427692, (Tevfikiye Köyü İç Yolu, 17100 Tevfikiye/Çanakkale Merkez/Çanakkale, Turkey)',
	remote_image_url: 'http://www-tc.pbs.org/wnet/secrets/files/2015/09/sade-trojan-promo-mez.jpg',
	list_id: list_famous_battles.id)

sublist_alexanders_battles = Sublist.create(title: 'Battles of Alexander the Great',
description: 'Some of the greatest battles Alexander the Great fought in ancient times..',
user_id: user.id,
list_id: list_famous_battles.id,
)

	ListItem.create(title: 'Battle of Gaugamela',
	description: "The Battle of Gaugamela , also called the Battle of Arbela, was the decisive battle of Alexander the Great's invasion of the Persian Achaemenid Empire. In 331 BC Alexander's army of the Hellenic League met the Persian army of Darius III near Gaugamela, close to the modern city of Dohuk (Iraqi Kurdistan). Even though heavily outnumbered, Alexander emerged victorious due to his army's superior tactics and his deft employment of light infantry. It was a decisive victory for the Hellenic League and led to the fall of the Achaemenid Empire.",
	adress: '36.69102436690597, 43.34750175476074, (Shikhan St, Al-Shikhan, Iraq)',
	remote_image_url: 'http://www.catchthispilum.com/wp-content/uploads/2015/05/65BWH.jpg',
	list_id: list_famous_battles.id,
	sublist_id: sublist_alexanders_battles.id)

	ListItem.create(title: 'Siege of Halicarnassus',
	description: "The Siege of Halicarnassus was fought between Alexander the Great and the Achaemenid Persian Empire in 334 BC. Alexander, who had no navy, was constantly being threatened by the Persian navy. It continuously attempted to provoke an engagement with Alexander, who would have none of it. Eventually, the Persian fleet sailed to Halicarnassus, in order to establish a new defense. Ada of Caria, the former queen of Halicarnassus, had been driven from her throne by her younger brother Pixodarus of Caria. When Pixodarus died, Darius had appointed Orontobates satrap of Caria, which included Halicarnassus in its jurisdiction. On the approach of Alexander in 334 BC, Ada, who was in possession of the fortress of Alinda, surrendered the fortress to him.",
	adress: 'Shikhan St, Al-Shikhan, Irak',
	remote_image_url: 'http://2.bp.blogspot.com/-Qce6Plinpwk/TtUTc5qOMRI/AAAAAAAAC6A/HSezJ5SpVew/s640/alexander-the-great-at-the-siege-of-tyre-332-bc.jpg',
	list_id: list_famous_battles.id,
	sublist_id: sublist_alexanders_battles.id)

list_of_cafees = List.create(title: 'Cafées Worldwide',
description: 'Some of the sweet cafes I know around the world, mostly in Berlin and Sweden though :P',
remote_list_image_url: 'https://thumb1.shutterstock.com/display_pic_with_logo/3558395/473369353/stock-vector-hipster-barista-holding-a-cup-of-hot-coffee-sack-with-coffee-beans-and-wooden-scoop-cup-branch-473369353.jpg',
user_id: user.id,
)

sublist_berlin_cafees = Sublist.create(title: 'Cafées in Berlin',
description: 'Some of the cafes I like in Berlin',
user_id: user.id,
list_id: list_of_cafees.id,
)

	ListItem.create(title: 'Betahaus',
	description: 'One of the big co-working cafées in Berlin. It got a bit of shortages of places with power outputs, but is loaded with freelancers and other loose people :P',
	adress: '52.50258185183961, 13.412221223115921, (Prinzessinnenstraße 19, 10969 Berlin, Germany)',
	remote_image_url: 'http://theheureka.com/wp-content/uploads/2014/08/9452090596_bb19194255_z.jpg',
	list_id: list_of_cafees.id,
	sublist_id: sublist_berlin_cafees.id)

	ListItem.create(title: 'Café Luzia',
	description: 'Actually more of a bar place than a cafe, but sure you can get a coffee here. One of my favourite places in Berlin with plenty of extravagant hipsters smack middle in Kreuzberg. Around weekends they do have bouncer at the door and the place can get quite too full to get in.',
	adress: '52.50168196376776, 13.4182732924819, (Oranienstraße 45, 10969 Berlin, Germany)',
	remote_image_url: 'http://snapthecat.de/wp-content/uploads/2014/08/Luzia-002.jpg',
	list_id: list_of_cafees.id,
	sublist_id: sublist_berlin_cafees.id)

	ListItem.create(title: 'St. Oberholz',
	description: "A two-floor co-working café in Berlin. First of the places you'll get to know if you're a freelancer or inspiring entrepreneur as yours truly. Prices are a little steep, but it's a huge place with in a good location at Rozenthaler platz.",
	adress: '52.52948932180885, 13.401940651237965, (Rosenthaler Str. 72A, 10119 Berlin, Germany)',
	remote_image_url: 'http://www.my-entdecker.de/wp-content/uploads/2013/02/9057147.jpg',
	list_id: list_of_cafees.id,
	sublist_id: sublist_berlin_cafees.id)

sublist_sweden_cafees = Sublist.create(title: 'Cafées in Sweden',
description: 'Some of the cafes I like in Berlin',
list_id: list_of_cafees.id,
)

	ListItem.create(title: 'Café Linne',
	description: 'This is a quaint fancy cafe in Uppsala.',
	adress: '59.861428153238684, 17.633571289479733, (Linnégatan 3, 753 32 Uppsala, Sweden)',
	remote_image_url: 'http://www.allakartor.se/venue_images_475/54818_79103609.jpg',
	list_id: list_of_cafees.id,
	sublist_id: sublist_sweden_cafees.id)

	ListItem.create(title: 'Café Storken',
	description: 'A rather busy café',
	adress: '59.85831863692117, 17.639036625623703, (Stora TORGET 3, 753 20 Uppsala, Sweden)',
	remote_image_url: 'http://dansnotremaison.com/wp-content/uploads/2012/04/Uppsala-Salon-de-the-Kafferumet-Storken-a-Stora-Torget.jpg',
	list_id: list_of_cafees.id,
	sublist_id: sublist_sweden_cafees.id)

	ListItem.create(title: "Hugo's Kaffe",
	description: "A small café with a vegan or hippie crowd. It got low prices and coffee sorts you don't normally find in cafées.",
	remote_image_url: 'http://media.basetool.se/ProductImage/205783/1025/3/327037/1440/810',
	adress: '59.86115901047501, 17.634420543909073, (Svartbäcksgatan 21, 753 32 Uppsala, Sweden)',
	list_id: list_of_cafees.id,
	sublist_id: sublist_sweden_cafees.id)

	ListItem.create(title: 'Café Ofvandahls',
	description: "An old really quaint café from 1870 and it still got it's original tapestry. It has the feel as though it has not changed the last one and a half century.",
	adress: '59.859519192326715, 17.63177789747715, (Sysslomansgatan 5A, 753 11 Uppsala, Sweden)',
	remote_image_url: 'https://vinbanken.se/wp-content/uploads/2014/07/Ofvandahls-Hovkonditori-Uppsala-servering.jpg',
	list_id: list_of_cafees.id,
	sublist_id: sublist_sweden_cafees.id)

list_of_hbo_series = List.create(title: 'My favorite HBO series',
description: 'Cool HBO series by location',
remote_list_image_url: 'http://www.thetvaddict.com/wp-content/uploads/2016/03/hbo.jpg',
user_id: user_2.id,
)

  ListItem.create(title: 'Penny Dreadful',
  description: "Penny Dreadful is a British-American horror drama television series created for Showtime and Sky by John Logan, who also acts as executive producer alongside Sam Mendes. The show was originally pitched to several US and UK channels, and eventually landed with Showtime, with Sky Atlantic as co-producer. It premiered at the South by Southwest film festival on March 9 and began airing on television on April 28, 2014, on Showtime on Demand. The series premiered on Showtime on May 11, 2014, the first in an eight-episode season. After the third season finale on June 19, 2016, series creator John Logan announced that Penny Dreadful had ended as the main story had reached its conclusion. The title refers to the penny dreadfuls, a type of 19th-century British fiction publication with lurid and sensational subject matter. The series draws upon many public domain characters from 19th-century British and Irish fiction, including Dorian Gray from Oscar Wilde's The Picture of Dorian Gray, Mina Harker, Abraham Van Helsing, Dr. Seward, Renfield and Count Dracula from Bram Stoker's Dracula, Victor Frankenstein and his monster from Mary Shelley's Frankenstein, and Dr. Henry Jekyll from Robert Louis Stevenson's Strange Case of Dr Jekyll and Mr Hyde.",
  adress: '51.51400408502045, -0.07076740264892578, (15 Leman St, London E1 8EN, Storbritannien)',
  remote_image_url: 'http://vignette4.wikia.nocookie.net/penny-dreadful/images/d/dc/Cast-Slider_001.jpg',
  list_id: list_of_hbo_series.id)

  ListItem.create(title: 'Game of Thrones',
  description: "Game of Thrones is an American fantasy drama television series created by David Benioff and D. B. Weiss. It is an adaptation of A Song of Ice and Fire, George R. R. Martin's series of fantasy novels, the first of which is titled A Game of Thrones. It is filmed at Titanic Studios in Belfast and on location elsewhere in the United Kingdom, as well as in Croatia, Iceland, Malta, Morocco, Spain, and the United States. The series premiered on HBO in the United States on April 17, 2011, and its sixth season concluded on June 26, 2016. The series was renewed for a seventh season, which is scheduled to premiere in mid-2017 with a total of seven episodes. The series will conclude with its eighth season in 2018.",
  adress: '',
  remote_image_url: 'http://digitalspyuk.cdnds.net/16/25/980x490/landscape-1466508335-20160602-ep609-publicity-still-00400095499.jpg',
  list_id: list_of_hbo_series.id)