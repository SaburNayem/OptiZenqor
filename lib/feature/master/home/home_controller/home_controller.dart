import 'package:optizenqor/feature/master/home/home_model/home_model.dart';

class HomeController {
  const HomeController();

  List<HomeModel> get dashboardCards => const <HomeModel>[
    HomeModel(
      title: 'Today Plan',
      description: 'Create a simple plan for your top three priorities.',
    ),
    HomeModel(
      title: 'Habit Track',
      description: 'Track repeat actions and keep daily consistency visible.',
    ),
    HomeModel(
      title: 'Energy Check',
      description: 'Review workload and protect your strongest focus blocks.',
    ),
  ];
}
