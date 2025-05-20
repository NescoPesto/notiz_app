import 'package:flutter/material.dart';

class ListenZeiger extends StatelessWidget { //Klasse für das Zeigen der Notizen
  final List<Map<String, String>> notizen;
  final VoidCallback update;
  final Function(Map<String, String>) delete;

  const ListenZeiger({
    super.key,
    required this.notizen,
    required this.update,
    required this.delete,
  });

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
            onTap: () => _zeigeNotiz(context, notiz, update, delete),
          ),
        );
      },
    );
  }
}

//Funktion für das Zeigen einzelner Notizen
void _zeigeNotiz (BuildContext context, Map<String, String> notiz, VoidCallback update, Function(Map<String, String>) delete){
  showDialog(context: context, //Als Dialog
  builder:(context) => AlertDialog(
                  title: Text(notiz['titel']!),
                  content: Text(notiz['notiz']!),
                  actions: [ //Button erstellen fürs Löschen, Bearbeiten und Schließen
                    IconButton( //Löschen
                      onPressed: (){
                        Navigator.of(context).pop();
                        _loeschen(context, notiz, update, delete);
                      }, 
                      icon: Icon(Icons.delete)
                      ),
                    IconButton( //Bearbeiten
                      onPressed: (){
                        Navigator.of(context).pop(); //geht den Dialog weg  
                       _bearbeiten(context, notiz, update); //Aufruf von _bearbeiten
                       }, 
                      icon: Icon(Icons.edit) //Stift-Icon
                    ),
                    TextButton( //'Fertig' zum Schließen des Dialogs
                      onPressed: () => Navigator.of(context).pop(), 
                      child: const Text('Fertig'),
                    ),
                  ],
                ),
              );
            }

void _bearbeiten (BuildContext context, Map<String, String> notiz, VoidCallback update){
  TextEditingController titelEdit = TextEditingController(text: notiz['titel']); //Variable für den Titel
  TextEditingController notizEdit = TextEditingController(text: notiz['notiz']); //Variable für die Notiz

  showDialog( //dann kommt Dialog
    context: context, 
    builder: (context)=> AlertDialog( //als AlertDialog
      title: Text('Notiz bearbeiten'), //was da oben steht
      content: Column( //Column mit einem Kind pro Textfeld
        children: [
          TextField(
            controller: titelEdit,
            decoration: InputDecoration(label: Text('Titel')), //UserInput
          ),
          TextField(
            controller: notizEdit,
            decoration: InputDecoration(label: Text('Notiz')),
          )
        ],
      ),
      actions: [
        TextButton( //Abbrechen Knopf
        onPressed: () => Navigator.of(context).pop(), 
        child: Text('Abbrechen')
        ),
        TextButton( //Bestätigen Knopf
          onPressed: (){
            notiz['titel'] = titelEdit.text; //Titel wird überschrieben
            notiz['notiz'] = notizEdit.text; //Notiz wird überschrieben
            Navigator.of(context).pop();
            update(); //Homepage wird aktualisiert
          }, 
          child: Text('Ok')
          )
      ],
    )
    );
}

void _loeschen (BuildContext context, Map<String, String> notiz, VoidCallback update, Function(Map<String, String>) delete){
  showDialog(context: context, 
  builder: (context) => AlertDialog( //Frage-Dialog zur Bestätigung
    title: Text('Möchten Sie die Notiz löschen?'),
    actions: [
      TextButton( //Abbrechen
      onPressed: () => Navigator.of(context).pop(), 
      child: Text('Nein')),
      TextButton(onPressed: (){ //Fortfahren
        Navigator.of(context).pop();
        delete(notiz); //Anwendung vom delete
        update();
      }, 
      child: Text('Ja'))
    ],
  )
  );
}
