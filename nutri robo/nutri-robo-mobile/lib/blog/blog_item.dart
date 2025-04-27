import 'package:flutter/material.dart';
import 'blog_detail_screen.dart';

// custom widget untuk masing-masing post
// untuk ditampilkan pada blogs_screen
// import 'package:nutrirobo/blog/models/blog.dart';

class BlogItem extends StatelessWidget {
  final String title;
  final String slug;
  final String intro;
  final String body;
  final String createdAt;
  //final String pk;

  BlogItem({required this.title, required this.slug, required this.intro, required this.body, required this.createdAt});

  void selectPost(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return BlogDetailScreen(title, slug, intro, body, createdAt);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectPost(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        decoration: BoxDecoration(
          boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0
                        )
                        ],
          gradient: LinearGradient(
            colors: [Colors.white.withOpacity(1), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}