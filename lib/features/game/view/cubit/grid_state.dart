part of 'grid_cubit.dart';

sealed class GridState extends Equatable {
  const GridState();

  @override
  List<Object> get props => [];
}

class GridInitial extends GridState {}

final class GridChanged extends GridState {
  final List<bool> grid;
  final int changed;
  final bool isPlaying;
  final int iteration;
  final int speed;

  const GridChanged({
    required this.grid,
    required this.changed,
    required this.isPlaying,
    required this.iteration,
    required this.speed,
  });

  @override
  List<Object> get props => [grid, changed, isPlaying, iteration, speed];
}
