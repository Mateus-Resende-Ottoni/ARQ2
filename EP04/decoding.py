# Converter operação em um char com o correspondente hexadecimal,
# com base na tabela de operações da ULA
def operationDecode(operation):
    #print("operationDecode " + operation + " start")
    operationValue = '0' # Variável de retorno
    if (operation == "zeroL"):
        operationValue = '0'
    elif (operation == "umL"):
        operationValue = '1'
    elif (operation == "copiaA"):
        operationValue = '2'
    elif (operation == "copiaB"):
        operationValue = '3'
    elif (operation == "nA"):
        operationValue = '4'
    elif (operation == "nB"):
        operationValue = '5'
    elif (operation == "AenB"):
        operationValue = '6'
    elif (operation == "nAeB"):
        operationValue = '7'
    elif (operation == "AxB"):
        operationValue = '8'
    elif (operation == "nAxnB"):
        operationValue = '9'
    elif (operation == "nAxnBn"):
        operationValue = 'A'
    elif (operation == "AeB"):
        operationValue = 'B'
    elif (operation == "AeBn"):
        operationValue = 'C'
    elif (operation == "AoBn"):
        operationValue = 'D'
    elif (operation == "AoB"):
        operationValue = 'E'
    elif (operation == "nAonBn"):
        operationValue = 'F'
    return operationValue

# Obter o caracter hexadecimal corespondente
# a um numero na base 10
def charDecode(value):
    #print("charDecode " + value + " start")
    charValue = '0' # Variável de retorno
    # Lista de casos e situações
    if (value == '10'):
        charValue = 'A'
    elif (value == '11'):
        charValue = 'B'
    elif (value == '12'):
        charValue = 'C'
    elif (value == '13'):
        charValue = 'D'
    elif (value == '14'):
        charValue = 'E'
    elif (value == '15'):
        charValue = 'F'
    # Caso o valor já seja um número correspondente
    # a sua versão hexadecimal, só copiá-lo
    else:
        charValue = value
    return charValue

# Função principal
def main():
    #print("Program start")
    # Abrir arquivo de leitura e de escrita
    fi = open("testeula.ula", "rt") # File_Input
    fo = open("testeula.hex", "wt") # File_Output

    # Inicializar variáveis
    #teste = 0
    charX = '0'
    charY = '0'
    charW = 'A'
    linha = ""

    # Ler 2 linhas (pular o "inicio.")
    linha = fi.readline()
    #print(linha)
    linha = fi.readline()
    #print(linha)
    # Enquanto não ler o indicativo do fim do conteúdo
    while linha.strip() != "fim.":
        # Reconhecer a primeira letra da linha
        # Se for X
        if linha[0] == 'X':
            # Ler o valor após o igual, decodificá-lo
            # e salvar na variável
            charX = charDecode(linha.strip()[2: (len(linha)-2) ])
        # Se for Y
        elif linha[0] == 'Y':
            # Ler o valor após o igual, decodificá-lo
            # e salvar na variável
            charY = charDecode(linha.strip()[2: (len(linha)-2)])
        # Se for W
        elif linha[0] == 'W':
            # Ler a operação após o igual, decodificá-la
            # e salvar na variável
            op = linha.strip()[2: (len(linha)-2) ]
            charW = operationDecode(op)
            # Salvar valores atuais no arquivo de saída
            #print("X: " + charX + "_ Y: " + charY + "_ W:" + charW)
            fo.write(charX + charY + charW + "\n")

        # Ler próxima linha
        linha = fi.readline()
        #print(f"Teste: {teste}")
        #teste += 1

    # Salvar um XXX no fim do arquivo, indicador para
    # o código do Arduino
    fo.write("XXX\n")
    # Fechar arquivos
    fi.close()
    fo.close()

# Chamar função principal
if __name__ == "__main__":
    main()