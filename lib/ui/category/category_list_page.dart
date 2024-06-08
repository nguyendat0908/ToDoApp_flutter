import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:todo_app/models/category_models.dart';
import 'package:todo_app/ui/category/creat_or_edit_category.dart';

import '../../entities/category_realm_entity.dart';
import '../../ultils/ultils.enums/color_extention.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<CategoryModel> categoryListDataSource = [];
  bool _isEditMode = false;

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
          color: const Color(0xFF363636),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
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
      ),
    );
  }

  Widget _buildChooseCategoryTitle() {
    return Column(
      children: [
        Text(
          'Chọn danh mục',
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
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.7),
      itemBuilder: (context, index) {
        final isLastItem = index == categoryListDataSource.length;
        if (isLastItem) {
          return _buildGridCategoryItemCreateNew();
        }
        final category = categoryListDataSource.elementAt(index);
        return _buildGridCategoryItem(category);
      },
      itemCount: categoryListDataSource.length + 1,
    );
  }

  Widget _buildGridCategoryItem(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _onHandleClickCategoryItem(category);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: category.backgroundColorHex != null
                  ? HexColor(category.backgroundColorHex!)
                  : Colors.white,
              border: Border.all(
                color: _isEditMode ? Colors.red : Colors.transparent,
                width: _isEditMode ? 2 : 0,
              ),
            ),
            child: category.iconCodePoint != null
                ? Icon(
                    IconData(category.iconCodePoint!),
                    color: category.iconColorHex != null
                        ? HexColor(category.iconColorHex!)
                        : Colors.white,
                    size: 30,
                  )
                : null,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Tạo icon create new
  Widget _buildGridCategoryItemCreateNew() {
    return GestureDetector(
      onTap: () {
        _gotoCreateCategoryPage();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFF80FFD1),
            ),
            child: const Icon(
              Icons.add,
              color: Color(0xFF00A369),
              size: 20,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: const Text(
              'Tạo mới',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateCategoryButton() {
    return Container(
      margin: const EdgeInsets.only(top: 108, bottom: 20),
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Hủy bỏ',
                style: TextStyle(
                    fontSize: 16, fontFamily: 'Lato', color: Color(0xFF8687E7)),
              )),
          const Spacer(),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditMode = !_isEditMode;
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8875FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                child: Text(
                  _isEditMode ? "Hủy chỉnh sửa" : "Chỉnh sửa",
                  style: const TextStyle(
                      fontSize: 16, fontFamily: 'Lato', color: Colors.white),
                )),
          )
        ],
      ),
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
          iconColorHex: e.iconColorHex);
    }).toList();
    setState(() {
      categoryListDataSource = categoryModels;
    });
  }

  void _gotoCreateCategoryPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CreateOrEditCategory()));
  }

  void _onHandleClickCategoryItem(CategoryModel category) {
    if (_isEditMode) {
      // Di den man hinh edit
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateOrEditCategory(
                    categoryId: category.id,
                  )));
    } else {
      Navigator.pop(context, {
        "categoryId": category.id,
        "name": category.name,
        "iconCodePoint": category.iconCodePoint,
        "backgroundColorHex": category.backgroundColorHex,
        "iconColorHex": category.iconColorHex,
      });
    }
  }
}
