import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/features/game/view/cubit/grid_cubit.dart';
import 'package:game_of_life/features/game/view/widgets/game_app_bar.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GridCubit, GridState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: const Text('Game of Life')),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10, // Number of columns
                      ),
                      itemCount: 150, // Number of items (10x15 grid)
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () =>
                              context.read<GridCubit>().toggleCell(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: state is GridChanged && state.grid[index]
                                  ? Colors.green
                                  : Colors.grey,
                              border: Border.all(color: Colors.blueGrey),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Moves: ${state is GridChanged ? state.iteration : 0}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Speed: ${state is GridChanged ? state.speed : 1}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          bottomNavigationBar: GameAppBar(),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: state is GridChanged && state.isPlaying
                ? Colors.red
                : Colors.green,
            onPressed: () {
              if (state is GridChanged && state.isPlaying) {
                context.read<GridCubit>().pause();
              } else {
                context.read<GridCubit>().play();
              }
            },
            child: Icon(
              state is GridChanged && state.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              size: 32,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
