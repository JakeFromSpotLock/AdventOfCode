import 'dart:math';

void main() {
  //  From input
  var bossHealth = 109;
  final bossArmor = 2;
  final bossDamage = 8;

  //  From problem description
  final myHealth = 100;

  //  Must buy exactly 1 of these
  final shopWeapons = [
    {'cost': 8, 'damage': 4, 'armor': 0},
    {'cost': 10, 'damage': 5, 'armor': 0},
    {'cost': 25, 'damage': 6, 'armor': 0},
    {'cost': 40, 'damage': 7, 'armor': 0},
    {'cost': 74, 'damage': 8, 'armor': 0},
  ];
  //  0 or 1 of these
  final shopArmor = [
    {'cost': 0, 'damage': 0, 'armor': 0}, //  Simulates not selecting any armor
    {'cost': 13, 'damage': 0, 'armor': 1},
    {'cost': 31, 'damage': 0, 'armor': 2},
    {'cost': 53, 'damage': 0, 'armor': 3},
    {'cost': 75, 'damage': 0, 'armor': 4},
    {'cost': 102, 'damage': 0, 'armor': 5},
  ];
  //  0 to 2 of these
  final shopRings = [
    {'cost': 0, 'damage': 0, 'armor': 0}, //  Simulates not selecting 1 of the rings
    {'cost': 0, 'damage': 0, 'armor': 0}, //  Simulates not selecting 1 of the rings (possibly neither)
    {'cost': 25, 'damage': 1, 'armor': 0},
    {'cost': 50, 'damage': 2, 'armor': 0},
    {'cost': 100, 'damage': 3, 'armor': 0},
    {'cost': 20, 'damage': 0, 'armor': 1},
    {'cost': 40, 'damage': 0, 'armor': 2},
    {'cost': 80, 'damage': 0, 'armor': 3},
  ];

  var mostExpensive = -1;
  shopWeapons.forEach((weapon) {
    shopArmor.forEach((armor) {
      for (var ring1 = 0; ring1 < shopRings.length - 1; ++ring1) {
        for (var ring2 = ring1 + 1; ring2 < shopRings.length; ++ring2) {
          final (cost, myArmor, myDamage) = calcStats(weapon, armor, shopRings[ring1], shopRings[ring2]);
          final doesBeatBoss = simFight([bossHealth, bossArmor, bossDamage], [myHealth, myArmor, myDamage]);
          if (!doesBeatBoss) {
            mostExpensive = (cost > mostExpensive) ? cost : mostExpensive;
          }
        }
      }
    });
  });

  //  Check result
  print(mostExpensive);
}

(int, int, int) calcStats(Map weapon, Map armor, Map ring1, Map ring2) {
  final totalCost = weapon['cost'] + armor['cost'] + ring1['cost'] + ring2['cost'];
  final totalArmor = weapon['armor'] + armor['armor'] + ring1['armor'] + ring2['armor'];
  final totalDamage = weapon['damage'] + armor['damage'] + ring1['damage'] + ring2['damage'];
  return (totalCost, totalArmor, totalDamage);
}

bool simFight(List<int> boss, List<int> player) {
  final playerEffectiveDamage = max(player[2] - boss[1], 1);
  final bossEffectiveDamage = max(boss[2] - player[1], 1);
  // while (boss[0] > 0 && player[0] > 0) {
  //   boss[0] -= playerEffectiveDamage;
  //   player[0] -= bossEffectiveDamage;
  // }
  // return (boss[0] <= 0);
  return playerEffectiveDamage > bossEffectiveDamage;
}
