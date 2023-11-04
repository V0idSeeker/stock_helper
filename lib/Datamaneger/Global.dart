class global{

static String Capitalize(String input) {
  List<String> words = input.split(' ');
  List<String> capitalizedWords = [];

  for (String word in words) {
    if (word.isNotEmpty) {
      String capitalizedWord = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
      capitalizedWords.add(capitalizedWord);
    }
  }

  return capitalizedWords.join(' ');
}

}