
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CameraController? controller;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void initializeCamera() async {
    controller = CameraController(cameras[1], ResolutionPreset.medium);
    await controller?.initialize();
    setState(() {
      isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Project K - Eye & Face Tracker')),
        body: isCameraInitialized
            ? CameraPreview(controller!)
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
