import 'dart:io';

const raceDuration = 2503; // Given from problem description

void main() async {
  try {
    var furthestDistance = 0;

    final lines = await File('../_resources/input.txt').readAsLines();
    for (var line in lines) {
      //  {name} can fly {#} km/s for {#} seconds, but then must rest for {#} seconds.
      //  0               3            6                                   13
      final pieces = line.split(' ');
      final speed = int.parse(pieces[3]);
      final sprintDuration = int.parse(pieces[6]);
      final restDuration = int.parse(pieces[13]);

      final totalFullCycles = raceDuration ~/ (sprintDuration + restDuration);
      final partialSecondsRemaining = raceDuration % (sprintDuration + restDuration);
      final partialDistanceTraveled =
          (partialSecondsRemaining >= sprintDuration) ? (speed * sprintDuration) : (speed * partialSecondsRemaining);

      final totalDistanceTraveled = partialDistanceTraveled + (speed * totalFullCycles * sprintDuration);
      if (totalDistanceTraveled > furthestDistance) {
        furthestDistance = totalDistanceTraveled;
      }
    }

    print(furthestDistance);
  } catch (e) {
    print('Error: $e');
  }
}
