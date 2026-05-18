import java.util.Scanner;
public class StudentGradeManager {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int studentCount = 0;
        double totalScore = 0.0;
        double highestScore = -1.0;
        double lowestScore = 11.0;
        int choice;
        do {
            // Hiển thị menu
            System.out.println("==========Menu=========");
            System.out.println("1. Nhập điểm học viên");
            System.out.println("2. Hiển thị thống kê");
            System.out.println("3. Thoát");
            choice = Integer.parseInt(sc.nextLine());

            switch (choice) {
                case 1:
                    System.out.println("Nhập điểm học viên từ 0->10. Gõ -1 để kết thúc");
                    while (true) {
                        double score;
                        if (sc.hasNextDouble()) {
                            score = Double.parseDouble(sc.nextLine());
                        } else {
                            sc.next();
                            continue;
                        }

                        if (score == -1) {
                            break;
                        }

                        if (score < 0 || score > 10) {
                            System.out.println("Điểm không hợp lệ! Nhập lại.");
                            continue;
                        }

                        // Cập nhật thống kê
                        studentCount++;
                        totalScore += score;
                        if (score > highestScore) highestScore = score;
                        if (score < lowestScore) lowestScore = score;

                        // Xếp loại học lực
                        String grade;
                        if (score < 5) {
                            grade = "Yếu";
                        } else if (score < 7) {
                            grade = "Trung bình";
                        } else if (score < 8) {
                            grade = "Khá";
                        } else if (score < 9) {
                            grade = "Giỏi";
                        } else {
                            grade = "Xuất sắc";
                        }

                        System.out.printf("Điểm %.1f : Học lực %s%n", score, grade);
                    }

                    // In kết quả sau khi nhập
                    if(studentCount > 0){
                        System.out.println("======Kết quả=====");
                        System.out.println("Tổng số học viên đã nhâp:" + studentCount);
                        System.out.println("Tổng điểm:" + totalScore);
                        System.out.println("Điểm cao nhất:" + highestScore);
                        System.out.println("Điểm thấp nhất:" + lowestScore);
                    }
                    else {
                        System.out.println("Chưa có học viên nào được nhập");
                    }
                    break;

                case 2:
                    // Hiển thị thống kê
                    if(studentCount == 0){
                        System.out.println("Chưa có dữ liệu");
                    }
                    else {
                        double average = totalScore / studentCount;
                        System.out.println("======Thống kê điểm======");
                        System.out.println("Số học viên:" + studentCount);
                        System.out.println("Điểm trung bình: " + average);
                        System.out.println("Điểm cao nhất:" + highestScore);
                        System.out.println("Điểm thấp nhất:" + lowestScore);
                    }
                    break;

                case 3:
                    // Thoát
                    System.out.println("Kết thúc chương trình.");
                    System.exit(0);
                    break;

                default:
                    System.out.println("Lựa chọn không hợp lệ vui lòng chọn lại!");
            }
        }while (true);
    }
}
