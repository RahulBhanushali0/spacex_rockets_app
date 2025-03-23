class AppUtils {
  static String convertToFeetInches(double meters) {
    final double inches = meters * 39.37;
    final int feet = (inches / 12).floor();
    final int remainingInches = (inches % 12).round();
    return '$feet ft $remainingInches in';
  }
}