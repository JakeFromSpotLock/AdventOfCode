import 'dart:io';

void main() async {
  // Parse distances into a map
  final dist = <String, int>{};
  Set<String> locs = {};

  // Read all lines from input and parse input
  final lines = await File('../_resources/input.txt').readAsLines();
  for (var line in lines) {
    final parts = line.split(' '); // Split line by spaces
    if (parts.length != 5) continue; // Skip invalid lines

    final x = parts[0]; // First location
    final y = parts[2]; // Second location
    final d = int.parse(parts[4]); // Distance

    dist[_getKey([x, y])] = d; // Store distance with sorted keys
    locs.addAll([x, y]);
  }

  // Get all unique locations
  final locations = locs.toList();

  // Calculate permutations of locations
  final permutations = _getPermutations(locations);

  // Calculate path distances for each permutation
  final distances = permutations.map((path) {
    return _calculatePathDistance(path, dist);
  }).toList();

  // Sort distances and get shortest and longest paths
  distances.sort();

  // Print results
  print(distances.first);
}

/// Calculate the total distance for a specific path
int _calculatePathDistance(List<String> path, Map<String, int> dist) {
  int total = 0;
  for (int i = 0; i < path.length - 1; i++) {
    final key = _getKey([path[i], path[i + 1]]);
    total += dist[key] ?? 0; // Add distance if key exists
  }
  return total;
}

/// Generate all permutations of a list
List<List<T>> _getPermutations<T>(List<T> items) {
  if (items.length <= 1) return [items];
  final permutations = <List<T>>[];

  for (int i = 0; i < items.length; i++) {
    final remaining = List.of(items)..removeAt(i);
    final subPermutations = _getPermutations(remaining);
    for (var sub in subPermutations) {
      permutations.add([items[i], ...sub]);
    }
  }

  return permutations;
}

String _getKey(List<String> cities) {
  cities.sort();
  return cities[0] + cities[1];
}
