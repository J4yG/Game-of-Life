import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/features/game/view/cubit/grid_cubit.dart';

class GameAppBar extends StatelessWidget {
  const GameAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey,
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(),
        StadiumBorder(),
      ),
      notchMargin: 6.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            iconSize: 32,
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.clear),
            iconSize: 32,
            onPressed: () {
              context.read<GridCubit>().clear();
            },
          ),
          SizedBox(width: 48), // The dummy child for the FAB
          IconButton(
            icon: Icon(Icons.speed),
            iconSize: 32,
            onPressed: () {
              context.read<GridCubit>().toggleSpeed();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            iconSize: 32,
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
