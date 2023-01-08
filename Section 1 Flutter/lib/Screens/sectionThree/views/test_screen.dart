// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:adaptive_speech/Screens/sectionThree/services/camera.dart';
// import 'package:tflite/tflite.dart';
// import 'dart:math' as math;
//
// typedef void Callback(List<dynamic> list, int h, int w);
//
// class Camera extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   final Callback setRecognitions;
//   final String model;
//
//   Camera(this.cameras, this.model, this.setRecognitions);
//
//   @override
//   _CameraState createState() => new _CameraState();
// }
//
// class _CameraState extends State<Camera> {
//   late CameraController controller;
//   bool isDetecting = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (widget.cameras == null || widget.cameras.length < 1) {
//       print('No camera is found');
//     } else {
//       controller = new CameraController(
//         widget.cameras[0],
//         ResolutionPreset.high,
//       );
//       controller.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//
//         controller.startImageStream((CameraImage img) {
//           if (!isDetecting) {
//             isDetecting = true;
//
//             int startTime = new DateTime.now().millisecondsSinceEpoch;
//
//             Tflite.runModelOnFrame(
//                 bytesList: img.planes.map((plane) {return plane.bytes;}).toList(),// required
//                 imageHeight: img.height,
//                 imageWidth: img.width,
//                 imageMean: 127.5,   // defaults to 127.5
//                 imageStd: 127.5,    // defaults to 127.5
//                 rotation: 90,       // defaults to 90, Android only
//                 numResults: 29,      // defaults to 5
//                 threshold: 0,     // defaults to 0.1
//                 asynch: true        // defaults to true
//             )
//                 .then((recognitions) {
// //              int endTime = new DateTime.now().millisecondsSinceEpoch;
// //              print("Detection took ${endTime - startTime}");
// //                 print(img.height);
// //                 print(recognitions);
//               widget.setRecognitions(recognitions!, img.height, img.width);
//
//               isDetecting = false;
//             });
//           }
//         });
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (controller == null || !controller.value.isInitialized) {
//       return Container();
//     }
//
//     var tmp = MediaQuery.of(context).size;
//     var screenH = math.max(tmp.height, tmp.width);
//     var screenW = math.min(tmp.height, tmp.width);
//     tmp = controller.value.previewSize;
//     var previewH = math.max(tmp.height, tmp.width);
//     var previewW = math.min(tmp.height, tmp.width);
//     var screenRatio = screenH / screenW;
//     var previewRatio = previewH / previewW;
//
//     return OverflowBox(
//       maxHeight:
//       screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
//       maxWidth:
//       screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
//       child: CameraPreview(controller),
//     );
//   }
// }
//
// String ssd = 'SSD MobileNet';
//
// class TestScreen extends StatefulWidget {
//   final List<CameraDescription> cameras;
//
//   TestScreen({required this.cameras});
//
//   @override
//   _TestScreenState createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   late List<dynamic> _recognitions;
//   int _imgHeight = 0;
//   int _imgWidth = 0;
//   String _model = '';
//   String currentText = '';
//   String deafAndMuteMessageText = '';
//   bl7() {
//     if (_recognitions == null) {
//       print('صبح');
//     } else {
//       setState(() {
//         currentText = _recognitions[0]['label'].toString();
//       });
//       print(_recognitions[0]['label'].toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bl7();
//     Size screenSize = MediaQuery.of(context).size;
//     return SafeArea(
//
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.camera_alt_outlined),
//           onPressed: () {
//             onSelectModel(ssd);
//           },
//         ),
//         body: _model == ''
//             ? Container()
//             : Stack(
//           children: [
//             Camera(widget.cameras, _model, setRecognitions),
//             Positioned(
//               left: math.max(0, 0),
//               top: math.max(0, 0),
//               width: 224,
//               height: 224,
//               child: Container(
//                 padding: EdgeInsets.only(top: 5.0, left: 5.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Color.fromRGBO(37, 213, 253, 1.0),
//                     width: 3.0,
//                   ),
//                 ),
//                 child: Text(
//                   "Test",
//                   style: TextStyle(
//                     color: Color.fromRGBO(37, 213, 253, 1.0),
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 SizedBox(
//                   height: 100.0,
//                 ),
//                 Text(
//                   'Your Text is $currentText ',
//                   style: TextStyle(fontSize: 40.0),
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       deafAndMuteMessageText =
//                           deafAndMuteMessageText + currentText;
//                     },
//                     child: Text('Press Here To Add')),
//                 Text('Your Text is $deafAndMuteMessageText'),
//               ],
//             ),
//             // BoundingBox(
//             //     _recognitions == null ? [] : _recognitions,
//             //     math.max(_imgHeight, _imgWidth),
//             //     math.min(_imgHeight, _imgWidth),
//             //     screenSize.width,
//             //     screenSize.height,
//             //     _model),
//           ],
//         ),
//       ),
//     );
//   }
//
//   onSelectModel(model) {
//     setState(() {
//       _model = model;
//     });
//     loadModel();
//   }
//
//   loadModel() async {
//     String result;
//     if (_model == ssd) {
//       result = await Tflite.loadModel(
//           labels: 'assets/ssd_mobilenet.txt',
//           model: 'assets/ssd_mobilenet.tflite');
//     }
//     print(result);
//   }
//
//   setRecognitions(recognitions, imgHeight, imgWidth) {
//     setState(() {
//       _recognitions = recognitions;
//       _imgHeight = imgHeight;
//       _imgWidth = imgWidth;
//     });
//   }
//
// }
