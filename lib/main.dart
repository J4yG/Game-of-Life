import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/core/router.dart';
import 'package:game_of_life/features/game/view/cubit/grid_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GridCubit()..init()),
      ],
      child: MaterialApp.router(
        title: 'Game of Life',
        routerConfig: router,
      ),
    );
  }
}
