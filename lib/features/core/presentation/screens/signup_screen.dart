import 'package:flutter/material.dart';


/// # Registro de usuario
///
/// Esta pantalla contiene un formulario
/// para registrar los datos de una cuenta nueva.
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  // Este objeto me da acceso a la validacion de formularios
  GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  // Me da acceso al texto de password para comparar si son iguales
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrarme"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autovalidate: true,
                validator: (String email) {
                  if (email.isEmpty)  return "Este campo no puede estar vacio";
                  else return null;
                },
              ),
              TextFormField(
                controller: _controller,
                autovalidate: true,
                validator: (String password) {
                  if (password.isEmpty)  return "Este campo no puede estar vacio";
                  else if (password.trim().length <= 8)  return "La contraseña debe tener al menos 8 caracteres";
                  else return null;
                },
              ),
              TextFormField(
                autovalidate: true,
                validator: (String password) {
                  if (_controller.text != password)  return "Los 2 password deben ser iguales";
                  else return null;
                },
              ),
              RaisedButton(
                child: Text("Crear cuenta"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // Todos los datos son correctos; se registra una cuenta
                  } else {
                    // Los datos estan vacios o incorrectos
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
