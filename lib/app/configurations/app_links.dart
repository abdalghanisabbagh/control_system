class AppLinks {
  static const baseUrl = 'http://localhost:80/';
  static const baseUrlDev = 'http://localhost:3333/';
  static const baseUrlProd =
      'https://control-2025-490607372730.us-central1.run.app/';

  static const baseUrlStaging =
      'https://staging-control-2025-490607372730.us-central1.run.app/';
}

class AuthLinks {
  static const auth = 'auth';
  static const getNewAccessToken = '$auth/get-new-access-token';
  static const login = '$auth/login';
  static const logout = '$auth/logout';
  static const refresh = '$auth/refresh';
}

class CohortLinks {
  static const cohort = 'cohort';
  static const connectSubjectToCohort = '$cohort/Connect-Subject';
  static const disConnectSubjectFromCohort = '$cohort/disconnect-Subject';
  static const getCohortBySchoolType = '$cohort/school-type';
  static const operationCreateCohort = '$cohort/operation-create-cohort';
}

class ControlMissionLinks {
  static const controlMission = 'control-mission';
  static const controlMissionEducationYear = 'education-year';
  static const controlMissionSchool = '$controlMission/school';
  static const distributedStudents = '$controlMission/distribution';
  static const getGradesByControlMission = '$controlMission/grades';
  static const getSubjectsByControlMission = 'subjects/controlMission';
  static const studentSeatNumbers = '$controlMission/student-seat-numbers';
}

class EducationYearsLinks {
  static const educationYear = 'education-year';
}

class ExamMissionLinks {
  static const examMission = 'exam-mission';
  static const examMissionControlMission = '$examMission/control-mission';
  static const examMissionSubject = '$examMission/subject';
  static const examMissionUpload = '$examMission/upload';
  static const previewExamMission = '$examMission/previewExam';
}

class ExamRoomLinks {
  static const examRooms = 'exam-rooms';
  static const examRoomsControlMission = '$examRooms/control-mission';
  static const examRoomsSchoolClass = '$examRooms/school-class';
}

class GeneratePdfLinks {
  static const generatePdf = 'generate-pdf';
  static const generatePdfAmCover = '$generatePdf/am-cover';
  static const generatePdfAttendance = '$generatePdf/attendance';
  static const generatePdfBrCover = '$generatePdf/br-cover';
  static const generatePdfIBCover = '$generatePdf/IB-cover';
  static const generatePdfSeat = '$generatePdf/seats';
}

class GradeLinks {
  static const grades = 'grades';
  static const gradesSchools = '$grades/school';
}

class ProctorsLinks {
  static const proctor = 'proctor';
}

class SchoolsLinks {
  static const classDesks = 'class-desk';
  static const getAllSchools = '$schools/all';
  static const getSchoolsClassesBySchoolId = '$schoolsClasses/school';
  static const schools = 'schools';
  static const schoolsClasses = 'school-classes';
  static const schoolsType = 'school-type';
}

class Stage {
  static const stage = 'stage';
}

class StudentsLinks {
  static const getStudentsByControlMission = '$student/controlMission';
  static const student = 'student';
  static const studentBarcodes = 'student-barcodes';
  static const studentBarcodesExamMission = 'student-barcodes/exam-mission';
  static const studentBarcodesStudent = 'student-barcodes/student';
  static const studentCohort = '$student/cohort';
  static const studentMany = '$student/many';
  static const studentSchool = '$student/school';
  static const studentSeatNumberActive = '$studentSeatNumbers/activate';
  static const studentSeatNumberDeActive = '$studentSeatNumbers/deactivate';
  static const studentSeatNumbers = 'student-seat-numbers';
  static const studentSeatNumbersControlMission =
      '$studentSeatNumbers/control-mission';

  static const studentSeatNumbersExamRoom = '$studentSeatNumbers/exam-rooms';
  static const studentSeatNumbersStudent = '$studentSeatNumbers/student';
  static const studentsClass = '$student/class';
  static const studentsGrades = '$student/students-grades/control-mission/';
}

class SubjectsLinks {
  static const deleteSchoolTypeInSubjects = '$subjects/remove-school-type';
  static const subject = 'subject';
  static const subjects = 'subjects';
  static const subjectsBySchoolType = '$subjects/school-type/';
  static const subjectsDeactivate = '$subjects/deactivate';
}

class UserLinks {
  static const activateUser = 'users/activate';
  static const deactivateUser = '/$users/deactivate';
  static const String getNewAccessToken = 'auth/get-new-access-token';
  static const getUsersByCreated = '$users/created-by';
  static const login = 'auth/login';
  static const logout = 'auth/logout';
  static const refresh = 'auth/refresh';
  static const userAddRoles = '$users/add-roles';
  static const userEditRoles = '$users/edit-roles';
  static const userEditUserHasSchools = '$users/edi-user-has-schools';
  static const users = 'users';
  static const usersAddSchools = '$users/add-schools';
  static const usersInSchool = '/$users/school';
}

class UserRolesSystemsLink {
  static const screen = 'user-roles-systems/screen';
  static const userRolesSystems = 'user-roles-systems';
  static const userRolesSystemsConnectRolesToScreens =
      'user-roles-systems/connect-roles-to-screens';

  static const userRolesSystemsDisconnectRolesFromScreens =
      'user-roles-systems/disconnect-roles-from-screens';
}

class SystemLogLinks {
  static const systemLog = 'system-logger';
  static const systemLogUser = '$systemLog/user';
  static const systemLogExportText = '$systemLog/export-text';
  static const systemLogExportExcel = '$systemLog/export-excel';
  static const systemLogResetAndExportToText = '$systemLog/reset-and-export-text';
}
