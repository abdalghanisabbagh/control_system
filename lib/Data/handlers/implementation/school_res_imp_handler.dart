import 'package:control_system/Data/Models/school/school_response/school_response.dart';
import 'package:control_system/Data/handlers/interfaces/response_interface.dart';

class SchoolResImpHandler extends ResponseInterface<SchoolResponseModel>{
  @override
  SchoolResponseModel fromJson(Map<String, dynamic> json) {
    return SchoolResponseModel.fromJson(json);
  }
  
}