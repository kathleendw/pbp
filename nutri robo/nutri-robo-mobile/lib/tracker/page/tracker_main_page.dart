import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'fetch_calorie_tracker.dart';
import 'fetch_sleep_tracker.dart';
import 'fetch_exercise_tracker.dart';
import 'fetch_water_tracker.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

final List<String> imgList = [
  'assets/calorie.jpg',
  'assets/exercise.jpg',
  'assets/sleep.jpg',
  'assets/water.jpg'
];

class MyTrackerPage extends StatefulWidget {
  const MyTrackerPage({Key? key}) : super(key: key);

  @override
  State<MyTrackerPage> createState() => _MyTrackerPageState();
}

class _MyTrackerPageState extends State<MyTrackerPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  String date = DateFormat("EEEEE, dd MMM yyyy").format(DateTime.now());
  String time = DateFormat("HH:mm").format(DateTime.now());
  late final Future myFutureCalorie;
  late final Future myFutureSleep;
  late final Future myFutureExercise;
  late final Future myFutureWater;

  String calorie = "";
  bool calorieIsValid = true;
  String descriptionCalorie = "";
  final _formKeyCalorie = GlobalKey<FormState>();

  String exercise = "";
  bool exerciseIsValid = true;
  String descriptionExercise = "";
  final _formKeyExercise = GlobalKey<FormState>();

  String water = "";
  bool waterIsValid = true;
  String descriptionWater = "";
  final _formKeyWater = GlobalKey<FormState>();

  TextEditingController bedTime = TextEditingController();
  TextEditingController wakeUp = TextEditingController();
  String descriptionSleep = "";
  final _formKeySleep = GlobalKey<FormState>();

  int totalSleepHours = 0;
  int totalSleepMinutes = 0;
  int totalExercise = 0;
  int totalWater = 0;

  countTotalExercise(int exercise) {
    totalExercise += exercise;
    return totalExercise.toString();
  }

  countTotalSleepHours(int sleepHours) {
    totalSleepHours += sleepHours;
    return totalSleepHours.toString();
  }

  countTotalSleepMinutes(int sleepMinutes) {
    totalSleepMinutes += sleepMinutes;
    return totalSleepMinutes.toString();
  }

  countTotalWater(int water) {
    totalWater += water;
    return totalWater.toString();
  }

  void addCalorie(request, calorie, description, date, time) async {
    await request.post('https://nutrirobo.up.railway.app/tracker/calorief/', {
      "calorie": calorie,
      "description": description,
      "date": date,
      "time": time
    });
  }

  void addSleep(
      request, sleepHours, sleepMinutes, description, date, time) async {
    await request.post('https://nutrirobo.up.railway.app/tracker/sleepf/', {
      "sleephours": sleepHours,
      "sleepminutes": sleepMinutes,
      "description": description,
      "date": date,
      "time": time
    });
  }

  void addExercise(request, exercise, description, date, time) async {
    await request.post('https://nutrirobo.up.railway.app/tracker/exercisef/', {
      "exercise": exercise,
      "description": description,
      "date": date,
      "time": time
    });
  }

  void addWater(request, water, description, date, time) async {
    await request.post('https://nutrirobo.up.railway.app/tracker/waterf/', {
      "water": water,
      "description": description,
      "date": date,
      "time": time
    });
  }

  countSleepHours(TextEditingController bedTime, TextEditingController wakeUp) {
    var arrBedTime = bedTime.text.split(':');
    int a = int.parse(arrBedTime[0]);
    int b = int.parse(arrBedTime[1]);
    var arrWakeUp = wakeUp.text.split(':');
    int x = int.parse(arrWakeUp[0]);
    int y = int.parse(arrWakeUp[1]);
    int j = (x * 60) + y;
    int k = (a * 60) + b;
    int z = j - k;
    int i = 0;
    int hours = 0;
    if (z < 0) {
      i = 1440 + z;
      hours = (i / 60) as int;
    } else {
      hours = (z / 60) as int;
    }
    return hours.toString();
  }

  countSleepMinutes(
      TextEditingController bedTime, TextEditingController wakeUp) {
    var arrBedTime = bedTime.text.split(':');
    int a = int.parse(arrBedTime[0]);
    int b = int.parse(arrBedTime[1]);
    var arrWakeUp = wakeUp.text.split(':');
    int x = int.parse(arrWakeUp[0]);
    int y = int.parse(arrWakeUp[1]);
    int j = (x * 60) + y;
    int k = (a * 60) + b;
    int z = j - k;
    int i = 0;
    int minutes = 0;
    if (z < 0) {
      i = 1440 + z;
      minutes = (i % 60);
    } else {
      minutes = (z % 60);
    }
    return minutes.toString();
  }

  void deleteCalorie(request, id) async {
    String pk = id.toString();
    await request.post(
        'https://nutrirobo.up.railway.app/tracker/delete-calorief/',
        {"id": pk});
  }

  void deleteSleep(request, id) async {
    String pk = id.toString();
    await request.post(
        'https://nutrirobo.up.railway.app/tracker/delete-sleepf/', {"id": pk});
  }

  void deleteExercise(request, id) async {
    String pk = id.toString();
    await request.post(
        'https://nutrirobo.up.railway.app/tracker/delete-exercisef/',
        {"id": pk});
  }

  void deleteWater(request, id) async {
    String pk = id.toString();
    await request.post(
        'https://nutrirobo.up.railway.app/tracker/delete-waterf/', {"id": pk});
  }

  @override
  void initState() {
    myFutureCalorie = fetchCalorieTracker();
    myFutureExercise = fetchExerciseTracker();
    myFutureSleep = fetchSleepTracker();
    myFutureWater = fetchWaterTracker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    final request = context.watch<CookieRequest>();

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
            const Spacer(),
            Text(date, style: const TextStyle(fontFamily: 'Poppins')),
          ],
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Center(
              child: Text(
                "Let's track your health, shall we?",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 350, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5), blurRadius: 8.0),
              ],
            ),
            child: Column(
              children: [
                CarouselSlider(
                  items: [
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: const DecorationImage(
                            image: AssetImage('assets/calorie.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 15,
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 250),
                              child: Form(
                                key: _formKeyCalorie,
                                child: Container(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 35, left: 20, bottom: 20),
                                            child: Text(
                                              'Calorie',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins'),
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.clear),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText:
                                                "Calories consumed in kkal",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (String value) {
                                            final v = int.tryParse(value);
                                            if (v == null) {
                                              setState(() {
                                                calorieIsValid = false;
                                              });
                                            } else {
                                              setState(() {
                                                calorieIsValid = true;
                                                calorie = value;
                                              });
                                            }
                                          },
                                          onSaved: (String? value) {
                                            setState(() {
                                              calorie = value!;
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please fill in the calories consumed.';
                                            } else if (calorieIsValid ==
                                                false) {
                                              return 'Invalid input. Please try again.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: "Description",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              descriptionCalorie = value!;
                                            });
                                          },
                                          onSaved: (String? value) {
                                            setState(() {
                                              descriptionCalorie = value!;
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please fill in the description.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            foregroundColor: Colors.black,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    219, 232, 246, 1.0),
                                            shape: const StadiumBorder()),
                                        onPressed: () {
                                          if (_formKeyCalorie.currentState!
                                              .validate()) {
                                            addCalorie(request, calorie,
                                                descriptionCalorie, date, time);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  elevation: 15,
                                                  child: Container(
                                                    child: ListView(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              bottom: 20),
                                                      shrinkWrap: true,
                                                      children: <Widget>[
                                                        const Center(
                                                          child: Text(
                                                              'Successfully added calories consumed!'),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MyTrackerPage()),
                                                            );
                                                          },
                                                          child: const Text(
                                                              'Back'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: const Text('Add',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Poppins')),
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: const DecorationImage(
                            image: AssetImage('assets/exercise.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 15,
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 250),
                              child: Form(
                                key: _formKeyExercise,
                                child: Container(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 35, left: 20, bottom: 20),
                                            child: Text(
                                              'Exercise',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.clear),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText:
                                                "Calories burned in kkal",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (String value) {
                                            final v = int.tryParse(value);
                                            if (v == null) {
                                              setState(() {
                                                exerciseIsValid = false;
                                              });
                                            } else {
                                              setState(() {
                                                exerciseIsValid = true;
                                                exercise = value;
                                              });
                                            }
                                          },
                                          onSaved: (String? value) {
                                            setState(() {
                                              exercise = value!;
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please fill in the calories burned.';
                                            } else if (exerciseIsValid ==
                                                false) {
                                              return 'Invalid input. Please try again.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: "Description",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              descriptionExercise = value!;
                                            });
                                          },
                                          onSaved: (String? value) {
                                            setState(() {
                                              descriptionExercise = value!;
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please fill in the description.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            foregroundColor: Colors.black,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    219, 232, 246, 1.0),
                                            shape: const StadiumBorder()),
                                        onPressed: () {
                                          if (_formKeyExercise.currentState!
                                              .validate()) {
                                            addExercise(
                                                request,
                                                exercise,
                                                descriptionExercise,
                                                date,
                                                time);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  elevation: 15,
                                                  child: Container(
                                                    child: ListView(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              bottom: 20),
                                                      shrinkWrap: true,
                                                      children: <Widget>[
                                                        const Center(
                                                          child: Text(
                                                              'Successfully added calories burned!'),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MyTrackerPage()),
                                                            );
                                                          },
                                                          child: const Text(
                                                              'Back'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: const Text('Add',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Poppins')),
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: const DecorationImage(
                            image: AssetImage('assets/sleep.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 15,
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 250),
                              child: Form(
                                key: _formKeySleep,
                                child: Container(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 35, left: 20, bottom: 20),
                                            child: Text(
                                              'Sleep',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins'),
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.clear),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: TextFormField(
                                          controller: bedTime,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.bedtime),
                                            labelText: "Enter Bed Time",
                                          ),
                                          readOnly: true,
                                          onTap: () async {
                                            TimeOfDay? userBedTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if (userBedTime != null) {
                                              DateTime parsedBedTime =
                                                  DateFormat.jm().parse(
                                                      // ignore: use_build_context_synchronously
                                                      userBedTime
                                                          .format(context)
                                                          .toString());
                                              String formattedBedTime =
                                                  DateFormat('HH:mm')
                                                      .format(parsedBedTime);
                                              setState(() {
                                                bedTime.text = formattedBedTime;
                                              });
                                            }
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your bed time.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: TextFormField(
                                          controller: wakeUp,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.sunny),
                                            labelText: "Enter Wake-Up Time",
                                          ),
                                          readOnly: true,
                                          onTap: () async {
                                            TimeOfDay? userWakeUpTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if (userWakeUpTime != null) {
                                              DateTime parsedWakeUpTime =
                                                  DateFormat.jm().parse(
                                                      // ignore: use_build_context_synchronously
                                                      userWakeUpTime
                                                          .format(context)
                                                          .toString());
                                              String formattedWakeUpTime =
                                                  DateFormat('HH:mm')
                                                      .format(parsedWakeUpTime);
                                              setState(() {
                                                wakeUp.text =
                                                    formattedWakeUpTime;
                                              });
                                            }
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your wake-up time.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: "Description",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              descriptionExercise = value!;
                                            });
                                          },
                                          onSaved: (String? value) {
                                            setState(() {
                                              descriptionExercise = value!;
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please fill in the description.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            foregroundColor: Colors.black,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    219, 232, 246, 1.0),
                                            shape: const StadiumBorder()),
                                        onPressed: () {
                                          if (_formKeySleep.currentState!
                                              .validate()) {
                                            addSleep(
                                                request,
                                                countSleepHours(
                                                    bedTime, wakeUp),
                                                countSleepMinutes(
                                                    bedTime, wakeUp),
                                                descriptionSleep,
                                                date,
                                                time);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  elevation: 15,
                                                  child: Container(
                                                    child: ListView(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              bottom: 20),
                                                      shrinkWrap: true,
                                                      children: <Widget>[
                                                        const Center(
                                                          child: Text(
                                                              'Successfully added amount of sleep!'),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MyTrackerPage()),
                                                            );
                                                          },
                                                          child: const Text(
                                                              'Back'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: const Text('Add',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Poppins')),
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: const DecorationImage(
                            image: AssetImage('assets/water.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 15,
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 250),
                              child: Form(
                                key: _formKeyWater,
                                child: Container(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 35, left: 20, bottom: 20),
                                            child: Text(
                                              'Water',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins'),
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.clear),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: "Water intake in ml",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (String value) {
                                            final v = int.tryParse(value);
                                            if (v == null) {
                                              setState(() {
                                                waterIsValid = false;
                                              });
                                            } else {
                                              setState(() {
                                                waterIsValid = true;
                                                water = value;
                                              });
                                            }
                                          },
                                          onSaved: (String? value) {
                                            setState(() {
                                              water = value!;
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please fill in the water intake.';
                                            } else if (waterIsValid == false) {
                                              return 'Invalid input. Please try again.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: "Description",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              descriptionWater = value!;
                                            });
                                          },
                                          onSaved: (String? value) {
                                            setState(() {
                                              descriptionWater = value!;
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please fill in the description.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            foregroundColor: Colors.black,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    219, 232, 246, 1.0),
                                            shape: const StadiumBorder()),
                                        onPressed: () {
                                          if (_formKeyWater.currentState!
                                              .validate()) {
                                            addWater(request, water,
                                                descriptionWater, date, time);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  elevation: 15,
                                                  child: Container(
                                                    child: ListView(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              bottom: 20),
                                                      shrinkWrap: true,
                                                      children: <Widget>[
                                                        const Center(
                                                          child: Text(
                                                              'Successfully added water consumed!'),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MyTrackerPage()),
                                                            );
                                                          },
                                                          child: const Text(
                                                              'Back'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: const Text('Add',
                                            style: TextStyle(fontSize: 16)),
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                  carouselController: _controller,
                  options: CarouselOptions(
                      enableInfiniteScroll: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
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
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: myFutureCalorie,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Row(
                  children: [
                    Container(
                      height: deviceHeight * 0.50,
                      width: deviceWidth * 0.35,
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 40, left: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 8.0),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/countCalorie.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    Container(
                      height: deviceHeight * 0.50,
                      width: deviceWidth * 0.65,
                      color: Colors.transparent,
                      padding:
                          const EdgeInsets.only(left: 30, top: 40, right: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 8.0),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/cardImage.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                );
              } else {
                if (snapshot.data.length == 0) {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countCalorie.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 220.0),
                              child: Text(
                                "0 kkal",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "You haven't consumed any calories",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.data.length == 1) {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countCalorie.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 220.0),
                              child: Text(
                                "${fetchTotalCalorie()} kkal",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
                              padding: const EdgeInsets.only(top: 80.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                child: Column(
                                  children: [
                                    Text(
                                      "${snapshot.data![index].fields.calorie} kkal",
                                      style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "${snapshot.data![index].fields.description}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        foregroundColor: Colors.black,
                                        backgroundColor: const Color.fromRGBO(
                                            219, 232, 246, 1.0),
                                        shape: const StadiumBorder(),
                                      ),
                                      onPressed: () {
                                        deleteCalorie(
                                            request, snapshot.data![index].pk);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 15,
                                              child: Container(
                                                child: ListView(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 20),
                                                  shrinkWrap: true,
                                                  children: <Widget>[
                                                    const Center(
                                                      child: Text(
                                                          'Successfully deleted calories consumed.'),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const MyTrackerPage()),
                                                        );
                                                      },
                                                      child: const Text('Back'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(height: 60),
                                    const Divider(
                                      color: Color.fromRGBO(38, 70, 85, 1),
                                      height: 3,
                                      thickness: 3,
                                      indent: 100,
                                      endIndent: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countCalorie.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 220.0),
                              child: Text(
                                "${fetchTotalCalorie()} kkal",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => CarouselSlider(
                              items: [
                                Container(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${snapshot.data![index].fields.calorie} kkal",
                                          style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          "${snapshot.data![index].fields.description}",
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            foregroundColor: Colors.black,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    219, 232, 246, 1.0),
                                            shape: const StadiumBorder(),
                                          ),
                                          onPressed: () {
                                            deleteCalorie(request,
                                                snapshot.data![index].pk);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  elevation: 15,
                                                  child: Container(
                                                    child: ListView(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              bottom: 20),
                                                      shrinkWrap: true,
                                                      children: <Widget>[
                                                        const Center(
                                                          child: Text(
                                                              'Successfully deleted calories consumed.'),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MyTrackerPage()),
                                                            );
                                                          },
                                                          child: const Text(
                                                              'Back'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(height: 60),
                                        const Divider(
                                          color: Color.fromRGBO(38, 70, 85, 1),
                                          height: 3,
                                          thickness: 3,
                                          indent: 100,
                                          endIndent: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              carouselController: _controller,
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          ),
          FutureBuilder(
            future: myFutureExercise,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Row(
                  children: [
                    Container(
                      height: deviceHeight * 0.50,
                      width: deviceWidth * 0.35,
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 40, left: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 8.0),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/countExercise.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    Container(
                      height: deviceHeight * 0.50,
                      width: deviceWidth * 0.65,
                      color: Colors.transparent,
                      padding:
                          const EdgeInsets.only(left: 30, top: 40, right: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 8.0),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/cardImage.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                );
              } else {
                if (snapshot.data.length == 0) {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countExercise.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 220.0),
                              child: Text(
                                "0 kkal",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "You haven't burned any calories",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.data.length == 1) {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countExercise.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 220.0),
                              child: Text(
                                "${fetchTotalExercise()} kkal",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
                              padding: const EdgeInsets.only(top: 80.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                child: Column(
                                  children: [
                                    Text(
                                      "${snapshot.data![index].fields.exercise} kkal",
                                      style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "${snapshot.data![index].fields.description}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        foregroundColor: Colors.black,
                                        backgroundColor: const Color.fromRGBO(
                                            219, 232, 246, 1.0),
                                        shape: const StadiumBorder(),
                                      ),
                                      onPressed: () {
                                        deleteExercise(
                                            request, snapshot.data![index].pk);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 15,
                                              child: Container(
                                                child: ListView(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 20),
                                                  shrinkWrap: true,
                                                  children: <Widget>[
                                                    const Center(
                                                      child: Text(
                                                          'Successfully deleted calories burned.'),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const MyTrackerPage()),
                                                        );
                                                      },
                                                      child: const Text('Back'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(height: 60),
                                    const Divider(
                                      color: Color.fromRGBO(38, 70, 85, 1),
                                      height: 3,
                                      thickness: 3,
                                      indent: 100,
                                      endIndent: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countExercise.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 220.0),
                              child: Text(
                                "${fetchTotalExercise()} kkal",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => CarouselSlider(
                              items: [
                                Container(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${snapshot.data![index].fields.exercise} kkal",
                                          style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          "${snapshot.data![index].fields.description}",
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            foregroundColor: Colors.black,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    219, 232, 246, 1.0),
                                            shape: const StadiumBorder(),
                                          ),
                                          onPressed: () {
                                            deleteExercise(request,
                                                snapshot.data![index].pk);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  elevation: 15,
                                                  child: Container(
                                                    child: ListView(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              bottom: 20),
                                                      shrinkWrap: true,
                                                      children: <Widget>[
                                                        const Center(
                                                          child: Text(
                                                              'Successfully deleted calories burned.'),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MyTrackerPage()),
                                                            );
                                                          },
                                                          child: const Text(
                                                              'Back'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(height: 60),
                                        const Divider(
                                          color: Color.fromRGBO(38, 70, 85, 1),
                                          height: 3,
                                          thickness: 3,
                                          indent: 100,
                                          endIndent: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              carouselController: _controller,
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          ),
          FutureBuilder(
            future: myFutureSleep,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Row(
                  children: [
                    Container(
                      height: deviceHeight * 0.50,
                      width: deviceWidth * 0.35,
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 40, left: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 8.0),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/countSleep.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    Container(
                      height: deviceHeight * 0.50,
                      width: deviceWidth * 0.65,
                      color: Colors.transparent,
                      padding:
                          const EdgeInsets.only(left: 30, top: 40, right: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 8.0),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/cardImage.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                );
              } else {
                if (snapshot.data.length == 0) {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countSleep.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 220.0),
                              child: Text(
                                "0 hrs 0 mins",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "You haven't slept",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.data.length == 1) {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countSleep.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 220.0),
                              child: Text(
                                "${fetchTotalSleepHours()} hrs ${fetchTotalSleepMinutes()} mins",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
                              padding: const EdgeInsets.only(top: 80.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                child: Column(
                                  children: [
                                    Text(
                                      "${snapshot.data![index].fields.sleephours} hrs ${snapshot.data![index].fields.sleepminutes} mins",
                                      style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "${snapshot.data![index].fields.description}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        foregroundColor: Colors.black,
                                        backgroundColor: const Color.fromRGBO(
                                            219, 232, 246, 1.0),
                                        shape: const StadiumBorder(),
                                      ),
                                      onPressed: () {
                                        deleteSleep(
                                            request, snapshot.data![index].pk);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 15,
                                              child: Container(
                                                child: ListView(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 20),
                                                  shrinkWrap: true,
                                                  children: <Widget>[
                                                    const Center(
                                                      child: Text(
                                                          'Successfully deleted amount of sleep.'),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const MyTrackerPage()),
                                                        );
                                                      },
                                                      child: const Text('Back'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(height: 60),
                                    const Divider(
                                      color: Color.fromRGBO(38, 70, 85, 1),
                                      height: 3,
                                      thickness: 3,
                                      indent: 100,
                                      endIndent: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countSleep.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 220.0),
                              child: Text(
                                "${fetchTotalSleepHours()} hrs ${fetchTotalSleepMinutes()} mins",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => CarouselSlider(
                              items: [
                                Container(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${snapshot.data![index].fields.sleephours} hrs ${snapshot.data![index].fields.sleepminutes} mins",
                                          style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          "${snapshot.data![index].fields.description}",
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            foregroundColor: Colors.black,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    219, 232, 246, 1.0),
                                            shape: const StadiumBorder(),
                                          ),
                                          onPressed: () {
                                            deleteSleep(request,
                                                snapshot.data![index].pk);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  elevation: 15,
                                                  child: Container(
                                                    child: ListView(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              bottom: 20),
                                                      shrinkWrap: true,
                                                      children: <Widget>[
                                                        const Center(
                                                          child: Text(
                                                              'Successfully deleted amount of sleep.'),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MyTrackerPage()),
                                                            );
                                                          },
                                                          child: const Text(
                                                              'Back'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(height: 60),
                                        const Divider(
                                          color: Color.fromRGBO(38, 70, 85, 1),
                                          height: 3,
                                          thickness: 3,
                                          indent: 100,
                                          endIndent: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              carouselController: _controller,
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          ),
          FutureBuilder(
            future: myFutureWater,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Row(
                  children: [
                    Container(
                      height: deviceHeight * 0.50,
                      width: deviceWidth * 0.35,
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 40, left: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 8.0),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/countWater.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    Container(
                      height: deviceHeight * 0.50,
                      width: deviceWidth * 0.65,
                      color: Colors.transparent,
                      padding:
                          const EdgeInsets.only(left: 30, top: 40, right: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 8.0),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/cardImage.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                );
              } else {
                if (snapshot.data.length == 0) {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countWater.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 220.0),
                              child: Text(
                                "0 ml",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "You haven't consumed any water",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.data.length == 1) {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countWater.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 220.0),
                              child: Text(
                                "${fetchTotalWater()} ml",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
                              padding: const EdgeInsets.only(top: 80.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                child: Column(
                                  children: [
                                    Text(
                                      "${snapshot.data![index].fields.water} ml",
                                      style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "${snapshot.data![index].fields.description}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        foregroundColor: Colors.black,
                                        backgroundColor: const Color.fromRGBO(
                                            219, 232, 246, 1.0),
                                        shape: const StadiumBorder(),
                                      ),
                                      onPressed: () {
                                        deleteWater(
                                            request, snapshot.data![index].pk);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 15,
                                              child: Container(
                                                child: ListView(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 20),
                                                  shrinkWrap: true,
                                                  children: <Widget>[
                                                    const Center(
                                                      child: Text(
                                                          'Successfully deleted water consumed.'),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const MyTrackerPage()),
                                                        );
                                                      },
                                                      child: const Text('Back'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(height: 60),
                                    const Divider(
                                      color: Color.fromRGBO(38, 70, 85, 1),
                                      height: 3,
                                      thickness: 3,
                                      indent: 100,
                                      endIndent: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.35,
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 40, left: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/countWater.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 220.0),
                              child: Text(
                                "${fetchTotalWater()} ml",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.50,
                        width: deviceWidth * 0.65,
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 30, top: 40, right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8.0),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/cardImage.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => CarouselSlider(
                              items: [
                                Container(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${snapshot.data![index].fields.water} ml",
                                          style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          "${snapshot.data![index].fields.description}",
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            foregroundColor: Colors.black,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    219, 232, 246, 1.0),
                                            shape: const StadiumBorder(),
                                          ),
                                          onPressed: () {
                                            deleteWater(request,
                                                snapshot.data![index].pk);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  elevation: 15,
                                                  child: Container(
                                                    child: ListView(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              bottom: 20),
                                                      shrinkWrap: true,
                                                      children: <Widget>[
                                                        const Center(
                                                          child: Text(
                                                              'Successfully deleted water consumed.'),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MyTrackerPage()),
                                                            );
                                                          },
                                                          child: const Text(
                                                              'Back'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(height: 60),
                                        const Divider(
                                          color: Color.fromRGBO(38, 70, 85, 1),
                                          height: 3,
                                          thickness: 3,
                                          indent: 100,
                                          endIndent: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              carouselController: _controller,
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
