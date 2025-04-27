// widget untuk menampilkan daftar post
import 'package:flutter/material.dart';
// import 'package:nutrirobo/blog/models/blog.dart';

import 'dummy_data.dart';
import 'blog_item.dart';

// class untuk menampilkan daftar post
class BlogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: fetchBlog(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Column(
                children: const [
                  Text(
                    "Tidak ada post",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return GridView.builder(
                  padding: const EdgeInsets.all(25),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => BlogItem(
                      title: snapshot.data![index].fields.title,
                      slug: snapshot.data![index].fields.slug,
                      intro: snapshot.data![index].fields.intro,
                      body: snapshot.data![index].fields.body,
                      createdAt:
                          snapshot.data![index].fields.createdAt.toString()));
            }
          }
        },
      ),
    );
  }
}
