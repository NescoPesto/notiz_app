import 'package:flutter/material.dart';

class ListenZeiger extends StatelessWidget {
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
          ),
        );
      },
    );
  }
}
