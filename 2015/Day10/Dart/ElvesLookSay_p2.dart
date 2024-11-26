const startSeq = '1113122113';
const iterations = 50;

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
