import 'dart:io';
import 'dart:math';

const maxTeaspoons = 100; //  From problem description

void main() async {
  try {
    List<List<int>> ingredientMetrics = [];
    final lines = await File('../_resources/input.txt').readAsLines();

    for (var line in lines) {
      //  Chocolate: capacity 0, durability 0, flavor -2, texture 2, calories 8
      //  Chocolate: capacity 0 durability 0 flavor -2 texture 2 calories 8
      //  0           1       2   3         4   5    6    7     8   9     10
      final pieces = line.replaceAll(',', '').split(' ');
      ingredientMetrics.add([
        int.parse(pieces[2]),
        int.parse(pieces[4]),
        int.parse(pieces[6]),
        int.parse(pieces[8]),
        int.parse(pieces[10])
      ]);
    }

    //  Combinatorics problem, distribute 100 into 4 categories
    //  C (n + k -1, k - 1)
    //  Where n = num teaspoons and k = ingredients
    //  C (103, 3) = 176,851
    final t = maxTeaspoons + ingredientMetrics.length - 1;
    final b = ingredientMetrics.length - 1;
    var numerator = maxTeaspoons + ingredientMetrics.length - 1;
    var denominator = ingredientMetrics.length - 1;
    for (var i = 1; i < b; i++) {
      numerator *= t - i;
      denominator *= b - i;
    }
    final numCombinations = numerator / denominator;

    //  Now for every possible combination of teaspoons across the different ingredients, calc the score
    var highestScore = 0;
    for (var i = 0; i < numCombinations; i++) {
      final ingredientCombo = unrankCombination(i, maxTeaspoons, ingredientMetrics.length);
      final score = calcCookieScore(ingredientCombo, ingredientMetrics);
      if (score[1] == 500 && score[0] > highestScore) {
        highestScore = score[0];
      }
    }

    print(highestScore);
  } catch (e) {
    print('Error: $e');
  }
}

List<int> calcCookieScore(List<int> combo, List<List<int>> metrics) {
  var capacity = 0;
  var durability = 0;
  var flavor = 0;
  var texture = 0;
  var calories = 0;

  for (var i = 0; i < combo.length; i++) {
    capacity += metrics[i][0] * combo[i];
    durability += metrics[i][1] * combo[i];
    flavor += metrics[i][2] * combo[i];
    texture += metrics[i][3] * combo[i];
    calories += metrics[i][4] * combo[i];
  }

  if (capacity < 1 || durability < 1 || flavor < 1 || texture < 1) {
    return [0, calories];
  } else {
    return [capacity * durability * flavor * texture, calories];
  }
}

int binomialCoefficient(int n, int k) {
  if (k > n) return 0;
  k = min(k, n - k);
  int c = 1;
  for (int i = 0; i < k; i++) {
    c = c * (n - i) ~/ (i + 1);
  }
  return c;
}

List<int> unrankCombination(int n, int total, int parts) {
  List<int> result = [];

  for (int i = 0; i < parts - 1; i++) {
    int x = 0;
    while (n >= binomialCoefficient(total - x + parts - i - 2, parts - i - 2)) {
      n -= binomialCoefficient(total - x + parts - i - 2, parts - i - 2);
      x++;
    }
    result.add(x);
    total -= x;
  }

  result.add(total); // Remaining teaspoons go to the last ingredient.
  return result;
}
