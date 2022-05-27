import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:kampuskita/app/modules/add_mahasiswa/bindings/add_mahasiswa_binding.dart';
import 'package:kampuskita/app/modules/add_mahasiswa/views/add_mahasiswa_view.dart';
import 'package:kampuskita/app/modules/all_presensi/bindings/all_presensi_binding.dart';
import 'package:kampuskita/app/modules/all_presensi/views/all_presensi_view.dart';
import 'package:kampuskita/app/modules/detail_presensi/bindings/detail_presensi_binding.dart';
import 'package:kampuskita/app/modules/detail_presensi/views/detail_presensi_view.dart';
import 'package:kampuskita/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:kampuskita/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:kampuskita/app/modules/home/bindings/home_binding.dart';
import 'package:kampuskita/app/modules/home/views/home_view.dart';
import 'package:kampuskita/app/modules/login/bindings/login_binding.dart';
import 'package:kampuskita/app/modules/login/views/login_view.dart';
import 'package:kampuskita/app/modules/new_password/bindings/new_password_binding.dart';
import 'package:kampuskita/app/modules/new_password/views/new_password_view.dart';
import 'package:kampuskita/app/modules/profile/bindings/profile_binding.dart';
import 'package:kampuskita/app/modules/profile/views/profile_view.dart';
import 'package:kampuskita/app/modules/update_password/bindings/update_password_binding.dart';
import 'package:kampuskita/app/modules/update_password/views/update_password_view.dart';
import 'package:kampuskita/app/modules/update_profile/bindings/update_profile_binding.dart';
import 'package:kampuskita/app/modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_MAHASISWA,
      page: () => AddMahasiswaView(),
      binding: AddMahasiswaBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DETAIL_PRESENSI,
      page: () => DetailPresensiView(),
      binding: DetailPresensiBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ALL_PRESENSI,
      page: () => AllPresensiView(),
      binding: AllPresensiBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
