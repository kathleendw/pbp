import 'package:flutter/material.dart';
import 'package:nutrirobo/target_health/page/detail_profile.dart';
import 'package:nutrirobo/target_health/page/detail_target.dart';

// void main() {
//   runApp(const MyTargetPage());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   static const MaterialColor white = MaterialColor(
//     0xFFFFFFFF,
//     <int, Color>{
//       50: Color(0xFFFFFFFF),
//       100: Color(0xFFFFFFFF),
//       200: Color(0xFFFFFFFF),
//       300: Color(0xFFFFFFFF),
//       400: Color(0xFFFFFFFF),
//       500: Color(0xFFFFFFFF),
//       600: Color(0xFFFFFFFF),
//       700: Color(0xFFFFFFFF),
//       800: Color(0xFFFFFFFF),
//       900: Color(0xFFFFFFFF),
//     },
//   );

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'NUTRI-ROBO',
//       theme: ThemeData(
//         //primarySwatch: Colors.blue,
//         primarySwatch: white,
//         scaffoldBackgroundColor: const Color.fromRGBO(219, 232, 246, 1.0),
//       ),
//       home: MyTargetPage(),
//     );
//   }
// }

class MyTargetPage extends StatefulWidget {
  const MyTargetPage({
    super.key,
  }); //required this.username});

  //final String username;

  @override
  State<MyTargetPage> createState() => _MyTargetPageState();
}

class _MyTargetPageState extends State<MyTargetPage> {
  List<String> listMenu = ['YOUR PROFILE', 'YOUR TARGET HEALTH'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            children: [
              Image.asset(
                'assets/logo.jpg',
                height: 70,
                width: 150,
              ),
            ],
          ),
          backgroundColor: Colors.white,
          //Text(widget.title),
          // actions: [
          //   TextButton(
          //     child: Text("Logout"),
          //     style: TextButton.styleFrom(
          //       textStyle: TextStyle(
          //         fontSize: 20,
          //       ),
          //       //primary:
          //     ),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        body: Center(
            child: ListView(
          children: [
            ListTile(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(Icons.account_circle_outlined),
                title: Text("YOUR PROFILE"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailMyProfilePage(username: "")))),
            ListTile(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(Icons.health_and_safety_outlined),
                title: Text("YOUR TARGET HEALTH"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailMyTargetPage(username: "")))),
          ],

          //itemCount: listMenu.length,
          // itemBuilder: (context, index) {
          //   return Padding(
          //       padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          //       child: Card(
          //         elevation: 0,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(0)),
          //         child: ListTile(
          //           //leading: Icon(Icons.account_circle_outlined),
          //           title: Text(listMenu[index]),
          //           trailing: Icon(Icons.keyboard_arrow_right),
          //         ),
          //       ));
          // },
        )));
  }
}

// class ProfileMenu extends StatelessWidget {
//   const ProfileMenu({
//      Key key,
//     @required this.text,
//     @required this.icon,
//     @required this.press,
//   }) : super(key: key);

//   final String text, icon;
//   final VoidCallback press;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal:  20, vertical: 10),
//       child: FlatButton(
//         padding: EdgeInsets.all(20),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
//         color: Color(0xFFF5F6F9),
//         onPressed: () {},
//         child: Row(context))
//       )
//   }
// }

//reference: https://www.youtube.com/watch?v=1MATGdHfZyM
