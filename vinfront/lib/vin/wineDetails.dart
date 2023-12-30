// wine_details.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinfront/authentification/SauvegardeUser.dart';
import 'package:vinfront/vin/service/VinService.dart';

class WineDetailsPage extends StatefulWidget {
  Map<String, dynamic> wineDetails;
  final VinService vinService;

  WineDetailsPage({required this.wineDetails, required this.vinService});

  @override
  _WineDetailsPageState createState() => _WineDetailsPageState();
}

class _WineDetailsPageState extends State<WineDetailsPage> {
  TextEditingController commentController = TextEditingController();
  Map<String, dynamic> editedWineDetails = {};

  @override
  void initState() {
    super.initState();
    editedWineDetails = widget.wineDetails;
  }

  Future<void> enregistrer() async {
    // Call the VinService to update the wine details
    editedWineDetails = await widget.vinService
        .updateWineDetails(editedWineDetails as Map<String, dynamic>);

    setState(() {
      // Update the state to trigger a rebuild of the widget tree
      editedWineDetails = editedWineDetails;
    });
  }

  void ajouterCommentaire() {
    // ajoute un commentaire à editedWineDetails.comments (qui est une liste)
    Map<String, dynamic> user =
        Provider.of<UserProvider>(context, listen: false).user;
    editedWineDetails['comments'].add({
      'user': '${user['prenom']} ${user['nom']}',
      'text': commentController.text,
      'date': DateTime.now().toString(),
    });
    commentController.clear();

    setState(() {
      // Update the state to trigger a rebuild of the widget tree
      editedWineDetails = editedWineDetails;
    });
  }

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
              child: Image.network(editedWineDetails['imageURL']),
            ),
            ListTile(
              title: Text('Nom'),
              subtitle: TextFormField(
                initialValue: editedWineDetails['nom'],
                onChanged: (value) {
                  setState(() {
                    editedWineDetails['nom'] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Domaine'),
              subtitle: TextFormField(
                initialValue: editedWineDetails['domaine'],
                onChanged: (value) {
                  setState(() {
                    editedWineDetails['domaine'] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Millésime'),
              subtitle: TextFormField(
                initialValue: editedWineDetails['millesime'].toString(),
                onChanged: (value) {
                  setState(() {
                    editedWineDetails['millesime'] = int.parse(value);
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Région'),
              subtitle: TextFormField(
                initialValue: editedWineDetails['region'],
                onChanged: (value) {
                  setState(() {
                    editedWineDetails['region'] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Pays'),
              subtitle: TextFormField(
                initialValue: editedWineDetails['pays'],
                onChanged: (value) {
                  setState(() {
                    editedWineDetails['pays'] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Description'),
              subtitle: TextFormField(
                initialValue: editedWineDetails['description'],
                onChanged: (value) {
                  setState(() {
                    editedWineDetails['description'] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Note'),
              subtitle: TextFormField(
                initialValue: editedWineDetails['note'].toString(),
                onChanged: (value) {
                  setState(() {
                    editedWineDetails['note'] = double.parse(value);
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Créé le'),
              subtitle: Text(editedWineDetails['creeLe']),
            ),
            ListTile(
              title: Text('Mis à jour le'),
              subtitle: Text(editedWineDetails['misAjourLe']),
            ),
            ListTile(
              title: Text('Commentaires'),
              subtitle: Column(
                children: [
                  for (var comment in editedWineDetails['comments'])
                    ListTile(
                      title: Text(comment['user']),
                      subtitle: Text(comment['text']),
                      trailing: Text(comment['date']),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ajouter un commentaire',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: ajouterCommentaire,
                child: Text('Ajouter un commentaire')),
            ElevatedButton(
              onPressed: enregistrer,
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
