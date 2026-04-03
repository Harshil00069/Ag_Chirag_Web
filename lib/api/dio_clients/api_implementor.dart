import 'dart:convert';
import 'package:dio/dio.dart';
import 'dio_client_base.dart';
import 'token_dio_client.dart';

class ApiImplementor {

  // static Future<AdminLoginModel> adminLoginApiImplementer({
  //   required String email,
  //   required String pwd,
  // }) async {
  //   try {
  //     final response = await DioClient.getDioClient()!.post(
  //       options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
  //       'loginAdmin',
  //       data: {'email': email, 'password': pwd}
  //     );
  //
  //     if (response.statusCode == 200) {
  //       DioClient.commonDebugLogger(response.realUri);
  //       DioClient.commonDebugLogger(response.data);
  //       final responseData = response.data is String
  //           ? jsonDecode(response.data)
  //           : response.data;
  //       return AdminLoginModel.fromJson(responseData);
  //     } else {
  //       throw CustomHttpException(
  //         exceptionMsg: response.statusMessage ?? "Internal Server Error",
  //       );
  //     }
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
  //
  // static Future<InsertProductDetailsModel> insertProductDetailApiImplementer({
  //   required XFile productImagePath,
  //   required List<XFile> subImagePaths,
  //   required String productName,
  //   required String productDescription,
  //   required String stockCount,
  //   required String productPrice,
  //   required String discountPrice,
  //   required bool productVisibility,
  // }) async {
  //   try {
  //     print("check=> ${productImagePath.path.isNotEmpty}");
  //     print("check2=> ${productImagePath.readAsBytes()}");
  //     print("name=> ${productImagePath.name}");
  //     var data = FormData.fromMap({
  //       'product_name': productName,
  //       'product_description': productDescription,
  //       'stock': stockCount,
  //       'price': productPrice,
  //       'discount_price': discountPrice,
  //       'product_visibility': productVisibility,
  //       "mainImage":productImagePath.path.isNotEmpty? MultipartFile.fromBytes(await productImagePath.readAsBytes(),filename: productImagePath.name) :"",
  //       "subImages": subImagePaths.isNotEmpty ? [
  //         for (var file in subImagePaths)
  //           MultipartFile.fromBytes(
  //               await file.readAsBytes(),
  //               filename: file.name
  //           )
  //       ] :[]
  //     });
  //
  //     final response = await TokenDioClient.getTokenDioClient()!.post(
  //       'insertProductDetail',
  //       data: data,
  //     );
  //     if (response.statusCode == 200) {
  //       return InsertProductDetailsModel.fromJson(response.data);
  //     } else {
  //       throw CustomHttpException(
  //         exceptionMsg: response.statusMessage.toString(),
  //       );
  //     }
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
  //
  // static Future<ProductDataModel> fetchProductDataApiImplementer()async{
  //   try {
  //
  //     final response = await TokenDioClient.getTokenDioClient()!.get(
  //       'getAllProducts',
  //     );
  //     if (response.statusCode == 200) {
  //       return ProductDataModel.fromJson(response.data);
  //     } else {
  //       throw CustomHttpException(
  //         exceptionMsg: response.statusMessage.toString(),
  //       );
  //     }
  //   }catch(e){
  //     rethrow;
  //   }
  // }
  //
  //
  // static Future<CommonResponseModel> updateProductVisibilityApiImplementer({required String id, required bool status})async{
  //   try {
  //
  //     final response = await TokenDioClient.getTokenDioClient()!.get(
  //       'updateProductVisibility',
  //       queryParameters: {
  //         "id": id,
  //         "status": status
  //       }
  //     );
  //     if (response.statusCode == 200) {
  //       return CommonResponseModel.fromJson(response.data);
  //     } else {
  //       throw CustomHttpException(
  //         exceptionMsg: response.statusMessage.toString(),
  //       );
  //     }
  //   }catch(e){
  //     rethrow;
  //   }
  // }
  //
  //
  // static Future<InsertProductDetailsModel> updateProductDetailApiImplementer({
  //   required XFile productImagePath,
  //   required List<XFile> subImagePaths,
  //   required String productName,
  //   required String productDescription,
  //   required String stockCount,
  //   required String productPrice,
  //   required String discountPrice,
  //   required bool productVisibility,
  //   required String id,
  // }) async {
  //   try {
  //     var data = FormData.fromMap({
  //       "id": id,
  //       'product_name': productName,
  //       'product_description': productDescription,
  //       'stock': stockCount,
  //       'price': productPrice,
  //       'discount_price': discountPrice,
  //       'product_visibility': productVisibility,
  //       "mainImage":productImagePath.path.isNotEmpty? MultipartFile.fromBytes(await productImagePath.readAsBytes(),filename: productImagePath.name) :"",
  //       "subImages": subImagePaths.isNotEmpty ? [
  //         for (var file in subImagePaths)
  //           MultipartFile.fromBytes(
  //               await file.readAsBytes(),
  //               filename: file.name
  //           )
  //       ] :[]
  //     });
  //     final response = await TokenDioClient.getTokenDioClient()!.post(
  //       'updateProductDetail',
  //       data: data,
  //     );
  //     if (response.statusCode == 200) {
  //       return InsertProductDetailsModel.fromJson(response.data);
  //     } else {
  //       throw CustomHttpException(
  //         exceptionMsg: response.statusMessage.toString(),
  //       );
  //     }
  //   } catch (error) {
  //     print("error=> ${error}");
  //     rethrow;
  //   }
  // }
  //
  // static Future<CommonResponseModel> deleteProductApiImplementer({required String id,})async{
  //   try {
  //
  //     final response = await TokenDioClient.getTokenDioClient()!.get(
  //         'deleteProduct',
  //         queryParameters: {
  //           "id": id,
  //         }
  //     );
  //     if (response.statusCode == 200) {
  //       return CommonResponseModel.fromJson(response.data);
  //     } else {
  //       throw CustomHttpException(
  //         exceptionMsg: response.statusMessage.toString(),
  //       );
  //     }
  //   }catch(e){
  //     rethrow;
  //   }
  // }
}
