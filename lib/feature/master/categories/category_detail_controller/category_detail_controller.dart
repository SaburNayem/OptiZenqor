import 'package:optizenqor/feature/master/categories/category_detail_model/category_detail_model.dart';

class CategoryDetailController {
  const CategoryDetailController();

  CategoryDetailModel fromCategoryId(String categoryId) {
    switch (categoryId) {
      case 'beauty_personal_care':
        return const CategoryDetailModel(
          title: 'Beauty & Personal Care',
          tabs: <String>['All', 'Skincare', 'Haircare', 'Makeup', 'Fragrances'],
        );
      case 'books_stationary':
        return const CategoryDetailModel(
          title: 'Books & Stationary',
          tabs: <String>['All', 'Academic', 'Office', 'Art', 'Supplies'],
        );
      case 'electronics_gadget':
        return const CategoryDetailModel(
          title: 'Electronics Gadget',
          tabs: <String>['All', 'Phones', 'Audio', 'Accessories', 'Gaming'],
        );
      case 'fashion_clothing':
        return const CategoryDetailModel(
          title: 'Fashion & Clothing',
          tabs: <String>['All', 'Men', 'Women', 'Kids', 'Shoes'],
        );
      case 'groceries_food':
        return const CategoryDetailModel(
          title: 'Groceries & Food',
          tabs: <String>['All', 'Snacks', 'Drinks', 'Fresh', 'Cooking'],
        );
      case 'health_wellness':
        return const CategoryDetailModel(
          title: 'Health & Wellness',
          tabs: <String>['All', 'Vitamins', 'Fitness', 'Care', 'Medical'],
        );
      case 'home_living':
        return const CategoryDetailModel(
          title: 'Home & Living',
          tabs: <String>['All', 'Furniture', 'Decor', 'Kitchen', 'Lighting'],
        );
      case 'sports_outdoor':
        return const CategoryDetailModel(
          title: 'Sports & Outdoor',
          tabs: <String>['All', 'Gym', 'Outdoor', 'Cycling', 'Travel'],
        );
      case 'toy_babies_product':
        return const CategoryDetailModel(
          title: 'Toy & Babies Product',
          tabs: <String>['All', 'Toys', 'Baby Care', 'Learning', 'Clothing'],
        );
      default:
        return const CategoryDetailModel(
          title: 'Category',
          tabs: <String>['All', 'Featured', 'Popular', 'New', 'Best'],
        );
    }
  }
}
