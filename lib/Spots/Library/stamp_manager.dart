class StampManager {
  static final Map<String, Set<String>> _unlockedByCategory = {
    "Biography": {},
    "News": {},
    "Stories": {},
    "Articles": {},
  };

  static final Map<String, Map<String, String>> stampCategories = {
    "Biography": {},
    "News": {},
    "Stories": {},
    "Articles": {},
  };

  static final Map<String, bool> medalsUnlocked = {
    "Biography": false,
    "News": false,
    "Stories": false,
    "Articles": false,
  };

  /// Verifica si una stamp está desbloqueada
  static bool isStampUnlocked(String category, String stampKey) {
    return _unlockedByCategory[category]!.contains(stampKey);
  }

  /// Desbloquea una stamp y revisa si ya se ganó una medalla
  static void unlockStamp(String category, String stampKey) {
    _unlockedByCategory[category]!.add(stampKey);

    // Revisar si completó las 15 stamps de esa categoría
    if (!medalsUnlocked[category]!) {
      if (_unlockedByCategory[category]!.length >= 15) {
        medalsUnlocked[category] = true;
        // ignore: avoid_print
        print("🥇 Medalla de $category desbloqueada!");
      }
    }
  }

  /// Obtener imagen de una stamp
  static String? getStampImage(String stampKey) {
    for (var category in stampCategories.keys) {
      if (stampCategories[category]!.containsKey(stampKey)) {
        return stampCategories[category]![stampKey];
      }
    }
    return null;
  }

  /// Encontrar categoría de una palabra
  static String? getCategoryOf(String stampKey) {
    for (var category in stampCategories.keys) {
      if (stampCategories[category]!.containsKey(stampKey)) {
        return category;
      }
    }
    return null;
  }
}
