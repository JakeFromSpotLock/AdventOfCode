import 'dart:collection';
import 'dart:io';

void main() {
  //  1 - Get the file path
  final file = File('../_resources/input.txt');

  try {
    //  2 - Simply grab all file content as a String, since we know it is a single line
    file.readAsString().then((contents) {
      var houses = HashMap();
      var x = 0;
      var y = 0;
      houses['$x-$y'] = 1; // Add the default present at the starting position

      //  3 - Then for each character...
      for (var i = 0; i < contents.length; i++) {
        //  3.1 - Update the coordinates
        switch (contents[i]) {
          case '^':
            ++y;
          case 'v':
            --y;
          case '<':
            --x;
          case '>':
            ++x;
        }

        //  3.2 - Increment house data
        houses['$x-$y'] = 1 + (houses['$x-$y'] ?? 0);
      }

      //  4 - Print the results
      print(houses.keys.length);
    });
  } catch (e) {
    print('Error: $e');
  }
}
