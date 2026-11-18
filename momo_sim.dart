// Student: Salha Abaker Abdul Mageid
// Reg no: 26218/2024
const String regNo = '26218/2024';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 4));

// by SA
// 1. formatRwf function
String formatRwf(int amount) {
  String strAmount = amount.toString();
  bool isNegative = false;
  
  if (strAmount.startsWith('-')) {
    isNegative = true;
    strAmount = strAmount.substring(1);
  }

  String result = '';
  int count = 0;
  int i = strAmount.length - 1;
  
  while (i >= 0) {
    result = strAmount[i] + result;
    count++;
    if (count % 3 == 0 && i != 0) {
      result = ',' + result;
    }
    i--;
  }
  
  if (isNegative) {
    result = '-' + result;
  }
  
  return '$result RWF';
}

// by SA
// 2. isValidPin function
bool isValidPin(String pin) {
  if (pin.length != 5) return false;
  
  bool allDigits = true;
  int i = 0;
  while (i < pin.length) {
    if (int.tryParse(pin[i]) == null) {
      allDigits = false;
      break;
    }
    i++;
  }
  if (!allDigits) return false;

  if (pin == '12345') return false;
  if (pin == '00000' || pin == '11111' || pin == '22222' || pin == '33333' || 
      pin == '44444' || pin == '55555' || pin == '66666' || pin == '77777' || 
      pin == '88888' || pin == '99999') {
    return false;
  }

  return true;
}

// by SA
// 3. sendMoney function
int sendMoney(int balance, int amount) {
  // Dummy momoFee logic (since we don't have D2 question)
  int fee = 0;
  if (amount < 100) {
    fee = -1; // invalid
  } else if (amount <= 1000) {
    fee = 50;
  } else if (amount <= 10000) {
    fee = 100;
  } else {
    fee = 200;
  }

  if (fee == -1) {
    print('Failed: invalid amount');
    return balance;
  }

  if (amount + fee > balance) {
    print('Failed: Insufficient balance');
    return balance;
  }

  int newBalance = balance - amount - fee;
  print('Sent ${formatRwf(amount)} (fee ${formatRwf(fee)}). New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

// by SA
// 4. buyAirtime function
int buyAirtime(int balance, int amount) {
  if (amount < 100 || amount > 50000) {
    print('Failed: invalid amount');
    return balance;
  }

  if (amount > balance) {
    print('Failed: Insufficient balance');
    return balance;
  }

  int newBalance = balance - amount;
  print('Bought airtime ${formatRwf(amount)}. New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

// by SA
void main() {
  print('Reg no: $regNo | D = $d | T = $t');
  print('-------------------------');

  // 1. Test isValidPin
  print('isValidPin("12345") -> ${isValidPin('12345')}');
  print('isValidPin("77777") -> ${isValidPin('77777')}');
  print('isValidPin("4821") -> ${isValidPin('4821')}');
  print('isValidPin("48a21") -> ${isValidPin('48a21')}');
  print('isValidPin("4821$d") -> ${isValidPin('4821$d')}');
  print('-------------------------');

  // 2. Set starting balance
  int balance = 20000 + (t * 500);
  print('Starting balance: ${formatRwf(balance)}');

  // 3. Do these in order
  int sendAmount = (d + 1) * 3000;
  
  // a. Send three times
  int count = 0;
  while (count < 3) {
    balance = sendMoney(balance, sendAmount);
    count++;
  }

  // b. Buy airtime
  balance = buyAirtime(balance, 1000);

  // c. Send 0
  balance = sendMoney(balance, 0);

  // d. Send 200,000
  balance = sendMoney(balance, 200000);

  print('-------------------------');
  // 4. Print Final balance
  print('Final balance: ${formatRwf(balance)}');

  print('-------------------------');
  // 5. Extra Tests
  print('--- My Extra Tests ---');
  print(formatRwf(-5000));
  print(formatRwf(1250000));
  print(isValidPin('00000'));
  print(isValidPin('12 45'));
  print(buyAirtime(balance, 60000));
}
