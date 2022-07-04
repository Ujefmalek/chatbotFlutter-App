import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final int index;
  const MessageBubble({required this.message,required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
        elevation: 5,
        color: index%2==0?Colors.white:Colors.lightBlueAccent,
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              crossAxisAlignment: index%2==0?CrossAxisAlignment.start:CrossAxisAlignment.end,
              children: [
                Text(message,style: TextStyle(fontSize: 20,
                ),),
              ],
            )),
      ),
    );
  }
}
