import 'dart:collection';
import 'dart:io';

void main() {
  //  1 - Get the file path
  final file = File('../_resources/input.txt');

  try {
    //  2 - Simply grab all file content as a String, since we know it is a single line
    file.readAsString().then((contents) {
      var houses = HashMap();
      var x1 = 0;
      var y1 = 0;
      var x2 = 0;
      var y2 = 0;
      houses['0-0'] = 2; // Add the default presents at the starting position

      //  3 - Then for each character...
      for (var i = 0; i < contents.length; i++) {
        //  3.1 - Determine who is getting the instruction
        var realSanta = i % 2; // The real santa goes on even indexed instructions

        if (realSanta == 0) {
          //  3.2 - Update the coordinates for Santa
          switch (contents[i]) {
            case '^':
              ++y1;
            case 'v':
              --y1;
            case '<':
              --x1;
            case '>':
              ++x1;
          }
          //  3.3 - Increment house data for Santa
          houses['$x1-$y1'] = 1 + (houses['$x1-$y1'] ?? 0);
        } else {
          //  3.2 - Update the coordinates for Robot
          switch (contents[i]) {
            case '^':
              ++y2;
            case 'v':
              --y2;
            case '<':
              --x2;
            case '>':
              ++x2;
          }
          //  3.3 - Increment house data for Robot
          houses['$x2-$y2'] = 1 + (houses['$x2-$y2'] ?? 0);
        }
      }

      //  4 - Print the results
      print(houses.keys.length);
    });
  } catch (e) {
    print('Error: $e');
  }
}
