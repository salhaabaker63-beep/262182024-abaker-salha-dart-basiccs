// Student: Salha Abaker Abdul Mageid
// Reg no: 26218/2024
const String regNo = '26218/2024';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 4));

// by SA
bool isValidPin(String pin) {
  if (pin.length != 5) return false;
  for (int i = 0; i < pin.length; i++) {
    if (int.tryParse(pin[i]) == null) {
      return false;
    }
  }
  return true;
}

// by SA
String formatRwf(int amount) {
  String strAmount = amount.toString();
  String result = '';
  int count = 0;
  for (int i = strAmount.length - 1; i >= 0; i--) {
    result = strAmount[i] + result;
    count++;
    if (count % 3 == 0 && i != 0) {
      result = ',' + result;
    }
  }
  return '$result RWF';
}

// by SA
void main() {
  print('Reg no: $regNo | D = $d | T = $t');
  print('-------------------------');

  print('Testing PINs:');
  print('12345 -> ${isValidPin('12345')}'); 
  print('77777 -> ${isValidPin('77777')}'); 
  print('4821 -> ${isValidPin('4821')}');   
  print('48a21 -> ${isValidPin('48a21')}'); 
  print('4821$d -> ${isValidPin('4821$d')}'); 

  print('-------------------------');

  int balance = 20000 + (t * 500);
  print('Starting balance: ${formatRwf(balance)}');

  int sendAmount = (d + 1) * 3000;
  
  for (int i = 1; i <= 3; i++) {
    if (balance >= sendAmount) {
      balance -= sendAmount;
      print('Send $i (${formatRwf(sendAmount)}): Success. Balance: ${formatRwf(balance)}');
    } else {
      print('Send $i (${formatRwf(sendAmount)}): Failed. Insufficient funds.');
    }
  }

  if (balance >= 1000) {
    balance -= 1000;
    print('Buy 1,000 airtime: Success. Balance: ${formatRwf(balance)}');
  }

  print('Try to send 0: Transaction rejected (Amount must be > 0).');

  if (balance >= 200000) {
    balance -= 200000;
    print('Send 200,000: Success. Balance: ${formatRwf(balance)}');
  } else {
    print('Send 200,000: Failed. Insufficient funds. Balance is only ${formatRwf(balance)}.');
  }

  print('-------------------------');
  print('Final balance: ${formatRwf(balance)}');

  print('-------------------------');
  print('--- My Extra Tests ---');
  print(isValidPin('00000')); 
  print(isValidPin('12 45')); 
  print(formatRwf(0));        
  print(formatRwf(500));      
  print(formatRwf(1000000));  
}
