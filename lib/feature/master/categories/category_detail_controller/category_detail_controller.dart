import 'package:optizenqor/feature/master/categories/category_detail_model/category_detail_model.dart';

class CategoryDetailController {
  const CategoryDetailController();

  CategoryDetailModel fromTitle(String title) {
    return CategoryDetailModel(
      title: title,
      tabs: const <String>[
        'All',
        'Skincare',
        'Haircare',
        'Makeup',
        'Fragrances',
      ],
    );
  }
}
