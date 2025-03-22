// Variáveis
//--------------------------------------------------
// Output values
int w0 = 10;
int w1 = 11;
int w2 = 12;
int w3 = 13;

int PC = 4;
int InputStart = 4;

int mem_size = 100;
String mem[100]; // PC, W, X, Y, [restante]
String op_code[1];

int clock = 100; // Bytes por segundo
// (é multiplicado por 8 em Serial.begin(),
//  por isso, bytes e não bits)

// Ativar debug mode para executar instrução
// por instrução, sendo necessário um input qualquer
// para passar à próxima
bool debug_mode = true;
//--------------------------------------------------

// Inicializar elementos do arduino
void setup()
{
  pinMode(w0, OUTPUT);
  pinMode(w1, OUTPUT);
  pinMode(w2, OUTPUT);
  pinMode(w3, OUTPUT);
  Serial.begin(clock*8); 
}

// Função para aumentar variável PC e atualizar valor na memória
void updatePC(){
	PC = PC + 1;
    mem[0] = PC;
}

// Função para validar caractere como hexadecimal
bool validateHexa(char hex){
  bool valido = false;
  if ( (hex >= 'A' && hex <= 'Z') ||
      (hex >= '0' && hex <= '9') ) {
    valido = true; 
  }
  return valido;
}

// Função para decodificar os valores presentes
// na instrucao e atualizar na memória
void decodificar(String instrucao, String* x, String* y, String* op){
  // Validar tamanho da instrução
  if (instrucao.length() == 3){
    // Validar cada caractere e se pode ser lido
    if ( validateHexa(instrucao.charAt(0)) ) {
      *x = instrucao.charAt(0);
    }
    if ( validateHexa(instrucao.charAt(1)) ) {
      *y = instrucao.charAt(1);
    }
    if ( validateHexa(instrucao.charAt(2)) ) {
      *op = instrucao.charAt(2);
      //Serial.print("Decode: ");
      //Serial.println(*op);
    }    
  }
}

// Função para converter caractere hexa em valor decimal
int toInt(String hexa, int charN) {
 int resultado = 0;
  if (hexa.charAt(charN) == '0') {
    resultado = 0;
  } else if (hexa.charAt(charN) == '1') {
    resultado = 1;
  } else if (hexa.charAt(charN) == '2') {
    resultado = 2;
  } else if (hexa.charAt(charN) == '3') {
    resultado = 3;
  } else if (hexa.charAt(charN) == '4') {
    resultado = 4;
  } else if (hexa.charAt(charN) == '5') {
    resultado = 5;
  } else if (hexa.charAt(charN) == '6') {
    resultado = 6;
  } else if (hexa.charAt(charN) == '7') {
    resultado = 7;
  } else if (hexa.charAt(charN) == '8') {
    resultado = 8;
  } else if (hexa.charAt(charN) == '9') {
    resultado = 9;
  } else if (hexa.charAt(charN) == 'A') {
    resultado = 10;
  } else if (hexa.charAt(charN) == 'B') {
    resultado = 11;
  } else if (hexa.charAt(charN) == 'C') {
    resultado = 12;
  } else if (hexa.charAt(charN) == 'D') {
    resultado = 13;
  } else if (hexa.charAt(charN) == 'E') {
    resultado = 14;
  } else if (hexa.charAt(charN) == 'F') {
    resultado = 15;
  }
  return resultado;
}

// Função para converter valor inteiro
// em um caracter (em formato String)
// com o correspondente valor hexadecimal
String fromInt (int value) {
  String resultado;
  if (value == 0) {
    resultado = "0";
  } else if (value == 1) {
    resultado = "1";
  } else if (value == 2) {
    resultado = "2";
  } else if (value == 3) {
    resultado = "3";
  } else if (value == 4) {
    resultado = "4";
  } else if (value == 5) {
    resultado = "5";
  } else if (value == 6) {
    resultado = "6";
  } else if (value == 7) {
    resultado = "7";
  } else if (value == 8) {
    resultado = "8";
  } else if (value == 9) {
    resultado = "9";
  } else if (value == 10) {
    resultado = "A";
  } else if (value == 11) {
    resultado = "B";
  } else if (value == 12) {
    resultado = "C";
  } else if (value == 13) {
    resultado = "D";
  } else if (value == 14) {
    resultado = "E";
  } else {
    resultado = "F";
  }
  return resultado;
}

// Função para executar operação e escrever
// valor resultante na memória
void executar(String* w, String* x, String* y, String* op){
  // Variáveis
  int a = toInt(*op, 0); // Operação
  int v1 = toInt(*x, 0); // Valor de X
  int v2 = toInt(*y, 0); // Valor de Y
  byte b1 = v1; // Valor de X em bits
  byte b2 = v2; // Valor de Y em bits
  int res = 0; // Variável de resposta
  switch (a) {
    case 0: // zeroL
      break;
    case 1: // umL
      res = 1;
      break;
    case 2: // copiaA
      res = v1;
      break;
    case 3: // copiaB
      res = v2;
      break;
    case 4: // nA
      res = (~b1);
      break;
    case 5: // nB
      res = (~b2);
      break;
    case 6: // AenB
      res = b1 & (~b2);
      break;
    case 7: // nAeB
      res = (~b1) & b2;
      break;
    case 8: // AxB
      res = (b1 | b2) & ~(b1 & b2);
      break;
    case 9: // nAxnB
      res = ((~b1) | (~b2)) & ~((~b1) & ~(b2));
      break;
    case 10: // nAxnBn
      res = ~((~b1) | (~b2)) & ~((~b1) & ~(b2));
      break;
    case 11: // AeB
      res = b1 & b2;
      break;
    case 12: // AoBn
      res = ~(b1 & b2);
      break;
    case 13: // AoBn
      res = ~(b1 | b2);
      break;
    case 14: // AoB
      res = b1 | b2;
      break;
    case 15: // nAonBn
      res = ~(~(b1) | ~(b2));
      break;
  }
  // Reduzir o valor resultante restringindo-o
  // aos 4 primeiros bits (um dígito hexadecimal)
  byte size_restriction = 15;
  res = res & size_restriction;
  // Salvar no endereço de w
  // o resultado
  *w = fromInt(res);
  // Ligar luzes equivalentes no Arduino
  light_up(res);
}

