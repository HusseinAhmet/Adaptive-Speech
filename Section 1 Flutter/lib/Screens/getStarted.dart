// ignore_for_file: prefer_const_constructors, file_names

import 'package:adaptive_speech/Screens/Cards/categories.dart';
import 'package:adaptive_speech/Screens/sectionOne/firstSection.dart';
import 'package:adaptive_speech/Screens/sectionTwo/getImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:adaptive_speech/Screens/sectionTwo/voice2sign.dart';
import 'package:adaptive_speech/Screens/sectionTwo/flask.dart';
class getStarted extends StatefulWidget {

  static String routeName = "/getStarted";
  @override
  _getStartedState createState() => _getStartedState();
}

class _getStartedState extends State<getStarted> {
  @override
  Widget build(BuildContext context) {
    String personType1 = 'Deaf';
    String personType2 = 'Normal';
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(
                    "Choose a Section",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                    ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Color.fromRGBO(113, 48, 148, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(50.0),
                    bottomRight: const Radius.circular(50.0))),
          ),
        ),
        backgroundColor: Color.fromRGBO(36, 36, 62, 1),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SpeechScreen.routeName);
                },
                child: GFCard(
                  color: Color(0xFF713094),
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(3),
                  elevation: 3,
                  height: 195,
                  boxFit: BoxFit.cover,
                  //titlePosition: GFPosition.start,
                  //showOverlayImage: true,
                  //imageOverlay: AssetImage('assets/Chat1.png'),

                  title: GFListTile(
                    title: Center(
                      child: Text(
                        'Voice Recognition Chat',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                  showImage: true,
                  image:
                      Image.asset('assets/Chat1.png', width: 110, height: 110),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => flasktest(),
                    ),
                  );
                },
                child: GFCard(
                  color: Color(0xFF713094),
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(3),
                  elevation: 3,
                  height: 195,
                  boxFit: BoxFit.cover,
                  //showOverlayImage: true,
                  //imageOverlay: AssetImage('assets/img.jpg'),

                  title: GFListTile(
                    title: Center(
                      child: Text(
                        'Voice To Sign Language',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                  ),
                  showImage: true,
                  image: Image.asset('assets/voice2Sign.png', width: 110, height: 110),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => getImage(),
                    ),
                  );
                },
                child: GFCard(
                  color: Color(0xFF713094),
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(3),
                  elevation: 3,
                  height: 195,
                  boxFit: BoxFit.cover,
                  //showOverlayImage: true,
                  //imageOverlay: AssetImage('assets/img.jpg'),

                  title: GFListTile(
                    title: Center(
                      child: Text(
                        'Test for Images',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                  ),
                  showImage: true,
                  image: Image.asset('assets/voice2Sign.png', width: 110, height: 110),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => categoriesState(personType2),
                    ),
                  );
                },
                child: GFCard(
                  color: Color(0xFF713094),
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(3),
                  elevation: 3,
                  height: 195,
                  boxFit: BoxFit.cover,
                  //showOverlayImage: true,
                  //imageOverlay: AssetImage('assets/img.jpg'),

                  title: GFListTile(
                    title: Center(
                      child: Text(
                        'Sign Language Translator',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                  ),
                  showImage: true,
                  image: Image.asset('assets/signTranslate.jpg', width: 110, height: 110),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => categoriesState(personType1),
                    ),
                  );
                },
                child: GFCard(
                  borderOnForeground: true,

                  color: Color(0xFF713094),
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.all(3),
                  elevation: 30,
                  height: 195,
                  boxFit: BoxFit.scaleDown,
                  //titlePosition: GFPosition.start,
                  //showOverlayImage: true,
                  //imageOverlay: AssetImage('assets/img1.png'),

                  title: GFListTile(
                    title: Center(
                      child: Text(
                        'Learning English with Sign language',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  showImage: true,
                  image:
                      Image.asset('assets/img1.png', width: 110, height: 110),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => categoriesState(personType2),
                    ),
                  );
                },
                child: GFCard(
                  color: Color(0xFF713094),
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(3),
                  elevation: 3,
                  height: 195,
                  boxFit: BoxFit.cover,
                  //showOverlayImage: true,
                  //imageOverlay: AssetImage('assets/img.jpg'),

                  title: GFListTile(
                    title: Center(
                      child: Text(
                        'Learning Sign language with English',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  showImage: true,
                  image: Image.asset('assets/img.png', width: 110, height: 110),
                ),
              ),
            ],
          ),
        ));
  }
}
