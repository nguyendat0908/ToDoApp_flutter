import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:realm/realm.dart';
import 'package:todo_app/ultils/ultils.enums/color_extention.dart';

import '../../entities/category_realm_entity.dart';

class CreateOrEditCategory extends StatefulWidget {
  final String? categoryId;
  const CreateOrEditCategory({super.key, this.categoryId});

  @override
  State<CreateOrEditCategory> createState() => _CreateOrEditCategoryState();
}

class _CreateOrEditCategoryState extends State<CreateOrEditCategory> {
  final _nameCategoryTextController = TextEditingController();
  Color _backgroundColorSelected = Colors.white;
  Color _iconColorSelected = Colors.white;
  IconData? _iconSelected;
  bool get isEdit {
    return widget.categoryId != null;
  }

  @override
  void initState() {
    super.initState();
    // In duong dan lket voi realm
    final storagePath = Configuration.defaultRealmPath;
    print(storagePath);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isEdit) {
        _findCategory(widget.categoryId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          isEdit ? 'Chỉnh sửa' : 'Tạo mới danh mục',
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Lato'),
        ),
      ),
      body: _buildBodyPageScreen(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBodyPageScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryNameFiled(),
        _buildCategoryChooseIconFiled(),
        _buildCategoryChooseBackgroundColorFiled(),
        _buildCategoryChooseIconAndTextColorFiled(),
        _buildCategoryPreview(),
        const Spacer(),
        _buildCancelAndCreateOrEditButton(),
      ],
    );
  }

  Widget _buildCategoryNameFiled() {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle('Tên danh mục :'),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _nameCategoryTextController,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
              decoration: InputDecoration(
                  hintText: 'Tên danh mục',
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFAFAFAF),
                      fontFamily: 'Lato'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                          width: 1, color: Color(0xFF979797)))),
              autofocus: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChooseIconFiled() {
    return Container(
      margin: const EdgeInsets.only(left: 24, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle('Biểu tượng danh mục :'),
          GestureDetector(
            onTap: _chooseIcon,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white.withOpacity(0.21),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _iconSelected != null
                    ? Icon(
                        _iconSelected,
                        color: Colors.white,
                        size: 26,
                      )
                    : Text(
                        'Chọn biểu tượng từ thư viện',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.87),
                            fontFamily: 'Lato'),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChooseBackgroundColorFiled() {
    return Container(
      margin: const EdgeInsets.only(left: 24, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle('Màu danh mục :'),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: _onChooseCategoryBackgroundColor,
              child: Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: _backgroundColorSelected),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChooseIconAndTextColorFiled() {
    return Container(
      margin: const EdgeInsets.only(left: 24, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle('Biểu tượng danh mục và màu văn bản :'),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: _onChooseCategoryIconTextColor,
              child: Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: _iconColorSelected),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPreview() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle('Biểu tượng danh mục và màu văn bản :'),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _backgroundColorSelected,
                ),
                child: Icon(
                  _iconSelected,
                  color: _iconColorSelected,
                  size: 20,
                ),
              ),
              Text(
                _nameCategoryTextController.text,
                style: TextStyle(fontSize: 14, color: _iconColorSelected),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFieldTitle(String titleLabel) {
    return Text(
      titleLabel,
      style: TextStyle(
          fontSize: 16,
          color: Colors.white.withOpacity(0.87),
          fontFamily: 'Lato'),
    );
  }

  Widget _buildCancelAndCreateOrEditButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Hủy bỏ',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: Color(0xFF8687E7)),
                )),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
                onPressed: () {
                  if (isEdit) {
                    _editCategory();
                  } else {
                    _onHandleCreateCategory();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8875FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                child: Text(
                  isEdit ? 'Xong' : 'Tạo danh mục',
                  style: const TextStyle(
                      fontSize: 16, fontFamily: 'Lato', color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  void _onHandleCreateCategory() async {
    try {
      final categoryName = _nameCategoryTextController.text;
      if (categoryName.isEmpty) {
        // Khong lam gi ca
        return;
      }
      // Mo realm chuan bi ghi du lieu
      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);

      final backgroundColorHex = _backgroundColorSelected.toHex();
      var catogery = CategoryRealmEntity(ObjectId(), categoryName,
          iconCodePoint: _iconSelected?.codePoint,
          backgroundColorHex: backgroundColorHex,
          iconColorColorHex: _iconColorSelected.toHex());
      // Luu len realm
      await realm.writeAsync(() {
        realm.add(catogery);
      });
      // Reset lai du lieu sau khi tao thanh cong
      _nameCategoryTextController.text = '';
      _backgroundColorSelected = const Color(0xFFC9CC41);
      _iconColorSelected = const Color(0xFF21A300);
      _iconSelected = null;
      setState(() {});
      // Show alert len man hinh nguoi dung
      _showAlert('Thành công', 'Tạo danh mục!');
    } catch (e) {
      print(e);
      _showAlert('Lỗi', 'Không tạo được danh mục!');
    }
  }

  void _chooseIcon() async {
    IconData? icon =
        await showIconPicker(context, iconPackModes: [IconPack.material]);
    setState(() {
      _iconSelected = icon;
    });
  }

  void _onChooseCategoryBackgroundColor() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: _backgroundColorSelected,
                onColorChanged: (Color newColor) {
                  setState(() {
                    _backgroundColorSelected = newColor;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  void _onChooseCategoryIconTextColor() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: _iconColorSelected,
                onColorChanged: (Color newColor) {
                  setState(() {
                    _iconColorSelected = newColor;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  Future<void> _showAlert(String title, String message) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  // Tim category
  void _findCategory(String id) {
    // Mo realm chuan bi ghi du lieu
    var config = Configuration.local([CategoryRealmEntity.schema]);
    var realm = Realm(config);
    // Tim theo id
    final category =
        realm.find<CategoryRealmEntity>(ObjectId.fromHexString(id));
    if (category == null) {
      return;
    }
    _nameCategoryTextController.text = category.name;
    if (category.iconCodePoint != null) {
      _iconSelected = IconData(category.iconCodePoint!, fontFamily: "Lato");
    }
    if (category.backgroundColorHex != null) {
      _backgroundColorSelected = HexColor(category.backgroundColorHex!);
    }
    if (category.iconColorHex != null) {
      _iconColorSelected = HexColor(category.iconColorHex!);
    }
    setState(() {});
  }

  Future<void> _editCategory() async {
    try {
      final categoryName = _nameCategoryTextController.text;
      if (categoryName.isEmpty) {
        // Khong lam gi ca
        return;
      }
      // Mo realm chuan bi ghi du lieu
      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);

      final category = realm.find<CategoryRealmEntity>(
          ObjectId.fromHexString(widget.categoryId!));
      if (category == null) {
        return;
      }
      // Luu len realm
      await realm.writeAsync(() {
        category.name = categoryName;
        category.iconCodePoint = _iconSelected?.codePoint;
        category.backgroundColorHex = _backgroundColorSelected.toHex();
        category.iconColorHex = _iconColorSelected.toHex();
      });
      // Reset lai du lieu sau khi tao thanh cong
      _nameCategoryTextController.text = '';
      _backgroundColorSelected = const Color(0xFFC9CC41);
      _iconColorSelected = const Color(0xFF21A300);
      _iconSelected = null;
      setState(() {});
      // Show alert len man hinh nguoi dung
      await _showAlert('Thành công', 'Chỉnh sửa danh mục!');
      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
      _showAlert('Lỗi', 'Không sửa được danh mục!');
    }
  }
}
