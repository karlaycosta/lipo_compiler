# Changelog

Todas as alterações notáveis deste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

## [1.2.0] - 2025-07-23

### ✨ Adicionado
- **Extensão VS Code MiniDart**: Suporte completo para desenvolvimento MiniDart no Visual Studio Code
  - Syntax highlighting específico para palavras-chave em português
  - Snippets e templates para estruturas básicas (algoritmo, função, se, enquanto)
  - Comandos integrados para compilar, executar e gerar AST
  - Atalhos de teclado (Ctrl+F5 para executar, Ctrl+Shift+B para compilar, Ctrl+Shift+A para AST)
  - Configurações personalizáveis (caminho do compilador, auto-compilação)
  - Criação automática de novos arquivos MiniDart com template
  - Detecção automática de arquivos .mdart
  - Integração completa com o terminal do VS Code

### 🐛 Corrigido
- **Crítico: Loop `enquanto` com erro de execução**: 
  - Resolvido erro "Operandos devem ser números" em loops while
  - Corrigida operação `jumpIfFalse` na VM que não fazia pop da condição da pilha
  - Pilha da VM agora permanece equilibrada durante execução de loops
  - Cálculo de offset do loop corrigido para voltar à posição correta
  - Todos os loops `enquanto` agora funcionam perfeitamente
- **Escape de aspas duplas no gerador AST Graphviz**:
  - Corrigido erro de sintaxe nas linhas 24 e 40 do arquivo DOT gerado
  - Removidas aspas duplas extras em strings literais
  - Melhorada função `_escapeLabel()` com ordem correta de escape
  - Garantida compatibilidade total com Graphviz

### 🔧 Melhorado
- **Máquina Virtual**: Estabilidade e confiabilidade aprimoradas
- **Extensão VS Code**: Interface moderna e intuitiva para desenvolvimento MiniDart
- **Debugging**: Melhor tratamento de erros de execução

## [1.1.1] - 2025-07-23

### 🐛 Corrigido
- **Escape de aspas duplas no gerador AST Graphviz**:
  - Corrigido erro de sintaxe nas linhas 24 e 40 do arquivo DOT gerado
  - Removidas aspas duplas extras em strings literais que causavam falha na geração de imagens
  - Melhorada função `_escapeLabel()` com ordem correta de escape de caracteres especiais
  - Resolvido erro "syntax error in line X" ao executar comando `dot -Tpng`
  - Garantida compatibilidade total com Graphviz para geração de PNG, SVG e PDF

## [1.1.0] - 2025-07-23

### ✨ Adicionado
- **Gerador de AST em Graphviz**: Nova funcionalidade para visualização gráfica da Árvore Sintática Abstrata
  - Classe `ASTGraphvizGenerator` implementando o padrão Visitor
  - Geração automática de arquivo DOT durante a compilação
  - Suporte a visualização em PNG, SVG e PDF
  - Cores e emojis diferenciados para cada tipo de nó da AST
- **Interface CLI melhorada**:
  - Nova opção `--ast-only` para gerar apenas a AST sem executar o código
  - Instruções detalhadas de uso com exemplos
  - Detecção automática do Graphviz e instruções de instalação
- **Novo exemplo**: `exemplos/exemplo_ast.mdart` para demonstração da visualização AST
- **Documentação expandida**:
  - Seção completa sobre visualização de AST no README.md
  - Guia de cores e símbolos da AST
  - Instruções de instalação do Graphviz para diferentes sistemas operacionais
  - Seção de debugging e análise melhorada

### 🔧 Melhorado
- README.md atualizado com informações do autor **Deriks Karlay Dias Costa**
- Documentação mais detalhada sobre uso do compilador
- Interface de linha de comando mais informativa

### 🐛 Corrigido
- Diagrama Mermaid no `parser.md` corrigido para compatibilidade com GitHub
  - Removidos caracteres problemáticos que causavam erros de renderização
  - Sintaxe simplificada para melhor compatibilidade

### 📚 Documentação
- Adicionadas instruções detalhadas para visualização da AST
- Documentação em português para todas as novas funcionalidades
- Exemplos práticos de uso da geração de AST

## [1.0.0] - 2025-07-23

### ✨ Inicial
- **Compilador MiniDart completo** com pipeline de 5 estágios:
  - 🔍 **Lexer**: Análise léxica com suporte a português
  - 🌳 **Parser**: Parser de descida recursiva gerando AST
  - 🧠 **Semantic Analyzer**: Análise semântica com verificação de tipos e escopo
  - ⚙️ **Code Generator**: Geração de bytecode otimizado
  - 🚀 **Virtual Machine**: VM stack-based para execução
- **Sintaxe em português**:
  - Palavras-chave: `var`, `se`, `senao`, `enquanto`, `imprimir`
  - Tipos: números, strings, booleanos, `nulo`
  - Operadores: aritméticos, comparação, lógicos (`e`, `ou`)
- **Funcionalidades implementadas**:
  - ✅ Declaração e atribuição de variáveis
  - ✅ Estruturas condicionais (`se`/`senao`)
  - ✅ Loops (`enquanto`)
  - ✅ Blocos de código
  - ✅ Expressões aritméticas e lógicas
  - ✅ Comandos de impressão
  - ✅ Precedência de operadores
- **Arquitetura robusta**:
  - Padrão Visitor para processamento da AST
  - Sistema de tratamento de erros integrado
  - Tabela de símbolos para gerenciamento de escopo
  - Geração de bytecode otimizada
- **Exemplos incluídos**:
  - `exemplo_basico.mdart`: Demonstração básica
  - `exemplo_completo.mdart`: Todas as funcionalidades
  - `calculadora_notas.mdart`: Calculadora de notas
  - `exemplo_funcional.mdart`: Programação funcional
- **Documentação completa**:
  - README.md detalhado em português
  - `parser.md`: Análise técnica completa do parser
  - Código fonte totalmente documentado
  - Exemplos práticos de uso
