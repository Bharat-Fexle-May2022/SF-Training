public with sharing class Day14_ProcessPurchaseOrder {

    public Day14_ProcessPurchaseOrder() {
        Day14_Interface order1 = new Day14_CustomerPurchaseOrder();
        Day14_Interface order2 = new Day14_EmployeePurchaseOrder();

        //Customer Order
        processOrder(order1);

        //Employee Order
        processOrder(order2);
    }

    public void processOrder(Day14_Interface order) {
        System.debug('Check discount : ' + order.discount());
    }

}