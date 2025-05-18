import 'package:flutter/material.dart';

class ListenZeiger extends StatelessWidget { //Klasse für das Zeigen der Notizen
  final List<Map<String, String>> notizen;

  const ListenZeiger({super.key, required this.notizen});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Container wird nur so viel Platz nehmen wie benötigt
      itemCount: notizen.length, //itemCount steht für wie viele Cards werden angezeigt
      itemBuilder: (context, index) { // es wird indexiert gezeigt, dass heißt, dass es einmal pro Notiz passiert
        final notiz = notizen[index]; //dem final notiz wird eine Notiz aus der Liste zugewiesen
        return Container( // In Container-Format
            color: Color.fromARGB(86, 170, 170, 170),
            child: ListTile(
            title: Text(notiz['titel']!), //VS-Code erfodert ein 'Nullcheck'
            subtitle: Text(notiz['notiz']!),
            onTap: () => _zeigeNotiz(context, notiz),
          ),
        );
      },
    );
  }
}

//Funktion für das Zeigen einzelner Notizen
void _zeigeNotiz (BuildContext context, Map<String, String> notiz){
  showDialog(context: context, //Als Dialog
  builder:(context) => AlertDialog(
                  title: Text(notiz['titel']!),
                  content: Text(notiz['notiz']!),
                  actions: [ //Button erstellen fürs Schließen
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Fertig'),
                    ),
                  ],
                ),
              );
            }