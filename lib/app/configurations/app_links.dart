class AppLinks {
  static const baseUrl = 'http://localhost:3333/';
  static const baseUrlDev = 'http://10.6.66.188:3333/';
}

class AuthLinks {
  static const login = 'auth/login';
  static const logout = 'auth/logout';
  static const refresh = 'auth/refresh';
  static const user = 'users';
  static const userAddRoles = 'users/add-roles';
  static const usersAddSchools = 'users/add-schools';
}

class SchoolsLinks {
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

class StudentsLinks {
  static const student = 'student';
  static const studentBarcodes = 'student-barcodes';
  static const studentBarcodesExamMission = 'student-barcodes/exam-mission';
  static const studentBarcodesStudent = 'student-barcodes/student';
  static const studentCohort = 'student/cohort';
  static const studentSchool = 'student/school';
  static const studentSetNumbers = 'student-set-numbers';
  static const studentSetNumbersControlMission =
      'student-set-numbers/control-mission';

  static const studentSetNumbersExamRoom = 'student-set-numbers/exam-rooms';
  static const studentSetNumbersStudent = 'student-set-numbers/student';
  static const studentsClass = 'student/class';
}

class EducationYearsLinks {
  static const educationyear = 'education-year';
}

class ControlMissionLinks {
  static const controlMission = 'control-mission';
  static const controlMissionEducationYear = 'control-mission/education-year';
  static const controlMissionSchool = 'control-mission/school';
}

class ExamLinks {
  static const examMission = 'exam-mission';
  static const examMissionControlMission = 'exam-mission/control-mission';
  static const examMissionSubject = 'exam-mission/subject';
  static const examRooms = 'exam-rooms';
  static const examRoomsControlMission = 'exam-rooms/control-mission';
  static const examRoomsSchoolClass = 'exam-rooms/school-class';
}

class UserRolesSystemsLink {
  static const userRolesSystems = 'user-roles-systems';
  static const userRolesSystemsConnectRolesTOScreens =
      'user-roles-systems/connect-roles-to-screens';
}
