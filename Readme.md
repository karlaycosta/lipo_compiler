 
 <h1 align="center">
     LiPo
    <br />
    <br />
    <a href="https://docs.lipolang.dev/pages">
     <img src="https://github.com/user-attachments/assets/42d53c44-92cb-41ca-9a50-58624decf753" alt="LiPo" height="400">
    </a>
  </h1>
</div>

<p align="center">
  <a href="#"><img src="https://img.shields.io/badge/Mintlify-00C09B?style=flat&logo=mintlify&logoColor=white" alt="Mintlify"></a>
  <a href="#"><img src="https://img.shields.io/badge/HTML/CSS/JS-E34F26?style=flat&logo=html5&logoColor=white" alt="HTML/CSS/JS"></a>
  <a href="#"><img src="https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white" alt="Dart"></a>
  <a href="#"><img src="https://img.shields.io/badge/Portugol-FF6600?style=flat&logoColor=white" alt="Portugol"></a>
  <a href="#"><img src="https://img.shields.io/badge/LiPo-4B0082?style=flat&logoColor=white" alt="LiPo"></a>
  <a href="#"> <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License" alt="Licença"></a>
    <a href="#">   <img src="https://img.shields.io/badge/Status-Active-brightgreen.svg" alt="Status"  alt="Licença"></a>
</p>

##  Introdução
**LIPO** (*Linguagem em Portugol*) é uma linguagem de programação educacional desenvolvida com foco no ensino de lógica e fundamentos da programação. Utiliza palavras-chave em português brasileiro, tornando-se mais acessível e intuitiva para falantes nativos.

## Por que LIPO?
- **Sintaxe em Português** - Aproxima o código da língua natural
- **Educacional** - Focada no aprendizado de programação
- **Tipagem Estática** - Maior segurança e detecção de erros
- **Inferência de Tipos** - Menos declarações explícitas necessárias

<br>

## Funcionalidades

###  Principais Características
- **Sintaxe em Português Brasileiro** - Todas as palavras-chave utilizam português, facilitando o aprendizado
- **Tipagem Estática** - Verificação de tipos em tempo de compilação para maior segurança
- **Inferência de Tipos** - O compilador deduz automaticamente os tipos das variáveis
- **Conversão Automática** - Conversão inteligente entre tipos numéricos
- **Ambiente Web** - Execute diretamente no navegador
- **Debugger Integrado** - Ferramentas de depuração avançadas

<br> 

## Ferramentas Incluídas
- Compilador completo
- Máquina virtual
- Debugger interativo
- Extensão para VS Code
- Interface web para testes

<br>

##  Instalação

### Pré-requisitos
- **Dart SDK** 3.8.1 ou superior
- **Git** para clonagem do repositório

###  Instalação Rápida

####  1. Clone o repositório

```bash
git clone https://github.com/karlaycosta/lipo_compiler/
```

####  2. Clone repositorio 

```bash
cd lipo_compiler
```

####  3. Instale as dependências

```bash
dart pub get
```

#### 4. Execute um arquivo .mdart:

```bash
dart run bin/compile.dart exemplo.mdart
```

#### Versão Web

```bash
# Para executar a versão web
cd web
dart run server.dart

```

 <br>
 
##  Como Usar

### 1. Criando seu primeiro programa

Crie um arquivo com extensão `.mdart`:

```bash
// exemplo.mdart
var nome = "Mundo";
var numero = 42;

se (numero > 10) {
    imprimir "Número grande: ";
    imprimir numero;
} senao {
    imprimir "Número pequeno";
}

imprimir "Olá, ";
imprimir nome;
```


### 2. Compilando e executando

