import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String textSalvo = "Nada Salvo!!!!";
  TextEditingController _controllerCampo = TextEditingController();

  _salvar() async {
    String valorDigitado = _controllerCampo.text;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valorDigitado);
  }

  _recuperar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      textSalvo = prefs.getString("nome") ?? "Sem valor";
    });
  }

  _remover() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");
    setState(() {
      textSalvo = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulacao de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              textSalvo,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Digite algo"),
              controller: _controllerCampo,
            ),
            Row(
              children: [
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Salvar",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: _salvar,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Ler",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: _recuperar,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Excluir",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: _remover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
