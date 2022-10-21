import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ImagePicker imagePicker;
  File? _image;
  String result = '';
  // var image;
  // late List<Pose> poses;

  //TODO declare detector

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
    //TODO initialize detector

  }

  @override
  void dispose() {
    super.dispose();

  }

  //TODO capture image using camera
  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doPoseDetection();
    }
  }

  //TODO choose image using gallery
  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doPoseDetection();
    }
  }

  //TODO pose detection code here
  doPoseDetection() async {
    setState(() {
      _image;
    });
  }

  // //TODO draw pose
  // drawPose() async {
  //   image = await _image?.readAsBytes();
  //   image = await decodeImageFromList(image);
  //   setState(() {
  //     image;
  //     poses;
  //     result;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              width: 100,
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Stack(children: <Widget>[
                Center(
                  child: ElevatedButton(
                    onPressed: _imgFromGallery,
                    onLongPress: _imgFromCamera,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: _image != null
                          ? Image.file(
                        _image!,
                        width: 350,
                        height: 350,
                        fit: BoxFit.fill,
                      )
                          : Container(
                        width: 350,
                        height: 350,
                        color: Colors.indigo,
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                    ),
                    // Container(
                    //   child: image != null
                    //       ? Center(
                    //           child: FittedBox(
                    //             child: SizedBox(
                    //               width: image.width.toDouble(),
                    //               height: image.height.toDouble(),
                    //               child: CustomPaint(
                    //                 painter: PosePainter(poses,image),
                    //               ),
                    //             ),
                    //           ),
                    //         )
                    //       : Container(
                    //           color: Colors.indigo,
                    //           width: 350,
                    //           height: 350,
                    //           child: const Icon(
                    //             Icons.camera_alt,
                    //             color: Colors.white,
                    //             size: 53,
                    //           ),
                    //         ),
                    // ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      )),
    );
  }
}

// class PosePainter extends CustomPainter {
//   PosePainter(this.poses, this.imageFile);
//
//   final List<Pose> poses;
//   var imageFile;
//
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (imageFile != null) {
//       canvas.drawImage(imageFile, Offset.zero, Paint());
//     }
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4.0
//       ..color = Colors.green;
//
//     final leftPaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3.0
//       ..color = Colors.yellow;
//
//     final rightPaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3.0
//       ..color = Colors.blueAccent;
//
//     for (final pose in poses)
//     {
//       pose.landmarks.forEach((_, landmark) {
//         canvas.drawCircle(
//             Offset(
//               landmark.x,
//               landmark.y
//             ),
//             1,
//             paint);
//       });
//
//       // void paintLine(
//       //     PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
//       //   final PoseLandmark joint1 = pose.landmarks[type1]!;
//       //   final PoseLandmark joint2 = pose.landmarks[type2]!;
//       //   canvas.drawLine(
//       //       Offset(joint1.x,
//       //           joint1.y),
//       //       Offset(joint2.x,
//       //           joint2.y),
//       //       paintType);
//       // }
//       //
//       // //Draw arms
//       // paintLine(
//       //     PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, leftPaint);
//       // paintLine(
//       //     PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, leftPaint);
//       // paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
//       //     rightPaint);
//       // paintLine(
//       //     PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, rightPaint);
//       //
//       // //Draw Body
//       // paintLine(
//       //     PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, leftPaint);
//       // paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
//       //     rightPaint);
//       //
//       // //Draw legs
//       // paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftPaint);
//       // paintLine(
//       //     PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftPaint);
//       // paintLine(
//       //     PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, rightPaint);
//       // paintLine(
//       //     PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, rightPaint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant PosePainter oldDelegate) {
//     return oldDelegate.poses != poses;
//   }
// }


