// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yesnoapp/components/my_button.dart';
import 'package:yesnoapp/components/my_textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text edit controllers
  final controladorUsuario = TextEditingController();
  final controladorContrasena = TextEditingController();

  //metodo iniciar sesion
  void inciarSesion(BuildContext context) async {
    String username = controladorUsuario.text;
    String password = controladorContrasena.text;

    if (username == 'admin' && password == 'admin') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);
      Navigator.pushNamed(context, 'principal');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Credenciales inválidas. Inténtalo de nuevo.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }

  //metodo guardar datos
  @override
  void initState() {
    //cargarPreferencias();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        leading: const Padding(padding: EdgeInsets.all(4.0)),
        title: const Text('Inicio de sesion'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50),
                //tex
                const Text(
                  'Iniciar sesion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 25),
                //Usuario textfield
                MyTextField(
                  controlador: controladorUsuario,
                  hintText: 'Usuario',
                  obscureText: false,
                ),
                //Contrasena textfield
                MyTextField(
                  controlador: controladorContrasena,
                  hintText: 'Contrasena',
                  obscureText: true,
                ),
                //guardar datos
                const SizedBox(
                  height: 6,
                ),
                //ingresar boton
                const SizedBox(height: 25),
                MyButton(
                  onTap: () => inciarSesion(context),
                ),
              ]),
        ),
      ),
    );
  }
}
