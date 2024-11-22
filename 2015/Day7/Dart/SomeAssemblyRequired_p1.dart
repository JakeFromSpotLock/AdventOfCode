import 'dart:collection';
import 'dart:convert';
import 'dart:io';

void main() async {
  try {
    //  1 - Init hash for all wire values
    var wires = HashMap();

    //  2 - Open file stream
    final file = File('../_resources/input.txt');
    Stream<String> lines = file
        .openRead() //  Stream the files contents
        .transform(utf8.decoder) //  Decode bytes to UTF-8.
        .transform(LineSplitter()); //  Convert stream to individual lines

    //  4 - For each line...
    await for (var line in lines) {
      //  4.1 - Parse instructions, possible inputs are:
      //  # -> a              | 1 instruction - int
      //  a AND b -> c        | 3 instructions - str KEYWORD str
      //  a OR b -> c         | 3 instructions - str KEYWORD str
      //  a LSHIFT # -> b     | 3 instructions - str KEYWORD int
      //  a RSHIFT # -> b     | 3 instructions - str KEYWORD int
      //  NOT a -> b          | 2 instructions - KEYWORD str
      final tokens = line.split('->'); // [0] is instruction side, [1] is destination wire
      final instructions = tokens[0].split(' ');

      //  4.2 - Emulate the Logic Gate
      if (instructions.length == 1) {
        //  Only possibility is to be the assignment operator (# -> a)
        wires[tokens[1]] = int.parse(instructions[0]);
      } else if (instructions.length == 2) {
        //  Only possibility is to be the One's Compliment (NOT a -> b)
        wires[tokens[1]] = ~wires[tokens[1]];
      } else {
        //  Now, deciding & distinct factor is always the second element of the instructions
        switch (instructions[1]) {
          case 'AND':
            wires[tokens[1]] = wires[instructions[0]] & wires[instructions[2]];
            break;
          case 'OR':
            wires[tokens[1]] = wires[instructions[0]] | wires[instructions[2]];
            break;
          case 'LSHIFT':
            wires[tokens[1]] = wires[instructions[0]] << int.parse(instructions[2]);
            break;
          case 'RSHIFT':
            wires[tokens[1]] = wires[instructions[0]] >> int.parse(instructions[2]);
            break;
        }
      }
    }

    //  6 - Print result
    print(wires['a']);
  } catch (e) {
    print('Error: $e');
  }
}
