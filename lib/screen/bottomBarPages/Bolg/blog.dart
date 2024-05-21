import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:Rafeed/apiServices/servicesService.dart';
import 'package:Rafeed/component/loadingScreen.dart';
import 'package:Rafeed/screen/bottomBarPages/Bolg/viewBlog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Blog extends StatelessWidget {
  Blog({Key? key});

  late Future<List<dynamic>> _fetchPosts;
  List<String> imageList = [];

  Future<List<dynamic>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://rafeed.sa/wp-json/wp/v2/posts'));
    if (response.statusCode == 200) {
      final responseMap = jsonDecode(response.body);
      // await Provider.of<ServicesService>(context, listen: false)
      //   .fetchBlogImage(basicAuth,responseMap['featured_media']);
      await fetchImage(responseMap);
      return responseMap;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  String basicAuth = "Basic " +
      base64Encode(utf8.encode('Rahyb:q3Tk Qi6N tO6Z d0aU kELi KX4I'));
  Future<void> fetchImage(List<dynamic> posts) async {
    for (int i = 0; i < posts.length; i++) {
      if (posts[i]['featured_media'] != 0) {
        final response = await http.get(
            Uri.parse(
                'https://rafeed.sa/wp-json/wp/v2/media/${posts[i]['featured_media']}'),
            headers: {'Authorization': basicAuth});
        if (response.statusCode == 200) {
          final imageResponse = jsonDecode(response.body);
          imageList.add(imageResponse['media_details']['sizes']['thumbnail']
              ['source_url']);
        }
      } else {
        imageList.add('https://via.placeholder.com/150');
      }
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   String username = 'Rahyb';
  //   String password = 'q3Tk Qi6N tO6Z d0aU kELi KX4I';
  //   String userpass = '$username:$password';
  //   basicAuth = 'Basic ' + base64Encode(utf8.encode(userpass));
  //   _fetchPosts = fetchPosts();
  // }

  @override
  Widget build(BuildContext context) {
    // _fetchPosts = fetchPosts();
    return Scaffold(
        body: FutureBuilder<List<dynamic>>(
            future: fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: LoadingScreen());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Container(
                  padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildSearchBar(context),
                        _buildCategoryFilter(),
                        _buildArticleOfTheMonth(),
                        Text(
                          'المقالات',
                          style: TextStyle(
                            fontFamily: 'Portada ARA',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(8, 108, 106, 1),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ...List.generate(snapshot.data!.length, (index) {
                          // List<String> imageUrl =
                          //     Provider.of<ServicesService>(context).imageUrls;
                          return _buildArticles(
                              context, snapshot.data![index], imageList[index]);
                        }),
                      ],
                    ),
                  ),
                );
              }
            }));
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.tune,
            color: Color.fromRGBO(19, 169, 179, 1),
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              suffixText: 'بحث',
              suffixIcon: Icon(
                Icons.search,
                color: Color.fromRGBO(202, 202, 202, 1),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          10,
          (index) => Container(
            margin: EdgeInsets.all(5),
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color?>(
                  Colors.transparent,
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: Color.fromRGBO(19, 169, 179, 1),
                    ),
                  ),
                ),
              ),
              child: Text(
                'تصنيف',
                style: TextStyle(
                  fontFamily: 'Portada ARA',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(122, 122, 122, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleOfTheMonth() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'مقال الشهر',
            style: TextStyle(
              fontFamily: 'Portada ARA',
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(8, 108, 106, 1),
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة',
                      style: TextStyle(
                        fontFamily: 'Portada ARA',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(43, 47, 78, 1),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      'وصف بسيط للفيديو خلال النشر او اضافة هاشتاج الى الفيديو للعرض المضاف',
                      style: TextStyle(
                        fontFamily: 'Portada ARA',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(139, 139, 139, 1),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                width: 134.w,
                height: 110.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("images/services6.png"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.29),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildArticles(BuildContext context, param1, String? imageUrl) {
    return ListBody(
      children: [
        Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              log(param1['title']['rendered'].toString());
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewBlog(
                    imageUrl: imageUrl.toString(),
                    date: param1['date'],
                    title: param1['title']['rendered'].toString(),
                    param1: param1),
              ));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Html(style: {
                          "p, h4, li, ol, a": Style(
                            direction: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          )
                        }, data: """
            <p style="text-align: right;">${param1['title']['rendered']}</p>
                  """),
                        // Text(
                        //   param1,
                        //   style: TextStyle(
                        //     fontFamily: 'Portada ARA',
                        //     fontSize: 16.sp,
                        //     fontWeight: FontWeight.w700,
                        //     color: Color.fromRGBO(43, 47, 78, 1),
                        //   ),
                        //   textAlign: TextAlign.right,
                        // ),
                        Text(
                          'وصف بسيط للفيديو خلال النشر او اضافة هاشتاج الى الفيديو للعرض المضاف',
                          style: TextStyle(
                            fontFamily: 'Portada ARA',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(139, 139, 139, 1),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  !(imageUrl == "" || imageUrl == null)
                      ? Container(
                          width: 85.w,
                          height: 85.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.29),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 85.w,
                          height: 85.h,
                          color: Colors.transparent,
                        ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
