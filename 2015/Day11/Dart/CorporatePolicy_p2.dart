const startPass = 'hepxxyzz';

void main() {
  final twoPairsRegex = RegExp(r'(?:([a-z])\1).*?(?!\1)([a-z])\2');
  final straightRegex =
      RegExp(r'(?:abc|bcd|cde|def|efg|fgh|ghi|hij|ijk|jkl|klm|lmn|mno|nop|opq|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz)');
  final illegalCharsRegex = RegExp(r'(?:i)|(?:o)|(?:l)');
  var newPassInvalid = true;
  var newPassword = startPass;

  while (newPassInvalid) {
    newPassword = incrementPassword(newPassword);

    if (!illegalCharsRegex.hasMatch(newPassword) &&
        twoPairsRegex.hasMatch(newPassword) &&
        straightRegex.hasMatch(newPassword)) {
      newPassInvalid = false;
    }
  }

  print(newPassword);
}

String incrementPassword(String currPass) {
  var newPass = currPass;

  for (var i = newPass.length - 1; i > -1; i--) {
    //  Increment the char, unless it is 'z'
    //  Remember lowercase chars ascii codes a-z : 97-122
    if (newPass.codeUnitAt(i) == 122) {
      newPass = newPass.substring(0, i) + 'a' + newPass.substring(i + 1);
    } else {
      newPass = newPass.substring(0, i) + String.fromCharCode(newPass.codeUnitAt(i) + 1) + newPass.substring(i + 1);
      break;
    }
  }

  return newPass;
}
