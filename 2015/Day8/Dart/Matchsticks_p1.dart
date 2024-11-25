import 'dart:io';

void main() async {
  try {
    //  1 - Get file contents and init counters
    final lines = await File('../_resources/input.txt').readAsLines();
    var numCharsOfCode = 0;
    var numCharsInMem = 0;

    for (var line in lines) {
      //  2 - Total the actual numbers of characters
      numCharsOfCode += line.length;

      //  3 - Replace escaped chars
      var newStr = line
          .substring(1, line.length - 1)
          .replaceAll(r'\\', '-')
          .replaceAll(r'\"', '-')
          .replaceAll(RegExp(r'\\x([0-9a-fA-F]{2})'), '-');

      //  4 - Tally the mem chars
      numCharsInMem += newStr.length;
    }

    //  5 - Print results
    print(numCharsOfCode - numCharsInMem);
  } catch (e) {
    print('Error: $e');
  }
}
