import 'package:flutter/material.dart';
// import 'package:nutrirobo/blog/models/blog.dart';
import 'package:nutrirobo/landingPage/page/landingPage.dart';
import 'package:nutrirobo/landingPage/page/signIn.dart';
import 'package:nutrirobo/tracker/page/tracker_main_page.dart';
import 'package:nutrirobo/faq/page/faq_main_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:nutrirobo/blog/blogs_screen.dart';
import 'package:nutrirobo/target_health/page/main_target.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    if (request.loggedIn) {
      _visibility = false;
    } else {
      _visibility = true;
    }
    return Drawer(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromRGBO(38, 70, 85, 1),
            ),
            title: const Text("Home Page"),
            onTap: () {
              Navigator.pop(
                context,
              );
            },
          ),
          ListTile(
            title: const Text("Tracker"),
            onTap: () {
              if (_visibility) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyTrackerPage()),
                );
              }
            },
          ),
          ListTile(
            title: const Text("Target Health"),
            onTap: () {
              // Route menu ke halaman form
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyTargetPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Blog'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BlogsScreen()));
            },
          ),
          ListTile(
            title: const Text('FAQ'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyfaqPage()));
            },
          ),
          Visibility(
              visible: _visibility,
              child: Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                    leading: const Icon(
                      Icons.login,
                      color: Colors.black,
                    ),
                    title: const Text('Sign In'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()));
                    },
                  ),
                ),
              )),
          Visibility(
              visible: !_visibility,
              child: Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    title: const Text('Sign Out'),
                    onTap: () async {
                      // ignore: unused_local_variable
                      final response = await request.get(
                        "https://nutrirobo.up.railway.app/auth/logout",
                      );
                      if (response["status"]) {
                        request.loggedIn = false;
                        request.jsonData = {};
                      } else {
                        request.loggedIn = true;
                      }
                      request.cookies = {};
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                    title: "NUTRI-ROBO",
                                    username: "",
                                  )));
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
