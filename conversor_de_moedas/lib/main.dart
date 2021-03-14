import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import "dart:convert";

Uri request =
    Uri.parse("https://api.hgbrasil.com/finance?key=7a9cb85c&format=json");

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearFields();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearFields();
      return;
    }
    double dolarInput = double.parse(text);
    realController.text = (dolarInput * dolar).toStringAsFixed(2);
    euroController.text = (dolarInput * dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearFields();
      return;
    }
    double euroInput = double.parse(text);
    dolarController.text = (euroInput * euro / dolar).toStringAsFixed(2);
    realController.text = (euroInput * euro).toStringAsFixed(2);
  }

  void _clearFields() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _clearFields)
        ],
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "ERRO AO CARREGAR DADOS :(",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 150.0,
                            color: Colors.amber,
                          ),
                          Divider(),
                          buildTextField(
                              "Reais", "R\$", realController, _realChanged),
                          Divider(),
                          buildTextField(
                              "Dolar", "US\$", dolarController, _dolarChanged),
                          Divider(),
                          buildTextField(
                              "Euro", "€", euroController, _euroChanged)
                        ],
                      ));
                }
            }
          }),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    onChanged: f,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix,
        prefixStyle: TextStyle(color: Colors.amber, fontSize: 25.0)),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
