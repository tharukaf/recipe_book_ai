class CookingStep {
  int stepNumber;
  String description;
  Duration duration;

  CookingStep({
    required this.stepNumber,
    required this.description,
    this.duration = Duration.zero,
  });

  // CookingStep to Json
  Map<String, dynamic> toMap() {
    return {
      'stepNumber': stepNumber,
      'description': description,
      'duration': duration.inMinutes,
    };
  }

  factory CookingStep.fromMap(Map<String, dynamic> map) {
    return CookingStep(
      stepNumber: map['stepNumber'],
      description: map['description'],
      duration: Duration(minutes: map['duration']),
    );
  }
}
