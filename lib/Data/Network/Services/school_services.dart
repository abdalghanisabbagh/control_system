import 'package:control_system/Data/Network/tools/app_error_handler.dart';
import 'package:control_system/Data/Network/tools/dio_factory.dart';
import 'package:control_system/Data/Network/tools/failure_model.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:dartz/dartz.dart';

class SchoolServices {
  static Future<Either<Failure, dynamic>> addNewSchoolType(
      {required String token, required String schoolType}) async {
    var dio = await DioFactory().getDio(token: token);
    try {
      var response = await dio
          .post(SchoolsLinks.schoolsType, data: {"schoolType": schoolType});
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(DataSource.DEFAULT.getFailure());
      }
    } catch (e) {
      print(e);

      return Left(DataSource.DEFAULT.getFailure());
    }
  }
}
