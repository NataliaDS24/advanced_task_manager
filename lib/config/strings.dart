class AppStrings {
  // General
  static const String pathError = 'Route not found';
  static const String appName = 'Advanced Task Manager';
  static const String voidText = '';

  // Enum TaskState
  static const String pending = 'Earring';
  static const String inProgres = 'In progress';
  static const String completed = 'Completed';

  // Enum TaskPriority
  static const String low = 'Low';
  static const String medium = 'Medium';
  static const String high = 'High';

  // Home Screen
  static const String noTasks = 'No tasks were found';
  static const String all = 'All';
  static const String pendings = 'Earrings';

  // Countries Screen
  static const String titleListCountries = 'Lista de Países';
  static const String errorImportingCountries = 'An error occurred while importing the countries.';
  static const String retry = 'Retry';

  // Errors
  static const String notPhotos = 'No results found.';
  static const String errorData = 'Error bringing the information.';

  // Errors Task repository
  static const String errorLoadingTaskData = 'Error loading tasks from API';
  static const String errorTaskRepository = 'Error in TaskApiRepository:';

  // Errors country repository
  static const String errorCountryQuery = 'Error in the country query.';
  static const String errorCountryApiEmpty = 'The API returned empty or invalid data.';
  static const String errorCountriesRetrieved = 'The countries could not be retrieved. Please try again later.';

  // Errors utils
  static const String errorDatetimeToString = 'Invalid date format:';
  static const String errorStringToDatetime = 'Invalid ISO format:';
}
