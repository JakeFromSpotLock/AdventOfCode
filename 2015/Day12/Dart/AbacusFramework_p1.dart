import 'dart:io';
import 'dart:convert';

void main() async {
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

  values.forEach((value) {
    if (value is int) {
      layerSum += value;
    } else if (value is List) {
      layerSum += sumSearchValues(value);
    } else if (value is Map) {
      layerSum += sumSearchValues(value.values);
    }
  });

  return layerSum;
}
