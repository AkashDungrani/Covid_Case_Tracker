class CovidData {
  final String name;
  final String flag;
  final int totalDeaths;
  final int totalConfirmed;
  final int totalRecovered;
  final int totalCritical;
  final int totalActive;
  final int population;

  CovidData({
    required this.name,
    required this.flag,
    required this.totalDeaths,
    required this.totalConfirmed,
    required this.totalRecovered,
    required this.totalCritical,
    required this.totalActive,
    required this.population,
  });

  factory CovidData.fromJson({required data}) {
    return CovidData(
      name: data["country"],
      flag: data["countryInfo"]["flag"],
      totalDeaths: data["deaths"],
      totalConfirmed: data["cases"],
      totalRecovered: data["recovered"],
      totalCritical: data["critical"],
      totalActive: data["active"],
      population: data["population"],
    );
  }
}
