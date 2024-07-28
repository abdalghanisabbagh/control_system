class AppLinks {
  /// `http://localhost:3333/`
  static const baseUrl = 'http://localhost:3333/';

  static const baseUrlDev = 'http://10.6.65.80:3333/';
}

class AuthLinks {
  static const login = 'auth/login';
  static const logout = 'auth/logout';
  static const refresh = 'auth/refresh';
  static const user = 'users';
  static const userAddRoles = 'users/add-roles';
  static const usersAddSchools = 'users/add-schools';
}

class ControlMissionLinks {
  static const controlMission = 'control-mission';
  static const controlMissionEducationYear = 'education-year';
  static const controlMissionSchool = '$controlMission/school';
  static const studentSeatNumbers = '$controlMission/student-seat-numbers';
  static const getGradesByControlMission = 'control-mission/grades';
  

}

class EducationYearsLinks {
  static const educationyear = 'education-year';
}

class ExamLinks {
  static const examMission = 'exam-mission';
  static const examMissionControlMission = 'exam-mission/control-mission';
  static const examMissionSubject = 'exam-mission/subject';
  static const examMissionUpload = 'exam-mission/upload';
  static const examRooms = 'exam-rooms';
  static const examRoomsControlMission = 'exam-rooms/control-mission';
  static const examRoomsSchoolClass = 'exam-rooms/school-class';
  static const previewExamMission = 'exam-mission/previewExam';
}

class GeneratePdfLinks {
  static const generatePdfAmCover = 'generate-pdf/am-cover';
  static const generatePdfBrCover = 'generate-pdf/br-cover';
  static const generatePdfIBCover = 'generate-pdf/IB-cover';
  static const generatePdfSeat = 'generate-pdf/seats';
}

class ProctorsLinks {
  static const proctor = 'proctor';
}

class SchoolsLinks {
  static const classDesks = 'class-desk';
  static const cohort = 'cohort';
  static const connectSubjectToCohort = '$cohort/Connect-Subject';
  static const disConnectSubjectFromCohort = '$cohort/disconnect-Subject';
  static const getAllSchools = 'schools/all';
  static const getCohortBySchoolType = '$cohort/school-type';
  static const getSchoolsClassesBySchoolId = '$schoolsClasses/school';
  static const grades = 'grades';
  static const gradesSchools = 'grades/school';
  static const schools = 'schools';
  static const schoolsClasses = 'school-classes';
  static const schoolsType = 'school-type';
  static const subject = 'subject';
  static const subjects = 'subjects';
}

class Stage {
  static const stage = 'stage';
}

class StudentsLinks {
  static const student = 'student';
  static const studentBarcodes = 'student-barcodes';
  static const studentBarcodesExamMission = 'student-barcodes/exam-mission';
  static const studentBarcodesStudent = 'student-barcodes/student';
  static const studentCohort = 'student/cohort';
  static const studentMany = 'student/many';
  static const studentSchool = 'student/school';
  static const studentSeatNumbers = 'student-seat-numbers';
  static const studentSeatNumbersControlMission =
      '$studentSeatNumbers/control-mission';

  static const studentSeatNumbersExamRoom = '$studentSeatNumbers/exam-rooms';
  static const studentSeatNumbersStudent = '$studentSeatNumbers/student';
  static const studentsClass = 'student/class';
}

class UserRolesSystemsLink {
  static const screen = 'user-roles-systems/screen';
  static const userRolesSystems = 'user-roles-systems';
  static const userRolesSystemsConnectRolesTOScreens =
      'user-roles-systems/connect-roles-to-screens';
}
