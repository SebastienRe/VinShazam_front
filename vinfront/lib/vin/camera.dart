// camera_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'wineDetails.dart'; // Import the wine details page

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
    final wineDetails = await sendImageToServer(file);
    print('Wine details:');
    print(wineDetails);
    if (wineDetails == null) {
      // Handle case when wine is not recognized
      return;
    }
    // Navigate to the wine details page and pass the wine details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WineDetailsPage(wineDetails: wineDetails),
      ),
    );
  }

  Future<Map<String, dynamic>?> sendImageToServer(File image) async {
    // Implement your logic to send the image to the server and get the wine details
    // Return null if wine is not recognized, otherwise return the wine details
    // Example implementation:
    return {
      "id": "2",
      "nom": "Domaine Sample",
      "domaine": "Sample Winery",
      "millesime": 2018,
      "region": "California",
      "pays": "USA",
      "description": "A superb red wine from the sunny California vineyards...",
      "note": 4.2,
      "imageURL":
          "https://www.vinimarche.fr/3039-large_default/chateau-roland-la-garde-cuvee-prestige-2019-blaye-cotes-de-bordeaux.jpg",
      "creeLe": "2023-02-15",
      "misAjourLe": "2023-12-19"
    };
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
