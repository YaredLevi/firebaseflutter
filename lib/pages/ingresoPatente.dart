import 'package:flutter/material.dart';
import 'package:productos1/models/PatenteModel.dart';
import 'package:productos1/providers/patentes_provider.dart';

class IngresoPatente extends StatefulWidget {
  IngresoPatente({Key key}) : super(key: key);

  @override
  _IngresoPatenteState createState() => _IngresoPatenteState();
}

class _IngresoPatenteState extends State<IngresoPatente> {
  bool activado = true;
  bool _guardando = false;
  final formKey = GlobalKey<FormState>();
  PatenteModel patente = new PatenteModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
        child: Form(
            //damos a identificación a el formulario para manejarlo
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Patente'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                _campoNombre(context),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Marca'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                _campoMarca(context),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Precio'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                _campoPrecio(context),
                SizedBox(height: 120),
                _botonGuardar(context),
                SizedBox(height: 16),
                _botonListado(context),
              ],
            )),
      ),
    ));
  }

  Widget _campoNombre(BuildContext context) {
    return TextFormField(
      initialValue: patente.patente,
      maxLength: 6,
      textCapitalization: TextCapitalization.characters,
      decoration:
          InputDecoration(labelText: 'Patente', border: OutlineInputBorder()),
      onSaved: (value) {
        patente.patente = value;
      },
      validator: (value) {
        if (value.length < 3) {
          return "Ingrese el nombre del producto";
        } else {
          return null;
        }
      },
    );
  }

  Widget _campoMarca(BuildContext context) {
    return TextFormField(
        initialValue: patente.marca,
        textCapitalization: TextCapitalization.sentences,
        decoration:
            InputDecoration(labelText: 'Marca', border: OutlineInputBorder()),
        onSaved: (value) {
          patente.marca = value;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Este campo no puede estar vacio';
          } else
            return null;
        });
  }

  //pasar string a number para validar campo numerico de precio
  bool isNumeric(String s) {
    if (s.isEmpty) return false;
    final n = num.tryParse(s);
    //si no recibo nada , no parsees , si recibo un dato parcea a number
    return (n == null) ? false : true;
  }

  Widget _campoPrecio(BuildContext context) {
    return TextFormField(
      initialValue: patente.precio.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration:
          InputDecoration(labelText: 'Precio', border: OutlineInputBorder()),
      onSaved: (value) {
        patente.precio = double.parse(value);
      },
      validator: (value) {
        if (isNumeric(value)) {
          return null;
        } else {
          return "Debe ingresar solo numeros";
        }
      },
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {
      //   _guardando = true;
    });

    PatentesProvider().crearProducto(patente);
    mostrarMensaje("Patente registrada");
    //Ejecutar un proceso
  }

  void mostrarMensaje(String texto) {
    final msg = SnackBar(
      content: Text(texto),
      duration: Duration(milliseconds: 1500),
    );

    ScaffoldMessenger.of(context).showSnackBar(msg);
  }

  Widget _botonGuardar(BuildContext context) {
    return ElevatedButton(
      onPressed: (_guardando) ? null : _submit,
      child: Row(
        children: [
          Icon(Icons.save),
          SizedBox(
            width: 79,
          ),
          Text(
            "GUARDAR",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _botonListado(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'home');
        },
        child: Row(
          children: [
            Icon(Icons.list_alt),
            SizedBox(
              width: 80,
            ),
            Text(
              "LISTADO",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
