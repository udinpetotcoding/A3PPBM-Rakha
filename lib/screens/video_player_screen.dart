import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final List<VideoPlayerController> _controllers = [];
  final List<bool> _isPlaying = [false, false, false];
  final List<bool> _isMinimized = [false, false, false];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    // Tambahkan URL video sesuai kebutuhan
    final videoUrls = [
      'https://media.gettyimages.com/id/840327136/video/lil-uzi-vert-at-the-2017-mtv-video-music-awards.mp4?s=mp4-640x640-gi&k=20&c=XzOWjVyZquqkEBjzbaYIyb0louctSoogVDDJogjmcfU=',
      'https://media.gettyimages.com/id/1340177325/video/lil-uzi-vert%C2%A0arrives-at-the-2021-met-gala-celebrating-in-america-a-lexicon-of-fashion.mp4?s=mp4-640x640-gi&k=20&c=AflRXGvhr9F7XODZs_XxiGOKuSqxGzz9nmPzlqF8HTo=',
      'https://media.gettyimages.com/id/1502048702/video/2023-bet-awards-arrivals.mp4?s=mp4-640x640-gi&k=20&c=Qftq4UvOqJQIfcdJSjtALb1CxB3IBr9d9C9wSrLNhks=',
    ];

    for (var url in videoUrls) {
      final controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {}); // Refresh setelah video diinisialisasi
        });
      _controllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _togglePlayPause(int index) {
    setState(() {
      if (_isPlaying[index]) {
        _controllers[index].pause();
      } else {
        _controllers[index].play();
      }
      _isPlaying[index] = !_isPlaying[index];
    });
  }

  void _toggleMinimize(int index) {
    setState(() {
      _isMinimized[index] = !_isMinimized[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            for (int i = 0; i < _controllers.length; i++)
              Expanded(
                flex: _isMinimized[i] ? 1 : 3,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[900],
                  ),
                  child: Column(
                    children: [
                      if (!_isMinimized[i])
                        Expanded(
                          child: _controllers[i].value.isInitialized
                              ? AspectRatio(
                            aspectRatio: _controllers[i].value.aspectRatio,
                            child: VideoPlayer(_controllers[i]),
                          )
                              : const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => _togglePlayPause(i),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                            ),
                            child: Text(
                              _isPlaying[i] ? 'Pause' : 'Play',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => _toggleMinimize(i),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                            ),
                            child: Text(
                              _isMinimized[i] ? 'Maximize' : 'Minimize',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
