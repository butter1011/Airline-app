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

List<Map<String, dynamic>> airportCardList = [
  {
    'origin': {
      'country': 'Japan',
      'city': 'Tokyo',
      'flag': 'assets/icons/flag_Japan.png',
      'time': '17:55'
    },
    'destination': {
      'country': 'Romania',
      'city': 'Bucharest',
      'flag': 'assets/icons/flag_Romania.png',
      'time': '20:55'
    },
    'flight number': 'UO 2923',
    'visit status': 'Recent Flight'
  },
  {
    'origin': {
      'country': 'Romania',
      'city': 'Bucharest',
      'flag': 'assets/icons/flag_Romania.png',
      'time': '20:55'
    },
    'destination': {
      'country': 'UK',
      'city': 'London',
      'flag': 'assets/icons/flag_UK.png',
      'time': '14:55'
    },
    'flight number': 'U1 3933',
    'visit status': 'Recent Flight'
  },
  {
    'origin': {
      'country': 'United Arab Emirates',
      'city': 'Abu Dhabi Airport',
      'flag': 'assets/icons/flag_United Arab Emirates.png',
      'time': ''
    },
    'destination': {'country': '', 'city': '', 'flag': '', 'time': ''},
    'flight number': '',
    'visit status': 'Visited recently'
  },
  {
    'origin': {
      'country': 'Moldova',
      'city': 'Tokyo',
      'flag': 'assets/icons/flag_Moldova.png',
      'time': '20:55'
    },
    'destination': {'country': '', 'city': '', 'flag': '', 'time': ''},
    'flight number': '',
    'visit status': 'Visited recently'
  },
  {
    'origin': {
      'country': 'UK',
      'city': 'Heathrow',
      'flag': 'assets/icons/flag_UK.png',
      'time': '17:55'
    },
    'destination': {'country': '', 'city': '', 'flag': '', 'time': ''},
    'flight number': '',
    'visit status': 'Upcoming visit'
  },
];
List<Map<String, dynamic>> airportReviewList = [
  {
    'country': "Abu Dhabi Airport",
    'logo': 'logo_abudhabi.png',
    'imagePath': "assets/images/Abu Dhabi.png",
    'reviewStatus': true,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
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
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_abudhabi_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
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
    'imagePath': "assets/images/Hawaiian.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_hawaiian_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_hawaiian_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
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
    'imagePath': "assets/images/Japan.png",
    'reviewStatus': true,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_japan_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_japan_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
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
    'imagePath': "assets/images/Ethiopian.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_ethiopian_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_ethiopian_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
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
    'imagePath': "assets/images/Fiji.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_fiji_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_fiji_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
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
    'imagePath': "assets/images/Air Canada.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_canada_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_canada_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
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
    'imagePath': "assets/images/Azerbaijan.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_azerbaijan_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_azerbaijan_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
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
    'imagePath': "assets/images/Finnair.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_finnair_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_finnair_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
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
    'imagePath': "assets/images/SriLankan.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_srilankan_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_srilankan_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
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
    'imagePath': "assets/images/Singapore.png",
    'reviewStatus': false,
    'reviews': {
      'Seat Comfort': [
        {
          'Name': 'Benedict Cumberbatch',
          'Avatar': 'avatar_1.png',
          'Date': '16.09.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_singapore_1.png']
        },
        {
          'Name': 'Andy Cumberbatch',
          'Avatar': 'avatar_2.png',
          'Date': '16.08.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': []
        },
        {
          'Name': 'Amanda Russel',
          'Avatar': 'avatar_3.png',
          'Date': '16.07.24',
          'Content':
              'Loved the adjustable headrest and soft cushioning. Made the trip very relaxing.',
          'Images': ['review_singapore_2.png']
        },
        {
          'Name': 'Naomi Karas',
          'Avatar': 'avatar_4.png',
          'Date': '16.06.24',
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
    'Used Airport': 'Abu Dhabi Airport',
    'Path': 'Tokyo -> Bucharest',
    'Content':
        'Loved the adjustable headrest, soft  cushioning. Made the trip very relaxing.',
    'Image': 'review_abudhabi_1.png'
  },
  {
    'Name': 'Andy Cumberbatch',
    'Avatar': 'avatar_2.png',
    'Date': '16.08.24',
    'Used Airport': 'Abu Dhabi Airport',
    'Path': 'Tokyo -> Bucharest',
    'Content':
        'Liked the adjustable headrest, soft cushioning. Made the trip very relaxing.',
    'Image': 'review_ethiopian_2.png'
  },
  {
    'Name': 'Amanda Russel',
    'Avatar': 'avatar_3.png',
    'Date': '16.07.24',
    'Used Airport': 'Abu Dhabi Airport',
    'Path': 'Tokyo -> Bucharest',
    'Content':
        'Loved the adjustable headrest, soft cushioning. Made the trip very relaxing.',
    'Image': 'review_turkish_1.png'
  },
];