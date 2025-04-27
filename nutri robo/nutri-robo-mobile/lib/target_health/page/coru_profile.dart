// import 'dart:convert';
// import 'package:/nutrirobo/target_health/model/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:';
// import 'package:http/http.dart' as http;
// //import 'package:pbp_django_auth/pbp_django_auth.dart';

// //import 'package:shared_preferences/shared_preferences.dart';

// Future<Profile> fetchProfile(String username) async {
//   final response = await http.get(Uri.parse(username)); // ini msh blm bener

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Profile.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load Profile');
//   }
// }

// class EditProfile extends StatefulWidget {
//   final String name;
//   final String email;
//   const EditProfile({
//     Key? key,
//     required this.name,
//     required this.email,
//   }) : super(key: key);
//   @override
//   _EditProfileState createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   late String _phone;
//   late String _role;

//   late String name;
//   late String email;
//   late Future<Profile> futureProfile;
//   late RestorableDateTime _selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     name = widget.name;
//     email = widget.email;
//     futureProfile = fetchProfile(name).then((value) {
//       _phone = value.fields.phone;
//       _role = value.fields.role;
//       return value;
//     });
//   }

//   Widget _buildBio(String initVal) {
//     return TextFormField(
//       initialValue: initVal,
//       decoration: new InputDecoration(
//         hintText: "contoh: Hai! saya suka kucing",
//         labelText: "Role diri",
//         border:
//             OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
//       ),
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Role tidak boleh kosong';
//         }
//         return null;
//       },
//       onChanged: (x) {
//         setState(() {
//           _role = x;
//         });
//       },
//     );
//   }

//   // void _selectDate(DateTime? newSelectedDate) {
//   //   if (newSelectedDate != null) {
//   //     setState(() {
//   //       _selectedDate.value = newSelectedDate;
//   //       _birthday = newSelectedDate;
//   //     });
//   //   }
//   // }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           title: Text("Profile"),
//           centerTitle: true,
//         ),
//         body: FutureBuilder<Profile>(
//             future: futureProfile,
//             builder: (context, AsyncSnapshot<Profile> snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 default:
//                   if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     return Form(
//                       child: SingleChildScrollView(
//                         child: Container(
//                           padding: EdgeInsets.all(20.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 "Edit Your Profile",
//                                 style: TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child:
//                                       _buildBio(snapshot.data!.fields.phone)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//               }
//             }));
//   }
// }

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoruProfilePage extends StatefulWidget {
  const CoruProfilePage({super.key});

  @override
  State<CoruProfilePage> createState() => _CoruProfilePageState();
}

class _CoruProfilePageState extends State<CoruProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String phone = "";
  String email = "";
  String role = "User";
  List<String> listRole = ['User', 'Instructor'];

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
                                decoration: InputDecoration(
                                  hintText: "Example: Bastian",
                                  labelText: "Name",
                                  // Menambahkan icon agar lebih intuitif
                                  icon: const Icon(Icons.people),
                                  // Menambahkan circular border agar lebih rapi
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                // Menambahkan behavior saat nama diketik
                                onChanged: (String? value) {
                                  setState(() {
                                    name = value!;
                                  });
                                },
                                // Menambahkan behavior saat data disimpan
                                onSaved: (String? value) {
                                  setState(() {
                                    name = value!;
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
                                  hintText: "Example: 081000000",
                                  labelText: "Phone",
                                  // Menambahkan icon agar lebih intuitif
                                  icon: const Icon(Icons.local_phone),
                                  // Menambahkan circular border agar lebih rapi
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                // Menambahkan behavior saat nama diketik
                                onChanged: (String? value) {
                                  setState(() {
                                    phone = value!;
                                  });
                                },
                                // Menambahkan behavior saat data disimpan
                                onSaved: (String? value) {
                                  setState(() {
                                    phone = value!;
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
                                decoration: InputDecoration(
                                  hintText: "Example: bastian@gmail.com",
                                  labelText: "Email",
                                  // Menambahkan icon agar lebih intuitif
                                  icon: const Icon(Icons.email_outlined),
                                  // Menambahkan circular border agar lebih rapi
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                // Menambahkan behavior saat nama diketik
                                onChanged: (String? value) {
                                  setState(() {
                                    email = value!;
                                  });
                                },
                                // Menambahkan behavior saat data disimpan
                                onSaved: (String? value) {
                                  setState(() {
                                    email = value!;
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
                              leading: const Icon(Icons.people_alt_outlined),
                              title: const Text(
                                'Role',
                              ),
                              trailing: DropdownButton(
                                value: role.isNotEmpty ? role : null,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: listRole.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    if (newValue == "User") {
                                      role = listRole[0];
                                    } else {
                                      role = listRole[1];
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
                                        "https://nutrirobo.up.railway.app/target_profile/flutter/update/profile/",
                                        {
                                          "name": name,
                                          "phone": phone,
                                          "email": email,
                                          "role": role,
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
    title: const Text("Failed to update profile!"),
    content: const Text("Invalid input!"),
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
    title: const Text("profile updated successfully!"),
    content: const Text("You will be redirected to your profile information"),
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
