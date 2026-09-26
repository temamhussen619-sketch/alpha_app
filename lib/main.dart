import 'package:flutter/material.dart';
import 'video_feed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alpha Motivation',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const VideoFeedScreen(),
    );
  }
}
