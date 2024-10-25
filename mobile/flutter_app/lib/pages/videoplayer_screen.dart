import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoScreen extends StatefulWidget {
  const YoutubeVideoScreen({super.key});

  @override
  _YoutubeVideoScreenState createState() => _YoutubeVideoScreenState();
}

class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    const videoUrl = "https://youtu.be/cEQ_ZITv2v0?si=2AFU1zZfO8lF7OA4"; // URL Video YouTube kamu
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void deactivate() {
    _controller.pause(); // Pause video ketika navigasi keluar
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose(); // Bersihkan controller saat halaman ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '5 easy steps to maintain your tomatoes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
              const SizedBox(height: 10),
              const Text(
                'Video Description or Other Content Here',
                style: TextStyle(color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }
}
