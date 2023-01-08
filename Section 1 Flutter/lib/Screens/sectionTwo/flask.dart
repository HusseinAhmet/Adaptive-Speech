import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_speech/google_speech.dart';
import "package:flutter/services.dart";
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:adaptive_speech/Screens/sectionTwo/yaw.dart';
class flasktest extends StatefulWidget {
  const flasktest({Key? key}) : super(key: key);

  @override
  _flasktestState createState() => _flasktestState();
}
class _flasktestState extends State<flasktest> {

///Firebase Storage
  List<String> links=[];
  List<String> inputs=[];
  late var link;
  Future<void> downloadURLExample(List<dynamic> inputs ) async {
    for (var v = 0; v<inputs.length; v++) {
      link = await firebase_storage.FirebaseStorage.instance
          .ref('/${inputs[v]}.jpg')
          .getDownloadURL();
      links.add(link);
    }
    print('Link is :  $links');}







  final RecorderStream _recorder = RecorderStream();

  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  late StreamSubscription<List<int>> _audioStreamSubscription;
  late BehaviorSubject<List<int>> _audioStream;

  @override
  void initState() {
    super.initState();

    _recorder.initialize();
    // MessageStyle(text, 0);
  }

  void streamingRecognize() async {
    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      _audioStream.add(event);
    });
    await _recorder.start();
    setState(() {
      recognizing = true;
    });
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString(''))}');
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = _getConfig();

    final responseStream = speechToText.streamingRecognize(
        StreamingRecognitionConfig(config: config, interimResults: true),
        _audioStream);

    var responseText = '';

    responseStream.listen((data) {
      final currentText =
      data.results.map((e) => e.alternatives.first.transcript).join('\n');

      if (data.results.first.isFinal) {
        responseText += '\n' + currentText;
        setState(() {
          text = responseText;
          recognizeFinished = true;
        });
      } else {
        setState(() {
          text = responseText + '\n' + currentText;
          recognizeFinished = true;
          print(text);
          // sendT(text, 0);
          // MessageStyle(text, 0);
        });
      }
    }, onDone: () {
      setState(() {
        recognizing = false;

      });
    });
  }

  void stopRecording() async {
    await _recorder.stop();
    await _audioStreamSubscription.cancel();
    await _audioStream.close();
    setState(() {
      recognizing = false;

      texprocess=text;
    });
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'en-US');





  @override
  List<String> list =["one", "Two", "Thee"];
  var Message="";
  var Message1=[];
  var Message2=[];
  String texprocess='';
  Future request() async{
    String maps=texprocess;
    http.Response RES =await  http.post(
        Uri.parse('io/yaw'),
        //headers: {"Content-Type": "application/json"},
        body:maps
      // jsonEncode(maps)
      // jsonEncode(texprocess,)
    );
    // String res=RES as String;
    final resJSON= RES.body.toString();
    String res=resJSON;
    String result = res.replaceAll("\"", "");
    List split=result.split(' ');
    setState(() {
      Message1=Message2=split;
      downloadURLExample(Message2);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("Speech To Sign Language"),
),
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
              extendedPadding: EdgeInsetsDirectional.only(start: 60.0, end: 60.0),
              tooltip: 'press to start recording',
              isExtended: true,
              elevation: 52,
              onPressed: recognizing ? stopRecording : streamingRecognize,
              label: Text("Listen ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              icon: Icon(
                recognizing ? Icons.stop_circle_outlined  : Icons.mic,
                size: 28,
              ),
            )
            ,
            Text(
              texprocess,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                extendedPadding: EdgeInsetsDirectional.only(start: 50.0, end: 50.0),
                tooltip: 'press to choose shortcut',
                heroTag: "msg",
                onPressed: () async {
                  request();
                },
                label: Text("Text Process",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),),
                icon: Icon(
                  Icons.quickreply_outlined,
                  size: 25,
                ),
              ),
            ),

          if(Message2==null)
            Text(
              "nothing yet",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),)
            else
           Text(
         Message2.toString(),
             style: TextStyle(
           color: Colors.black,
        fontWeight: FontWeight.bold,
             fontSize: 23),),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: FloatingActionButton.extended(
            //     extendedPadding: EdgeInsetsDirectional.only(start: 50.0, end: 50.0),
            //     tooltip: 'press to choose shortcut',
            //     heroTag: "msg",
            //     onPressed: () async {
            //       request();
            //     },
            //     label: Text("Sendd",
            //       style: TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 23),),
            //     icon: Icon(
            //       Icons.quickreply_outlined,
            //       size: 25,
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    label: Text("Show Images",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    icon: Icon(
                      Icons.message,
                      size: 25,
                    ),
                  ),
                  // FloatingActionButton.extended(
                  //   onPressed: () {
                  //
                  //     Message2=Message1;
                  //     setState(() {
                  //       downloadURLExample(Message2);
                  //     },);
                  //
                  //
                  //   },
                  //   label: Text("Show",
                  //       style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.bold,
                  //       )),
                  //   icon: Icon(
                  //     Icons.message,
                  //     size: 25,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
