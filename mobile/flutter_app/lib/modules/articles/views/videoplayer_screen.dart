// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeVideoScreen extends StatefulWidget {
//   final String videoUrl;
//   const YoutubeVideoScreen({super.key, required this.videoUrl});

//   @override
//   _YoutubeVideoScreenState createState() => _YoutubeVideoScreenState();
// }

// class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState(); // URL Video YouTube kamu
//     final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

//     _controller = YoutubePlayerController(
//       initialVideoId: videoId!,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     );
//   }

//   @override
//   void deactivate() {
//     _controller.pause(); // Pause video ketika navigasi keluar
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     _controller.dispose(); // Bersihkan controller saat halaman ditutup
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           '5 easy steps to maintain your tomatoes',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: YoutubePlayerBuilder(
//         player: YoutubePlayer(
//           controller: _controller,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Colors.red,
//         ),
//         builder: (context, player) {
//           return Column(
//             children: [
//               player,
//               const SizedBox(height: 10),
//               const Text(
//                 'Video Description or Other Content Here',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeVideoScreen extends StatefulWidget {
//   final String videoUrl;

//   const YoutubeVideoScreen({Key? key, required this.videoUrl})
//       : super(key: key);

//   @override
//   State<YoutubeVideoScreen> createState() => _YoutubeVideoScreenState();
// }

// class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();

//     // Ambil video ID dari URL yang diberikan
//     final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

//     if (videoId == null) {
//       // Jika videoId tidak valid, tampilkan pesan error di konsol
//       debugPrint("Invalid YouTube URL: ${widget.videoUrl}");
//     } else {
//       _controller = YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: const YoutubePlayerFlags(
//           autoPlay: true,
//           mute: false,
//         ),
//       );
//     }
//   }

//   @override
//   void deactivate() {
//     if (_controller.value.isPlaying) {
//       _controller.pause(); // Pause video ketika navigasi keluar
//     }
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     _controller.dispose(); // Bersihkan controller saat halaman ditutup
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           'Video Player',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: widget.videoUrl.isEmpty ||
//               YoutubePlayer.convertUrlToId(widget.videoUrl) == null
//           ? const Center(
//               child: Text(
//                 "Invalid YouTube Video URL",
//                 style: TextStyle(color: Colors.red, fontSize: 16),
//               ),
//             )
//           : YoutubePlayerBuilder(
//               player: YoutubePlayer(
//                 controller: _controller,
//                 showVideoProgressIndicator: true,
//                 progressIndicatorColor: Colors.red,
//               ),
//               builder: (context, player) {
//                 return Column(
//                   children: [
//                     player,
//                     const SizedBox(height: 10),
//                     const Text(
//                       'Video Description or Other Content Here',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoScreen extends StatefulWidget {
  final String videoUrl;

  const YoutubeVideoScreen({super.key, required this.videoUrl});

  @override
  State<YoutubeVideoScreen> createState() => _YoutubeVideoScreenState();
}

class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    // Ambil video ID dari URL yang diberikan
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    if (videoId == null) {
      debugPrint("Invalid YouTube URL: ${widget.videoUrl}");
    } else {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  @override
  void deactivate() {
    if (_controller != null && _controller!.value.isPlaying) {
      _controller!.pause(); // Pause video ketika navigasi keluar
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.dispose(); // Bersihkan controller saat halaman ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

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
          'Video Player',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: videoId == null
          ? const Center(
              child: Text(
                "Invalid YouTube Video URL",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            )
          : YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller!,
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
