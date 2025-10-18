import '../models/listing.dart';
import '../models/user.dart';

class DummyData {
  static final sampleListings = <Listing>[
    Listing(
      id: 'l1',
      title: 'Zindiroom Room for Rent',
      description: 'A warm room in the heart of the city, close to campus.',
      city: 'Zindiro Rwanda',
      price: 200000,
      rooms: 1,
      image: 'assets/images/sample_house1.jpg',
      ownerId: 'u2',
    ),
    Listing(
      id: 'l2',
      title: 'Spacious 2BR Apartment',
      description: 'Near transport, ideal for roommates.',
      city: 'Riverton',
      price: 650.0,
      rooms: 2,
      image: 'assets/images/sample_house2.jpg',
      ownerId: 'u3',
    ),
    Listing(
      id: 'l3',
      title: 'Quiet Suburban Studio',
      description: 'Perfect for focused students.',
      city: 'Lakeside',
      price: 420.0,
      rooms: 1,
      image: 'assets/images/sample_house3.jpg',
      ownerId: 'u4',
    ),
  ];

  static final sampleRoommates = <Map<String, dynamic>>[
  {'id': 'r1', 'name': 'Person One', 'age': 22, 'bio': 'Love quiet study nights and cooking.', 'image': 'assets/images/person1.jpeg'},
  {'id': 'r2', 'name': 'Person Two', 'age': 24, 'bio': 'Outgoing, likes soccer and movies.', 'image': 'assets/images/person2.jpeg'},
  {'id': 'r3', 'name': 'Person Three', 'age': 21, 'bio': 'Early riser, neat and tidy.', 'image': 'assets/images/person3.jpeg'},
  {'id': 'r4', 'name': 'Person Four', 'age': 23, 'bio': 'Artist and coffee lover.', 'image': 'assets/images/person4.jpg'},
  ];

  static final sampleUsers = <UserProfile>[
    UserProfile(id: 'u1', name: 'Alice Student', email: 'alice@example.com', role: UserRole.student),
    UserProfile(id: 'u2', name: 'Bob Landlord', email: 'bob@example.com', role: UserRole.landlord),
    UserProfile(id: 'u3', name: 'Clara Realtor', email: 'clara@example.com', role: UserRole.realtor),
    UserProfile(id: 'u4', name: 'Dan Owner', email: 'dan@example.com', role: UserRole.landlord),
  ];
}
