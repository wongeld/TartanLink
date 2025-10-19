import '../models/listing.dart';
import '../models/user.dart';

class DummyData {
  static final sampleListings = <Listing>[
    Listing(
      id: 'l1',
      title: 'Zindiro Room for Rent',
      description: 'A warm room in the heart of the city, close to campus.',
      city: 'Zindiro, Kigali',
      price: 200000,
      rooms: 1,
      image: 'assets/images/sample_house1.jpg',
      ownerId: 'u2',
    ),

    Listing(
      id: 'l2',
      title: 'Shared Studio — Remera (near CMU Africa)',
      description:
          'Bright shared studio with study desk, high-speed Wi-Fi and monthly cleaning. 7-minute walk to CMU Africa.',
      city: 'Remera, Kigali',
      price: 180000,
      rooms: 1,
      image: 'assets/images/sample_house2.jpg',
      ownerId: 'u3',
    ),

    Listing(
      id: 'l3',
      title: 'Quiet Single Room — Kacyiru',
      description:
          'Single furnished room in a quiet compound. Bills included (water + electricity up to a cap). Safe for students.',
      city: 'Kacyiru, Kigali',
      price: 210000,
      rooms: 1,
      image: 'assets/images/sample_house3.jpg',
      ownerId: 'u4',
    ),

    Listing(
      id: 'l4',
      title: 'Student Flatshare — Gaculiro',
      description:
          'Two-bedroom flat shared by students. Each tenant gets a locked bedroom and shared kitchen. 10 min by bike to campus.',
      city: 'Gaculiro, Kigali',
      price: 160000,
      rooms: 1,
      image: 'assets/images/sample_house4.jpg',
      ownerId: 'u5',
    ),

    Listing(
      id: 'l5',
      title: 'En-suite Room — Kimihurura',
      description:
          'Compact en-suite room with wardrobe and study area. Safe compound, easy access to shops and transport to CMU Africa.',
      city: 'Kimihurura, Kigali',
      price: 240000,
      rooms: 1,
      image: 'assets/images/sample_house5.jpg',
      ownerId: 'u6',
    ),

    Listing(
      id: 'l6',
      title: 'Budget Room with Balcony — Remera',
      description:
          'Simple furnished room, shared kitchen and bathroom. Ideal for budget-conscious students. Short walk to campus buses.',
      city: 'Remera, Kigali',
      price: 150000,
      rooms: 1,
      image: 'assets/images/sample_house6.jpg',
      ownerId: 'u7',
    ),

    Listing(
      id: 'l7',
      title: 'Two-room Studio (split) — Kacyiru',
      description:
          'Studio split into two private rooms; shared kitchenette. Monthly laundry service optional. Close to CMU Africa.',
      city: 'Kacyiru, Kigali',
      price: 195000,
      rooms: 1,
      image: 'assets/images/sample_house7.jpg',
      ownerId: 'u8',
    ),

    Listing(
      id: 'l8',
      title: 'Quiet Room in Family Home — Gisozi',
      description:
          'Room inside a family home in a quiet neighbourhood. Meals negotiable, excellent for first-year students needing support.',
      city: 'Gisozi, Kigali',
      price: 220000,
      rooms: 1,
      image: 'assets/images/sample_house8.jpg',
      ownerId: 'u9',
    ),
  ];

  static final sampleRoommates = <Map<String, dynamic>>[
    {
      'id': 'r1',
      'name': 'Amina Nkurunziza',
      'age': 24,
      'bio':
          'CMU Africa student in AI program. Enjoys evening walks and cooking Rwandan dishes.',
      'image': 'assets/images/person1.jpg',
    },
    {
      'id': 'r2',
      'name': 'Samuel Okello',
      'age': 25,
      'bio':
          'Master’s student in Software Engineering. Loves coding, basketball, and clean shared spaces.',
      'image': 'assets/images/person2.jpg',
    },
    {
      'id': 'r3',
      'name': 'Linda Mutesi',
      'age': 23,
      'bio':
          'Studying Data Science at CMU Africa. Easy-going, organized, and enjoys watching documentaries.',
      'image': 'assets/images/person3.jpg',
    },
    {
      'id': 'r4',
      'name': 'Tunde Adebayo',
      'age': 26,
      'bio':
          'From Nigeria, passionate about robotics and AI ethics. Likes cooking and morning workouts.',
      'image': 'assets/images/person4.jpg',
    },
    {
      'id': 'r5',
      'name': 'Grace Mugisha',
      'age': 22,
      'bio':
          'CMU Africa first-year student. Loves reading, group study sessions, and volunteering on weekends.',
      'image': 'assets/images/person5.jpg',
    },
    {
      'id': 'r6',
      'name': 'Elijah Kamau',
      'age': 25,
      'bio':
          'Software systems student from Kenya. Prefers quiet roommates and enjoys jazz music.',
      'image': 'assets/images/person6.jpg',
    },
    {
      'id': 'r7',
      'name': 'Fatou Diallo',
      'age': 24,
      'bio':
          'From Senegal, studying Cybersecurity. Friendly, tidy, and enjoys hosting movie nights.',
      'image': 'assets/images/person7.jpg',
    },
    {
      'id': 'r8',
      'name': 'Abel Tesfaye',
      'age': 27,
      'bio':
          'CMU Africa student in Electrical and Computer Engineering. Loves hiking and mentoring younger students.',
      'image': 'assets/images/person8.jpg',
    },
  ];


  static final sampleUsers = <UserProfile>[
    UserProfile(id: 'u1', name: 'Alice Student', email: 'alice@example.com', role: UserRole.student),
    UserProfile(id: 'u2', name: 'Bob Landlord', email: 'bob@example.com', role: UserRole.landlord),
    UserProfile(id: 'u3', name: 'Clara Realtor', email: 'clara@example.com', role: UserRole.realtor),
    UserProfile(id: 'u4', name: 'Dan Owner', email: 'dan@example.com', role: UserRole.landlord),
  ];
}
