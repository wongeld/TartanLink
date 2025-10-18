import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/dummy_data.dart';

import 'listing_detail.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);
    final favs = app.favorites;
    final likedRoommateIds = app.likedRoommates;
    final likedRoommates = DummyData.sampleRoommates.where((r) => likedRoommateIds.contains(r['id'])).toList();

    return ListView(
      children: [
        if (favs.isNotEmpty) ...[
          Padding(padding: EdgeInsets.all(12), child: Text('Saved Listings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ...favs.map((f) => ListTile(
                leading: SizedBox(width: 70, height: 56, child: Image.asset(f.image, fit: BoxFit.cover)),
                title: Text(f.title),
                subtitle: Text(f.city),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListingDetail(listing: f))),
              )),
        ],
        if (likedRoommates.isNotEmpty) ...[
          Padding(padding: EdgeInsets.all(12), child: Text('Liked Roommates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ...likedRoommates.map((r) => ListTile(
                leading: SizedBox(width: 56, height: 56, child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(r['image'], fit: BoxFit.cover))),
                title: Text('${r['name']}, ${r['age']}'),
                subtitle: Text(r['bio']),
              )),
        ],
        if (favs.isEmpty && likedRoommates.isEmpty) Center(child: Padding(padding: EdgeInsets.all(24), child: Text('No favorites yet'))),
      ],
    );
  }
}
