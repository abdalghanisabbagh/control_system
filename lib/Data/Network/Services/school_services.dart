class SchoolServices {
  // static Future<Either<Failure, dynamic>> addNewSchoolType(
  //     {required String schoolType}) async {
  // TokenService tokenService = Get.find<TokenService>();
  // if (tokenService.tokenModel == null) {
  //   return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  // }

  // var dio = DioFactory().getDio(token: tokenService.tokenModel);
  // try {
  //   var response = await dio
  //       .post(SchoolsLinks.schoolsType, data: {"schoolType": schoolType});
  //   if (response.statusCode == 201) {
  //     return const Right(true);
  //   } else {
  //     return Left(DataSource.DEFAULT.getFailure());
  //   }
  // } catch (e) {

  //   return Left(DataSource.DEFAULT.getFailure());
  // }
  // }
}
