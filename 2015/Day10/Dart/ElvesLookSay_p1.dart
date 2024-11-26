const startSeq = '1113122113';
const iterations = 40;

void main() {
  final groupsRegex = RegExp(r'(\d)\1*');
  var sequence = startSeq;

  for (var i = 0; i < iterations; i++) {
    sequence = sequence.replaceAllMapped(groupsRegex, (match) {
      final substr = match.group(0)!;
      return substr.length.toString() + substr[0];
    });
  }

  print(sequence.length);
}


//  =====================================================
//  First attemp, seems correct logically, but blows up 
//  trying to calc  40 iterations due to space inefficiency 


// void main() {
//   final groupsRegex = RegExp(r'(\d)\1*');

//   var groups = groupsRegex.allMatches(startSeq).map((match) => match.group(0)!).toList();

//   for (var i = 0; i < iterations; i++) {
//     List<String> temp = [];
//     for (var j = 0; j < groups.length; j++) {
//       final verbal = groups[j].length.toString();
//       final number = groups[j][0];
//       temp.addAll([verbal, number]);
//     }
//     groups = temp;
//   }

//   final totalLength = groups.fold<int>(0, (sum, str) => sum + str.length);

//   print(totalLength);
// }
