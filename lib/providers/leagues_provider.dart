import 'package:flutter/foundation.dart';
import '../models/league.dart';
import '../services/api_football_service.dart';

enum LeaguesState { initial, loading, loaded, error }

class LeaguesProvider with ChangeNotifier {
  final ApiFootballService _apiService;
  
  LeaguesState _state = LeaguesState.initial;
  List<League> _leagues = [];
  String? _errorMessage;

  LeaguesProvider(this._apiService);

  LeaguesState get state => _state;
  List<League> get leagues => _leagues;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == LeaguesState.loading;
  bool get hasError => _state == LeaguesState.error;

  Future<void> fetchLeagues() async {
    _state = LeaguesState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _leagues = await _apiService.getLeagues();
      _state = LeaguesState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = LeaguesState.error;
    }
    notifyListeners();
  }

  void clearLeagues() {
    _leagues = [];
    _state = LeaguesState.initial;
    _errorMessage = null;
    notifyListeners();
  }
}


