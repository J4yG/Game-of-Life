import 'package:game_of_life/features/game/view/screens/game_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => GameScreen(),
    ),
    GoRoute(
      path: '/settings',
      // Todo: Implement SettingsScreen
      builder: (context, state) => GameScreen(),
    ),
    GoRoute(
      path: '/load_game',
      // Todo: Implement LoadGameScreen
      builder: (context, state) => GameScreen(),
    ),
  ],
);
