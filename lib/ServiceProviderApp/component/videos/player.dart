import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';


class Player extends StatefulWidget {
  bool ismini = false;
  final String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'; // Replace with your video URL

  Player({
    Key? key,
    required this.ismini,
  }) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller; // Declare the video player controller
  bool isPlayed = false; // Flag to track playback state
  bool _isFullScreen = false; // Flag to track fullscreen mode
  late FlickManager flickManager; // Declare flickManager

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.videoUrl); // corrected the VideoPlayerController initialization
    _controller!.initialize().then((_) => setState(() {
          flickManager =
              FlickManager(autoPlay: false, videoPlayerController: _controller);
        }));
    _controller1 = VideoPlayerController.network(
        widget.videoUrl); // corrected the VideoPlayerController initialization
    _controller1!.initialize().then((_) => setState(() {
          flickManager = FlickManager(
              autoPlay: false, videoPlayerController: _controller1);
        }));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      isPlayed = !isPlayed;
      // Toggle between aspect ratios for different sizes
      _controller!.setLooping(true); // Enable looping for seamless resizing
      if (isPlayed) {
        _controller!.play();
      } else {
        _controller!.pause();
      }
    });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      // Optionally, adjust UI elements based on fullscreen mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // _togglePlay();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                // Handle back button press
                // _togglePlay();
                Navigator.of(context)
                    .pop(true); // Return true when dismissed by the user
                return true; // Prevent dialog from being dismissed by the back button
              },
              child: AlertDialog(
                backgroundColor: Colors.transparent,
                content: SizedBox(
                  width: 300, // Set a fixed width for the video player
                  height: 300, // Set a fixed height for the video player
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: flickManager != null
                        ? FlickVideoPlayer(flickManager: flickManager)
                        : CircularProgressIndicator(),
                  ),
                ),
                // No actions button
              ),
            );
          },
        );
      },
      child: Stack(
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Calculate the aspect ratio based on available width
                  double aspectRatio =
                      constraints.maxWidth / (constraints.maxWidth * (5 / 9));

                  return AspectRatio(
                    aspectRatio: aspectRatio,
                    child: AbsorbPointer(
                      absorbing:
                          true, // Disable user interactions on the child widget
                      child: VideoPlayer(_controller1),
                    ),
                  );
                },
              ),
            ),
          ),
          !isPlayed
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Color(0xFF13A9B3),
                      child: Icon(
                        Icons.play_arrow,
                        size: 20.r,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
