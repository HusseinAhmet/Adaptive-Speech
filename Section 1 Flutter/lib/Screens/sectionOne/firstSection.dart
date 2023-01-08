// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers, prefer_const_constructors, file_names

import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'liveStreaming.dart';
import 'message_style.dart';
import "package:flutter/services.dart";
import 'package:google_speech/google_speech.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';

class SpeechScreen extends StatefulWidget {
  static String routeName = "/SpeechScreen";
  @override
  _SpeechScreenState createState() => _SpeechScreenState();

}

class _SpeechScreenState extends State<SpeechScreen> {
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

      sendT(text, 0);
      MessageStyle(_text, 0);

    });
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'en-US');


  ///////////////////////////////////////////////////////////////////////
  // _AudioRecognizeState bb =_AudioRecognizeState();
  ScrollController _controller = ScrollController();
  late stt.SpeechToText _speech;

  String _text = 'Press the Listen button and start speaking';
  double _confidence = 1.0;

 late List<MessageStyle> message = [

    // MessageStyle('Press the Listen button and start speaking', 0),
   // MessageStyle(text, 0),
   // sendT(text, 0),
  ];

  final _messageController = TextEditingController();
  late String qmsg;
    sendT(String str, int i)  {
    setState(() {

      message.add(MessageStyle(str, i));
      Timer(Duration(milliseconds: 100), () {
        _controller.animateTo(_controller.position.maxScrollExtent,
            duration: Duration(microseconds: 700), curve: Curves.easeOut);
      });
    });
  }

  _SimpleDialogCreator(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Choose any shortcut"),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  qmsg = "Help!";
                  Navigator.of(context).pop(MessageStyle.a1(qmsg));
                },
                child: const Text('Help!'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  qmsg = "Can you help me?";
                  Navigator.of(context).pop(MessageStyle.a1(qmsg));
                },
                child: const Text('Can you help me?'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  qmsg = "Excuse me";
                  Navigator.of(context).pop(MessageStyle.a1(qmsg));
                  // .pop(add(_text, 1));
                },
                child: const Text('Excuse me'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  qmsg = "Can you give me this bottle?";
                  Navigator.of(context).pop(MessageStyle.a1(qmsg));
                },
                child: const Text('Can you give me this bottle?'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  qmsg = "Can you tell me the way to the hospital?";
                  Navigator.of(context).pop(MessageStyle.a1(qmsg));
                },
                child: const Text('Can you tell me the way to the hospital?'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  qmsg = "Thanks for your help";
                  Navigator.of(context).pop(MessageStyle.a1(qmsg));
                },
                child: const Text('Thanks for your help'),
              ),
            ],
          );
        });
  }

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
                child: TextButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context)
                          .pop(sendT(CustomController.text.toString(), 1));
                    });
                  },
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Speech Recognition',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        backgroundColor: Color.fromRGBO(113, 48, 148, 1),

      ),

      backgroundColor: const Color.fromRGBO(36, 36, 62, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  Column(
        mainAxisAlignment:   MainAxisAlignment.end,

        children: [
          // MessageStyle(text, 0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
             child:
           //   ElevatedButton(
           //   onPressed: recognizing ? stopRecording : streamingRecognize,
           //   child: recognizing
           //           ? Text('Stop recording')
           //           : Text('Listen'),
           //
           // ),
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
               ),


                    ),
                    FloatingActionButton.extended(
                      extendedPadding: EdgeInsetsDirectional.only(start: 60.0, end: 60.0),
                      tooltip: 'press to go live streaming ',
                      heroTag: "msg",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => vAudioRecognize(),
                          ),
                        );
                      },
                      label: Text("Live ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      icon: Icon(
                        Icons.quickreply_outlined,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.extended(
                extendedPadding: EdgeInsetsDirectional.only(start: 70.0, end: 70.0),
                tooltip: 'press to add a text',
                heroTag: "text",
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
                extendedPadding: EdgeInsetsDirectional.only(start: 50.0, end: 50.0),
                tooltip: 'press to choose shortcut',
                heroTag: "msg",
                onPressed: () {
                  _SimpleDialogCreator(context);
                },
                label: Text("Shortcuts",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                icon: Icon(
                  Icons.quickreply_outlined,
                  size: 25,
                ),
              ),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

            Container(
              width: double.infinity,
              height: 600,
              child: ListView.separated(
                  shrinkWrap: true,
                  controller: _controller,
                  itemBuilder: (context, index) => message[index],
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsetsDirectional.only(start: 20),
                        child: Column(
                          children: [

                            Container(
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                  itemCount: message.length),
            ),

          ],
        ),
      ),
    );
  }
}