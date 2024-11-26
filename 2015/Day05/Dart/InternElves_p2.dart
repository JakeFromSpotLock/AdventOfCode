import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main() async {
  //  1 - Define Regex for 'Nice' list -- help from: https://regex101.com
  final distinctCoupleRegex = new RegExp(r'([a-z]{2}).*?\1');
  final singleSeparatedCoupleRegex = new RegExp(r'([a-z]).\1');

  //  2 - Open file stream
  final file = File('../_resources/input.txt');
  Stream<String> lines = file
      .openRead() //  Stream the files contents
      .transform(utf8.decoder) //  Decode bytes to UTF-8.
      .transform(LineSplitter()); //  Convert stream to individual lines

  try {
    //  3 - For each line (AKA word)...
    var count = 0;
    await for (var line in lines) {
      //  Check if it satisfies the Nice Requirements...
      if (distinctCoupleRegex.hasMatch(line) && singleSeparatedCoupleRegex.hasMatch(line)) {
        //  And count any occurences
        count += 1;
      }
    }

    //  4 - Print result
    print(count);
  } catch (e) {
    print('Error: $e');
  }
}
