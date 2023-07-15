import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';
import 'src/logs/bloc_observer.dart';
import 'src/services/service_locator.dart' as di; //dependecy injection

import 'src/my_app.dart';

void main() {
  //si assicura che tutto sia inizializzato a livello native
  WidgetsFlutterBinding.ensureInitialized();
  //iniziallizza il logger con la stampa a video colorata
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(),
  );
  di.init(); //init del service locator
  //observer di tutti i bloc
  //Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}




// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flutter App with Clean Architecture"),
//       ),
//       bottomNavigationBar: const CustomNavBar(),
//     );
//   }
// }
