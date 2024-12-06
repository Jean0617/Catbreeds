import 'package:catbreeds/blocs/home/home_bloc.dart';
import 'package:catbreeds/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const CatbreedsApp());
}

class CatbreedsApp extends StatelessWidget {
  const CatbreedsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => HomeBloc())
      ], 
      child: MaterialApp(
        title: 'CatBreeds',
        initialRoute: AppRoutes.home,
        routes: AppRoutes.buildRoutes(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        )
      )
    );
  }
}
