import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:realm/realm.dart';
import 'package:todo_app/ultils/ultils.enums/color_extention.dart';

import '../../entities/category_realm_entity.dart';

class CreateOrEditCategory extends StatefulWidget {
  const CreateOrEditCategory({super.key});

  @override
  State<CreateOrEditCategory> createState() => _CreateOrEditCategoryState();
}

class _CreateOrEditCategoryState extends State<CreateOrEditCategory> {
  final _nameCategoryTextController = TextEditingController();
  // final List<Color> _colorDataSoure = [];
  // final List<Icon> _iconDataSoure = [];
  Color _colorSelected = Colors.white;
  Color _iconColorSelected = Colors.white;
  IconData? _iconSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In duong dan lket voi realm
    final storagePath = Configuration.defaultRealmPath;
    print(storagePath);
    // _colorDataSoure.addAll([
    //   const Color(0xFFC9CC41),
    //   const Color(0xFF66CC41),
    //   const Color(0xFF41CCA7),
    //   const Color(0xFF4181CC),
    //   const Color(0xFF41A2CC),
    //   const Color(0xFFCC8441),
    //   const Color(0xFF9741CC),
    //   const Color(0xFFCC4173),
    // ]);
    // _iconDataSoure.addAll([
    //   const Icon(Icons.local_grocery_store),
    //   const Icon(Icons.work),
    //   const Icon(Icons.sports),
    //   const Icon(Icons.design_services),
    //   const Icon(Icons.book),
    //   const Icon(Icons.social_distance),
    //   const Icon(Icons.music_note),
    //   const Icon(Icons.health_and_safety),
    //   const Icon(Icons.movie),
    //   const Icon(Icons.home),
    //   const Icon(Icons.create),
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Create new category',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Lato'),
        ),
      ),
      body: _buildBodyPageScreen(),
    );
  }

  Widget _buildBodyPageScreen() {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
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
      ),
    );
  }

  Widget _buildCategoryNameFiled() {
    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle('Category name :'),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _nameCategoryTextController,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
              decoration: InputDecoration(
                  hintText: 'Category name',
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFAFAFAF),
                      fontFamily: 'Lato'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFF979797)))),
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
          _buildFieldTitle('Category icon :'),
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
                        'Choose icon from library',
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
          _buildFieldTitle('Category color :'),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: _onChooseCategoryBackgroundColor,
              child: Container(
                width: 36,
                height: 36,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: _colorSelected),
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 10),
          //   width: double.infinity,
          //   height: 36,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       final color = _colorDataSoure.elementAt(index);
          //       final isSelected = _colorSelected == color;
          //       return GestureDetector(
          //         onTap: () {
          //           print('Chon mau thu $index');
          //           setState(() {
          //             _colorSelected = color;
          //           });
          //         },
          //         child: Container(
          //           width: 36,
          //           height: 36,
          //           margin: EdgeInsets.only(right: 12),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(18), color: color),
          //           child: isSelected
          //               ? Icon(
          //                   Icons.check,
          //                   color: Colors.white,
          //                   size: 20,
          //                 )
          //               : null,
          //         ),
          //       );
          //     },
          //     itemCount: _colorDataSoure.length,
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(top: 10),
          //   width: double.infinity,
          //   height: 36,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       final color = _colorDataSoure.elementAt(index);
          //       final isSelected = _colorSelected == color;
          //       return GestureDetector(
          //         onTap: () {
          //           print('Chon mau thu $index');
          //           setState(() {
          //             _colorSelected = color;
          //           });
          //         },
          //         child: Container(
          //           width: 36,
          //           height: 36,
          //           margin: EdgeInsets.only(right: 12),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(18), color: color),
          //           child: isSelected
          //               ? Icon(
          //                   Icons.check,
          //                   color: Colors.white,
          //                   size: 20,
          //                 )
          //               : null,
          //         ),
          //       );
          //     },
          //     itemCount: _colorDataSoure.length,
          //   ),
          // ),
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
          _buildFieldTitle('Category icon & text color :'),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: _onChooseCategoryIconTextColor,
              child: Container(
                width: 36,
                height: 36,
                margin: EdgeInsets.only(right: 12),
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
          _buildFieldTitle('Category icon & text color'),
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
                  color: _colorSelected,
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
            margin: EdgeInsets.only(left: 30),
            child: TextButton(
                onPressed: () {
                  // todo
                },
                child: const Text(
                  'Cancel',
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
                onPressed: _onHandleCreateCategory,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8875FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                child: const Text(
                  'Create Category',
                  style: TextStyle(
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

      final backgroundColorHex = _colorSelected.toHex();
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
      _colorSelected = const Color(0xFFC9CC41);
      _iconColorSelected = const Color(0xFF21A300);
      _iconSelected = null;
      setState(() {});
      // Show alert len man hinh nguoi dung
      _showAlert('Successfully', 'Create category!');
    } catch (e) {
      print(e);
      _showAlert('Fail', 'No create category!');
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
                pickerColor: _colorSelected,
                onColorChanged: (Color newColor) {
                  setState(() {
                    _colorSelected = newColor;
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

  void _showAlert(String title, String message) {
    showDialog(
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
                  child: Text('OK'))
            ],
          );
        });
  }
}
