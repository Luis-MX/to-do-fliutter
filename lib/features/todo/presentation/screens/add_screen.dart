import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/blocs/todo_bloc.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final ToDoBloc _bloc = ToDoBloc();

  final TextEditingController _controllerNombre = TextEditingController();
  final TextEditingController _controllerTarea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo To Do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ToDoBloc, EstadoBase>(
          bloc: _bloc,
          builder: (context, snapshot) {
            if (snapshot is EstadoInicial) {
              return Column(
                children: <Widget>[
                  TextField(
                    controller: _controllerNombre,
                    decoration: InputDecoration(
                        labelText: 'Nombre'
                    ),
                  ),
                  TextField(
                    controller: _controllerTarea,
                    decoration: InputDecoration(
                        labelText: 'Tarea'
                    ),
                    maxLines: 5,
                  ),
                ],
              );
            } else if (snapshot is EstadoCamposVacios) {
              return Column(
                children: <Widget>[
                  TextField(
                    controller: _controllerNombre,
                    decoration: InputDecoration(
                        labelText: 'Nombre',
                        errorText: 'Este campo es obligatorio'
                    ),
                  ),
                  TextField(
                    controller: _controllerTarea,
                    decoration: InputDecoration(
                        labelText: 'Tarea',
                        errorText: 'Este campo es obligatorio'
                    ),
                    maxLines: 5,
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          // Guardar los datos
          _bloc.add(EventoClick(_controllerNombre.text, _controllerTarea.text));
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
