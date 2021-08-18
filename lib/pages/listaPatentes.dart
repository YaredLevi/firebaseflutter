import 'package:flutter/material.dart';
import 'package:productos1/models/PatenteModel.dart';
import 'package:productos1/providers/patentes_provider.dart';

class ListaPatentes extends StatefulWidget {
  ListaPatentes({Key key}) : super(key: key);

  @override
  _ListaPatentesState createState() => _ListaPatentesState();
}

class _ListaPatentesState extends State<ListaPatentes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado"),
      ),
      body: _crearListado(),
      //floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: PatentesProvider().cargarPatentes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<PatenteModel>> snapshot) {
        if (snapshot.hasData) {
          final patente = snapshot.data;

          return ListView.builder(
            itemCount: patente.length,
            itemBuilder: (context, i) => _crearItem(context, patente[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, PatenteModel patente) {
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          child: Icon(
            Icons.delete,
          ),
          color: Colors.red,
        ),
        onDismissed: (direction) {
          PatentesProvider().borrarProducto(patente.id);
        },
        child: Card(
          child: Column(
            children: [
              ListTile(
                  title: Text(
                    'Patente: ${patente.patente.toUpperCase()}',
                    style: TextStyle(
                        color: Colors.blue[400], fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Marca: ${patente.marca}'),
                        Text('Valor: ${patente.precio}'),
                      ]),
                  onTap: () {
                    Navigator.pushNamed(context, 'ingreso', arguments: patente);
                  })
            ],
          ),
        ));
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.green,
      onPressed: () {
        Navigator.pushNamed(context, 'ingreso');
      },
    );
  }
}
