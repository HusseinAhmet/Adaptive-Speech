// import 'package:camera/camera.dart';
// //import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:adaptive_speech/Screens/sectionThree/src/app_root.dart';
//
//
// List<CameraDescription> cameras;
// main() async{
//
//
//
//
//   WidgetsFlutterBinding.ensureInitialized();
//   try{
//
//     cameras=await availableCameras();
//
//   } on CameraException catch(e)
//   {
//     print('Error ${e.code} + Error Messge : $e.message');
//   }
// //  await Firebase.initializeApp();
//   runApp(AppRoot(cameras: cameras,));
// }
