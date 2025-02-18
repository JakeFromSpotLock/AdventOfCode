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

    //  3 - Count the reports
    var count = 0;
    await for (var line in lines) {
      var safe = true;
      final pieces = line.split(' ').map(int.parse).toList();

      bool? order = null;
      for (var i = 0; i < pieces.length - 1; i++) {
        final dif = pieces[i] - pieces[i + 1];
        //  Check that the step is in range
        if (0 == dif || dif.abs() > 3) {
          safe = false;
          break;
        }
        //  Check that the order is consistently asc or desc (true is + / false is -)
        if (order != null) {
          if (order != (dif > 0)) {
            safe = false;
            break;
          }
        } else {
          order = (dif > 0);
          continue;
        }
      }

      // Count
      if (safe) {
        count++;
      }
    }

    //  4 - Print result
    print(count);
  } catch (e) {
    print('Error: $e');
  }
}
