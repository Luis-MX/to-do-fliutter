import 'package:bloc/bloc.dart';
import 'package:todo_app/features/todo/data/datasources.dart';
import 'package:todo_app/features/todo/domain/entities.dart';

enum ESTADO {INICIAL, ERROR, GUARDADO}

class ToDoBloc extends Bloc<EventoClick, EstadoBase> {
  Database _database;
  ToDoBloc() {
    _database = Database();
  }
  @override
  // TODO: implement initialState
  get initialState => EstadoInicial();

  @override
  Stream<EstadoBase> mapEventToState(EventoClick event) async* {
    String nombre = event.titulo;
    String tarea = event.tarea;
    if (tarea.isEmpty || nombre.isEmpty) {
      yield EstadoCamposVacios();
    } else {
      _database.save(ToDo(nombre, tarea));
    }
  }
}

/// Eventos de entrada en el bloc
///
/// En este caso solo se manejan los eventos de tipo click
class EventoClick {

  final String titulo;
  final String tarea;

  EventoClick(this.titulo, this.tarea);
}


/// Estados de salida en el bloc
///
/// En este caso solo se manejan los estados para
/// campos vacios y cuando se guarda exitosamente
class EstadoBase {
}

class EstadoInicial extends EstadoBase {}

class EstadoCamposVacios extends EstadoBase {}

class EstadoGuardado extends EstadoBase {}

