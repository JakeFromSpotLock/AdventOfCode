import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';

void main() async {
  try {
    //  1 - Define the lights
    var lights = List.generate(1000, (index) => List.generate(1000, (index) => 0));

    //  2 - Define a Regex to pull all instructions
    final dataRegex = RegExp(r'(toggle|turn off|turn on) (\d+),(\d+) through (\d+),(\d+)');

    //  3 - Open file stream
    final file = File('../_resources/input.txt');
    Stream<String> lines = file
        .openRead() //  Stream the files contents
        .transform(utf8.decoder) //  Decode bytes to UTF-8.
        .transform(LineSplitter()); //  Convert stream to individual lines

    //  4 - For each line...
    await for (var line in lines) {
      //  4.1 - Parse to get the instructions
      final match = dataRegex.firstMatch(line);
      if (match != null) {
        final instruction = match.group(1);
        final x1 = int.parse(match.group(2)!);
        final y1 = int.parse(match.group(3)!);
        final x2 = int.parse(match.group(4)!);
        final y2 = int.parse(match.group(5)!);

        //  4.2 - Update the indicated lights (classic nested for-loop for matrix manipulation)
        for (var i = x1; i <= x2; i++) {
          for (var j = y1; j <= y2; j++) {
            //  4.3 - Switch on the instruction to determine the effect
            switch (instruction) {
              case 'toggle':
                lights[i][j] += 2;
                break;
              case 'turn on':
                lights[i][j] += 1;
                break;
              case 'turn off':
                lights[i][j] = (lights[i][j] < 1) ? 0 : lights[i][j] - 1;
                break;
            } //end switch
          } //end inner-for
        } //end outer-for
      } //end if
    } //end await for

    //  5 - Count the brightness
    final total = lights.expand((row) => row).sum;

    //  6 - Print result
    print(total);
  } catch (e) {
    print('Error: $e');
  }
}
