import 'package:sixam_mart/common/widgets/paginated_list_view.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/web_page_title_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<CategoryController>().getCategoryList(false);

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'categories'.tr),
      endDrawer: const MenuDrawer(),endDrawerEnableOpenDragGesture: false,
      body: SafeArea(child: SingleChildScrollView(
        controller: _scrollController, child: FooterView(child: Column(
          children: [
            WebScreenTitleWidget(title: 'categories'.tr),
            SizedBox(
            width: Dimensions.webMaxWidth,
            child: GetBuilder<CategoryController>(builder: (catController) {
              return catController.categoryList != null ? catController.categoryList!.isNotEmpty ?
              PaginatedListView(
                scrollController: _scrollController,
                onPaginate: (int? offset) => catController.getCategoryList(false,offset: offset ?? 1),
                totalSize: catController.categoryResponse?.totalSize,
                viewButton: true,
                offset: int.parse(catController.categoryResponse?.offset ?? '1'),
                //enabledPagination: true,
                itemView: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 : ResponsiveHelper.isTab(context) ? 4 : 2,
                    childAspectRatio: (1/1),
                    mainAxisSpacing: Dimensions.paddingSizeSmall,
                    crossAxisSpacing: Dimensions.paddingSizeSmall,
                  ),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  itemCount: catController.categoryList!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.toNamed(RouteHelper.getCategoryItemRoute(
                        catController.categoryList![index].id, catController.categoryList![index].name!,
                      )),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                        ),
                        alignment: Alignment.center,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

                          ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            child: CustomImage(
                              height: 50, width: 50, fit: BoxFit.cover,
                              image: '${catController.categoryList![index].imageFullUrl}',
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                          Text(
                            catController.categoryList![index].name!, textAlign: TextAlign.center,
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                            maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),

                        ]),
                      ),
                    );
                  },
                ),
              ) : NoDataScreen(text: 'no_category_found'.tr) : const Center(child: CircularProgressIndicator());
            }),
      ),
          ],
        )))),
    );
  }
}


