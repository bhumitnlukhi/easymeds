import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/basic_medicine_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/home/widgets/web/web_basic_medicine_nearby_view_widget.dart';
import 'package:sixam_mart/features/home/widgets/web/widgets/medicine_item_card.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class RelatedProductView extends StatefulWidget {
  final bool fromShop;
  final int categoryId;
  const RelatedProductView({super.key, this.fromShop = false,required this.categoryId});

  @override
  State<RelatedProductView> createState() => _RelatedProductViewState();
}

class _RelatedProductViewState extends State<RelatedProductView> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ItemController>(builder: (itemController) {
      List<Categories>? categories = [];
      List<Item>? catOneProducts = [];
      if(widget.fromShop ? itemController.reviewedCategoriesList != null && itemController.reviewedItemList != null : itemController.basicMedicineModel != null){
        categories.add(Categories(name: 'all'.tr, id: 0));

        for (var product in widget.fromShop ? itemController.reviewedItemList! : itemController.basicMedicineModel!.products!) {
          if (widget.categoryId == product.categoryIds?[0].id) {
            if(catOneProducts.length > 5){
              break;
            }
            else {
              catOneProducts.add(product);
            }
          }
        }
      }
      return catOneProducts.isNotEmpty ? Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Column(children: [
            catOneProducts.isNotEmpty ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Related Products', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                      /*InkWell(
                        onTap: () {},
                        child: Text(
                          'see_all'.tr,
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor, decoration: TextDecoration.underline),
                        ),
                      ),*/
                    ],
                  ),
                ),
                SizedBox(
                  height: ResponsiveHelper.isDesktop(context) ? widget.fromShop ? 290 : 260 : widget.fromShop ? 292 : 247, width: Get.width,
                  child: (widget.fromShop ? itemController.reviewedCategoriesList != null : itemController.basicMedicineModel != null) ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                   // padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                    itemCount: catOneProducts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                        child: MedicineItemCard(item: catOneProducts[index]),
                      );
                    },
                  ) : const MedicineCardShimmer(),
                ),
              ],
            ) : const SizedBox(),
          ]),

        ]),
      ) : const SizedBox();
    });
  }
}




