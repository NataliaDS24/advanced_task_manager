Advanced Task Manager – Flutter App

Advanced Task Manager es una aplicación desarrollada en Flutter que permite gestionar tareas, editar y actualizar su estado, consumir algunas de estas a través de una Api con dio, para luego integrarse con una base de datos local utilizando sqliflite; consumir información de una API pública usando GraphQL para otro modulo de la app sobre países. Fue construida como parte de una prueba técnica enfocada en arquitectura limpia, manejo de estado con Riverpod, persistencia local con sqflite y pruebas unitarias/UI.

Características principales
1. Gestión de tareas (CRUD parcial)
   
   - Listado de tareas almacenadas localmente en SQLite.
   - Registro de nuevas tareas mediante formulario validado.
   - Edición de tareas existentes.
   - Cambio de estado (Pending, In Progress, Completed) desde el listado.
   - Actualización visual inmediata mediante notifiers y Riverpod.
   - Actualización de estado a Completed a traves de checkbox.
   - Reutilización limpia para registro, detalle y actualización de las Task.

2. API pública mediante Dio
    Consumo de las tareas iniciales desde:
    https://jsonplaceholder.typicode.com/

  - Implementación usando dio con uso de trycath.
  - Base para futura paginación.
  - Validación e inicialización en el Notifier del splash screen.
  - Validación en caso de registros en la base de datos.

3. Base de datos Local con sqflite:

  - Creación de manager de la base datos para inicialización y posibles actualizaciones.
  - Creación de tabla con id autoincrementable para las tareas.
  - Implementación de provider para uso global en core/init_providers.dart.
  - Metodos para get, insert y update en la tabla tasks_table.dart.
  - Serialización mediante extensiones y utilidades de fechas.

4. API pública mediante GraphQL
    Consumo de países desde:
    https://countries.trevorblades.com/

    - Implementación usando graphql_flutter.

    - Manejo completo de:
        Carga inicial
        Error de red
        Reintento
        Listado visual con bandera y nombre del país

    - Inicialización de provider global en core/init_providers.dart.

5. Manejo de estado con Riverpod (StateNotifier)

   - Separación clara entre estado inmutable y lógica.

   - Notifiers especializados por screen:
        HomeNotifier
        TaskActionNotifier
        CountriesNotifier

6. Pruebas unitarias y de UI

    Modulo Countries:
        Tests de repositorios (mock GraphQLClient)
        Tests de notifiers (carga, éxito, error)
        Tests de UI para countries_screen.dart
        

Arquitectura del proyecto

lib/
│
├── core/                  # Inicializador de providers (Dio, GraphQL, Sqflite)
├── config/                # Temas, colores, fuentes, rutas
├── data/
│   ├── api_helper/        # Constantes y config GraphQL
│   ├── repositories/      # Repositorios (DB y API)
│   └── sqlite/            # Tablas, helpers
│
├── enums/                 # Enums y prioridades
├── models/                # Modelos / factories
├── ui/
│   ├── screens/           # Pantallas principales
│   └── widgets/           # Widgets reutilizables
│
└── utils/                 # Extensiones y utilidades

Siguiendo principios de separación de responsabilidades:

    UI: Renderiza únicamente el estado.
    StateNotifier: Contiene toda la lógica.
    Repository: Abstrae DB o API.
    Models: Estructuras inmutables.

Tecnologías utilizadas

    Área	Tecnología
    Lenguaje	Flutter (Dart 3)
    Manejo de estado	Riverpod (StateNotifier)
    API remota	GraphQL / graphql_flutter
    API json ded ejemplo Dio / dio
    Persistencia SQLite (sqflite)
    Pruebas	flutter_test, mocktail
    Estilo	Material Design

Requisitos previos

 Antes de ejecutar el proyecto necesitas:

    Flutter 3.x o superior
    Dart 3.x
    Emulador Android/iOS o dispositivo físico

Instalación

Clonar el repositorio:

    git clone https://github.com/NataliaDS24/advanced_task_manager.git
    cd advanced_task_manager

Instalar dependencias:

    flutter pub get


Ejecutar la app:

    flutter run

Pruebas

    Ejecutar tests unitarios
    flutter test

Autor
Natalia Díaz Serrano
Desarrolladora Flutter