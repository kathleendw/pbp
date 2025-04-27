import 'package:flutter/material.dart';
//import 'package:pbp_django_auth/pbp_django_auth.dart';
//import 'package:provider/provider.dart';
import '../util/fetchFeedbackUser.dart';
import 'addFeedback.dart';
import 'package:http/http.dart' as http;

class FeedbackUserPage extends StatefulWidget {
  const FeedbackUserPage({super.key, required this.username});

  final String username;

  @override
  State<FeedbackUserPage> createState() =>
      // ignore: no_logic_in_create_state
      _FeedbackUserPageState(username: username);
}

class _FeedbackUserPageState extends State<FeedbackUserPage> {
  _FeedbackUserPageState({required this.username});
  final String username;
  @override
  Widget build(BuildContext context) {
    //final request = context.watch<CookieRequest>();
    // The rest of your widgets are down below
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
      body: FutureBuilder(
          future: fetchFeedbackUser(username),
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
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 275.0),
                      child: Center(
                        child: Text(
                          "$username belum menambahkan feedback",
                          style: const TextStyle(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rating: ${snapshot.data![index].fields.rating} / 10",
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(38, 70, 85, 1)),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // ignore: unused_local_variable
                                      final response = await http.get(Uri.parse(
                                          "https://nutrirobo.up.railway.app/delete-task/${snapshot.data![index].pk}"));
                                    },
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.red),
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )
                                ],
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
                              )
                            ],
                          ),
                        ));
              }
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFeedbackPage()));
        },
        label: const Text('Add Feedback'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
