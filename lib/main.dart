import 'package:flutter/material.dart';
import 'listview.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notiz_app', //Name aktualisiert
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow), //Farbe definiert
      ),
      home: const MyHomePage(title: 'Notiz_app'), //Name akutalisiert
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(controller: myController);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> _notizen = []; // eine Liste mit allen Notizen wird erstellt, die erste ist für den Titel, die zweite für die Notiz, Map ist für die Zuweisung der Werte
  int _counter = 0;

  //hier kommt die Funktion für das erstellen von Notizen, das passiert wenn man den + Knopf drückt
  void _createNote() {
    final title = TextEditingController(); // Variabel für den Titel
    final notiz = TextEditingController();  // Variabel für die Notiz

    showDialog( //dem User wird ein Fenster zeigen
      context: context,
      builder: (context) {
        return AlertDialog( //Der Dialog wird wie folgt aussehen
          title: const Text('Neue Notiz'), //es heißt eine Neue Notiz
          content: Column( //ist ein Column
          mainAxisSize: MainAxisSize.min,
          children: [//mit 2 Kinder
            TextField( //das Eine für den Titel
              controller: title, //für die Variabel title
              decoration: const InputDecoration(
                labelText: 'Titel eingeben', //worauf das steht, was in diesem Feld eingebeben wird ist dann der Titel
              ),
            ),
            TextField( //das Andere für die eigentliche Notiz
              controller: notiz, //für die Variabel Notiz
              decoration: const InputDecoration(
                labelText: 'Notiz eingeben', //das ist was darauf steht
              ),
            ),
          ],
        ),

        actions: [
          TextButton( //Fertig-Knopf wird auftauchen
            onPressed: () { // wenn der mal gedrückt wird
              _listit(title, notiz); //wird erstmal _listit aufgerufen!
              Navigator.of(context).pop(); // dann geht das ganze dann weg
            },
            child: const Text('fertig'), //das ist der Text des fertig-Knopfes
          ),
        ],
      );
    },
  );
}

//_listit ist eine Funktion erstellen mit Parameter titel und notiz, dsa wird beim _createNote aufgerufen, 
//und die Funktion speichert das in unsere Liste _notiz + _counter inkrementieren
void _listit(TextEditingController title, TextEditingController notiz){
  setState(() { //setState heißt, dass sich was aktualisiert werden muss
  _notizen.add({ //es wird der Liste _notizen hinzugefügt:
    'titel': title.text, //Der Titel der Notiz
    'notiz': notiz.text, //Die Notiz selbst
    });
    _counter++;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

body: Center( //In der Mitte des Bildschirms
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (_counter == 0) //Nur wenn _counter = 0 ist, wird der Text angezeigt
        const Text(
          'Sie haben noch keine Notizen erstellt, drücken Sie auf "+"',
        )
      else //sonst, die Liste
        ListenZeiger(notizen: _notizen),
    ],
  ),
),

  floatingActionButton: FloatingActionButton(
    onPressed: _createNote,
    tooltip: 'create note',
    child: const Icon(Icons.add),
  ),
  );
}
}
