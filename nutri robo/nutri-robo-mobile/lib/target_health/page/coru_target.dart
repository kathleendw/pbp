import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoruTargetPage extends StatefulWidget {
  const CoruTargetPage({super.key});

  @override
  State<CoruTargetPage> createState() => _CoruTargetPageState();
}

class _CoruTargetPageState extends State<CoruTargetPage> {
  final _formKey = GlobalKey<FormState>();

  String weight = "";
  String height = "";
  String age = "";
  String gender = "Male";
  List<String> listGender = ['Male', 'Female'];
  String calories = "";
  String water = "";
  String exercise = "";
  String sleep = "";
  //String height = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // The rest of your widgets are down below
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
        body: ListView(children: [
          Container(
              margin: const EdgeInsets.only(top: 60, left: 25, right: 25),
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              // Menggunakan padding sebesar 8 pixels
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Example: 55",
                                  labelText: "Weight",

                                  // Menambahkan circular border agar lebih rapi
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                // Menambahkan behavior saat nama diketik
                                onChanged: (String? value) {
                                  setState(() {
                                    weight = value!;
                                  });
                                },
                                // Menambahkan behavior saat data disimpan
                                onSaved: (String? value) {
                                  setState(() {
                                    weight = value!;
                                  });
                                },
                                // Validator sebagai validasi form
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              // Menggunakan padding sebesar 8 pixels
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Example: 170",
                                  labelText: "Height",

                                  // Menambahkan circular border agar lebih rapi
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                // Menambahkan behavior saat nama diketik
                                onChanged: (String? value) {
                                  setState(() {
                                    height = value!;
                                  });
                                },
                                // Menambahkan behavior saat data disimpan
                                onSaved: (String? value) {
                                  setState(() {
                                    height = value!;
                                  });
                                },
                                // Validator sebagai validasi form
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              // Menggunakan padding sebesar 8 pixels
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Example: 20",
                                  labelText: "Age",

                                  // Menambahkan circular border agar lebih rapi
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                // Menambahkan behavior saat nama diketik
                                onChanged: (String? value) {
                                  setState(() {
                                    age = value!;
                                  });
                                },
                                // Menambahkan behavior saat data disimpan
                                onSaved: (String? value) {
                                  setState(() {
                                    age = value!;
                                  });
                                },
                                // Validator sebagai validasi form
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                'Gender',
                              ),
                              trailing: DropdownButton(
                                value: gender.isNotEmpty ? gender : null,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: listGender.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    if (newValue == "Male") {
                                      gender = listGender[0];
                                    } else {
                                      gender = listGender[1];
                                    }
                                    // role = newValue!;
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final response = await request.post(
                                        "https://nutrirobo.up.railway.app/target_profile/flutter/update/target/",
                                        {
                                          "weight": weight,
                                          "height": height,
                                          "gender": gender,
                                          "age": age,
                                        });
                                    if (!response['status']) {
                                      // ignore: use_build_context_synchronously
                                      showAlertDialogFailed(context);
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      showAlertDialogSuccess(context);
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        const Color.fromARGB(255, 15, 81, 135)),
                                child: const Text(
                                  "SAVE",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ))),
              ))
        ]));
  }
}

showAlertDialogFailed(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Try Again"),
    onPressed: () {
      Navigator.pop(
        context,
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Failed to update target!"),
    content: const Text("Invalid input"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogSuccess(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Close"),
    onPressed: () {
      Navigator.pop(
        context,
      );
      Navigator.pop(
        context,
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Target added successfully!"),
    content: const Text("You will be redirected to your target health"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
