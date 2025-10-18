import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../models/listing.dart';
import 'listing_detail.dart';
import 'search_screen.dart';
import 'roommate_swipe.dart';
import 'favorites_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  Widget _buildBody() {
    switch (_tab) {
      case 0:
        return _buildListings();
      case 1:
        return RoommateSwipeScreen();
      case 2:
        return SearchScreen();
      case 3:
        return FavoritesScreen();
      case 4:
        return ChatScreen();
      case 5:
        return ProfileScreen();
      default:
        return _buildListings();
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(title: Text('Tartan Homes'), actions: [IconButton(icon: Icon(Icons.people), onPressed: () => Navigator.pushNamed(context, '/roommates'))]),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_search), label: 'Roommates'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildListings() {
    final app = Provider.of<AppState>(context);
    final listings = app.listings;
    return ListView.builder(
      itemCount: listings.length,
      itemBuilder: (_, i) {
        final l = listings[i];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListingDetail(listing: l))),
          child: Card(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
                  child: SizedBox(width: 120, height: 100, child: Image.asset(l.image, fit: BoxFit.cover)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        SizedBox(height: 6),
                        Text(l.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey[700])),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${l.city} • ${l.rooms}br', style: TextStyle(color: Colors.grey[600])),
                            Row(
                              children: [
                                Text('\$${l.price.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                                IconButton(
                                  icon: Icon(app.isFavorite(l.id) ? Icons.favorite : Icons.favorite_border, color: app.isFavorite(l.id) ? Theme.of(context).primaryColor : Colors.grey),
                                  onPressed: () => app.toggleFavorite(l.id),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
