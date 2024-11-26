import 'dart:convert';
import 'dart:io';

void main() async {
  //  1 - Define Regex for 'Nice' list -- help from: https://regex101.com
  final vowelRegex = new RegExp(r'(\w*[aeiou]\w*){3}');
  final duplicateRegex = new RegExp(r'([a-z])\1');
  final naughtyBlobsRegex = new RegExp(r'(?:ab)|(?:cd)|(?:pq)|(?:xy)');

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
      if (vowelRegex.hasMatch(line) && duplicateRegex.hasMatch(line) && !naughtyBlobsRegex.hasMatch(line)) {
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
