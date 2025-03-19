class BreathingMethod {
  final int inhale;
  final int hold;
  final int exhale;

  BreathingMethod({
    required this.inhale,
    required this.hold,
    required this.exhale
  });

   static List<BreathingMethod> breathingMethods = [
  BreathingMethod(inhale: 4, hold: 7, exhale: 8), 
  BreathingMethod(inhale: 4, hold: 2, exhale: 6), 
  BreathingMethod(inhale: 4, hold: 4, exhale: 4), 
  BreathingMethod(inhale: 3, hold: 3, exhale: 3), 
];
}

class BreathingSession {
  final String methodName;
  final int duration;  // 訓練時長
  final int inhale;  // 吸氣時間
  final int hold;    // 屏氣時間
  final int exhale;  // 吐氣時間

  BreathingSession({
    required this.methodName,
    required this.duration,
    required this.inhale,
    required this.hold,
    required this.exhale,
  });
}