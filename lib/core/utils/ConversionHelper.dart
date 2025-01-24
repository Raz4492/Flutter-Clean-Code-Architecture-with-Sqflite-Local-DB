class ConversionHelper {
  // Helper method to convert any value to a String
  static String convertToString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is bool) return value ? 'true' : 'false';
    if (value is int) return value.toString();
    if (value is double) return value.toString();
    if (value is DateTime) return value.toIso8601String();
    return value.toString();
  }

  // Helper method to convert String to int
  static int convertToInt(String value) {
    return int.tryParse(value) ?? 0; // Returns 0 if the string cannot be parsed to int
  }

  // Helper method to convert String to DateTime
  static DateTime? convertToDateTime(String value) {
    return DateTime.tryParse(value); // Returns null if the string cannot be parsed to DateTime
  }

  // Helper method to convert String to double
  static double convertToDouble(String value) {
    return double.tryParse(value) ?? 0.0; // Returns 0.0 if the string cannot be parsed to double
  }

  // Helper method to convert String to bool
  static bool convertToBool(String value) {
    return value.toLowerCase() == 'true'; // Converts 'true' to true and any other value to false
  }

  // Helper method to convert String to List<String> (if needed)
  static List<String> convertToListString(String value) {
    return value.split(','); // Example: converting 'item1,item2,item3' to a List<String>
  }
}
