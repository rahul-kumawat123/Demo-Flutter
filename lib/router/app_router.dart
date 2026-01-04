import 'package:go_router/go_router.dart';
import '../models/movie/movie_model.dart';
import '../screens/splash_screen.dart';
import '../screens/login/ui/login_screen.dart';
import '../screens/login/ui/signup_screen.dart';
import '../screens/home/ui/home_screen.dart';
import '../screens/detail/ui/movie_detail_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/movie-detail',
        name: 'movieDetail',
        builder: (context, state) {
          final movie = state.extra as MovieModel;
          return MovieDetailScreen(movie: movie);
        },
      ),
    ],
  );
}
