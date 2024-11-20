Map<String, dynamic> airportList = {
  'Africa': ['North Africa', 'Sub-Saharan Africa'],
  'Asia': ['East Asia', 'Southeast Asia', 'South Asia', 'Central Asia'],
  'Europe': [
    'Western Europe',
    'Eastern Europe',
    'Northern Europe',
    'Southern Europe',
    'Central Europe'
  ],
  'North America': [
    'United States',
    'Canada',
    'Mexico',
    'Central America',
    'Caribbean'
  ],
  'South America': ['South America', 'Southern Cone', 'Amazon Basin'],
  'Australia': [
    'Australia and New Zealand',
    'Melanesia',
    'Micronesia',
    'Polynesia'
  ]
};
List<Map<String, Object>> airportCardList = [
  {
    'from': {
      'country': 'Japan',
      'airport': 'Beijing Capital',
      'flag': 'assets/icons/flag_Japan.png',
      'time': '17:55'
    },
    'to': {
      'country': 'Romania',
      'airport': 'Indira Gandhi',
      'flag': 'assets/icons/flag_Romania.png',
      'time': '20:55'
    },
    "class of travel": "Economy",
    'airline': 'Emirates',
    'flight number': 'UO 2923',
    'visit status': 'Recent Flight'
  },
  {
    'from': {
      'country': 'Istanbul',
      'airport': 'Zurich Airport',
      'flag': 'assets/icons/flag_Romania.png',
      'time': '20:55'
    },
    'to': {
      'country': 'UK',
      'airport': 'Tokyo Airport',
      'flag': 'assets/icons/flag_UK.png',
      'time': '14:55'
    },
    "class of travel": "First",
    'airline': 'Air France',
    'flight number': 'U1 3933',
    'visit status': 'Recent Flight'
  },
];
// 'airports': [
//   {
//     'country': 'United Arab Emirates',
//     'airport': 'Abu Dhabi Airport',
//     'flag': 'assets/icons/flag_United Arab Emirates.png',
//     'visit status': 'Visited recently',
//     'time': '17:55'
//   },
//   {
//     'country': 'Moldova',
//     'airport': 'Chisinau Airport',
//     'flag': 'assets/icons/flag_Moldova.png',
//     'visit status': 'Visited recently',
//     'time': '20:55'
//   },
//   {
//     'country': 'UK',
//     'airport': 'Heathrow Airport',
//     'flag': 'assets/icons/flag_UK.png',
//     'visit status': 'Upcoming visit',
//     'time': '17:55'
//   },
// ]

