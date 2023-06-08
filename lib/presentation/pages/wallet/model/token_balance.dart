class TokenBalance {
  final int id;
  final double balance;

  TokenBalance({required this.id, required this.balance});

  factory TokenBalance.fromJson(Map<String, dynamic> json) => TokenBalance(
      id: int.parse("${json['id']}") , balance:  json['balance'].toDouble());
}
