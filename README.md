# Aplicacion To-DO

Aplicacion que expone como adminstras usuarios y datos cambiantes en tiempo real con Flutter.

## Inicio Rapido en Flutter

Si este proyecto se crea desde linea de comandos, puede ser generado con el mismpo nombre y paquete
con el siguiente comando:

```bash
flutter create -i swift -a kotlin --androidx --org cozcyt.gob.mx --project-name todo_app carpeta
```

El comando anterior genera un proyecto usando los lenguajes Kotlin y Swift del lado nativo,
con **--org** se define un identificador de la persona o empresa que crea la aplicacion,
**--project-name**  es el nombre de la aplicacion que junto a --org forma el paquete o identificador
de la aplicacion, necesario para identificar la aplicacion en el sistema y las tiendas.

Es importante ejecutar la aplicacion en un emulador o un dispositivo antes continuar con otra configuracion.

## Inicio Rapido en Firebase

Para facilitar la configuracion se puede consultar la siguiente [liga en firebase](https://firebase.google.com/docs/flutter/setup?hl=es-419):

En resumen, los pasos son los siguientes el caso de la plataforma de Android:

1. Una vez tengas tu proyecto flutter, localiza el paquete de la aplicacion en `android/app/build.gradle`,
que en este caso es `cozcyt.gob.mx.todo_app`:
```gradle
...
    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "cozcyt.gob.mx.todo_app"
        minSdkVersion 16
        targetSdkVersion 28
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }
...
```
2. Ir a la [consola de firebase](https://console.firebase.google.com).

3. Crear un nuevo proyecto, en el cual al terminar de configurar, buscar y elegir la opcion de crear
una nueva aplicacion que en este caso es para Android.

4. Llenar el formulario con un nombre que identifique la aplicacion y paquete de la aplicacion.

5. Opcionalmente, se puede agregar la clave SHA1 que es necsaria para usar autenticacion con Google,
verificacion de numero de telefono, firebase messaging, entre otros.

Para obtenerla es muy facil, en Mac o Linux se puede ejecutar la siguiente instruccion en la
terminal en la carpeta `android`:

```bash
./gradlew signingReport
```

En Windows se puede ejecutar la siguiente instruccion en el simbolo de sistema dentro de la carpeta
`android` ejecutando el archivo `gradlew.bat`:

```bash
gradlew signingReport
```

6. Descaragar el archivo que da firebase y colocarlo en `android/app/google-services.json`.

7. Agregar la linea indicada en `android/build.gradle`:

```bash
buildscript {
    ext.kotlin_version = '1.3.50'
    repositories {
        google()
        jcenter()
    }

    dependencies {
        classpath 'com.google.gms:google-services:3.2.1' // Agregar esta linea
        classpath 'com.android.tools.build:gradle:3.5.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
...
```

Agregar la siguiente linea al final del archivo `android/app/build.gradle`:

```bash
apply plugin: 'com.google.gms.google-services'
```

8. Para terminar la configuracion, saltarse los pasos restantes del asistente de firebase y ejecutar
la aplicacion para para comprobar que que la conexion es exitosa.
