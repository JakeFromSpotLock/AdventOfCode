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

    //  3 - Get each integer on the line to make the left and right lists, then sort to line them up
    var leftList = [];
    var rightList = [];
    await for (var line in lines) {
      final pieces = line.split('   ');
      leftList.add(int.parse(pieces[0]));
      rightList.add(int.parse(pieces[1]));
    }
    leftList.sort();
    rightList.sort();

    //  4 - Sum distances of each
    var sum = 0;
    for (var i = 0; i < leftList.length; i++) {
      sum += (leftList[i] - rightList[i]).abs() as int;
    }

    //  5 - Print result
    print(sum);
  } catch (e) {
    print('Error: $e');
  }
}
