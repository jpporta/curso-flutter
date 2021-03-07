import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _information = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _information = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    setState(() {
      if (imc < 18.6)
        _information = "Abaixo do peso: ";
      else if (imc < 24.9)
        _information = "Peso ideal: ";
      else if (imc < 29.9)
        _information = "Levemente acima do peso: ";
      else if (imc < 34.9)
        _information = "Obesidade Grau I: ";
      else if (imc < 39.9)
        _information = "Obesidade Grau II: ";
      else if (imc < 40)
        _information = "Obesidade Grau III: ";
      else
        _information = "Acima do peso: ";
      _information += "${imc.toStringAsPrecision(4)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value.isEmpty ? "Insira seu peso!" : null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle:
                            TextStyle(color: Colors.green, fontSize: 20)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: weightController,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value.isEmpty ? "Insira sua altura!" : null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle:
                            TextStyle(color: Colors.green, fontSize: 20)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: heightController,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                    child: Container(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) _calculate();
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                      ),
                    ),
                  ),
                  Text(_information,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25.0))
                ],
              ),
            )));
  }
}