// Função para ligar luzes com base no
// resultado da operação
void light_up(int value){

  // Determinar com ands com potências
  // de 2 se o valor tem um dígito
  // nessa determinada posição
  int v1 = value & 1;
  int v2 = value & 2;
  int v3 = value & 4;
  int v4 = value & 8;
  
  //Serial.print("Light value: ");
  //Serial.print(value);
  //Serial.print("  ");
  //Serial.print(v1);
  //Serial.print("  ");
  //Serial.print(v2);
  //Serial.print("  ");
  //Serial.print(v3);
  //Serial.print("  ");
  //Serial.println(v4);
  
  // Conferir as luzes que devem ser
  // ligadas verificando o resultado
  // dos ands
  // w0
  if (v1 != 0) {
    digitalWrite(w0, HIGH); 
  } else {
    digitalWrite(w0, LOW); 
  }
  // w1
  if (v2 != 0) {
    digitalWrite(w1, HIGH); 
  } else {
    digitalWrite(w1, LOW); 
  }
  // w2
  if (v3 != 0) {
    digitalWrite(w2, HIGH); 
  } else {
    digitalWrite(w2, LOW); 
  }
  // w3
  if (v4 != 0) {
    digitalWrite(w3, HIGH); 
  } else {
    digitalWrite(w3, LOW); 
  }
}

// Print do estado atual da memória
void dump(){
  int a = 0;
  Serial.print("-> | ");
  while (a < mem_size && mem[a] != "XXX") {
    Serial.print(mem[a]);
    Serial.print(" | ");
    a++;
  }
  Serial.println("");
}

void loop()
{
  // Valores iniciais para PC, W, X e Y
  mem[0] = 4;
  mem[1] = 1;
  mem[2] = 2;
  mem[3] = 3;
  
  // Ponteiros de W, X e Y
  String* w = &mem[1];
  String* x = &mem[2];
  String* y = &mem[3];
  String* op = &op_code[0];
  
  // Variáveis
  PC = InputStart;
  String instrucao;
  bool comecar = false;
  bool executar_ = false;
  bool inputed = false;
  bool finished_reading = false;
  bool next = false;
  String input;
  String lixo;
  
  // Começar o programa com os inputs
  while (!comecar) {
   	if (Serial.available()) {
      comecar = true; 
    }
  }
  
    // Ler todos inputs
    while(!finished_reading && PC < mem_size) {
      if ( Serial.available() > 0 ) {
        instrucao = Serial.readStringUntil(' ');
        if (instrucao == "XXX") {
         finished_reading = true; 
        }
        else {
         mem[PC] = instrucao;
    
         updatePC(); 
        } // Fim _ if (instrucao == "XXX")
      } // Fim _ if ( Serial.available() > 0 )
    } // Fim _ while(Serial.available() && PC < mem_size)
    // Se não tiver chegado no fim do espaço da
    // memória, salvar um indicador de fim
    if (PC < mem_size) {
    	mem[PC] = "XXX"; 
    } // Fim _ if (PC < mem_size)
  
    // Retornar ao início dos inputs
    PC = InputStart;
    mem[0] = PC;
  
    // Perguntar se é para executar o programa
    Serial.println("Deseja executar o programa? (S/N)");
    while (!inputed) {
      if (Serial.available()) {
        input = Serial.readStringUntil(' ');
        // Apenas sair da pergunta se a resposta for válida
        if (input.charAt(0) == 'S' || input.charAt(0) == 'N') {
        	inputed = true;
          if (input.charAt(0) == 'S') {
           executar_ = true; 
          } // Fim _ if (input.charAt(0) == 'S')
        } // Fim _ if (input.charAt(0) == 'S' || input.charAt(0) == 'N')
      } // Fim _ if (Serial.available())
    } // Fim _ while (!inputed)
  
    // Se o programa não for ser executado
    if (!executar) {
     Serial.println("Operacao encerrada"); 
    }
    // Se o programa for ser executado
    else {
      Serial.println("Iniciando operacao");
      // Ler até o fim das instruções
      while(PC < mem_size && mem[PC] != "XXX") {
	    instrucao = mem[PC];
    
        // Decodificar
        decodificar(instrucao, x, y, op);
        // Executar
        executar(w, x, y, op);
        // Passar ao próximo
        updatePC();     
        // Dump/Print da memória
        dump();
        
        // Esperar input caso
        // debug_mode seja verdadeiro
        if (debug_mode) {
          while (!next) {
            if (Serial.available() > 0) {
              next = true;
              lixo = Serial.read();
            }
          }
          next = false;
        }
        
      } // Fim _ while(PC < mem_size && mem[PC] != "XXX")
    } // Fim _ if (!executar)
  
  
  
} // Fim loop()