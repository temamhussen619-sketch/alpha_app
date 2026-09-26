import 'package:flutter/material.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({Key? key}) : super(key: key);

  @override
  State<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> _feedItems = [
    {'title': 'Alpha Motivation Video 1', 'author': '@alpha_user'},
    {'title': 'Alpha Motivation Video 2', 'author': '@motivation_hub'},
    {'title': 'Ad Space / Promo Banner', 'author': '@sponsored'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: _feedItems.length,
        itemBuilder: (context, index) {
          final item = _feedItems[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: Colors.grey[900],
                child: Center(
                  child: Icon(
                    item['author'] == '@sponsored' 
                        ? Icons.campaign 
                        : Icons.play_circle_outline,
                    size: 80,
                    color: Colors.amber,
                  ),
                ),
              ),
              Positioned(
                right: 15,
                bottom: 100,
                child: Column(
                  children: [
                    _buildActionButton(Icons.person, "Profile"),
                    const SizedBox(height: 20),
                    _buildActionButton(Icons.card_giftcard, "Gifts"),
                    const SizedBox(height: 20),
                    _buildActionButton(Icons.stars, "VIP"),
                  ],
                ),
              ),
              Positioned(
                left: 15,
                bottom: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['author']!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item['title']!,
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black54,
          radius: 25,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
