import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddFeedbackPage extends StatefulWidget {
  const AddFeedbackPage({super.key});

  @override
  State<AddFeedbackPage> createState() => _AddFeedbackPageState();
}

class _AddFeedbackPageState extends State<AddFeedbackPage> {
  final _formKey = GlobalKey<FormState>();

  String rating = "";
  String feedback = "";
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                  child: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                        child: Center(
                          child: Text(
                            "Add Feedback",
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(38, 70, 85, 1)),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30.0),
                        child: Divider(
                          color:
                              Color.fromRGBO(38, 70, 85, 1), //color of divider
                          height: 1, //height spacing of divider
                          thickness: 2, //thickness of divier line
                          indent: 140, //spacing at the start of divider
                          endIndent: 140, //spacing at the end of divider
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Rating",
                            icon: const Icon(Icons.thumbs_up_down_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              rating = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              rating = value!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Rating tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Divider(
                          color:
                              Color.fromRGBO(38, 70, 85, 1), //color of divider
                          height: 1, //height spacing of divider
                          thickness: 1, //thickness of divier line
                          indent: 25, //spacing at the start of divider
                          endIndent: 25, //spacing at the end of divider
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Feedback",
                            icon: const Icon(Icons.mail),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              feedback = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              feedback = value!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Feedback tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 40.0),
                        child: Divider(
                          color:
                              Color.fromRGBO(38, 70, 85, 1), //color of divider
                          height: 1, //height spacing of divider
                          thickness: 1, //thickness of divier line
                          indent: 25, //spacing at the start of divider
                          endIndent: 25, //spacing at the end of divider
                        ),
                      ),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await request.post(
                                  "https://nutrirobo.up.railway.app/auth/addfeedback/",
                                  {
                                    "rating": rating,
                                    "feedback": feedback,
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
                            "Add Feedback",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ))),
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
    title: const Text("Failed to add feedback!"),
    content: const Text("Invalid input for rating or feedback message"),
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
    title: const Text("Feedback added successfully!"),
    content: const Text("You will be redirected to your feedback list"),
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
