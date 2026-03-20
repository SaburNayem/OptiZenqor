import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/widget/card_widget.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/drawer/drawer_screen/drawer_screen.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/feature/master/shop/shop_controller/shop_controller.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({this.initialQuery, super.key});

  final String? initialQuery;

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ShopController _controller = ShopController();
  final TextEditingController _searchController = TextEditingController();
  late List<ProductModel> _products;
  RangeValues _priceRange = const RangeValues(0, 50);
  double _minimumRating = 0;

  bool get _hasSearchQuery => _searchController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _products = _controller.data.products;

    if (widget.initialQuery != null && widget.initialQuery!.trim().isNotEmpty) {
      _searchController.text = widget.initialQuery!;
      _products = _controller.searchProducts(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _products = _applyFilters(_controller.searchProducts(query));
    });
  }

  List<ProductModel> _applyFilters(List<ProductModel> products) {
    return products.where((ProductModel product) {
      return product.price >= _priceRange.start &&
          product.price <= _priceRange.end &&
          product.rating >= _minimumRating;
    }).toList();
  }

  Future<void> _openFilterSheet() async {
    RangeValues selectedPriceRange = _priceRange;
    double selectedRating = _minimumRating;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Filter Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Price Range: \$${selectedPriceRange.start.round()} - \$${selectedPriceRange.end.round()}',
                  ),
                  RangeSlider(
                    values: selectedPriceRange,
                    min: 0,
                    max: 50,
                    divisions: 10,
                    labels: RangeLabels(
                      '\$${selectedPriceRange.start.round()}',
                      '\$${selectedPriceRange.end.round()}',
                    ),
                    onChanged: (RangeValues values) {
                      setModalState(() {
                        selectedPriceRange = values;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  Text('Minimum Rating: ${selectedRating.toStringAsFixed(1)}'),
                  Slider(
                    value: selectedRating,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: selectedRating.toStringAsFixed(1),
                    onChanged: (double value) {
                      setModalState(() {
                        selectedRating = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _priceRange = const RangeValues(0, 50);
                              _minimumRating = 0;
                              _products = _applyFilters(
                                _controller.searchProducts(
                                  _searchController.text.trim(),
                                ),
                              );
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              _priceRange = selectedPriceRange;
                              _minimumRating = selectedRating;
                              _products = _applyFilters(
                                _controller.searchProducts(
                                  _searchController.text.trim(),
                                ),
                              );
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MasterDrawerScreen(),
      appBar: AppCustomAppBar(
        title: 'Shop',
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: _openFilterSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7F8),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0xFFE3E8EB)),
                ),
                child: const Row(
                  children: <Widget>[
                    Icon(Icons.tune_rounded, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(Icons.menu_rounded),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!_hasSearchQuery) ...<Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.categories);
                      },
                      child: const Text('Categories'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Offer page ready to add next'),
                          ),
                        );
                      },
                      child: const Text('Offer'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
            ],
            TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: const InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 18),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (BuildContext context, int index) {
                final ProductModel product = _products[index];
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
            ),
          ],
        ),
      ),
    );
  }
}
