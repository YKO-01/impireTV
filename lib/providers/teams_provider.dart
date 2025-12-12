import 'package:flutter/foundation.dart';
import '../models/team.dart';
import '../services/api_football_service.dart';

enum TeamsState { initial, loading, loaded, error }

class TeamsProvider with ChangeNotifier {
  final ApiFootballService _apiService;
  
  TeamsState _state = TeamsState.initial;
  List<Team> _teams = [];
  String? _errorMessage;

  TeamsProvider(this._apiService);

  TeamsState get state => _state;
  List<Team> get teams => _teams;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == TeamsState.loading;
  bool get hasError => _state == TeamsState.error;

  Future<void> fetchTeams() async {
    _state = TeamsState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _teams = await _apiService.getTeams();
      _state = TeamsState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = TeamsState.error;
    }
    notifyListeners();
  }

  void clearTeams() {
    _teams = [];
    _state = TeamsState.initial;
    _errorMessage = null;
    notifyListeners();
  }
}


