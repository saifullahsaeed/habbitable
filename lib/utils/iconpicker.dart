import 'package:flutter/material.dart';
import 'package:get/get.dart';

showIconPickerCustom(
  BuildContext context,
  Function(IconData, String?) onSelected,
) async {
  List<IconData> recent = [];
  List<IconData> food = [
    Icons.menu_book_rounded,
    Icons.restaurant_rounded,
    Icons.restaurant_menu_rounded,
    Icons.lunch_dining_outlined,
  ];

  return await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return DefaultTabController(
        length: 2,
        child: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    icon: Icon(Icons.history_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.lunch_dining_outlined),
                  ),
                ],
              ),
              // Add TabBarView here
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 30,
                        childAspectRatio: 1,
                      ),
                      itemCount: recent.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(recent[index]),
                        );
                      },
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 60,
                        childAspectRatio: 1,
                      ),
                      itemCount: food.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onSelected(food[index], food[index].fontFamily);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              food[index],
                              color: Get.theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
