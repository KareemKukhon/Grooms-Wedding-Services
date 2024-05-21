import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/videos/player.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/videos/youtubePlayer.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/galleryModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';
import 'package:video_player/video_player.dart';

import 'bottomSheetCard.dart';

class GridViewGallery extends StatelessWidget {
  GridViewGallery({Key? key});

  // final List<MediaItem> mediaItems;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginSignup>(builder: (context, provider, x) {
      return Container(
        // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  for (int i = 0; i < provider.user!.gallery!.length; i += 2)
                    _mediaItem(provider.user!.gallery![i], context),
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
                  for (int i = 1; i < provider.user!.gallery!.length; i += 2)
                    _mediaItem(provider.user!.gallery![i], context),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _mediaItem(Gallery gallery, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          // Handle the tap event based on whether it's a photo or video
          // if (gallery) {
          //   // Handle video playback
          // } else {
          //   // Handle photo viewing
          // }
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Container(
                child: gallery.type != 'IMAGE'
                    ? // Display a video player widget
                    Container(
                        color: Colors.grey, // Placeholder for video
                        child: YoutubePlayer1(
                          videoId: gallery.url,
                        ),
                      )
                    : Image.network(
                        server + gallery.url,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(
                                  15)), // Adjust the border radius as needed
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          Color.fromARGB(136, 111, 180, 185))),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => BottomSheetCard(
                          title: 'متأكد من حذف عملك التالى!',
                          subTitle:
                              'يتم الحذف بشكل نهائي ولا يمكن الاسترجاع ولكن يمكنك الاضافة ',
                          image: 'images/redWarning.png',
                          btn1: 'حذف ',
                          btn2: 'البقاء',
                          onClicked: () async {
                            await Provider.of<LoginSignup>(context,
                                    listen: false)
                                .deleteWork(gallery.id);
                            Navigator.of(context).pop();
                          },
                          btn1Color: Colors.red),
                    );
                  },
                  child: Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
