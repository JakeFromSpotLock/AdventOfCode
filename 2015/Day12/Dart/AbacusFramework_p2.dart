import 'dart:io';
import 'dart:convert';

void main() async {
  // dynamic test = {};

  // print(test is Map);

  try {
    //  1 - Retrieve input as a Map object
    final input = await File('../_resources/input.txt').readAsString();
    final json = jsonDecode(input) as Map;

    //  2 - Recursively look through the JSON values and their children
    final sum = sumSearchValues(json.values);

    //  3 - Print the results
    print(sum);
  } catch (e) {
    print('Error: $e');
  }
}

int sumSearchValues(dynamic values) {
  var layerSum = 0;
  var redDetected = false;

  values.forEach((value) {
    if (value is int) {
      layerSum += value;
    } else if (value is List) {
      layerSum += sumSearchValues(value);
    } else if (value is Map) {
      layerSum += sumSearchValues(value.values);
    } else if (value is String && value == 'red' && !(values is List)) {
      // Immedietly break, stoppping any additional recursion, and reset layer to 0
      //  At least, thats what I would like to do, but return/breaking for a forEach
      //  is not allowed. And swapping to a for loop and indexing like values[i] will
      //  lose the ambiguity of List/Map and need for .length() and indexing methods
      //  which are not compatible with both, losing all our compact dynamic handling
      //  so... sacrifice a little efficiency for code simplicity
      redDetected = true;
    }
  });

  return redDetected ? 0 : layerSum;
}