```bash
# Execução básica
dart run bin/compile.dart exemplo.mdart

# Ver apenas a árvore sintática
dart run bin/compile.dart exemplo.mdart --ast-only

# Ver bytecode gerado
dart run bin/compile.dart exemplo.mdart --bytecode

# Verificar versão

```bash
dart run bin/compile.dart --version
```

### 3. Saída esperada

```bash
Número grande: 42
Olá, Mundo
```

<br>

##  Contribuição

Contribuições são muito bem-vindas! Siga estes passos:

### Como Contribuir
1. **Fork** este repositório
2. **Clone** seu fork localmente
3. **Crie** uma branch para sua feature: `git checkout -b feature/nova-funcionalidade`
4. **Faça** suas alterações e commits
5. **Teste** suas modificações
6. **Abra** um Pull Request detalhado

<br> 

###  Diretrizes
- Código limpo e bem comentado
- Mensagens de commit claras e objetivas
- Teste todas as funcionalidades
- Mantenha a documentação atualizada
- Siga os padrões de código existentes

<br> 

##  Licença
Este projeto está licenciado sob a [Licença MIT](LICENSE).

``` bash
MIT License - você pode usar, modificar e distribuir livremente,
mantendo a referência ao repositório original.
```

<br> 

## Equipe

#### Desenvolvimento Principal

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/karlaycosta">
        <img src="https://github.com/karlaycosta.png" width="100px" alt="Karlay Costa"/>
        <br />
        <sub><b>Karlay Costa</b></sub>
        <br />
        <sub>Desenvolvedor Principal</sub>
      </a>
    </td>
  </tr>
</table>

#### Colaboradores

Agradecemos a todas as pessoas que contribuíram para este projeto:

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/AlineCely">
        <img src="https://github.com/AlineCely.png" width="80px" alt="Aline Cely"/>
        <br />
        <sub><b>Aline Cely</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/filipepak">
        <img src="https://github.com/filipepak.png" width="80px" alt="Filipe"/>
        <br />
        <sub><b>Filipe</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/Gab0701">
        <img src="https://github.com/Gab0701.png" width="80px" alt="João Gabriel"/>
        <br />
        <sub><b>João Gabriel</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/JoaoPedroCavalcante">
        <img src="https://github.com/JoaoPedroCavalcante.png" width="80px" alt="João Pedro"/>
        <br />
        <sub><b>João Pedro</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/jhony996358">
        <img src="https://github.com/jhony996358.png" width="80px" alt="Jhonefer Vinicius"/>
        <br />
        <sub><b>Jhonefer Vinicius</b></sub>
      </a>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://github.com/Igormachado90">
        <img src="https://github.com/Igormachado90.png" width="80px" alt="Igor Machado"/>
        <br />
        <sub><b>Igor Machado</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/italo-assuncao">
        <img src="https://github.com/italo-assuncao.png" width="80px" alt="Ítalo Assunção"/>
        <br />
        <sub><b>Ítalo Assunção</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/JKLModesto">
        <img src="https://github.com/JKLModesto.png" width="80px" alt="Pedro Modesto"/>
        <br />
        <sub><b>Pedro Modesto</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/LeoGuile">
        <img src="https://github.com/LeoGuile.png" width="80px" alt="Leo Guile"/>
        <br />
        <sub><b>Leo Guile</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/Luitinho147">
        <img src="https://github.com/Luitinho147.png" width="80px" alt="Luiz"/>
        <br />
        <sub><b>Luiz</b></sub>
      </a>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://github.com/NoanMoreira">
        <img src="https://github.com/NoanMoreira.png" width="80px" alt="Noan Moreira"/>
        <br />
        <sub><b>Noan Moreira</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/StellaKarolinaNunes">
        <img src="https://github.com/StellaKarolinaNunes.png" width="80px" alt="Stella Karolina"/>
        <br />
        <sub><b>Stella Karolina</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/thaissoliveira">
        <img src="https://github.com/thaissoliveira.png" width="80px" alt="Thais Oliveira"/>
        <br />
        <sub><b>Thais Oliveira</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/Vitoralmeidaf">
        <img src="https://github.com/Vitoralmeidaf.png" width="80px" alt="Vitor Almeida"/>
        <br />
        <sub><b>Vitor Almeida</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/vitormezz">
        <img src="https://github.com/vitormezz.png" width="80px" alt="Vitor Mezzomo"/>
        <br />
        <sub><b>Vitor Mezzomo</b></sub>
      </a>
    </td>
  </tr>
</table>

 <br> 

<p align="center">
  <strong>Feito com carinho pela comunidade LIPO - Professor Dericks Karlay é Alunos de Ciência da computação - T383-8TA </strong>
  <br />
  <sub>Ajudando a democratizar o ensino de programação em português</sub>
</p>



