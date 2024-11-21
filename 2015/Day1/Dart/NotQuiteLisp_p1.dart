import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main() async {
  //  1 - Get the file path
  final file = File('../_resources/input.txt');

  //  2 - Open file stream
  Stream<String> lines = file
      .openRead() //  Stream the files contents
      .transform(utf8.decoder) //  Decode bytes to UTF-8.
      .transform(LineSplitter()); //  Convert stream to individual lines

  try {
    //  3 - For each line...
    var floor = 0;
    await for (var line in lines) {
      //  Check each character...
      for (int i = 0; i < line.length; i++) {
        //  inc/dec accordingly
        if (line[i] == '(') {
          ++floor;
        } else if (line[i] == ')') {
          --floor;
        }
      }
    }

    //  4 - Print result
    print(floor);
  } catch (e) {
    print('Error: $e');
  }
}
