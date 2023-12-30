// camera_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:vinfront/vin/service/VinService.dart';
import 'wineDetails.dart'; // Import the wine details page

class CameraPage extends StatefulWidget {
  final VinService vinService; // Define the named parameter
  CameraPage(
      {required this.vinService}); // Add the named parameter to the constructor

  @override
  _CameraPageState createState() => _CameraPageState(
      vinService: vinService); // Pass the named parameter to the state
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  late CameraController controller;

  final VinService vinService; // Define the named parameter

  _CameraPageState(
      {required this.vinService}); // Add the named parameter to the constructor

  // Rest of the code...

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
    controller = CameraController(cameras[0], ResolutionPreset.high);
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
    // Convert XFile to File
    final file = File(image.path);
    // Send the image to the server and get the wine details
    final wineDetails = await this.vinService.sendImageToServer(file);
    if (wineDetails == null) {
      // Handle case when wine is not recognized
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le vin n\'a pas été reconnu'),
        ),
      );
      return;
    }
    // Navigate to the wine details page and pass the wine details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            WineDetailsPage(wineDetails: wineDetails, vinService: vinService),
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
