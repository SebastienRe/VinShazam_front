// camera_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import './imagePreview.dart';

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
        title: const Text('Scannez votre bouteille'),
      ),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            child: CameraPreview(controller),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: takePhoto,
              child: const Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }
}
