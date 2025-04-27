import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nutrirobo/target_health/model/profile.dart';
import 'package:nutrirobo/target_health/page/coru_profile.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DetailMyProfilePage extends StatefulWidget {
  final String username;

  DetailMyProfilePage({
    super.key,
    required this.username,
  });

  @override
  State<DetailMyProfilePage> createState() =>
      _DetailMyProfileState(username: username);
}

class _DetailMyProfileState extends State<DetailMyProfilePage> {
  _DetailMyProfileState({required this.username});
  final String username;
  late String name;
  late String phone;
  late String email;
  late String role;

  Future<List<Profile>> fetchProfile(String username) async {
    var url = Uri.parse(
        'https://nutrirobo.up.railway.app/target_profile/flutter/profile/$username');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object ToDo
    List<Profile> listProfile = [];
    for (var d in data) {
      if (d != null) {
        listProfile.add(Profile.fromJson(d));
      }
    }

    return listProfile;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final request = context.watch<CookieRequest>();
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
            const Text("User Profile"),
            const Text("   "),
            Icon(Icons.account_circle_outlined),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: fetchProfile(username),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Color.fromRGBO(38, 70, 85, 1),
                )),
              );
              // } else {
            } else {
              if (snapshot.data.length == 0) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 275.0),
                      child: Center(
                        child: Text(
                          "$username belum mendaftarkan profile",
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
                return Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      Center(
                          child: Row(children: [
                        Text(
                          widget.username,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        if ('${snapshot.data![0].fields.role}' == "2")
                          Row(children: [
                            Text("   "),
                            Icon(
                              Icons.verified_outlined,
                              color: Colors.blue[800],
                            )
                          ])
                      ])),
                      const SizedBox(height: 12),
                      Row(children: [
                        const Text(
                          "Name ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${snapshot.data![0].fields.name}'),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        const Text("Phone ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${snapshot.data![0].fields.phone}'),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        const Text("Email ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${snapshot.data![0].fields.email}'),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        const Text("Role ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        if ('${snapshot.data![0].fields.role}' == "1")
                          const Text("User")
                        else
                          const Text("Instructor"),
                      ]),
                    ]),
                  ),
                ]);
              }
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CoruProfilePage()));
        },
        label: const Text('Update Profile'),
        icon: const Icon(Icons.people_alt_outlined),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
