import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
 
import 'listing_detail.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  String city = '';

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);
    final results = app.listings.where((l) {
      final matchesQuery = query.isEmpty || l.title.toLowerCase().contains(query.toLowerCase());
      final matchesCity = city.isEmpty || l.city.toLowerCase().contains(city.toLowerCase());
      return matchesQuery && matchesCity;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Search title or feature'),
            onChanged: (v) => setState(() => query = v),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(labelText: 'City'),
            onChanged: (v) => setState(() => city = v),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (_, i) => ListTile(
                leading: SizedBox(width: 70, height: 56, child: Image.asset(results[i].image, fit: BoxFit.cover)),
                title: Text(results[i].title),
                subtitle: Text(results[i].city),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListingDetail(listing: results[i]))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
