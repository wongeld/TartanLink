import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/dummy_data.dart';
import '../state/app_state.dart';

class RoommateSwipeScreen extends StatefulWidget {
  @override
  _RoommateSwipeScreenState createState() => _RoommateSwipeScreenState();
}

class _RoommateSwipeScreenState extends State<RoommateSwipeScreen> {
  late List<Map<String, dynamic>> cards;
  Offset _dragOffset = Offset.zero;
  double _rotation = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    cards = List.from(DummyData.sampleRoommates.reversed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Discover Roommates')),
      body: Center(
        child: cards.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('No more profiles'),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => setState(() => cards = List.from(DummyData.sampleRoommates.reversed)),
                    child: Text('Reload'),
                  )
                ],
              )
            : SizedBox(
                width: 340,
                height: 520,
                child: Stack(
                  alignment: Alignment.center,
                  children: cards.asMap().entries.map((entry) {
                    final index = entry.key;
                    final profile = entry.value;
                    final isTop = index == cards.length - 1;
                    final offsetY = (cards.length - 1 - index) * 8.0;
                    return Positioned(
                      top: offsetY,
                      child: isTop ? _buildDraggableCard(profile) : _buildCard(profile),
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }

  Widget _buildDraggableCard(Map<String, dynamic> profile) {
    final appState = Provider.of<AppState>(context, listen: false);
    return GestureDetector(
      onPanStart: (_) {
        setState(() {
          _isDragging = true;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _dragOffset += details.delta;
          _rotation = _dragOffset.dx / 300;
        });
      },
      onPanEnd: (details) {
        setState(() {
          _isDragging = false;
        });
        final threshold = 150;
        if (_dragOffset.dx > threshold) {
          // liked
          appState.likeRoommate(profile['id']);
          setState(() {
            cards.remove(profile);
            _dragOffset = Offset.zero;
            _rotation = 0.0;
          });
        } else if (_dragOffset.dx < -threshold) {
          // disliked
          appState.dislikeRoommate(profile['id']);
          setState(() {
            cards.remove(profile);
            _dragOffset = Offset.zero;
            _rotation = 0.0;
          });
        } else {
          // reset
          setState(() {
            _dragOffset = Offset.zero;
            _rotation = 0.0;
          });
        }
      },
      child: Transform.translate(
        offset: _isDragging ? _dragOffset : Offset.zero,
        child: Transform.rotate(
          angle: _isDragging ? _rotation : 0.0,
          child: Stack(
            children: [
              _buildCard(profile, isDragging: _isDragging),
              if (_isDragging && _dragOffset.dx > 30)
                Positioned(
                  left: 24,
                  top: 24,
                  child: Opacity(
                    opacity: (_dragOffset.dx / 150).clamp(0.0, 1.0),
                    child: _badge('LIKE', Colors.green),
                  ),
                ),
              if (_isDragging && _dragOffset.dx < -30)
                Positioned(
                  right: 24,
                  top: 24,
                  child: Opacity(
                    opacity: (-_dragOffset.dx / 150).clamp(0.0, 1.0),
                    child: _badge('NOPE', Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCard(Map<String, dynamic> p, {bool isDragging = false}) {
    return Card(
      elevation: isDragging ? 12 : 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 320,
        height: 480,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(p['image'], fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${p['name']}, ${p['age']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(p['bio'], style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

