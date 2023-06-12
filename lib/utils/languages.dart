final List<LanguageModel> languages = [
  LanguageModel("English", "en_US"),
  LanguageModel("Hindi", "hi_IN"),
];

class LanguageModel {
  LanguageModel(
      this.language,
      this.symbol,
      );

  String language;
  String symbol;
}