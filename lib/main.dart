import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => HomePage()},
    ));

class HPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "  ";
  String city = " ";

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.red])),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.yellow, Colors.green])),
          margin: EdgeInsets.fromLTRB(
              size.width / 3, size.height / 4, size.width / 3, size.height / 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (var val) {
                    city = val;
                  },
                ),
              ),
              FlatButton(
                  height: size.height / 15,
                  color: Colors.black,
                  onPressed: () {
                    getTemp(city);
                  },
                  child: Text(
                    'узнать погоду',
                    style: TextStyle(color: Colors.white),
                  )),
              Text(
                text,
                style: TextStyle(fontSize: 28),
              )
            ],
          ),
        )
      ],
    ));
  }

  Future<void> getTemp(String city) async {
    var resp = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=' +
            city +
            '&appid=11f1cf95185719869bf780bc8a0efe5c&units=metric');
    if (resp.statusCode == 200) {
      var jreq = json.decode(resp.body);
      text = ('температура ' +
          jreq['main']['temp'].toString() +
          '\nощущается как' +
          jreq['main']['feels_like'].toString());
      setState(() {});
    }
  }
}
