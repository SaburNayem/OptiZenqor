import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/widget/card_widget.dart';
import 'package:optizenqor/feature/master/categories/category_detail_controller/category_detail_controller.dart';
import 'package:optizenqor/feature/master/categories/category_detail_model/category_detail_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({
    required this.title,
    required this.categoryId,
    super.key,
  });

  final String title;
  final String categoryId;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final CatalogService _catalogService = const CatalogService();
  final CategoryDetailController _controller = const CategoryDetailController();
  late final CategoryDetailModel _data;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _data = _controller.fromCategoryId(widget.categoryId);
    _tabController = TabController(length: _data.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = _catalogService.getProductsByCategory(widget.categoryId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(_data.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.mainShell,
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.home),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(58),
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            decoration: BoxDecoration(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              dividerColor: Colors.transparent,
              labelColor: AppColor.primary,
              unselectedLabelColor: Colors.white,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              tabs: _data.tabs.map((String item) => Tab(text: item)).toList(),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF5FAFA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5FAFA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.border),
                    ),
                    child: const Row(
                      children: <Widget>[
                        Icon(Icons.tune_rounded, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Filter',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5FAFA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.border),
                    ),
                    child: const Row(
                      children: <Widget>[
                        Icon(Icons.swap_vert_rounded, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Sort By',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List<Widget>.generate(_data.tabs.length, (
                int tabIndex,
              ) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.64,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final ProductModel product = products[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.productDetails,
                          arguments: product,
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
