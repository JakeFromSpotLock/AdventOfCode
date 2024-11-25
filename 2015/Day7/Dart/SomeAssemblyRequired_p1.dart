import 'dart:io';

void main() async {
  // Read the input file
  final file = File('../_resources/input.txt');
  final instructions = await file.readAsLines();

  // Parse instructions into a map
  final circuit = <String, String>{};
  for (var line in instructions) {
    final parts = line.split(' -> ');
    circuit[parts[1]] = parts[0];
  }

  // Memoization map for calculated wire values
  final memo = <String, int>{};

  // Recursive function to evaluate a wire's value
  int evaluate(String wire) {
    if (memo.containsKey(wire)) return memo[wire]!;
    if (int.tryParse(wire) != null) return int.parse(wire); // Direct number

    final expr = circuit[wire]!;
    int result;

    if (expr.contains('AND')) {
      final parts = expr.split(' AND ');
      result = evaluate(parts[0]) & evaluate(parts[1]);
    } else if (expr.contains('OR')) {
      final parts = expr.split(' OR ');
      result = evaluate(parts[0]) | evaluate(parts[1]);
    } else if (expr.contains('NOT')) {
      final part = expr.split(' ')[1];
      result = ~evaluate(part) & 0xFFFF; // Ensure 16-bit result
    } else if (expr.contains('LSHIFT')) {
      final parts = expr.split(' LSHIFT ');
      result = evaluate(parts[0]) << int.parse(parts[1]);
    } else if (expr.contains('RSHIFT')) {
      final parts = expr.split(' RSHIFT ');
      result = evaluate(parts[0]) >> int.parse(parts[1]);
    } else {
      result = evaluate(expr); // Direct assignment
    }

    memo[wire] = result; // Memoize the result
    return result;
  }

  // Evaluate the value of wire "a"
  final resultA = evaluate('a');
  print('Value of wire a: $resultA');
}




//  =============================================
//  The below code was first attempt at solution
//  via recursion, does not complete
//  =============================================

// import 'dart:collection';
// import 'dart:convert';
// import 'dart:io';

// void main() async {
//   try {
//     //  1 - Init hash for all wire values
//     var wires = HashMap();

//     //  2 - Open file stream
//     final file = File('../_resources/input.txt');
//     Stream<String> lines = file
//         .openRead() //  Stream the files contents
//         .transform(utf8.decoder) //  Decode bytes to UTF-8.
//         .transform(LineSplitter()); //  Convert stream to individual lines

//     //  3 - For each line, break the equation to save the assignment definition to each destination
//     //      B/c each wire can only be assigned 1 value, this will 'graph' the circuit in the hashmap
//     await for (var line in lines) {
//       final tokens = line.split('->'); // [0] is instruction side, [1] is destination wire
//       wires[tokens[1].trim()] = tokens[0].trim();
//     }

//     //  4 - Now we can recursively look through the map until we find our desired inputs value
//     final value = getWireValue(wires, 'a');

//     //  5- Print result
//     print(value);
//   } catch (e) {
//     print('Error: $e');
//   }
// }

// int getWireValue(HashMap circuit, String wire) {
//   //  1 - If the value is already numeric, done, return it
//   if (circuit[wire] is int) {
//     return circuit[wire];
//   }

//   //  2 - Retrieve the given wires definition from the circuit and parse the instructions
//   //      Possible inputs are:
//   //      a -> b              | 1 instruction - int/str
//   //      a AND b -> c        | 3 instructions - int/str KEYWORD int/str
//   //      a OR b -> c         | 3 instructions - int/str KEYWORD int/str
//   //      a LSHIFT # -> b     | 3 instructions - int/str KEYWORD int
//   //      a RSHIFT # -> b     | 3 instructions - int/str KEYWORD int
//   //      NOT a -> b          | 2 instructions - KEYWORD int/str
//   final instructions = circuit[wire].split(' ');

//   //  3 - Emulate the Logic Gate
//   if (instructions.length == 1) {
//     //  Only possibility is to be the assignment operator (a -> b)
//     final val = int.tryParse(instructions[0]);
//     if (val != null) {
//       //  Either numeric assignment, update the hash to speed up future searches and return that value...
//       circuit[wire] = val;
//       return val;
//     } else {
//       //  Or other wire is input (recursively look for that)
//       return getWireValue(circuit, instructions[0]);
//     }
//   } else if (instructions.length == 2) {
//     //  Only possibility is to be the One's Compliment (NOT a -> b)
//     return ~(int.tryParse(instructions[1]) ?? getWireValue(circuit, instructions[1]));
//   } else {
//     // 2 Operand equations
//     final lhs = int.tryParse(instructions[0]) ?? getWireValue(circuit, instructions[0]);
//     final rhs = int.tryParse(instructions[2]) ?? getWireValue(circuit, instructions[2]);
//     //  Now, the distinguishing factor is always the second element of the instructions
//     switch (instructions[1]) {
//       case 'AND':
//         return lhs & rhs;
//       case 'OR':
//         return lhs | rhs;
//       case 'LSHIFT':
//         return lhs << rhs;
//       case 'RSHIFT':
//         return lhs >> rhs;
//       default:
//         throw Exception('Valid instruction not found...');
//     }
//   }
// }
