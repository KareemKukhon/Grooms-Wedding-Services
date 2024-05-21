import 'package:Rafeed/var/var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Rafeed/models/ratingModel.dart';

class CommentComponent extends StatefulWidget {
  RatingModel ratingModel;
  CommentComponent({
    Key? key,
    required this.ratingModel,
  }) : super(key: key);

  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  @override
  Widget build(BuildContext context) {
    String logoUrl =
        widget.ratingModel.user!.logo ?? 'public/uploads/defaultImage.jpg';

    double rating = widget.ratingModel.value ?? 0;
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(
          widget.ratingModel.review ?? "",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF2B2F4E),
            fontSize: 12.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int i = 0; i < 5; i++)
                  if (i < rating)
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    )
                  else
                    Icon(
                      Icons.star_border,
                      color: const Color.fromARGB(255, 211, 211, 211),
                    )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 180.w,
                  child: Text(
                    widget.ratingModel.user!.username,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF181818),
                      fontSize: 16.sp,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    logoUrl != 'null'
                        ? server + "/" + logoUrl
                        : 'https://rafeedsa.com:8083/public/uploads/defaultImage.jpg',
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 10),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20), child: Divider())
      ]),
    );
  }
}
