import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class ViewBlog extends StatelessWidget {
  String? title;
  String date;
  dynamic param1;
  String imageUrl;
  ViewBlog({
    Key? key,
    this.title,
    required this.date,
    this.param1,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height / 2.4,
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_forward),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //               Html(style: {
                    //                 "p, h4, li, ol, a": Style(
                    //                   direction: TextDirection.rtl,
                    //                   textAlign: TextAlign.right,
                    //                 )
                    //               }, data: """
                    //   <p style="text-align: right;">${param1['title']['rendered']}</p>
                    // """),
                    Text(
                      title ?? "",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromRGBO(43, 47, 78, 1),
                        fontFamily: 'Portada ARA',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          date.toString().substring(0, 10),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color.fromRGBO(139, 139, 139, 1),
                            fontSize: 10.sp,
                            fontFamily: 'Portada ARA',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Icon(
                          Icons.access_time,
                          color: Color.fromRGBO(139, 139, 139, 1),
                          size: 13.sp,
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Html(style: {
                      "p, h4, li, ol, a": Style(
                        direction: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      )
                    }, data: """
        <p style="text-align: right;">${param1['content']['rendered']}</p>
      """),
                    // Text(
                    //   "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص ..",
                    //   textAlign: TextAlign.right,
                    //   style: TextStyle(
                    //     color: Color.fromRGBO(122, 122, 122, 1),
                    //     fontWeight: FontWeight.w600,
                    //     fontFamily: 'Portada ARA',
                    //     fontSize: 18.sp,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, 55.h),
                ),
                backgroundColor: MaterialStateProperty.all<Color?>(
                  Color.fromRGBO(19, 169, 179, 1),
                ),
              ),
              onPressed: () async {
                try {
                  await Share.share(
                      '**Share the actual content of your article here**');
                } catch (e) {}
              },
              child: Text(
                'مشاركة المقال',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Portada ARA',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
