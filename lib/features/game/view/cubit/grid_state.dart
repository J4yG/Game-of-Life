part of 'grid_cubit.dart';

sealed class GridState extends Equatable {
  const GridState();

  @override
  List<Object> get props => [];
}

final class GridChanged extends GridState {
  final List<bool> grid;
  final int changed;
  final bool isPlaying;
  final int iteration;

  const GridChanged({
    required this.grid,
    required this.changed,
    required this.isPlaying,
    required this.iteration,
  });

  @override
  List<Object> get props => [grid, changed, isPlaying, iteration];
}
