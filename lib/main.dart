import 'package:flutter/material.dart';
import 'API.dart';
import 'dart:convert';
import 'MessageBubble.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String message;
  late Uri url;
  late var response;
  ScrollController sc=new ScrollController();
  final tc=TextEditingController();
  List<String> messages = <String>['How May I Help You?'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('ChatBot'),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(flex: 12,
                    child: ListView.builder(
                      controller: sc,
                      shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MessageBubble(message: messages[index], index: index);
                        }
                    )
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: tc,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      message = value.trim().toString();
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(25)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 5),
                          borderRadius: BorderRadius.circular(25)),
                      hintText: "Your query",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(Icons.computer),
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 1,
                    child:  ElevatedButton(
                  child: Text(
                    'ASK',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  onPressed: () async{
                    tc.clear();
                    url=Uri.http('192.168.0.101:5000','/res',{'que':message});
                    response = await getData(url);
                    var decodedData=jsonDecode(response);
                    print(decodedData['ans']);
                    setState(() {
                      messages.add(message);
                      messages.add(decodedData['ans']);
                    });
                    sc.jumpTo(sc.position.maxScrollExtent);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                )
                ),
                SizedBox(height: 20,)
              ],
            ),
          )
          ),
        ),
      );
  }
}
