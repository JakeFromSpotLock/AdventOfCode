import 'dart:io';

const raceDuration = 2503; // Given from problem description

void main() async {
  try {
    //  {reindeerName: [speed, sprintDuration, restDuration, pointTotal]}
    var reindeerData = <String, List<int>>{};
    var nameList = <String>[];

    final lines = await File('../_resources/input.txt').readAsLines();
    for (var line in lines) {
      //  {name} can fly {#} km/s for {#} seconds, but then must rest for {#} seconds.
      //  0               3            6                                   13
      final pieces = line.split(' ');
      reindeerData[pieces[0]] = [int.parse(pieces[3]), int.parse(pieces[6]), int.parse(pieces[13]), 0];
      nameList.add(pieces[0]);
    }

    for (var i = 1; i <= raceDuration; i++) {
      var currLeaders = [];
      var furthestDistance = 0;
      //  Determine the leaders at this second
      for (var name in nameList) {
        final dist = _getDistance(i, reindeerData[name]![0], reindeerData[name]![1], reindeerData[name]![2]);
        if (dist > furthestDistance) {
          //  New leader
          furthestDistance = dist;
          currLeaders = [name];
        } else if (dist == furthestDistance) {
          //  Tied leaders
          currLeaders.add(name);
        }
      }
      //  Add points for each leader at this second of the race
      for (var name in currLeaders) {
        reindeerData[name]![3] += 1;
      }
    }

    //  Get the winners point total
    final scores = reindeerData.values.map((data) => data[3]).toList();
    scores.sort();

    //  Print results
    print(scores.last);
  } catch (e) {
    print('Error: $e');
  }
}

int _getDistance(int currentTime, int speed, int sprintDuration, int restDuration) {
  final totalFullCycles = currentTime ~/ (sprintDuration + restDuration);
  final partialSecondsRemaining = currentTime % (sprintDuration + restDuration);
  final partialDistanceTraveled =
      (partialSecondsRemaining >= sprintDuration) ? (speed * sprintDuration) : (speed * partialSecondsRemaining);

  final totalDistanceTraveled = partialDistanceTraveled + (speed * totalFullCycles * sprintDuration);
  return totalDistanceTraveled;
}
