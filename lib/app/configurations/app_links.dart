class AppLinks {
  static const baseUrlDev = 'http://localhost:3333/';

  static const baseUrl = 'http://localhost:80/';

  static const baseUrlProd = 'https://control-o5xlbifnea-uc.a.run.app/';
}

class AuthLinks {
  static const auth = 'auth';
  static const login = '$auth/login';
  static const logout = '$auth/logout';
  static const refresh = '$auth/refresh';
}

class UserLinks {
  static const users = 'users';
  static const usersInSchool = '/$users/school';
  static const userAddRoles = '$users/add-roles';
  static const usersAddSchools = '$users/add-schools';
  static const getUsersByCreated = '$users/created-by';
  static const userEditRoles = '$users/edit-roles';
}

class ControlMissionLinks {
  static const controlMission = 'control-mission';
  static const controlMissionEducationYear = 'education-year';
  static const controlMissionSchool = '$controlMission/school';
  static const studentSeatNumbers = '$controlMission/student-seat-numbers';
  static const getGradesByControlMission = '$controlMission/grades';
  static const getSubjectsByControlMission = 'subjects/controlMission';
}

class EducationYearsLinks {
  static const educationyear = 'education-year';
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
  static const generatePdfBrCover = '$generatePdf/br-cover';
  static const generatePdfIBCover = '$generatePdf/IB-cover';
  static const generatePdfSeat = '$generatePdf/seats';
  static const generatePdfAttendence = '$generatePdf/attendance';
}

class ProctorsLinks {
  static const proctor = 'proctor';
}

class GradeLinks {
  static const grades = 'grades';
  static const gradesSchools = '$grades/school';
}

class SubjectsLinks {
  static const subject = 'subject';
  static const subjects = 'subjects';
  static const subjectsDeactivate = '$subjects/deactivate';
  static const subjectsBySchoolType = '$subjects/school-type/';
  static const deleteSchoolTypeinSubjects = '$subjects/remove-school-type';
}

class CohortLinks {
  static const cohort = 'cohort';
  static const connectSubjectToCohort = '$cohort/Connect-Subject';
  static const disConnectSubjectFromCohort = '$cohort/disconnect-Subject';
  static const getCohortBySchoolType = '$cohort/school-type';
}

class SchoolsLinks {
  static const classDesks = 'class-desk';
  static const schools = 'schools';
  static const getAllSchools = '$schools/all';
  static const getSchoolsClassesBySchoolId = '$schoolsClasses/school';
  static const schoolsClasses = 'school-classes';
  static const schoolsType = 'school-type';
}

class Stage {
  static const stage = 'stage';
}

class StudentsLinks {
  static const student = 'student';
  static const studentBarcodes = 'student-barcodes';
  static const studentBarcodesExamMission = 'student-barcodes/exam-mission';
  static const studentBarcodesStudent = 'student-barcodes/student';
  static const studentCohort = '$student/cohort';
  static const studentMany = '$student/many';
  static const studentSchool = '$student/school';
  static const studentSeatNumbers = 'student-seat-numbers';
  static const studentSeatNumbersControlMission =
      '$studentSeatNumbers/control-mission';

  static const studentSeatNumbersExamRoom = '$studentSeatNumbers/exam-rooms';
  static const studentSeatNumbersStudent = '$studentSeatNumbers/student';
  static const studentsClass = '$student/class';
  static const getStudentsByControlMission = '$student/controlMission';
  static const studentsGrades = '$student/students-grades/control-mission/';
}

class UserRolesSystemsLink {
  static const screen = 'user-roles-systems/screen';
  static const userRolesSystems = 'user-roles-systems';
  static const userRolesSystemsConnectRolesToScreens =
      'user-roles-systems/connect-roles-to-screens';
  static const userRolesSystemsDisconnectRolesFromScreens =
      'user-roles-systems/disconnect-roles-from-screens';
}
