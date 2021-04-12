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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Body Massa Index";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Body Massa Index";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);
      if (bmi < 18.5) {
        _infoText = "Underweight (BMI Anda ${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 18.5 && bmi < 24.99) {
        _infoText = "Normal Range (BMI Anda ${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 24.99 && bmi < 29.99) {
        _infoText = "Over Weight (BMI Anda ${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 29.99 && bmi < 34.99) {
        _infoText = "Obese Class I (BMI Anda ${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 34.99 && bmi < 39.99) {
        _infoText = "Obese Class II (BMI Anda ${bmi.toStringAsPrecision(4)})";
      } else if (bmi > 40) {
        _infoText = "Obese Class III (BMI Anda ${bmi.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Body Massa Index Calculator"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.blueGrey),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Weight (kg)",
                    labelStyle: TextStyle(color: Colors.blueGrey)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your weight!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Height (cm)",
                    labelStyle: TextStyle(color: Colors.blueGrey)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your height!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calculate",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
