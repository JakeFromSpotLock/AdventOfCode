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

  // Part 1: Compute the value of wire "a"
  final resultA = evaluate('a');
  print('Part 1: Value of wire a: $resultA');

  // Part 2: Override wire "b" with the value of wire "a" and re-evaluate
  circuit['b'] = resultA.toString();
  memo.clear(); // Clear the memoization cache for re-computation
  final resultA2 = evaluate('a');
  print('Part 2: Value of wire a: $resultA2');
}
