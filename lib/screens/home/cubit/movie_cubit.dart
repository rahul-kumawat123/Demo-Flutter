import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/movie/movie_model.dart';
import '../data/movie_repository_impl.dart';
import '../domain/movie_repository.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository _repository;

  MovieCubit({MovieRepository? repository})
    : _repository = repository ?? MovieRepositoryImpl(),
      super(const MovieState.initial());

  List<MovieModel> _carouselMovies = [];
  List<MovieModel> _gridMovies = [];
  int _currentPage = 1;
  int _totalPages = 1;

  // Fetch initial movies - page 1 for carousel, page 2 for grid
  Future<void> fetchMovies() async {
    emit(const MovieState.loading());

    final page1Result = await _repository.getTrendingMovies(1);

    await page1Result.fold(
      (error) async {
        emit(MovieState.error(error.message));
      },
      (response) async {
        _carouselMovies = response.results.take(10).toList();
        _totalPages = response.totalPages;

        final page2Result = await _repository.getTrendingMovies(2);

        page2Result.fold(
          (error) {
            // Still show carousel even if page 2 fails
            _gridMovies = [];
            _currentPage = 1;
            emit(
              MovieState.loaded(
                carouselMovies: _carouselMovies,
                gridMovies: _gridMovies,
                currentPage: _currentPage,
                totalPages: _totalPages,
              ),
            );
          },
          (page2Response) {
            _gridMovies = page2Response.results;
            _currentPage = 2;
            emit(
              MovieState.loaded(
                carouselMovies: _carouselMovies,
                gridMovies: _gridMovies,
                currentPage: _currentPage,
                totalPages: _totalPages,
              ),
            );
          },
        );
      },
    );
  }

  // Load more movies for grid (pagination)
  Future<void> loadMoreMovies() async {
    final currentState = state;

    if (currentState is! MovieLoaded) return;
    if (currentState.isLoadingMore) return;
    if (_currentPage >= _totalPages) return;

    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = _currentPage + 1;
    final result = await _repository.getTrendingMovies(nextPage);

    result.fold(
      (error) {
        emit(currentState.copyWith(isLoadingMore: false));
      },
      (response) {
        _gridMovies = [..._gridMovies, ...response.results];
        _currentPage = nextPage;
        emit(
          MovieState.loaded(
            carouselMovies: _carouselMovies,
            gridMovies: _gridMovies,
            currentPage: _currentPage,
            totalPages: _totalPages,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> refreshMovies() async {
    _carouselMovies = [];
    _gridMovies = [];
    _currentPage = 1;
    await fetchMovies();
  }

  bool get hasMorePages => _currentPage < _totalPages;
}
