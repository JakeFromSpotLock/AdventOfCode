import 'dart:io';
import 'dart:convert';

// From problem description
const animationIterations = 100;
const gridSize = 100;

void main() async {
  try {
    // Initialize the lights from the input into the 100x100 grid
    List<List<bool>> lights = [];
    final file = File('../_resources/input.txt');
    Stream<String> lines = file.openRead().transform(utf8.decoder).transform(LineSplitter());
    await for (var line in lines) {
      lights.add(line.split('').map((c) => c == '#').toList());
    }

    //  Make the correction for the broken ON lights
    lights[0][0] = true;
    lights[0][99] = true;
    lights[99][0] = true;
    lights[99][99] = true;

    // Animate the lights
    for (var i = 0; i < animationIterations; i++) {
      lights = animate(lights);
    }

    // Count the number of lights that are on
    final lightsOn = lights.expand((row) => row).where((x) => x).length;

    // Print results
    print(lightsOn);
  } catch (e) {
    print('Error: $e');
  }
}

List<List<bool>> animate(List<List<bool>> grid) {
  final newGrid = List.generate(gridSize, (_) => List<bool>.filled(gridSize, false));

  for (int row = 0; row < gridSize; row++) {
    for (int col = 0; col < gridSize; col++) {
      if ((row == 0 || row == 99) && (col == 0 || col == 99)) {
        // Broken lights, leave on
        newGrid[row][col] = true;
        continue;
      }

      final count = getNumNeighborsOn(grid, row, col);
      if (grid[row][col]) {
        // Keeping an On light On
        newGrid[row][col] = (count == 2 || count == 3);
      } else {
        // Turning an Off light On
        newGrid[row][col] = (count == 3);
      }
    }
  }

  return newGrid;
}

int getNumNeighborsOn(List<List<bool>> grid, int row, int col) {
  int count = 0;
  for (int dr = -1; dr <= 1; dr++) {
    for (int dc = -1; dc <= 1; dc++) {
      if (dr == 0 && dc == 0) continue; // Skip the current cell
      final newRow = row + dr;
      final newCol = col + dc;
      if (newRow >= 0 && newRow < gridSize && newCol >= 0 && newCol < gridSize) {
        if (grid[newRow][newCol]) {
          count++;
        }
      }
    }
  }
  return count;
}
