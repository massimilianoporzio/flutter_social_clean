import 'package:flutter/material.dart';
import 'package:flutter_social_clean/src/features/chat/data/models/chat_model.dart';
import 'package:flutter_social_clean/src/features/chat/data/models/message_model.dart';
import 'package:flutter_social_clean/src/shared/data/models/post_model.dart';
import 'package:flutter_social_clean/src/shared/data/models/user_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loggy/loggy.dart';
import 'src/services/service_locator.dart' as di; //dependecy injection

import 'src/my_app.dart';

Future<void> main() async {
  //si assicura che tutto sia inizializzato a livello native
  WidgetsFlutterBinding.ensureInitialized();
  //HIVE INIT
  await Hive.initFlutter();
  //HIVE REGISTER MY ADAPTERS
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(MessageModelAdapter());
  Hive.registerAdapter(ChatModelAdapter());
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
