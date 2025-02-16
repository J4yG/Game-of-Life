import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_of_life/features/game/domain/game_of_life_calculator.dart';

part 'grid_state.dart';

class GridCubit extends Cubit<GridState> {
  GridCubit()
      : super(GridChanged(
          grid: List.generate(150, (index) => false),
          changed: -1,
          isPlaying: false,
          iteration: 0,
        ));
  List<bool> _grid = List.generate(150, (index) => false);
  int _iteration = 0;
  late Timer? _timer;

  void toggleCell(int index) {
    _grid[index] = !_grid[index];
    emit(GridChanged(
      grid: _grid,
      changed: index,
      isPlaying: _timer?.isActive ?? false,
      iteration: _iteration,
    ));
  }

  void play() {
    emit(GridChanged(
      grid: _grid,
      changed: -1,
      isPlaying: true,
      iteration: _iteration,
    ));
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _iteration += 1;
      _grid = GameOfLifeCalculator.calculateNextGeneration(_grid);
      emit(GridChanged(
        grid: _grid,
        changed: -1,
        isPlaying: true,
        iteration: _iteration,
      ));
    });
  }

  void pause() {
    _timer?.cancel();
    emit(GridChanged(
      grid: _grid,
      changed: -1,
      isPlaying: false,
      iteration: _iteration,
    ));
  }

  void clear() {
    _timer?.cancel();
    _iteration = 0;
    _grid.fillRange(0, 150, false);
    emit(GridChanged(
      grid: _grid,
      changed: -1,
      isPlaying: false,
      iteration: _iteration,
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
