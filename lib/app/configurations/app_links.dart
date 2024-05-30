class AppLinks {
  static const baseUrl = 'http://localhost:3333/';
  static const baseUrlDev = 'http://10.6.71.92:3333/';
}

class AuthLinks {
  static const login = 'auth/login';
  static const refresh = 'auth/refresh';
  static const logout = 'auth/logout';
  static const user = 'users';
  static const userAddRoles = 'users/add-roles';
  static const usersAddSchools = 'users/add-schools';
}

class SchoolsLinks {
  static const getAllSchools = 'schools/all';

  static const schools = 'schools';
  static const grades = 'grades';
  static const gradesSchools = 'grades/school';
  static const cohort = 'cohort';
  static const connectSubjectToCohort = '$cohort/Connect-Subject';
  static const disConnectSubjectFromCohort = '$cohort/disconnect-Subject';
  static const subject = 'subject';
  static const subjects = 'subjects';
  static const schoolsClasses = 'school-classes';
  static const schoolsType = 'school-type';
}

class StudentsLinks {
  static const student = 'student';
  static const studentsClass = 'student/class';
  static const studentCohort = 'student/cohort';
  static const studentSchool = 'student/school';
  static const studentBarcodes = 'student-barcodes';
  static const studentBarcodesStudent = 'student-barcodes/student';
  static const studentBarcodesExamMission = 'student-barcodes/exam-mission';
  static const studentSetNumbers = 'student-set-numbers';
  static const studentSetNumbersControlMission =
      'student-set-numbers/control-mission';
  static const studentSetNumbersStudent = 'student-set-numbers/student';
  static const studentSetNumbersExamRoom = 'student-set-numbers/exam-rooms';
}

class EducationYearsLinks {
  static const educationyear = 'education-year';
}

class ControlMissionLinks {
  static const controlMission = 'control-mission';
  static const controlMissionSchool = 'control-mission/school';
  static const controlMissionEducationYear = 'control-mission/education-year';
}

class ExamLinks {
  static const examMission = 'exam-mission';
  static const examMissionSubject = 'exam-mission/subject';
  static const examMissionControlMission = 'exam-mission/control-mission';
  static const examRooms = 'exam-rooms';
  static const examRoomsControlMission = 'exam-rooms/control-mission';
  static const examRoomsSchoolClass = 'exam-rooms/school-class';
}

class UserRolesSystemsLink {
  static const userRolesSystems = 'user-roles-systems';
  static const userRolesSystemsConnectRolesTOScreens =
      'user-roles-systems/connect-roles-to-screens';
}
