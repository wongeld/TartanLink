import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/listing.dart';
import '../data/dummy_data.dart';

class AppState extends ChangeNotifier {
  UserProfile? _user;
  List<Listing> _listings = [];
  Set<String> _favorites = {}; // listing ids
  Map<String, List<Map<String, String>>> _chats = {};

  AppState() {
    _listings = DummyData.sampleListings;
    // seed chats with dummy user
    _chats = {};
  }

  UserProfile? get user => _user;
  List<Listing> get listings => List.unmodifiable(_listings);
  List<Listing> get favorites =>
      _listings.where((l) => _favorites.contains(l.id)).toList();
  // liked roommate ids
  Set<String> _likedRoommates = {};

  List<String> get likedRoommates => List.unmodifiable(_likedRoommates);

  void setUser(UserProfile u) {
    _user = u;
    notifyListeners();
  }

  void toggleFavorite(String listingId) {
    if (_favorites.contains(listingId)) _favorites.remove(listingId);
    else _favorites.add(listingId);
    notifyListeners();
  }

  void likeRoommate(String roommateId) {
    _likedRoommates.add(roommateId);
    notifyListeners();
  }

  void dislikeRoommate(String roommateId) {
    _likedRoommates.remove(roommateId);
    notifyListeners();
  }

  // roommate ads (users posting they want a roommate / requirements)
  final List<Map<String, dynamic>> _roommateAds = [];

  List<Map<String, dynamic>> get roommateAds => List.unmodifiable(_roommateAds);

  void postRoommateAd(Map<String, dynamic> ad) {
    _roommateAds.insert(0, ad);
    notifyListeners();
  }

  void removeRoommateAd(String adId) {
    _roommateAds.removeWhere((a) => a['id'] == adId);
    notifyListeners();
  }

  bool isFavorite(String listingId) => _favorites.contains(listingId);

  List<Map<String, String>> getChat(String otherUserId) {
    return _chats.putIfAbsent(otherUserId, () => []);
  }

  void sendMessage(String otherUserId, String fromId, String text) {
    final chat = _chats.putIfAbsent(otherUserId, () => []);
    chat.add({
      'from': fromId,
      'text': text,
      'time': DateTime.now().toIso8601String(),
    });
    notifyListeners();
  }
}
