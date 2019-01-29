import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Informe seus dados!";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText="Informe seus dados!";
    });
  }

  void _calculate(){
   setState(() {
     double weight = double.parse(weightController.text);
     double height = double.parse(heightController.text)/100;
     double imc = weight/(height*height);
     if(imc<18.6){
       _infoText="Abaixo do peso.\n IMC = ${imc.toStringAsPrecision(3)}";
     }else if(imc>=18.6 && imc < 24.9){
       _infoText="Peso ideal.\n IMC = ${imc.toStringAsPrecision(3)}";
     }else if(imc>=24.9 && imc < 29.9){
       _infoText="Levemente acima do peso.\n IMC = ${imc.toStringAsPrecision(3)}";
     }else if(imc >=29.9 && imc < 34.9){
       _infoText="Obesidade grau 1.\n IMC = ${imc.toStringAsPrecision(3)}";
     }else if(imc >= 34.9 && imc < 39.9){
       _infoText="Obesidade grau 2.\n IMC = ${imc.toStringAsPrecision(3)}";
     }else if(imc>=39.9){
       _infoText="Obesidade grau 3.\n IMC = ${imc.toStringAsPrecision(3)}";
     }
   });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120, color: Colors.lightBlue),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.lightBlue)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.lightBlue)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child:  RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    color: Colors.lightBlue,
                  ),
                ),
              ),
              Text(_infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue, fontSize: 25.0),)
            ],
          ),
        ),
      ),
    );
  }
}
