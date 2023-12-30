// camera_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  void takePhoto() async {
    if (!controller.value.isInitialized) {
      return;
    }
    final image = await controller.takePicture();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewPage(imagePath: image.path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Page'),
      ),
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            child: CameraPreview(controller),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: takePhoto,
              child: Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePreviewPage extends StatelessWidget {
  final String imagePath;

  const ImagePreviewPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
