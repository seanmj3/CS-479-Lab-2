boolean stressDetection(int heartRate) {
    if (heartRate > 100) {
      stress = true;
    } else {
      stress = false;
    }
  return stress;
}
