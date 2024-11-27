import 'dart:io';

//  If we treat this probably like a circular connected graph, and we then
//  simply sum up the happiness change of a connection for both people to
//  create a single valued edge, we can solve this similarly to SingleNight_p1
//  by finding the most optimal permutation
void main() async {
  try {
    final dist = <String, int>{};
    Set<String> attendees = {};

    final lines = await File('../_resources/input.txt').readAsLines();

    for (var line in lines) {
      //  Split by spaces, important pieces are always at the same index. Input of form:
      //  {name1} would {direction} {#} happiness units by sitting next to {name2}.
      //  0               2          3                                        10
      //  Use the substring to remove the '.' at the end, which messes up the names
      final pieces = line.substring(0, line.length - 1).split(' ');

      final key = _getKey(pieces[0], pieces[10]);
      final value = (pieces[2] == 'gain') ? int.parse(pieces[3]) : 0 - int.parse(pieces[3]);
      dist[key] = (dist[key] == null) ? value : dist[key]! + value;

      attendees.addAll([pieces[0], pieces[10]]);
    }

    //  For part two we need to add ourselves to the seating chart
    final myName = 'Jake';
    attendees.forEach((name) {
      final key = _getKey(name, myName);
      dist[key] = 0;
    });
    attendees.add(myName);

    final names = attendees.toList();
    print(names);

    final permutations = _getPermutations(names);

    final happyPointConfigurations = permutations.map((seatingChart) {
      return _calculateHappyPoints(seatingChart, dist);
    }).toList();

    // Sort distances and get shortest and longest paths
    happyPointConfigurations.sort();

    //  Print results
    print(happyPointConfigurations.last);
  } catch (e) {
    print('Error: $e');
  }
}

String _getKey(String name1, String name2) {
  final sortedNames = [name1, name2];
  sortedNames.sort();
  return sortedNames[0] + sortedNames[1];
}

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

int _calculateHappyPoints(List<String> seatingChart, Map<String, int> dist) {
  int total = 0;
  for (int i = 0; i < seatingChart.length - 1; i++) {
    final key = _getKey(seatingChart[i], seatingChart[i + 1]);
    total += dist[key] ?? 0;
  }
  // Add the first last pair b/c the table is circular and wraps around
  total += dist[_getKey(seatingChart.first, seatingChart.last)] ?? 0;
  return total;
}
