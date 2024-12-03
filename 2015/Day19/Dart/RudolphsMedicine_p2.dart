import 'dart:io';

//  https://en.wikipedia.org/wiki/CYK_algorithm
//  https://www.geeksforgeeks.org/cyk-algorithm-for-context-free-grammar/
//  https://en.wikipedia.org/wiki/Greedy_algorithm#:~:text=The%20choice%20made%20by%20a,algorithm%20never%20reconsiders%20its%20choices.

void main() async {
  try {
// Read input file
    final file = File('../_resources/input.txt');
    final lines = await file.readAsLines();
    var molecule = '';

    // Parse the rules and the initial molecule
    Map<String, String> replacements = {};
    for (var line in lines) {
      if (line.contains("=>")) {
        final parts = line.split(" => ");
        replacements[parts[1]] = parts[0]; // Reversing for reduction
      } else if (line.isNotEmpty) {
        molecule = line; // The molecule is the last non-empty line
      }
    }

    // Sort the replacements by length of the keys in descending order
    // This ensures we apply the largest possible replacement first
    final sortedReplacements = replacements.keys.toList()..sort((a, b) => b.length.compareTo(a.length));

    // Reduce the molecule to "e"
    int steps = 0;
    while (molecule != "e") {
      bool reduced = false;

      for (var key in sortedReplacements) {
        if (molecule.contains(key)) {
          molecule = molecule.replaceFirst(key, replacements[key]!);
          steps++;
          reduced = true;
          break;
        }
      }

      // If no reduction was possible, something went wrong
      if (!reduced) {
        throw Exception("No valid reduction found!");
      }
    }

    //  Print output
    print(steps);
  } catch (e) {
    print('Error: $e');
  }
}
