import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayer1 extends StatelessWidget {
  YoutubePlayer1({super.key,this.videoId="https://www.youtube.com/watch?v=BBAyRBTfsOU"});
  String? videoId;

  @override
  Widget build(BuildContext context) {
    videoId = YoutubePlayer.convertUrlToId(
        videoId!);
    return Center(
      child: GestureDetector(
          onTap: () {
            _showVideoPopup(context, videoId ?? "");
          },
          child: Container(
            width: 200.w,
            height: 200.h,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId!,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              progressColors: ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.redAccent,
              ),
            ),
          )),
    );
  }

  void _showVideoPopup(BuildContext context, String videoId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              progressColors: ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.redAccent,
              ),
            ),
          ),
        );
      },
    );
  }
}
