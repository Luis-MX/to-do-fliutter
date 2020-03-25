import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerPassword2 = TextEditingController();

  bool ocultarPassword = true;
  bool registrando = false;

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _controllerEmail,
                readOnly: registrando,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (String email) {
                  if (email.isEmpty)  return "Este campo no puede estar vacio";
                  else return null;
                },
              ),
              TextFormField(
                controller: _controllerPassword,
                readOnly: registrando,
                obscureText: ocultarPassword,
                decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  suffix: IconButton(
                    icon: Icon(Icons.remove_red_eye, color: ocultarPassword ? Colors.grey : Colors.blue,),
                    onPressed: () {
                      setState(() {
                        ocultarPassword = !ocultarPassword;
                      });
                    },
                  )
                ),
                validator: (String password) {
                  if (password.isEmpty)  return "Este campo no puede estar vacio";
                  else if (password.trim().length <= 8)  return "La contraseña debe tener al menos 8 caracteres";
                  else return null;
                },
              ),
              TextFormField(
                controller: _controllerPassword2,
                obscureText: ocultarPassword,
                readOnly: registrando,
                decoration: InputDecoration(
                    labelText: 'Confirmar Password',
                    prefixIcon: Icon(Icons.lock),
                ),
                validator: (String password) {
                  if (_controllerPassword.text.trim() != password.trim())  return "Los 2 password deben ser iguales";
                  else return null;
                },
              ),
              RaisedButton(
                child: Text("Crear cuenta"),
                color: registrando ? Colors.orange : Colors.blue,
                onPressed: registrando ? null : () async {
                  print('Validando');
                  if (
                  _controllerEmail.text.trim().isNotEmpty &&
                      _controllerPassword.text.trim().length >= 8 &&
                  _controllerPassword.text.trim() == _controllerPassword2.text.trim()
                  ) {
                    // Todos los datos son correctos; se registra una cuenta
                    setState(() {
                      registrando = true;
                    });
                    AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _controllerEmail.text.trim(), password: _controllerPassword.text.trim()
                    );
                    if (result.user == null) {
                      setState(() {
                        registrando = false;
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                  } else {
                    // Los datos estan vacios o incorrectos
                    print('NO valido');
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
