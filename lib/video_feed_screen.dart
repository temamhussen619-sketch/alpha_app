import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({Key? key}) : super(key: key);

  @override
  State<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  final PageController _pageController = PageController();
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  final List<Map<String, String>> _feedItems = [
    {'title': 'Alpha Motivation Video 1', 'author': '@alpha_user'},
    {'title': 'Alpha Motivation Video 2', 'author': '@motivation_hub'},
    {'title': 'Ad Space / Promo Banner', 'author': '@sponsored'},
  ];

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test Banner Ad ID
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );
    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
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
                    bottom: 80,
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
          if (_isBannerAdLoaded && _bannerAd != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
        ],
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
