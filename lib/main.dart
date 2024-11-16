import 'package:flutter/material.dart';
import 'package:myapp/MovieSearchScreen/movie_search_screen.dart';
import 'package:myapp/MovieSearchScreen/search_provider.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
// import 'package:search_box_using_imdb/MovieSearchScreen/Movie_search_screen.dart';
// import 'package:search_box_using_imdb/MovieSearchScreen/search_provider.dart';

void main() async {
  // await dotenv.load();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => SearchProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MovieSearchScreen(),
    );
  }
}
