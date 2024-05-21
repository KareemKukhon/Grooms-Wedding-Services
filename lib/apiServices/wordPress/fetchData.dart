import 'dart:convert';
import 'package:Rafeed/component/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class WordPressPosts extends StatefulWidget {
  @override
  _WordPressPostsState createState() => _WordPressPostsState();
}

class _WordPressPostsState extends State<WordPressPosts> {
  late Future<List<dynamic>> _fetchPosts;

  Future<List<dynamic>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://rafeed.sa/wp-json/wp/v2/posts'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPress Posts'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchPosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LoadingScreen());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListBody(
                  children: [
                    Html(style: {
                      "p, h4, li, ol, a": Style(
                        direction: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      )
                    }, data: """
        <p style="text-align: right;">${snapshot.data![index]['title']['rendered']}</p>
      """),
                    Html(style: {
                      "p, h4, li, ol, a": Style(
                        direction: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      )
                    }, data: snapshot.data![index]['content']['rendered']),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WordPressPosts(),
  ));
}
