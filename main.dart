import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search APP',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'MOVIE FUN APP',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectMov = "Guardians of the Galaxy Vol. 2";
  List<String> movieList = [
    "Guardians of the Galaxy Vol. 2",
    "Doctor Stranger",
    "Halloween",
    "Smile",
    "Avatar",
    "Godzilla",
    "Black Adam",
    "Annabelle",
    "Lucifer",
    "The Heirs",
    "The Conjuring",
    "Tom And Jerry",
    "Dora And The Lost City Of Gold",
  ];
  String desc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("MOVIE DESCRIPTION",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Image.asset('assets/images/3.jpg', scale: 2),
            DropdownButton(
              itemHeight: 60,
              value: selectMov,
              onChanged: (newValue) {
                setState(() {
                  selectMov = newValue.toString();
                });
              },
              items: movieList.map((selectMov) {
                return DropdownMenuItem(
                  value: selectMov,
                  child: Text(
                    selectMov,
                  ),
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: _searchMovie, child: const Text("SEARCH")),
            Text(desc,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

 Future<void> _searchMovie() async {
  
    var apiid = "57f7fd5e";
    var url = Uri.parse('http://www.omdbapi.com/?t=$selectMov&apikey=$apiid');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        var title= parsedJson['Title'];
        var year = parsedJson['Year'];
        var runtime = parsedJson['Runtime'];
        var genre = parsedJson['Genre'];
        var director = parsedJson['Director'];
        var plot = parsedJson['Plot'];

        desc =
            "The title for this movie is $title. \nIt published on $year. \nIt just take $runtime to finish this movie. \nThe genre for this movie is $genre. \n$director is the director for this movie. \nPlot movie is $plot";
      });
    }
    Fluttertoast.showToast(
          msg: "FOUND",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
  }  
}