import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

void main() async {
  //  1 - Get the file path
  final file = File('../_resources/input.txt');

  //  2 - Open file stream
  Stream<String> lines = file
      .openRead() //  Stream the files contents
      .transform(utf8.decoder) //  Decode bytes to UTF-8.
      .transform(LineSplitter()); //  Convert stream to individual lines

  try {
    //  3 - Iterate by line
    var sum = 0;
    await for (var line in lines) {
      // 4 - Parse the info (LxWxH)
      var dimensions = line.split('x');
      var l = int.parse(dimensions[0]);
      var w = int.parse(dimensions[1]);
      var h = int.parse(dimensions[2]);

      //  5 - Do the math for this gift
      var faceA = l * w;
      var faceB = w * h;
      var faceC = h * l;
      var total = (2 * (faceA + faceB + faceC)) + [faceA, faceB, faceC].reduce(min);

      //  6 - Tally the total
      sum += total;
    }

    //  7 - Print the results
    print(sum);
  } catch (e) {
    print('Error: $e');
  }
}
