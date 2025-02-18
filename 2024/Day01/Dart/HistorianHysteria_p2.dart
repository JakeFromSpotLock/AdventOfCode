import 'dart:io';
import 'dart:convert';
import 'dart:core';

void main() async {
  try {
    //  1 - Get the file path
    final file = File('../_resources/input.txt');

    //  2 - Open file stream
    Stream<String> lines = file
        .openRead() //  Stream the files contents
        .transform(utf8.decoder) //  Decode bytes to UTF-8.
        .transform(LineSplitter()); //  Convert stream to individual lines

    //  3 - Get each integer on the line to make the left and right counts
    var leftCounts = {};
    var rightCounts = {};
    await for (var line in lines) {
      final pieces = line.split('   ');
      final leftInt = int.parse(pieces[0]);
      final rightInt = int.parse(pieces[1]);

      leftCounts[leftInt] = (leftCounts[leftInt] == null) ? 1 : leftCounts[leftInt] += 1;
      rightCounts[rightInt] = (rightCounts[rightInt] == null) ? 1 : rightCounts[rightInt] += 1;
    }

    //  4 - Calc
    var score = 0;
    leftCounts.forEach((key, value) {
      score += (key * value * (rightCounts[key] ?? 0)) as int;
    });

    //  5 - Print result
    print(score);
  } catch (e) {
    print('Error: $e');
  }
}
