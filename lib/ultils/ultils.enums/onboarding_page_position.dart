enum OnboardingPagePosition { page1, page2, page3 }

extension OnboardingPagePositionExtension on OnboardingPagePosition {
  // Tra ve image cho 3 page
  String onboardingPageImage() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return "assets/images/onboarding_1.png";
      case OnboardingPagePosition.page2:
        return "assets/images/onboarding_2.png";
      case OnboardingPagePosition.page3:
        return "assets/images/onboarding_3.png";
    }
  }

  String onboardingPageTitle() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return "Quản lý nhiệm vụ";
      case OnboardingPagePosition.page2:
        return "Tạo thói quen";
      case OnboardingPagePosition.page3:
        return "Tổ chức các nhiệm vụ";
    }
  }

  String onboardingPageContent() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return "Bạn có thể dễ dàng quản lý tất cả công việc hàng ngày của mình trong ứng dụng";
      case OnboardingPagePosition.page2:
        return "Trong ứng dụng, bạn có thể tạo thói quen cá nhân hóa của mình để duy trì hiệu quả";
      case OnboardingPagePosition.page3:
        return "Bạn có thể sắp xếp công việc của mình bằng cách thêm công việc vào các danh mục riêng";
    }
  }
}
