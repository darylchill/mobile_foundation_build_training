import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:new_app/pages/new_screen.dart';

import 'widgets/flutter_logo.dart';

void main() {
  runApp(const MyApp());
}

class SubType{
  final String type;
  final String label;
  // Constructor
  SubType(this.type, this.label);

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      json['type'],
      json['label'],
    );
  }
}

Future fetchSubTypesList() async {
  // set the server address
  const url = "http://10.0.2.2:4000/graphql";

  //set query resolver
  const query = r''' 
      query{
         getEventSubTypes
       }
  ''';
  
  //using POST
  final response = await post(
      Uri.parse(url), 
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"query": query})
  );

  // filtering
  if(response.statusCode == 200){
    final body = jsonDecode(response.body);
    final List data = body['data']['getEventSubTypes'];

    print("Response Data: $data");
    return data.map((json) => SubType.fromJson(json)).toList();
  }



}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mobile Training',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder(
            future: fetchSubTypesList(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              else if(snapshot.hasError)
                {
                  return Center(child: Text("Error: ${snapshot.error}"),);
                }
              else if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  return  ListView.builder(
                      itemCount: snapshot.data!.length ,
                      itemBuilder:(context, index){
                        final subtype = snapshot.data![index];
                        return ListTile(
                          title: Text(subtype.type),
                          subtitle: Text(subtype.label),
                        );
                      }
                      );
                }
                else{
                  return Center(child: Text("No Data"),);
                }
              }
              return Center(child: CircularProgressIndicator(),);
            })
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          fetchSubTypesList();
        },
        tooltip: 'Fetch',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
