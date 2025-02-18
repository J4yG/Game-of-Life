import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_of_life/features/game/domain/game_of_life_calculator.dart';
import 'package:pausable_timer/pausable_timer.dart';

part 'grid_state.dart';

class GridCubit extends Cubit<GridState> {
  GridCubit() : super(GridInitial());
  late List<bool> _grid;
  late int _iteration;
  late int _speed;
  late bool _isPlaying;
  PausableTimer? _timer;

  init() async {
    _iteration = 0;
    _speed = 1;
    _isPlaying = false;
    _grid = List.generate(150, (index) => false);
    await _createTimer();

    emit(GridChanged(
      grid: _grid,
      changed: -1,
      isPlaying: _isPlaying,
      iteration: _iteration,
      speed: _speed,
    ));
  }

  void toggleCell(int index) {
    _grid[index] = !_grid[index];
    _iteration = 0;
    emit(GridChanged(
      grid: _grid,
      changed: index,
      isPlaying: _isPlaying,
      iteration: _iteration,
      speed: _speed,
    ));
  }

  void play() {
    _isPlaying = true;
    _timer?.start();
  }

  void pause() {
    _isPlaying = false;
    _timer?.pause();
    emit(GridChanged(
      grid: _grid,
      changed: -1,
      isPlaying: _isPlaying,
      iteration: _iteration,
      speed: _speed,
    ));
  }

  void clear() {
    _isPlaying = false;
    _timer?.pause();
    _iteration = 0;
    _grid.fillRange(0, 150, false);
    emit(GridChanged(
      grid: _grid,
      changed: -1,
      isPlaying: _isPlaying,
      iteration: _iteration,
      speed: _speed,
    ));
  }

  Future<void> toggleSpeed() async {
    if (_speed < 5) {
      _speed += 1;
    } else {
      _speed = 1;
    }
    emit(GridChanged(
      grid: _grid,
      changed: -1,
      isPlaying: _isPlaying,
      iteration: _iteration,
      speed: _speed,
    ));
    await _createTimer();
    if (_isPlaying) {
      _timer?.start();
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> _createTimer() async {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = PausableTimer.periodic(
        Duration(milliseconds: 1100 - (200 * _speed)), () {
      _iteration += 1;
      _grid = GameOfLifeCalculator.calculateNextGeneration(_grid);
      emit(GridChanged(
        grid: _grid,
        changed: -1,
        isPlaying: _isPlaying,
        iteration: _iteration,
        speed: _speed,
      ));
    });
  }
}
