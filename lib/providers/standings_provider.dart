import 'package:flutter/foundation.dart';
import '../models/standing.dart';
import '../services/api_football_service.dart';

enum StandingsState { initial, loading, loaded, error }

class StandingsProvider with ChangeNotifier {
  final ApiFootballService _apiService;
  
  StandingsState _state = StandingsState.initial;
  List<Standing> _standings = [];
  String? _errorMessage;

  StandingsProvider(this._apiService);

  StandingsState get state => _state;
  List<Standing> get standings => _standings;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == StandingsState.loading;
  bool get hasError => _state == StandingsState.error;

  Future<void> fetchStandings() async {
    _state = StandingsState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _standings = await _apiService.getStandings();
      _state = StandingsState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = StandingsState.error;
    }
    notifyListeners();
  }

  void clearStandings() {
    _standings = [];
    _state = StandingsState.initial;
    _errorMessage = null;
    notifyListeners();
  }
}


