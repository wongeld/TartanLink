import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/listing.dart';
import '../state/app_state.dart';
import 'chat_detail_screen.dart'; // <-- Add this import

class ListingDetail extends StatelessWidget {
  final Listing listing;
  ListingDetail({required this.listing});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);

    // Assign the chat user based on listing (temporary)
    final chatUserId = 'u2';
    final chatUserName = 'Bob Landlord';
    final chatUserImage = 'assets/profile_placeholder.png';

    return Scaffold(
      appBar: AppBar(title: Text(listing.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.all(12),
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    listing.image,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listing.title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('${listing.city} • ${listing.rooms} rooms',
                            style: TextStyle(color: Colors.grey[600])),
                        SizedBox(height: 6),
                        Text(
                          'RWF ${NumberFormat('#,###', 'en_US').format(listing.price)}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 12),
                        Text(listing.description,
                            style: TextStyle(color: Colors.grey[800])),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    app.toggleFavorite(listing.id),
                                icon: Icon(app.isFavorite(listing.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                                label: Text(app.isFavorite(listing.id)
                                    ? 'Saved'
                                    : 'Save'),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: Icon(Icons.message),
                                label: Text('Message'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChatDetailScreen(
                                        userId: chatUserId,
                                        userName: chatUserName,
                                        userImage: chatUserImage,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
