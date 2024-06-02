import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:todo_app/models/category_models.dart';

import '../../entities/category_realm_entity.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<CategoryModel> categoryListDataSource = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBodyPage(),
    );
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color(0xFF363636),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildChooseCategoryTitle(),
            _buildGridCategoryList(),
            _buildCreateCategoryButton()
          ],
        ),
      ),
    );
  }

  Widget _buildChooseCategoryTitle() {
    return Column(
      children: [
        Text(
          'Choose Category',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.87)),
        ),
        // Thanh duong thang
        const Divider(
          color: Color(0xFF979797),
        )
      ],
    );
  }

  Widget _buildGridCategoryList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.7),
      itemBuilder: (context, index) {
        final category = categoryListDataSource.elementAt(index);
        return _buildGridCategoryItems(category);
      },
      itemCount: categoryListDataSource.length,
    );
  }

  Widget _buildGridCategoryItems(CategoryModel category) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFCCFF88),
          ),
          child: category.iconCodePoint != null
              ? Icon(
                  IconData(category.iconCodePoint!),
                  color: Color(0xFF21A300),
                  size: 20,
                )
              : null,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            'Grocery',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateCategoryButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8687E7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
          child: const Text(
            'Add Category',
            style: TextStyle(fontSize: 16, color: Colors.white),
          )),
    );
  }

// Hàm xử lý bất đồng bộ lấy category từ realm xuống
  Future<void> _getCategoryList() async {
    // Mo realm chuan bi ghi du lieu
    var config = Configuration.local([CategoryRealmEntity.schema]);
    var realm = Realm(config);
    // Nhan data ve
    final categories = realm.all<CategoryRealmEntity>();
    List<CategoryModel> categoryModels = categories.map((e) {
      return CategoryModel(
          id: e.id.hexString,
          name: e.name,
          iconCodePoint: e.iconCodePoint,
          backgroundColorHex: e.backgroundColorHex,
          iconColorColorHex: e.iconColorColorHex);
    }).toList();
    setState(() {
      categoryListDataSource = categoryModels;
    });
  }
}
