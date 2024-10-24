class CookingStep {
  int stepNumber;
  String description;
  Duration duration;

  CookingStep({
    required this.stepNumber,
    required this.description,
    this.duration = Duration.zero,
  });
}
