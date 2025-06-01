extension NumExtension on num {
  String convertToCurrency() {
    if (this % 1 == 0) {
      return this.toInt().toString();
    } else {
      return this.toStringAsFixed(2);
    }
  }
}
