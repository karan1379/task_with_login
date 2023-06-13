import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_with_login/controller/home_scren_controller.dart';
import 'package:task_with_login/utils/api_constants.dart';

class MovieDetailScreen extends StatelessWidget {
  var movieId ;
   MovieDetailScreen({required this.movieId,Key? key}) : super(key: key){
    // var movieId=Get.arguments;
    controller.movieDetails(movieId);
  }

  HomeScreenController controller=Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Detail"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.cyan,
                width: Get.width,
                height: 300,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Obx(
                      () => CachedNetworkImage(
                    imageUrl:
                    "${ApiConstants.imageUrl}${controller.movieDetailModel.value?.belongsToCollection?.posterPath}",
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: 120,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
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
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
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
                        color: Colors.blue,
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
                ),
              ),
              Obx(() => Text(
                controller.movieDetailModel.value?.title ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 20),
              )),
              const SizedBox(
                height: 5,
              ),
              Obx(() => Text(
                controller.movieDetailModel.value?.tagline ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 12),
              )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text("${controller.movieDetailModel.value?.voteAverage?.toStringAsFixed(1)}/10",
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),)),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text(controller.movieDetailModel.value?.status ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),
              )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text(controller.movieDetailModel.value?.releaseDate ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16),)),
              const SizedBox(
                height: 10,
              ),
              /*     Obx(() =>
                  Text(_controller.model.value?.popularity.toString() ?? "")),
              const SizedBox(
                height: 10,
              ),*/
              Obx(() => Text(controller.movieDetailModel.value?.genres != null
                  ? controller.movieDetailModel.value!.genres!.map((e) => e.name).join(",")
                  : "",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16),)),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text(controller.movieDetailModel.value?.overview ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15),)),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Get.width/2,
                  child: ElevatedButton(
                    style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),),
                    onPressed: () {
                     // Get.to(()=>BookTicketScreen());
                    },
                    child: const Text("Book Ticket",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),),),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
