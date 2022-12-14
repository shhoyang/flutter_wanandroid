class RegUtils {
  static String removeSymbol(String? origin) {
    if (origin == null || origin.isEmpty) {
      return "";
    }
    return origin.replaceAll(RegExp("(&[^;]+;)|(<[^>]+>)"), "");
  }
}
