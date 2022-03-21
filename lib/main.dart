import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  List<double> listRiwayatKonversi = [];
  List<String> listNamaSuhu = [];

  TextEditingController textFieldController = TextEditingController();
  double celcius = 0.0;
  double reamur = 0.0;
  double kelvin = 0.0;
  double hasil = 0.0;
  String _newValue = "Kelvin";

  var listitem = [
    "Reamur",
    "Kelvin",
  ];

  hitungReamur(){
    setState(() {
      celcius = double.parse(textFieldController.text);
      reamur = (4 * celcius) / 5;
      hasil = reamur;
      listNamaSuhu.add("Reamur");
      listRiwayatKonversi.add(hasil);
    });
  }

  hitungKelvin(){
    setState(() {
      celcius = double.parse(textFieldController.text);
      kelvin = celcius + 273.15;
      hasil = kelvin;
      listNamaSuhu.add("Kelvin");
      listRiwayatKonversi.add(hasil);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      home:Scaffold(
        appBar: AppBar(
        title: Text("Konverter Suhu"),
        ),
      body: Container(
        child: Column(
          children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
            controller: textFieldController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Masukan Suhu Dalam Celcius',
            ),
            validator: (value){
              if(value == String){
                return 'Inputan yang di ijinkan hanya angka';
              }
              return null;
            },
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: DropdownButton<String>(
                items: 
                  listitem.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),);
                }).toList(),
                value: _newValue,
                onChanged: (String? changeValue) {
                  setState(() {
                    _newValue = changeValue!;
                    if(_newValue == "Kelvin"){
                      hitungKelvin();
                    } else {
                      hitungReamur();
                    }
                  });
                },
                
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Column(
                  children: [
                    Text("Hasil", style: TextStyle(fontSize: 25),),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("$hasil", style: TextStyle(fontSize: 25),),
                    )
                  ],
                )
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
              ),
                onPressed: () {
                  if(_newValue == "Kelvin"){
                    hitungKelvin();
                  } else {
                    hitungReamur();
                  }
                },
                child: Text("Konversi Suhu", style: TextStyle(fontSize: 20),)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Riwayat Konversi", style: TextStyle(fontSize: 20),),
            
          ),Expanded(child: ListView.builder(itemCount: listRiwayatKonversi.length,itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(listNamaSuhu[index] + " : ", style: TextStyle(fontSize: 15),),
                  Text(listRiwayatKonversi[index].toString(), style: TextStyle(fontSize: 15),),
                ],
              ),
            );
          }))
        ],
        ),
      ),
      
      ),
    );
  }
}
