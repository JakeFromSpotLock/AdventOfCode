//  This is crazy inefficient and needs improvement..
//  There may be some mathmatical formula for divisors that could help cheat
//  having to recalc or something, or storing found values for other smaller
//  factors...
//  Could be some snealy math with: https://en.wikipedia.org/wiki/Divisor_function#Approximate_growth_rate

void main() {
  //  From problem description
  final minPresents = 34000000;

  //  Keep checking until min present threshold reached...
  var houseNumber = 750000;
  var notEnoughPresents = true;
  while (notEnoughPresents) {
    final numGifts = calcHousesGifts(houseNumber);
    if (numGifts >= minPresents) {
      notEnoughPresents = false;
    } else {
      ++houseNumber;
    }
  }

  print(houseNumber);
}

int calcHousesGifts(int houseNumber) {
  //  1 and itself are always factors of anything
  Set<int> factors = {1, houseNumber};

  //  Find all other factors of the house number
  for (var i = 2; i <= houseNumber / 2; ++i) {
    if (houseNumber % i == 0) {
      factors.addAll({i, houseNumber ~/ i});
    }
  }

  //  Sum all factors and multiply by 10 to get number of gifts delivered
  return factors.fold(0, (total, element) => total + element) * 10;
}
