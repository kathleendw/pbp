import 'package:flutter/material.dart';
import 'package:nutrirobo/faq/model/faq_model.dart';

class MyfaqDetail extends StatelessWidget {
  // In the constructor, require a Todo.
  const MyfaqDetail({super.key, required this.myfaqData});

  // Declare a field that holds the Todo.
  final MyfaqData myfaqData;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('FAQ'),
      ),
      // drawer: MyDrawer(),
      body: Container(
        color: Colors.white,
        child: ListView(padding: new EdgeInsets.all(13.0), children: <Widget>[
          Container(
            child: Center(
              child: Text(
                myfaqData.fields.question,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Center(
              child: Text(
                myfaqData.fields.answer,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        

        ]),
      ),
      
    );
  }
}
