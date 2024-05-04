const String currentCurrency = "\$";

String getPriceAndCurrency(double price) {
  return "${price.toStringAsFixed(1)} $currentCurrency";
}
