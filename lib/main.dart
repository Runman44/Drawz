import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geo_artz/data/database.dart';
import 'package:geo_artz/data/design_data_source_database.dart';
import 'package:geo_artz/data/design_repository.dart';
import 'package:geo_artz/domain/usecase/get_designs.dart';
import 'package:geo_artz/screen/draw_screen.dart';
import 'package:get_it/get_it.dart';

import 'domain/model/drawing.dart';

void main() {
  setup();
  runApp(MyApp());
}

void setup() {
  GetIt.I.registerSingleton<MyDatabase>(MyDatabase());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepPurpleAccent),
      home: MyHomePage(title: 'Geo Artz'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        )),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple,
                  Colors.purple,
                ])),
        child: StreamBuilder(
          stream: GetDesigns(
                  DesignRepository(DesignDataSourceDatabase(GetIt.instance<MyDatabase>())))
              .execute(),
          builder: (context, AsyncSnapshot<List<Drawing>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation ==
                      Orientation.landscape ? 3: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.8),
                ),
                itemBuilder: (_, index) {
                  return GridTile(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Expanded(child: Image.memory( Uint8List.view(snapshot.data![index].imageBytes!.buffer),)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            IconButton(onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DrawScreen(drawing: snapshot.data![index])),
                              );
                            }, icon: Icon(Icons.edit), iconSize: 18.0),
                            IconButton(onPressed: (){}, icon: Icon(Icons.shopping_basket), iconSize: 18.0),
                          ],),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data?.length,
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DrawScreen()),
          );
        },
        tooltip: 'add design',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
