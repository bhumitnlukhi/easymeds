import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/basic_medicine_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/home/widgets/web/web_basic_medicine_nearby_view_widget.dart';
import 'package:sixam_mart/features/home/widgets/web/widgets/medicine_item_card.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class CategoriesWiseProductView extends StatefulWidget {
  final bool fromShop;
  const CategoriesWiseProductView({super.key, this.fromShop = false});

  @override
  State<CategoriesWiseProductView> createState() => _CategoriesWiseProductViewState();
}

class _CategoriesWiseProductViewState extends State<CategoriesWiseProductView> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ItemController>(builder: (itemController) {
      List<Categories>? categories = [];
      List<Item>? catOneProducts = [];
      List<Item>? catTwoProducts = [];
      List<Item>? catThreeProducts = [];
      List<Item>? catFourProducts = [];
      List<Item>? catFiveProducts = [];
      if(widget.fromShop ? itemController.reviewedCategoriesList != null && itemController.reviewedItemList != null : itemController.basicMedicineModel != null){
        categories.add(Categories(name: 'all'.tr, id: 0));
        for (var category in widget.fromShop ? itemController.reviewedCategoriesList! : itemController.basicMedicineModel!.categories!) {
           categories.add(category);
        }
        if(categories.length > 7 ){
          for(int i=1;i<6;i++){
            for (var product in widget.fromShop ? itemController.reviewedItemList! : itemController.basicMedicineModel!.products!) {
              if(i == 1){

                if(categories[i].id == product.categoryIds?[0].id){
                  catOneProducts.add(product);
                }
              }
              else if(i == 2){
                if(categories[i].id == product.categoryIds?[0].id){
                  catTwoProducts.add(product);
                }
              }else if(i == 3){
                if(categories[i].id == product.categoryIds?[0].id){
                  catThreeProducts.add(product);
                }
              }else if(i == 4){
                if(categories[i].id == product.categoryIds?[0].id){
                  catFourProducts.add(product);
                }
              }
              else {
                if(categories[i].id == product.categoryIds?[0].id){
                  catFiveProducts.add(product);
                }
              }
            }
          }
        }

      }
      return catOneProducts.isNotEmpty ? Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          /*Padding(
            padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
            child: Text(widget.fromShop ? 'best_reviewed_products'.tr : 'basic_medicine_nearby'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
          ),*/

          Column(
              children: [
            catOneProducts.isNotEmpty ? Container(
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                color: widget.fromShop ? Theme.of(context).disabledColor.withOpacity(0.1) : Colors.purpleAccent.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,top: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${categories[1].name}', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        InkWell(
                          onTap: () {
                            // Get.toNamed(RouteHelper.getCategoryRoute());
                            Get.toNamed(RouteHelper.getCategoryItemRoute(
                              categories[1].id, categories[1].name!,
                            ));
                          },
                          child: Text(
                            'view_more'.tr,
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.isDesktop(context) ? widget.fromShop ? 290 : 260 : widget.fromShop ? 292 : 247, width: Get.width,
                    child: (widget.fromShop ? itemController.reviewedCategoriesList != null : itemController.basicMedicineModel != null) ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
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
              ),
            ) : const SizedBox(),
            catTwoProducts.isNotEmpty ? Container(
              margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                color: widget.fromShop ? Theme.of(context).disabledColor.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,top: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${categories[2].name}', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouteHelper.getCategoryItemRoute(
                              categories[2].id, categories[2].name!,
                            ));                          },
                          child: Text(
                            'view_more'.tr,
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.isDesktop(context) ? widget.fromShop ? 290 : 260 : widget.fromShop ? 292 : 247, width: Get.width,
                    child: (widget.fromShop ? itemController.reviewedCategoriesList != null : itemController.basicMedicineModel != null) ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                      itemCount: catTwoProducts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                          child: MedicineItemCard(item: catTwoProducts[index]),
                        );
                      },
                    ) : const MedicineCardShimmer(),
                  ),
                ],
              ),
            ) : const SizedBox(),
            catThreeProducts.isNotEmpty ? Container(
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                color: widget.fromShop ? Theme.of(context).disabledColor.withOpacity(0.1) : Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,top: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${categories[3].name}', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouteHelper.getCategoryItemRoute(
                              categories[3].id, categories[3].name!,
                            ));                          },
                          child: Text(
                            'view_more'.tr,
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.isDesktop(context) ? widget.fromShop ? 290 : 260 : widget.fromShop ? 292 : 247, width: Get.width,
                    child: (widget.fromShop ? itemController.reviewedCategoriesList != null : itemController.basicMedicineModel != null) ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                      itemCount: catThreeProducts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                          child: MedicineItemCard(item: catThreeProducts[index]),
                        );
                      },
                    ) : const MedicineCardShimmer(),
                  ),
                ],
              ),
            ) : const SizedBox(),
            catFourProducts.isNotEmpty ? Container(
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                color: widget.fromShop ? Theme.of(context).disabledColor.withOpacity(0.1) : Colors.blue.withOpacity(0.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,top: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${categories[4].name}', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouteHelper.getCategoryItemRoute(
                              categories[4].id, categories[4].name!,
                            ));                          },
                          child: Text(
                            'view_more'.tr,
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.isDesktop(context) ? widget.fromShop ? 290 : 260 : widget.fromShop ? 292 : 247, width: Get.width,
                    child: (widget.fromShop ? itemController.reviewedCategoriesList != null : itemController.basicMedicineModel != null) ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                      itemCount: catFourProducts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                          child: MedicineItemCard(item: catFourProducts[index]),
                        );
                      },
                    ) : const MedicineCardShimmer(),
                  ),
                ],
              ),
            ) : const SizedBox(),
            catFiveProducts.isNotEmpty ? Container(
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                color: widget.fromShop ? Theme.of(context).disabledColor.withOpacity(0.1) : Colors.purpleAccent.withOpacity(0.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,top: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${categories[5].name}', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouteHelper.getCategoryItemRoute(
                              categories[5].id, categories[5].name!,
                            ));                          },
                          child: Text(
                            'view_more'.tr,
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.isDesktop(context) ? widget.fromShop ? 290 : 260 : widget.fromShop ? 292 : 247, width: Get.width,
                    child: (widget.fromShop ? itemController.reviewedCategoriesList != null : itemController.basicMedicineModel != null) ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                      itemCount: catFiveProducts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                          child: MedicineItemCard(item: catFiveProducts[index]),
                        );
                      },
                    ) : const MedicineCardShimmer(),
                  ),
                ],
              ),
            ) : const SizedBox(),
            const SizedBox(height: 10,),
            InkWell(
              onTap: () {
                Get.toNamed(RouteHelper.getCategoryRoute());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeLarge),
                child: Text(
                  'view_more'.tr, style: robotoMedium.copyWith(color: Theme.of(context).cardColor),
                ),
              ),
            ),
            const SizedBox(height: 15,)
          ]),

        ]),
      ) : const SizedBox();
    });
  }
}




