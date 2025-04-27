import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nutrirobo/target_health/model/physical_info.dart';
import 'package:nutrirobo/target_health/page/coru_target.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DetailMyTargetPage extends StatefulWidget {
  final String username;

  DetailMyTargetPage({
    super.key,
    required this.username,
  });

  @override
  State<DetailMyTargetPage> createState() =>
      _DetailMyTargetState(username: username);
}

class _DetailMyTargetState extends State<DetailMyTargetPage> {
  _DetailMyTargetState({required this.username});
  final String username;
  late String weight;
  late String height;
  late String age;
  late String gender;
  late String calories;
  late String sleep;
  late String exercise;
  late String date;

  //late Future<PhysicalInfo> futureProfile;

  Future<List<PhysicalInfo>> fetchTarget(String username) async {
    var url = Uri.parse(
        'https://nutrirobo.up.railway.app/target_profile/flutter/target/$username');
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
    List<PhysicalInfo> listTarget = [];
    for (var d in data) {
      if (d != null) {
        listTarget.add(PhysicalInfo.fromJson(d));
      }
    }

    return listTarget;
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
            const Text("Target Health"),
            const Text("   "),
            Icon(Icons.health_and_safety_outlined),
          ],
        ), //
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: fetchTarget(username),
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
                          "$username belum mendaftarkan target health",
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
                return Column(children: <Widget>[
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
                        ])),
                      ])),
                  const SizedBox(height: 20),
                  Text("Weight"),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ini warna msh blm di setting
                            child: Text(
                                // snapshot.data!.fields.weight.toString() +
                                '${snapshot.data![0].fields.weight}' + " kg"),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 1.0, color: Colors.indigo.shade600)),
                      )),
                  const SizedBox(height: 12),
                  Text("Height"),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ini warna msh blm di setting
                            child: Text(
                                // snapshot.data!.fields.height.toString() +
                                '${snapshot.data![0].fields.height}' + " cm"),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 1.0, color: Colors.indigo.shade600)),
                      )),
                  const SizedBox(height: 12),
                  Text("Age"),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ini warna msh blm di setting
                            child: Text(
                                // snapshot.data!.fields.age.toString() +
                                '${snapshot.data![0].fields.age}' + " years"),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 1.0, color: Colors.indigo.shade600)),
                      )),
                  const SizedBox(height: 12),
                  Text("Gender"),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              // ini warna msh blm di setting
                              child: Row(children: [
                                // if (snapshot.data!.fields.gender
                                //         .toString() ==
                                if ('${snapshot.data![0].fields.gender}' == "m")
                                  const Text("Male")
                                else
                                  const Text("Female"),
                              ])
                              //Text(widget.gender + ),
                              ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 1.0, color: Colors.indigo.shade600)),
                      )),
                  const SizedBox(height: 12),
                  Text("Calories"),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ini warna msh blm di setting
                            child: Text(
                                // snapshot.data!.fields.calories.toString() +
                                '${snapshot.data![0].fields.calories}' +
                                    " kal/day"),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 1.0, color: Colors.indigo.shade600)),
                      )),
                  const SizedBox(height: 12),
                  Text("Water"),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ini warna msh blm di setting
                            child: Text(
                                //snapshot.data!.fields.water.toString() +
                                '${snapshot.data![0].fields.water}' +
                                    " ml/day"),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 1.0, color: Colors.indigo.shade600)),
                      )),
                  const SizedBox(height: 12),
                  Text("Exercise"),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ini warna msh blm di setting
                            child: Text(
                                //snapshot.data!.fields.exercise.toString() +
                                '${snapshot.data![0].fields.exercise}' +
                                    " minutes/day"),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 1.0, color: Colors.indigo.shade600)),
                      )),
                  const SizedBox(height: 12),
                  Text("Sleep Time"),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ini warna msh blm di setting
                            child: Text('${snapshot.data![0].fields.sleep}' +
                                " hours/day"),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 1.0, color: Colors.indigo.shade600)),
                      )),
                  const SizedBox(height: 16),
                ]);
              }
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CoruTargetPage()));
        },
        label: const Text('Update Target Health'),
        icon: const Icon(Icons.health_and_safety_outlined),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
