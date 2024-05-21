import 'package:Rafeed/component/videos/player.dart';
import 'package:Rafeed/component/videos/youtubePlayer.dart';
import 'package:Rafeed/models/galleryModel.dart';
import 'package:Rafeed/var/var.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WorkGallery extends StatelessWidget {
  WorkGallery({Key? key, required this.mediaItems});

  final List<Gallery> mediaItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                for (int i = 0; i < mediaItems.length; i += 2)
                  _mediaItem(mediaItems[i], context),
              ],
            ),
          ),
          // SizedBox(
          //   width: 10,
          // ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                for (int i = 1; i < mediaItems.length; i += 2)
                  _mediaItem(mediaItems[i], context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mediaItem(Gallery mediaItem, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          // Handle the tap event based on whether it's a photo or video
          if (mediaItem.type != "IMAGE") {
            // Handle video playback
          } else {
            // Handle photo viewing
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            child: mediaItem.type != "IMAGE"
                ? // Display a video player widget
                Container(
                    color: Colors.grey, // Placeholder for video
                    child: YoutubePlayer1(videoId: mediaItem.url,),
                  )
                : CachedNetworkImage(
                    imageUrl: server + '/' + mediaItem.url,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.red.shade400,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
