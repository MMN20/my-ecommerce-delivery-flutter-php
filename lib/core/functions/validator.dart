String? validator(
  String s,
  int minLength,
  int maxLength,
  String minMessage,
  String maxMessage, [
  bool canBeEmpty = false,
  String emptyMessage = "Can't be empty",
]) {
  // if it can't be empty
  if (s.isEmpty && !canBeEmpty) {
    return emptyMessage;
  } // if it can be empty and it is empty
  else if (s.isEmpty && canBeEmpty) {
    return null;
  }
  if (s.length < minLength) {
    return minMessage;
  }
  if (s.length > maxLength) {
    return maxMessage;
  }
  return null;
}
