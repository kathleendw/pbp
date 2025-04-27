import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nutrirobo/drawer.dart';
import 'package:nutrirobo/landingPage/util/fetchFeedbackItems.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'feedbackUser.dart';

final List<String> imgList = [
  'assets/nutriroboImage.jpg',
  'assets/trackerImage.jpg',
  'assets/targetHealthImage.jpg',
  'assets/blogImage.jpg',
  'assets/faqImage.jpg'
];

final List<String> carouselCaption = [
  'Nutri-robo',
  'Tracker',
  'Target Health',
  'Blog',
  'FAQ'
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.username});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  final String username;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() => _MyHomePageState(username: username);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({required this.username});
  final String username;
  int _current = 0;
  bool _visibility = false;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    if (request.loggedIn) {
      _visibility = true;
    } else {
      _visibility = false;
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Row(
            children: [
              Image.asset(
                'assets/logo.jpg',
                height: 70,
                width: 150,
              ),
            ],
          ),
        ),
        endDrawer: const MyDrawer(),
        body: ListView(children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: Color.fromRGBO(38, 70, 85, 1), //color of divider
              height: 5, //height spacing of divider
              thickness: 3, //thickness of divier line
              indent: 25, //spacing at the start of divider
              endIndent: 25, //spacing at the end of divider
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(color: Colors.white, blurRadius: 2.0)
                ]),
            child: Center(
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset('assets/introduction.jpg', fit: BoxFit.cover),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(),
                      ),
                    ],
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Our Reviews",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(38, 70, 85, 1),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Aubrey'),
                      ))),
              Visibility(
                  visible: _visibility,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackUserPage(
                                    username: username,
                                  )),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                      ),
                      child: const Text(
                        "See your review",
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          FutureBuilder(
              future: fetchFeedback(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Color.fromRGBO(38, 70, 85, 1),
                    )),
                  );
                } else {
                  if (snapshot.data.length == 0) {
                    return Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0),
                          child: Center(
                            child: Text(
                              "Belum ada feedback ditambahkan",
                              style: TextStyle(
                                  color: Color.fromRGBO(38, 70, 85, 1),
                                  fontSize: 20,
                                  fontFamily: 'Aubrey'),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage('assets/cardImage.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(38, 70, 85, 1),
                                        blurRadius: 2.0)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rating: ${snapshot.data![index].fields.rating} / 10",
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(38, 70, 85, 1)),
                                  ),
                                  Text(
                                    snapshot.data![index].fields.date
                                        .toString()
                                        .substring(0, 10),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Feedback:",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(38, 70, 85, 1)),
                                  ),
                                  Text(
                                    "${snapshot.data![index].fields.feedback}",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  }
                }
              })
        ]));
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(),
                  ),
                ],
              )),
        ))
    .toList();
