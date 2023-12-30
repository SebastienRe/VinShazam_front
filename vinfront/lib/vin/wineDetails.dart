// wine_details.dart
import 'package:flutter/material.dart';

class WineDetailsPage extends StatelessWidget {
  final Map<String, dynamic> wineDetails;

  const WineDetailsPage({required this.wineDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du vin'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Image.network(wineDetails['imageURL']),
            ),
            ListTile(
              title: Text('Nom'),
              subtitle: Text(wineDetails['nom']),
            ),
            ListTile(
              title: Text('Domaine'),
              subtitle: Text(wineDetails['domaine']),
            ),
            ListTile(
              title: Text('Millésime'),
              subtitle: Text(wineDetails['millesime'].toString()),
            ),
            ListTile(
              title: Text('Région'),
              subtitle: Text(wineDetails['region']),
            ),
            ListTile(
              title: Text('Pays'),
              subtitle: Text(wineDetails['pays']),
            ),
            ListTile(
              title: Text('Description'),
              subtitle: Text(wineDetails['description']),
            ),
            ListTile(
              title: Text('Note'),
              subtitle: Text(wineDetails['note'].toString()),
            ),
            ListTile(
              title: Text('Créé le'),
              subtitle: Text(wineDetails['creeLe']),
            ),
            ListTile(
              title: Text('Mis à jour le'),
              subtitle: Text(wineDetails['misAjourLe']),
            ),
          ],
        ),
      ),
    );
  }
}
