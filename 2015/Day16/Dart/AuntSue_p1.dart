import 'dart:io';

//  From Problem Description:
const tickerTape = {
  'children': 3,
  'cats': 7,
  'samoyeds': 2,
  'pomeranians': 3,
  'akitas': 0,
  'vizslas': 0,
  'goldfish': 5,
  'trees': 3,
  'cars': 2,
  'perfumes': 1
};

void main() async {
  try {
    final lines = await File('../_resources/input.txt').readAsLines();

    for (var line in lines) {
      //  Example Input:  Sue 1: goldfish: 9, cars: 0, samoyeds: 9
      //  Sue {#}: {item_1}: {#}, {item_2}: {#}, {item_3}: {#}
      //  Sue # item_1 # item_2 # item_3 #
      //  0   1   2     3   4   5   6     7
      final pieces = line.replaceAll(',', '').replaceAll(':', '').split(' ');

      if (tickerTape[pieces[2]] == int.parse(pieces[3]) &&
          tickerTape[pieces[4]] == int.parse(pieces[5]) &&
          tickerTape[pieces[6]] == int.parse(pieces[7])) {
        print(pieces[1]);
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}
