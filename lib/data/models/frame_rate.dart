enum FrameRate {
  initial(label: '60 fps', rate: 60.0),
  gba(label: 'GBA', rate: 59.7275),
  dsGba(label: 'DS GBA', rate: 59.8261),
  ds(label: 'DS', rate: 59.6555),
  custom(label: 'Personalizado', rate: 0.0);

  const FrameRate({
    required this.label,
    required this.rate,
  });

  final String label;
  final double rate;
}
