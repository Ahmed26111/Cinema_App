enum PeriodEnum{
  period1(periodTime: "10:00 AM" , periodPrice: 100),
  period2(periodTime: "12:00 PM" , periodPrice: 100),
  period3(periodTime: "2:00 PM" , periodPrice: 100),
  period4(periodTime: "4:00 PM" , periodPrice: 150),
  period5(periodTime: "6:00 PM" , periodPrice: 150),
  period6(periodTime: "8:00 PM" , periodPrice: 150),
  period7(periodTime: "10:00 PM" , periodPrice: 180),;

  final String periodTime;
  final double periodPrice;

  const PeriodEnum({required this.periodTime, required this.periodPrice});
}