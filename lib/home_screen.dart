import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_with_login/controller/home_scren_controller.dart';
import 'package:task_with_login/helper/routes/routes.dart';
import 'package:task_with_login/utils/api_constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
 TextEditingController searchController=TextEditingController();
   HomeScreenController controller=Get.put(HomeScreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Padding(
           padding: const EdgeInsets.only(top: 10),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                TextFormField(
                  controller:searchController,
                 decoration:const InputDecoration(
                   hintText: "Search",
                   border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )
                   )
                 ),
                ),
               Obx(()=>
                  Expanded(
                   child: RefreshIndicator(
                     onRefresh: () async{
                       controller.reset();
                       controller.getList(1);
                     },
                     child: Scrollbar(
                       controller: controller.scrollController,
                       child: ListView.builder(
                           controller: controller.scrollController,
                         itemCount:controller.moviesList.length,
                           shrinkWrap:true,
                           itemBuilder:(context,index){
                           var model=controller.moviesList[index];
                           return InkWell(
                             onTap: (){
                               Get.toNamed(Routes.movieDetails,arguments:model.id);
                             },
                             child: Row(
                               children: [
                                 Container(
                                   color: Colors.cyan,
                                   width: 120,
                                   height: 140,
                                   margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                   child: CachedNetworkImage(
                                     imageUrl:"${ApiConstants.imageUrl}${model.posterPath}",
                                     imageBuilder: (context, imageProvider) {
                                       return Container(
                                         width: 120,
                                         height: 140,
                                         decoration:BoxDecoration(
                                           borderRadius: BorderRadius.circular(10),
                                           image: DecorationImage(
                                             image: imageProvider,
                                             fit:BoxFit.fill,
                                           ),
                                         ),
                                       );
                                     },
                                     placeholder: (context, url) {
                                       return const SizedBox(
                                         width: 120,
                                         height: 140,
                                         child: Center(
                                           child: SizedBox(
                                             width:  10,
                                             height: 10,
                                             child: CircularProgressIndicator(
                                               valueColor:
                                               AlwaysStoppedAnimation<Color>(Colors.blue),
                                               strokeWidth: 3.5,
                                             ),
                                           ),
                                         ),
                                       );
                                     },
                                     errorWidget: (context, url, error) {
                                       return Container(
                                         width: 120,
                                         height: 140,
                                         color: Colors.red ,
                                         child: const Icon(Icons.error),
                                       );
                                     },
                                   ),
                                 ),
                                 const SizedBox(width: 10,),
                                 Expanded(
                                   child: Padding(
                                     padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(model.title??"",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                         Text(model.originalLanguage??"",
                                           style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                         ),
                                         Text("${model.voteAverage}/10",
                                           style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                         ),
                                         Text(model.overview??"",
                                           style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                           maxLines: 4,
                                           overflow: TextOverflow.ellipsis,),
                                       ],
                                     ),
                                   ),
                                 )
                               ],
                             ),
                           );
                       }),
                     ),
                   ),
                 ),
               )
             ],
           ),
         ),
       ),
    );
  }
}
