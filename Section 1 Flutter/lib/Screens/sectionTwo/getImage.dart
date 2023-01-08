import 'dart:async';


import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:adaptive_speech/Screens/sectionTwo/yaw.dart';

class getImage extends StatefulWidget {
  const getImage({Key? key}) : super(key: key);

  @override
  _getImageState createState() => _getImageState();
}

class _getImageState extends State<getImage> {
  List<String> inputs=[];
  List<String> links=[];
    late var link;
  Future<void> downloadURLExample(List<String> inputs ) async {
     for (var v = 0; v<inputs.length; v++) {
       link = await firebase_storage.FirebaseStorage.instance
          .ref('/${inputs[v]}.jpg')
          .getDownloadURL();
       links.add(link);
     }
     print('Link is :  $links');}
    @override
    _dialogCreator(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            TextEditingController CustomController = TextEditingController();
            return AlertDialog(
              title: const Text("Enter your Message"),
              content: TextField(
                controller: CustomController,
              ),
              actions: [
                Container(
                  child: Row(
                    children: [
                      TextButton(
                        child: Text('Confirm'),
                        onPressed: () {
                          inputs.add( CustomController.text.toString());
                          print(inputs);
                        },
                      ),
                      TextButton(
                        child: Text('send'),
                        onPressed: () {
                          downloadURLExample(inputs);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly
        ,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              _dialogCreator(context);
            },
        label: Text("Text",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        )),
    icon: Icon(
    Icons.message,
    size: 25,
    ),

          ),
          FloatingActionButton.extended(
             onPressed: () { downloadURLExample(inputs);
             Timer(Duration(milliseconds: 100), () {
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => yaw(links),
                 ),
               );
             });

            },
            label: Text("Get Images",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            icon: Icon(
              Icons.message,
              size: 25,
            ),
          ),
        ],
      ),

body: Column(
  children: [

    // Image.network(link!)
  ],
),



    );
  }


}




