import 'dart:io';

//  From problem description
const totalEggNog = 150;

//  https://en.wikipedia.org/wiki/Subset_sum_problem
//  https://www.geeksforgeeks.org/subset-sum-problem-dp-25/

void main() async {
  //  Read input file and parse container capacities
  final file = File('../_resources/input.txt');
  final containers = (await file.readAsLines()).map(int.parse).toList();

  //  Get all combinations of containers
  final allCombinations = getCombinations(containers);

  //  Count combinations that sum to the target capacity
  final validCombinations = allCombinations.where((combo) => combo.sum == totalEggNog).toList();
  print(validCombinations.length);
}

//  Helper function: Get all combinations of a list
List<List<T>> getCombinations<T>(List<T> items) {
  List<List<T>> result = [[]];
  for (var item in items) {
    result += result.map((combo) => [...combo, item]).toList();
  }
  return result;
}

//  Extension method to calculate the sum of a list
extension SumExtension on List<int> {
  int get sum => fold(0, (a, b) => a + b);
}
