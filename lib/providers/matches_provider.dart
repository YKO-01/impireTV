import 'package:flutter/foundation.dart';
import '../models/match.dart';
import '../services/api_football_service.dart';

enum MatchesState { initial, loading, loaded, error }

class MatchesProvider with ChangeNotifier {
  final ApiFootballService _apiService;
  
  MatchesState _state = MatchesState.initial;
  List<Match> _matches = [];
  String? _errorMessage;

  MatchesProvider(this._apiService);

  MatchesState get state => _state;
  List<Match> get matches => _matches;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == MatchesState.loading;
  bool get hasError => _state == MatchesState.error;

  Future<void> fetchLiveMatches() async {
    _state = MatchesState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _matches = await _apiService.getLiveMatches();
      _state = MatchesState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = MatchesState.error;
    }
    notifyListeners();
  }

  Future<void> fetchTodayMatches() async {
    _state = MatchesState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _matches = await _apiService.getTodayMatches();
      _state = MatchesState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = MatchesState.error;
    }
    notifyListeners();
  }

  Future<void> fetchYesterdayMatches() async {
    _state = MatchesState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _matches = await _apiService.getYesterdayMatches();
      _state = MatchesState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = MatchesState.error;
    }
    notifyListeners();
  }

  Future<void> fetchTomorrowMatches() async {
    _state = MatchesState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _matches = await _apiService.getTomorrowMatches();
      _state = MatchesState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = MatchesState.error;
    }
    notifyListeners();
  }

  void clearMatches() {
    _matches = [];
    _state = MatchesState.initial;
    _errorMessage = null;
    notifyListeners();
  }
}


