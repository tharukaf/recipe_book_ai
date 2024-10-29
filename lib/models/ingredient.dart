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
  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'description': description,
      'duration': duration.inMinutes,
    };
  }
}
