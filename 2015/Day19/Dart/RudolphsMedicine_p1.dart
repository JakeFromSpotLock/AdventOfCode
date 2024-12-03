import 'dart:io';

void main() async {
  try {
    //  Parse / initialize all the chemical data
    Map<String, List<String>> replacementInfo = {};
    var calibrationChemical = '';

    final lines = await File('../_resources/input.txt').readAsLines();
    for (var line in lines) {
      final pieces = line.split(' ');
      if (pieces.length == 3) {
        //  ex: 'Al => ThF'
        //        0 1   2
        if (replacementInfo.containsKey(pieces[0])) {
          replacementInfo[pieces[0]]!.add(pieces[2]);
        } else {
          replacementInfo[pieces[0]] = [pieces[2]];
        }
      } else if (pieces[0].isNotEmpty) {
        calibrationChemical = line;
      }
    }

    //  For each input chemcial, find all occurences of it and replace each with every
    //  output chemical available for replacement. Save each and every replacement to
    //  a Set so duplicates are not counted twice.
    Set<String> results = {};
    replacementInfo.forEach((key, data) {
      final matches = key.allMatches(calibrationChemical).toList();
      for (var i = 0; i < matches.length; i++) {
        for (var replacementOption in data) {
          final updatedChemical = calibrationChemical.replaceRange(matches[i].start, matches[i].end, replacementOption);
          results.add(updatedChemical);
        }
      }
    });

    //  Print results
    print(results.length);
  } catch (e) {
    print('Error: $e');
  }
}
