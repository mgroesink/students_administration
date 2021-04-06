import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:studentsadministration/student.dart';

import 'image_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROC van Twente',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Student> _students = [];
  // Fetch content from the json file
  Future<void> readJson(String klas) async {
    final String response =
        await rootBundle.loadString('assets/json/I9AO.json');
    final data = await json.decode(response);
    setState(() {
      data["items"].forEach((student) {
        if (klas == null || student["Klas"].toString().toLowerCase() ==
            klas.toLowerCase()) {
          _students.add(Student(student));
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ROC van Twente - I9AO',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            FlatButton(
              child: Text("Next page"),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudentImage())
                );
              },
            ),
            ElevatedButton(
              child: Text('Load Data'),
              onPressed: () async {
                await readJson(null);
              },
            ),

            // Display the data loaded from json
            // if there are students
            _students.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _students.length,
                      itemBuilder: (context, index) {
                        return FlatButton(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => StudentImage(url:
                                  'https://th.bing.com/th/id/OIP.AywqK88V0S_yuyA3kjOMvwAAAA?pid=ImgDet&rs=1'
                                ),),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              leading: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                    fontSize: 50.0, color: Colors.black87),
                              ),
                              tileColor:
                                  _students[index].Klas.codeUnitAt(4) % 2 == 0
                                      ? Colors.redAccent
                                      : Colors.blueAccent,
                              subtitle: Text(
                                _students[index].Klas,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              title: Text(
                                _students[index].Naam,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
