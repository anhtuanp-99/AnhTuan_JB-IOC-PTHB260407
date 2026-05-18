import java.util.Scanner;
//[Luyện tập] Tính tiền hóa đơn siêu thị
public class SupermaketBill {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // Nhập dữ liệu
        System.out.print("Tên khách hàng: ");
        String customerName = sc.nextLine();

        System.out.print("Tên sản phẩm: ");
        String productName = sc.nextLine();

        System.out.print("Giá sản phẩm: ");
        double price = Double.parseDouble(sc.nextLine());

        System.out.print("Số lượng mua: ");
        int quantity = Integer.parseInt(sc.nextLine());

        System.out.println("Khách có thẻ thành viên hay ko? (true/false): ");
        boolean isMember = Boolean.parseBoolean(sc.nextLine());

        // Tính toán
        double amount = price * quantity;
        double discount = isMember ? amount * 0.1 : 0.0;
        double afterDiscount = amount - discount;
        double vat = afterDiscount * 0.08;
        double totalPayment = afterDiscount + vat;

        // In thông tin
        System.out.println("==============Hóa đơn=============");
        System.out.printf("Khách hàng: %s%n", customerName);
        System.out.printf("Sản phẩm: %s%n", productName);
        System.out.printf("Số lượng: %d%n", quantity);
        System.out.printf("Đơn giá: %,.2f VND%n", price);
        System.out.printf("Thành tiền: %,.2f VND%n", amount);
        System.out.printf("Giảm giá: %,.2f VND%n", discount);
        System.out.printf("Tiền VAT: %,.2f VND%n", vat);
        System.out.printf("Tổng thanh toán: %,.2f VND%n", totalPayment);

        sc.close();
    }
}
