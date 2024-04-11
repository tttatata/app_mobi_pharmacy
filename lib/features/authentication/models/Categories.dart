// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  final int id;
  final String title;
  final String subTitle;
  final String imageUrl;

  Category({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subTitle': subTitle,
      'imageUrl': imageUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map[' id'] ?? '',
      title: map['title'] ?? '',
      subTitle: map['subTitle'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}

List<Category> category = [
  Category(
      id: 1,
      title: "Thực phẩm chức năng",
      subTitle: "",
      imageUrl:
          "https://suckhoedoisong.qltns.mediacdn.vn/Images/quangcao/2018/01/25/suckhoedoisong.vn-_Tin_thng-_Thng_o.jpg"),
  Category(
      id: 2,
      title: "Dược mỹ phẩm",
      subTitle: "",
      imageUrl:
          "https://thanhnien.mediacdn.vn/Uploaded/dieutrang-qc/2021_10_22/mai-han-duoc-my-pham-2-4439.png"),
  Category(
      id: 3,
      title: "Chăm sóc cá nhân",
      subTitle: "",
      imageUrl:
          "https://s-imgcdn.tapchicongthuong.vn/tcct-media/23/1/21/cham-soc-ca-nhan-thien-nhien.jpg"),
  Category(
      id: 4,
      title: "Chăm sóc sức khỏe",
      subTitle: "",
      imageUrl:
          "https://timo.vn/wp-content/uploads/mua-bao-hiem-cham-soc-suc-khoe-toan-cau.png"),
  Category(
      id: 5,
      title: "Thuốc",
      subTitle: "",
      imageUrl:
          "https://cdnmedia.baotintuc.vn/Upload/r2ZmuVn2vsFEWUzMUAXAg/files/2023/11/Thu-tuc-tieu-huy-thuoc-tan-duoc-da-het-han-su-dung-1.jpg"),
  Category(
      id: 6,
      title: "Quà tặng",
      subTitle: "",
      imageUrl:
          "https://hips.hearstapps.com/hmg-prod/images/close-up-of-stack-gifts-on-table-against-blue-royalty-free-image-1676327737.jpg?crop=0.668xw:1.00xh;0,0&resize=640:*"),
  Category(
      id: 7,
      title: "Mẹ và bé",
      subTitle: "",
      imageUrl: "https://bota.vn/wp-content/uploads/2018/11/bg3.jpg"),
  Category(
      id: 8,
      title: "Hỗ trợ làm đẹp",
      subTitle: "",
      imageUrl:
          "https://product.hstatic.net/200000736563/product/upload_0ca81b253d09412f901c19f2d5928a52_master.jpg"),
  Category(
      id: 9,
      title: "Thiết bị y tế",
      subTitle: "",
      imageUrl:
          "https://nhapkhautrungquoc.vn/wp-content/uploads/2021/07/Trang-thiet-bi-y-te-nhap-khau-Trung-Quoc.jpg"),
  Category(
      id: 10,
      title: "Khuyến mãi hot🔥",
      subTitle: "",
      imageUrl:
          "https://openend.vn/wp-content/uploads/2022/01/chuong-trinh-khuyen-mai-trong-kinh-doanh-scaled.jpg"),
];
