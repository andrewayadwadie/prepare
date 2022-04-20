 
import 'package:get/get.dart';
import '../../service/contractors_services.dart';
import '../../../view/auth/login_screen.dart';

class ContractorsListController extends GetxController {
  List<dynamic> contractors = [];
  int errorNo = 0;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getAllContractorsData();
    super.onInit();
  }

  bool get loading => _loading.value;
  List<dynamic> getAllContractorsData() {
    if (_loading.value == true) {
      ContractrosServices.getAllContractros().then((value) {
        if(value.runtimeType == List){
          contractors = value;
        _loading.value = false;
        update();
        }else if(value == 401){
          Get.offAll(const LoginScreen());
        }else if(value== 500|| value == 400){
          errorNo = value;
        }
      });
    }
    return contractors;
  }
}
