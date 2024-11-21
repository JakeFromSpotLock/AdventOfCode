import 'dart:convert';
import 'package:crypto/crypto.dart';

const input = 'ckczppom';
const target = '00000';
const maxTrys = 100000000; // Could do it in a while-loop, but will add a soft limit for safety

void main() {
  //  1 - Iterate on ever increasing numbers
  for (var i = 0; i < maxTrys; i++) {
    //  2 - Get the Md5 hash of the input
    var hash = generateMd5('$input$i');

    //  3 - Check if we have success
    var first5 = hash.substring(0, 5);
    if (first5 == target) {
      print(i);
      return;
    }
  }

  //  4 - Failure
  print('No AdventCoins found...');
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
