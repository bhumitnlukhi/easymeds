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

      return itemController.relatedItemList!.isNotEmpty ? Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Column(children: [
            itemController.relatedItemList!.isNotEmpty ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Related_Products'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
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
                  child: itemController.relatedItemList != null ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                   // padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                    itemCount: itemController.relatedItemList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                        child: MedicineItemCard(item: itemController.relatedItemList![index]),
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




