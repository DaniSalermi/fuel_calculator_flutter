import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  final _currencies = ['Pesos', 'Dólares', 'Euros'];
  final double _formDistance = 5.0;
  String result = '';
  String _currency = 'Pesos';
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
        appBar: AppBar(
          title: Text("Hola"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  controller: distanceController,
                  decoration: InputDecoration(
                      labelText: 'Distancia del viaje (km)',
                      hintText: 'ej. 124',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  controller: avgController,
                  decoration: InputDecoration(
                      labelText: 'Rendiemiento (km/L)',
                      hintText: 'ej. 70',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                          labelText: 'Precio',
                          hintText: 'ej. 800',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.number,
                    )),
                    Container(width: _formDistance * 5),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      value: _currency,
                      onChanged: (String value) {
                        _onDropdownChanged(value);
                      },
                    ))
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          onPressed: () {
                            setState(() {
                              result = _calculate();
                            });
                          },
                          child: Text(
                            'Enviar',
                            textScaleFactor: 1.5,
                          ))),
                  Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).buttonColor,
                          textColor: Theme.of(context).primaryColorDark,
                          onPressed: () {
                            setState(() {
                              result = _reset();
                            });
                          },
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.5,
                          ))),
                ],
              ),
              Text(result)
            ],
          ),
        ));
  }

  void _onDropdownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consuption = double.parse(avgController.text);
    double _totalCost = _distance / _consuption * _fuelCost;

    String _result = 'El costo total de tu viaje es: ' +
        _totalCost.toStringAsFixed(2) +
        ' ' +
        _currency;

    return _result;
  }

  _reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';
    setState(() {
      result = '';
    });
  }
}