List<Map<String, dynamic>> airportReviewList = [
  {
    'country': "Abu Dhabi Airport",
    'logo': 'logo_abudhabi.png',
    'about': 'Very long  bio goes here pushing it to the second row',
    'trending': 'New lounges, pet-friendly zones, or upgraded Wi-Fi!',
    'perk': 'Spacious legroom, speedy check-in, and eco-friendly practices.',
    'imagePath': "assets/images/Abu Dhabi.png",
    'reviewStatus': true,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adj ustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': [
            'review_abudhabi_1.png',
            'review_canada_1.png',
            'review_turkish_1.png'
          ]
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_abudhabi_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
      ],
      'Cleanliness': {},
      'Booking Experience': {}
    }
  },
  {
    'country': "Hawaiian Airlines",
    'logo': 'logo_hawaiian.png',
    'about': 'Very long  bio goes here pushing it to the second row',
    'trending': 'New lounges, pet-friendly zones, or upgraded Wi-Fi!',
    'perk': 'Spacious legroom, speedy check-in, and eco-friendly practices.',
    'imagePath': "assets/images/Hawaiian.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_hawaiian_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_hawaiian_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
      ],
      'Cleanliness': {},
      'Booking Experience': {}
    }
  },
  {
    'country': "Japan Airlines",
    'logo': 'logo_japan.png',
    'about': 'Very long  bio goes here pushing it to the second row',
    'trending': 'New lounges, pet-friendly zones, or upgraded Wi-Fi!',
    'perk': 'Spacious legroom, speedy check-in, and eco-friendly practices.',
    'imagePath': "assets/images/Japan.png",
    'reviewStatus': true,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_japan_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_japan_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
      ],
      'Cleanliness': {},
      'Booking Experience': {}
    }
  },
  {
    'country': "Ethiopian Airlines",
    'logo': 'logo_ethiopian.png',
    'about': 'Very long  bio goes here pushing it to the second row',
    'trending': 'New lounges, pet-friendly zones, or upgraded Wi-Fi!',
    'perk': 'Spacious legroom, speedy check-in, and eco-friendly practices.',
    'imagePath': "assets/images/Ethiopian.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_ethiopian_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_ethiopian_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
      ],
      'Cleanliness': {},
      'Booking Experience': {}
    }
  },
  {
    'country': "Fiji Airways",
    'logo': 'logo_fiji.png',
    'about': 'Very long  bio goes here pushing it to the second row',
    'trending': 'New lounges, pet-friendly zones, or upgraded Wi-Fi!',
    'perk': 'Spacious legroom, speedy check-in, and eco-friendly practices.',
    'imagePath': "assets/images/Fiji.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_fiji_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_fiji_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
      ],
      'Cleanliness': {},
      'Booking Experience': {}
    }
  },
  {
    'country': "Air Canada",
    'logo': '',
    'about': 'Very long  bio goes here pushing it to the second row',
    'trending': 'New lounges, pet-friendly zones, or upgraded Wi-Fi!',
    'perk': 'Spacious legroom, speedy check-in, and eco-friendly practices.',
    'imagePath': "assets/images/Air Canada.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_canada_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_canada_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
      ],
      'Cleanliness': {},
      'Booking Experience': {}
    }
  },
  {
    'country': "Azerbaijan Airlines",
    'logo': '',
    'about': 'Very long  bio goes here pushing it to the second row',
    'trending': 'New lounges, pet-friendly zones, or upgraded Wi-Fi!',
    'perk': 'Spacious legroom, speedy check-in, and eco-friendly practices.',
    'imagePath': "assets/images/Azerbaijan.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_azerbaijan_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_azerbaijan_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
      ],
      'Cleanliness': {},
      'Booking Experience': {}
    }
  },
  {
    'country': "Finnair",
    'logo': '',
    'about': 'Very long  bio goes here pushing it to the second row',
    'trending': 'New lounges, pet-friendly zones, or upgraded Wi-Fi!',
    'perk': 'Spacious legroom, speedy check-in, and eco-friendly practices.',
    'imagePath': "assets/images/Finnair.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_finnair_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_finnair_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
      ],
      'Cleanliness': {},
      'Booking Experience': {}
    }
  },
  {
    'country': "SriLankan Airlines",
    'logo': '',
    'about': 'Very long  bio goes here pushing it to the second row',
    'trending': 'New lounges, pet-friendly zones, or upgraded Wi-Fi!',
    'perk': 'Spacious legroom, speedy check-in, and eco-friendly practices.',
    'imagePath': "assets/images/SriLankan.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_srilankan_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_srilankan_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
      ],
      'Cleanliness': {},
      'Booking Experience': {}
    }
  },
  {
    'country': "Singapore Airlines",
    'logo': '',
    'about': 'Very long  bio goes here pushing it to the second row',
    'trending': 'New lounges, pet-friendly zones, or upgraded Wi-Fi!',
    'perk': 'Spacious legroom, speedy check-in, and eco-friendly practices.',
    'imagePath': "assets/images/Singapore.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_singapore_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_singapore_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
          'Usedairport': 'Japan Airways',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
      ],
      'Cleanliness': {},
      'Booking Experience': {}
    }
  },
];
List<Map<String, dynamic>> trendingFeedbackList = [
  {
    'Name': 'Benedict Cumberbatch',
    'Avatar': 'avatar_1.png',
    'Date': '16.09.24',
    'Used Airport': 'Hawaiian Airlines',
    'Path': 'Tokyo -> Bucharest',
    'Content':
        'Loved the adjustable headrest, soft  cushioning. Made the trip very relaxing.',
    'Image': [
      'review_abudhabi_1.png',
      'review_ethiopian_2.png',
      'review_turkish_1.png'
    ]
  },
  {
    'Name': 'Andy Cumberbatch',
    'Avatar': 'avatar_2.png',
    'Date': '16.08.24',
    'Used Airport': 'Hawaiian Airlines',
    'Path': 'Tokyo -> Bucharest',
    'Content':
        'Liked the adjustable headrest, soft cushioning. Made the trip very relaxing.',
    'Image': [
      'review_ethiopian_2.png',
      'review_abudhabi_1.png',
      'review_turkish_1.png'
    ]
  },
  {
    'Name': 'Amanda Russel',
    'Avatar': 'avatar_3.png',
    'Date': '16.07.24',
    'Used Airport': 'Hawaiian Airlines',
    'Path': 'Tokyo -> Bucharest',
    'Content':
        'Loved the adjustable headrest, soft cushioning. Made the trip very relaxing.',
    'Image': [
      'review_turkish_1.png',
      'review_ethiopian_2.png',
      'review_abudhabi_1.png',
    ]
  },
];
List<Map<String, dynamic>> socialList = [
  {'Name': 'Linkedin', 'Avatar': 'assets/icons/linkedin.png'},
  {'Name': 'Telegram', 'Avatar': 'assets/icons/telegram.png'},
  {'Name': 'Discord', 'Avatar': 'assets/icons/discord.png'},
  {'Name': 'Whatsapp', 'Avatar': 'assets/icons/whatsapp.png'},
  {'Name': 'Twitter', 'Avatar': 'assets/icons/twitter.png'},
];
List<Map<String, dynamic>> mainCategoryAndSubcategoryForAirline = [
  {
    'mainCategory': ' Departure and Arrival Experience',
    'iconUrl': 'assets/icons/review_icon_boarding.png',
    'subCategory': {
      'Check-In Process': null,
      'Boarding Efficiency': null,
      'Baggage Delivery': null,
      'Lounge Access': null,
    },
  },
  {
    'mainCategory': 'Comfort',
    'iconUrl': 'assets/icons/review_icon_comfort.png',
    'subCategory': {
      'Seat Width': null,
      'Legroom': null,
      'Aircraft': null,
      'Accessibility': null,
      'Amenities': null,
    },
  },
  {
    'mainCategory': 'Cleanliness',
    'iconUrl': 'assets/icons/review_icon_cleanliness.png',
    'subCategory': {
      'Cabin': null,
      'Toilet': null,
    },
  },
  {
    'mainCategory': 'Onboard Service',
    'iconUrl': 'assets/icons/review_icon_onboard.png',
    'subCategory': {
      'Responsiveness': null,
      'Helpfulness': null,
    },
  },
  {
    'mainCategory': 'Food & Beverage',
    'iconUrl': 'assets/icons/review_icon_food.png',
    'subCategory': {
      'Choice': null,
      'Taste': null,
      'Quantity': null,
      'Duty Free Value': null,
      'Duty Free Choices': null,
    },
  },
  {
    'mainCategory': 'Entertainment and Wi-Fi',
    'iconUrl': 'assets/icons/review_icon_entertainment.png',
    'subCategory': {
      'IFE Availability': null,
      'IFE Choices': null,
      'Wi-Fi Speed': null,
      'Wi-Fi Value': null,
    },
  },
];
List<Map<String, dynamic>> mainCategoryAndSubcategoryForAirport = [
  {
    'mainCategory': 'Accessibility',
    'iconUrl': 'assets/icons/review_icon_access.png',
    'subCategory': {
      'Ease of Access': null,
      'Parking Availability': null,
      'Disability Access': null,
      'Pet Friendliness': null,
    },
  },
  {
    'mainCategory': 'Wait Times',
    'iconUrl': 'assets/icons/review_icon_wait.png',
    'subCategory': {
      'Security': null,
      'Baggage Delivery Time': null,
    },
  },
  {
    'mainCategory': 'Helpfulness/Ease of Travel',
    'iconUrl': 'assets/icons/review_icon_help.png',
    'subCategory': {
      'Helpfulness of Airport Staff': null,
      'Signage Clarity': null,
      'Ease of Connection': null,
    },
  },
  {
    'mainCategory': 'Ambience/Comfort',
    'iconUrl': 'assets/icons/review_icon_ambience.png',
    'subCategory': {
      'Ability to Relax/Work': null,
      'Cleanliness': null,
      'Availability of Seating Area': null,
    },
  },
  {
    'mainCategory': 'Food & Beverage and Shopping',
    'iconUrl': 'assets/icons/review_icon_food.png',
    'subCategory': {
      'Value of Shops': null,
      'Choice of Shops': null,
      'Value of F&B': null,
      'Choice of F&B': null,
    },
  },
  {
    'mainCategory': 'Amenities and Facilities',
    'iconUrl': 'assets/icons/review_icon_entertainment.png',
    'subCategory': {
      'Wi-Fi': null,
      'Restroom Facilities': null,
      'Lounges': null,
    },
  },
];
