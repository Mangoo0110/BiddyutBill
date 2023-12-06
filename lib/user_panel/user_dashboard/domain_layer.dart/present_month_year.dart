String monthYearString(DateTime date){
  final List<String> allMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  var monthYear ="";
  monthYear = "${allMonths[date.month - 1]}, ${date.year}";
  return monthYear;
}