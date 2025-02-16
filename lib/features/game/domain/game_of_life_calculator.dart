class GameOfLifeCalculator {
  // Private constructor to prevent instantiation
  GameOfLifeCalculator._();

  static List<bool> calculateNextGeneration(List<bool> grid) {
    List<bool> newGrid = List.generate(grid.length, (index) => false);
    // Implementation of the Game of Life algorithm
    grid.asMap().forEach((index, cell) {
      int livingNeighbors = 0;

      // Check the 8 neighbors of the current cell
      // From top-left to bottom-right
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          // Skip the current cell
          if (i == 0 && j == 0) {
            continue;
          }
          int neighborIndex = index + i * 10 + j;
          if (
              // Check if the neighbor is within the grid
              neighborIndex >= 0 &&
                  neighborIndex < grid.length &&
                  // Check if the neighbor is in the same row
                  index % 10 + j >= 0 &&
                  // Check if the neighbor is in the same column
                  index % 10 + j < 10) {
            if (grid[neighborIndex]) {
              livingNeighbors++;
            }
          }
        }
      }
      // Apply the rules of the Game of Life
      if (cell && (livingNeighbors == 2 || livingNeighbors == 3)) {
        newGrid[index] = true;
      } else if (!cell && livingNeighbors == 3) {
        newGrid[index] = true;
      }
    });

    return newGrid;
  }
}
