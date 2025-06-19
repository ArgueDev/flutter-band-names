// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Nirvana', votes: 3),
    Band(id: '3', name: 'Pearl Jam', votes: 2),
    Band(id: '4', name: 'Red Hot Chili Peppers', votes: 1),
    Band(id: '5', name: 'The Beatles', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band Names'),
        shadowColor: Colors.black,
        elevation: 3,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('Direction: $direction');
        print('Id: ${band.id}');
        //TODO: Llamar el borrado en el server
      } ,
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle(color: Colors.white),)
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2))
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {

    final textController = TextEditingController();

    //* Estilo de dialogo para Android
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('New Band Name'),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () => addBandToList(textController.text),
            elevation: 5,
            textColor: Colors.indigo,
            child: Text('Add'),
          )
        ]
      ),
    );

    //* Estilo de dialogo para iOS
    // showCupertinoDialog(
    //   context: context, 
    //   builder: ( _ ) => CupertinoAlertDialog(
    //     title: Text('New Band Name'),
    //     content: CupertinoTextField(
    //       controller: textController,
    //     ),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         onPressed: () => addBandToList(textController.text),
    //         child: Text('Add'),
    //       ),
    //       CupertinoDialogAction(
    //         isDestructiveAction: true,
    //         onPressed: () => Navigator.pop(context), // Cerrar el dialogo
    //         child: Text('Cancel'),
    //       )
    //     ],
    //   )
    // );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      // Podemos agregar el nuevo nombre
      bands.add(Band(
        id: DateTime.now().toString(), // Generamos un ID único
        name: name,
        votes: 0, // Inicializamos los votos en 0
      ));
      setState(() {});
    }

    Navigator.pop(context); // Cerrar el dialogo
  }
}
