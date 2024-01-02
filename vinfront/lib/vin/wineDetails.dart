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
  TextEditingController note = TextEditingController();
  Map<String, dynamic> editedWineDetails = {};
  Map<String, dynamic> user = {};

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    editedWineDetails = widget.wineDetails;
  }

  Future<void> enregistrer() async {
    // Call the VinService to update the wine details
    bool result =
        (await widget.vinService.updateWineDetails(editedWineDetails));
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vin mis à jour'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de l\'enregistrement'),
        ),
      );
    }
  }

  void ajouterCommentaire() {
    // ajoute un commentaire à editedWineDetails.comments (qui est une liste)
    if (commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Commentaire vide'),
        ),
      );
      return;
    } else if (note.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Note vide'),
        ),
      );
      return;
    }

    editedWineDetails['comments'].add({
      'user': '${user['prenom']} ${user['nom']}',
      'text': commentController.text,
      'date': DateTime.now().toString(),
      'note': int.parse(note.text),
    });
    commentController.clear();
    note.clear();

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
                readOnly: user['isAdmin'] == false,
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
                readOnly: user['isAdmin'] == false,
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
                readOnly: user['isAdmin'] == false,
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
                readOnly: user['isAdmin'] == false,
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
                readOnly: user['isAdmin'] == false,
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
                readOnly: user['isAdmin'] == false,
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
                readOnly: user['isAdmin'] == false,
                initialValue: editedWineDetails['note'].toString(),
                onChanged: (value) {
                  setState(() {
                    editedWineDetails['note'] = double.parse(value);
                  });
                },
              ),
            ),
            Container(
              color: Color.fromARGB(255, 230, 230,
                  230), // Remplacez "blue" par la couleur de fond souhaitée
              child: Column(
                children: [
                  ListTile(
                    title: Text('Commentaires'),
                    subtitle: Column(
                      children: [
                        for (var comment in editedWineDetails['comments'])
                          ListTile(
                            title: Text(comment['user']),
                            subtitle: Text(comment['text']),
                            trailing: Text(comment['date']),
                            leading: Text(comment['note'].toString() + '/5'),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ajouter un commentaire',
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: note,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ajouter une note (/5)',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: ajouterCommentaire,
                      child: Text('Ajouter un commentaire')),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: enregistrer,
              child: Text('Enregistrer'),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Créé le'),
                    subtitle: Text(editedWineDetails['creeLe']),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Mis à jour le'),
                    subtitle: Text(editedWineDetails['misAjourLe']),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
