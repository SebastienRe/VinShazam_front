// wine_details.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
  //note = int
  TextEditingController note = TextEditingController();
  Map<String, dynamic> editedWineDetails = {};
  Map<String, dynamic> user = {};

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    editedWineDetails = widget.wineDetails;
  }

  void getWineDetails() async {
    print('getWineDetails');
    editedWineDetails = (await widget.vinService
        .getWineDetails(editedWineDetails['_id'])) as Map<String, dynamic>;
    print(editedWineDetails);
    setState(() {
      editedWineDetails = editedWineDetails;
    });
  }

  Future<void> enregistrer() async {
    // Call the VinService to update the wine details
    bool result =
        (await widget.vinService.updateWineDetails(editedWineDetails));
    if (result) {
      getWineDetails();
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

  Future<void> ajouterCommentaire() async {
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
    } else if (int.parse(note.text) < 0 || int.parse(note.text) > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La note doit être comprise entre 0 et 5'),
        ),
      );
      return;
    }

    var comment = {
      'user': '${user['prenom']} ${user['nom']}',
      'text': commentController.text,
      'date': DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      'note': int.parse(note.text),
    };

    commentController.clear();
    note.clear();

    bool result =
        (await widget.vinService.addComment(editedWineDetails['_id'], comment));
    if (result) {
      getWineDetails();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Commentaire ajouté'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de l\'ajout du commentaire'),
        ),
      );
    }
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
                readOnly: true,
                initialValue: editedWineDetails['note'].toString(),
                onChanged: (value) {
                  setState(() {
                    editedWineDetails['note'] = double.parse(value);
                  });
                },
              ),
            ),
            Visibility(
              visible: user['isAdmin'],
              child: ElevatedButton(
                onPressed: enregistrer,
                child: Text('Enregistrer'),
              ),
            ),
            Container(
              color: Color.fromARGB(255, 243, 243,
                  243), // Remplacez "blue" par la couleur de fond souhaitée
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
                          child: TextFormField(
                            controller: note,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ajouter une note (/5)',
                            ),
                            keyboardType: TextInputType.number,
                            // Only numbers can be entered
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                    title: Text('Dernière Mise à jour :'),
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
