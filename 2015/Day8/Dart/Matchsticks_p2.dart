import 'dart:io';

void main() async {
  try {
    //  1 - Get file contents and init counters
    final lines = await File('../_resources/input.txt').readAsLines();
    var numCharsOfCode = 0;
    var numCharsEncoded = 0;

    for (var line in lines) {
      //  2 - Total the actual numbers of characters
      numCharsOfCode += line.length;

      //  3 - Encode the chars
      //  Only \ -> \\ is necessary b/c it will also correct the start of \x..
      var newStr = '"${line.replaceAll(r'\', r'\\').replaceAll('"', r'\"')}"';

      //  4 - Tally the mem chars
      numCharsEncoded += newStr.length;
    }

    //  5 - Print results
    print(numCharsEncoded - numCharsOfCode);
  } catch (e) {
    print('Error: $e');
  }
}
