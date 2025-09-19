import 'dart:io';
import 'dart:convert';
import 'bytecode.dart';
import 'standard_library.dart';

enum InterpretResult { ok, compileError, runtimeError }

/// Representa um frame de chamada de função
class CallFrame {
  /// Função sendo executada
  final CompiledFunction function;
<<<<<<< HEAD
  
  /// Ponteiro de instrução para esta função
  int ip;
  
  /// Posição na pilha onde começam as variáveis locais desta função
  final int slots;
  
  CallFrame({
    required this.function,
    this.ip = 0,
    required this.slots,
  });
  
=======

  /// Ponteiro de instrução para esta função
  int ip;

  /// Posição na pilha onde começam as variáveis locais desta função
  final int slots;

  CallFrame({required this.function, this.ip = 0, required this.slots});

>>>>>>> origin/dev
  @override
  String toString() => 'CallFrame(${function.name}/${function.arity})';
}

class VM {
  late BytecodeChunk _chunk;
  int _ip = 0;
  final List<Object?> _stack = [];
  final Map<String, Object?> _globals = {};
  final List<CallFrame> _frames = [];
  Map<String, CompiledFunction> _functions = {};
  late StandardLibrary _standardLibrary;
  bool _debugMode = false; // Modo debug da VM
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
  
  // Callbacks para debugger interativo
  Function(int ip, OpCode opCode, List<dynamic> stack, Map<String, dynamic> globals)? onInstructionExecute;
  Function(String functionName, List<dynamic> args)? onFunctionCall;
  Function(String functionName, dynamic returnValue)? onFunctionReturn;

  VM() {
=======

  // Callback opcional para capturar print (útil para testes)
  void Function(String)? _printCallback;

  // Callbacks para debugger interativo
  Function(
    int ip,
    OpCode opCode,
    List<dynamic> stack,
    Map<String, dynamic> globals,
  )?
  onInstructionExecute;
  Function(String functionName, List<dynamic> args)? onFunctionCall;
  Function(String functionName, dynamic returnValue)? onFunctionReturn;

  VM({void Function(String)? printCallback}) {
>>>>>>> origin/dev
    // Configura stdout para UTF-8
    stdout.encoding = utf8;
    // Inicializa a biblioteca padrão
    _standardLibrary = StandardLibrary();
<<<<<<< HEAD
=======
    _printCallback = printCallback;
>>>>>>> origin/dev
  }

  /// Ativa ou desativa o modo debug da VM
  void setDebugMode(bool enabled) {
    _debugMode = enabled;
  }

  /// Ativa ou desativa o modo debug da VM
  void setDebugMode(bool enabled) {
    _debugMode = enabled;
  }

  InterpretResult interpret(BytecodeChunk chunk) {
    _chunk = chunk;
    _ip = 0;
    _stack.clear();
    _globals.clear();
    _frames.clear();

    try {
      return _run();
    } on VmRuntimeError catch (e) {
      stderr.writeln('Erro de Execução: ${e.message}');
      return InterpretResult.runtimeError;
    }
  }

  /// Define as funções disponíveis para execução
  void setFunctions(Map<String, CompiledFunction> functions) {
    _functions = functions;
  }

  InterpretResult _run() {
    while (true) {
      final instruction = _chunk.code[_ip++];
<<<<<<< HEAD
<<<<<<< HEAD
      
=======

>>>>>>> origin/dev
=======
      
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
      // Debug: mostra instrução atual
      if (_debugMode) {
        _debugInstruction(instruction);
      }
<<<<<<< HEAD
<<<<<<< HEAD
      
      // Callback para debugger interativo
      
      
=======

      // Callback para debugger interativo
      

>>>>>>> origin/dev
=======
      
      // Callback para debugger interativo
      if (onInstructionExecute != null) {
        onInstructionExecute!(_ip - 1, instruction.opcode, List.from(_stack), Map.from(_globals));
      }
      
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
      switch (instruction.opcode) {
        case OpCode.pushConst:
          _push(_chunk.constants[instruction.operand!]);
          break;
        case OpCode.pop:
          _pop();
          break;
        case OpCode.defineGlobal:
          final name = _chunk.constants[instruction.operand!] as String;
          _globals[name] = _pop();
          break;
        case OpCode.getGlobal:
          final name = _chunk.constants[instruction.operand!] as String;
          if (_globals.containsKey(name)) {
            _push(_globals[name]);
          } else if (_standardLibrary.hasFunction(name)) {
            // É uma função nativa, coloca o nome na pilha para posterior chamada
            _push(name);
          } else {
            _runtimeError("Variável global indefinida '$name'.");
          }
          break;
        case OpCode.setGlobal:
          final name = _chunk.constants[instruction.operand!] as String;
          if (!_globals.containsKey(name)) {
            _runtimeError("Variável global indefinida '$name'.");
          }
          _globals[name] = _peek(0); // Atribui sem desempilhar
          break;
<<<<<<< HEAD
=======
        case OpCode.getLocal:
          final slot = instruction.operand!;
          _push(_stack[_currentFrame().slots + slot]);
          break;
        case OpCode.setLocal:
          final slot = instruction.operand!;
          _stack[_currentFrame().slots + slot] = _peek(0);
          break;
>>>>>>> origin/dev
        case OpCode.add:
          final b = _pop();
          final a = _pop();
          if (a is num && b is num) {
            _push(a + b);
          } else if (a is String && b is String) {
            _push(a + b);
          } else {
            _runtimeError("Operandos devem ser dois números ou duas strings.");
          }
          break;
        case OpCode.subtract:
          _binaryOp((a, b) => a - b);
          break;
        case OpCode.multiply:
          _binaryOp((a, b) => a * b);
          break;
        case OpCode.divide:
          _binaryOp((a, b) => a / b);
          break;
        case OpCode.modulo:
          _binaryOp((a, b) => a % b);
          break;
        case OpCode.negate:
          final value = _pop();
          if (value is num) {
            _push(-value);
          } else {
            _runtimeError("Operando deve ser um número.");
          }

          break;
        case OpCode.not:
          _push(!_isTruthy(_pop()));
          break;
        case OpCode.typeof_:
          final value = _pop();
          _push(_getTypeName(value));
          break;
        case OpCode.toInt:
          final value = _pop();
          if (value is double) {
            _push(value.toInt());
          } else {
            _push(value); // Se já é int ou outro tipo, mantém
          }
          break;
        case OpCode.toDouble:
          final value = _pop();
          if (value is int) {
            _push(value.toDouble());
          } else {
            _push(value); // Se já é double ou outro tipo, mantém
          }
          break;
        case OpCode.equal:
          final b = _pop();
          final a = _pop();
          _push(a == b);
          break;
        case OpCode.greater:
          _binaryOp((a, b) => a > b);
          break;
        case OpCode.less:
          _binaryOp((a, b) => a < b);
          break;
        case OpCode.print:
<<<<<<< HEAD
          final value = _stringify(_pop());
          stdout.write('$value\n');
=======
          final value = _pop();
          // Se é um número e é inteiro, imprimir como inteiro
          String output;
          if (value is double && value == value.truncate()) {
            output = value.toInt().toString();
          } else {
            output = value.toString();
          }

          // Use callback se disponível, senão use print padrão
          if (_printCallback != null) {
            _printCallback!(output);
          } else {
            print(output);
          }
>>>>>>> origin/dev
          break;
        case OpCode.jump:
          _ip += instruction.operand!;
          break;
        case OpCode.jumpIfFalse:
          if (!_isTruthy(_peek(0))) {
            _ip += instruction.operand!;
          }
          _pop(); // Remove a condição da pilha após verificá-la
          break;
        case OpCode.loop:
          _ip -= instruction.operand!;
          break;
        case OpCode.call:
          final argCount = instruction.operand!;
<<<<<<< HEAD
          if (!_callValue(_peek(0), argCount)) {  // A função está no topo da pilha
=======
          if (!_callValue(_peek(0), argCount)) {
            // A função está no topo da pilha
>>>>>>> origin/dev
            return InterpretResult.runtimeError;
          }
          break;
        case OpCode.break_:
          // break_ é tratado durante a compilação com jumps - não deveria chegar aqui
          _runtimeError("Instrução 'break' inválida.");
          break;
        case OpCode.continue_:
          // continue_ é tratado durante a compilação com jumps - não deveria chegar aqui
          _runtimeError("Instrução 'continue' inválida.");
          break;
        case OpCode.indexAccess:
          final index = _pop();
          final list = _pop();
          if (list is List && index is int) {
            if (index >= 0 && index < list.length) {
              _push(list[index]);
            } else {
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
              _runtimeError("Índice $index fora do alcance da lista (tamanho: ${list.length}).");
              return InterpretResult.runtimeError;
            }
          } else {
            _runtimeError("Acesso por índice requer uma lista e um índice inteiro.");
<<<<<<< HEAD
=======
              _runtimeError(
                "Índice $index fora do alcance da lista (tamanho: ${list.length}).",
              );
              return InterpretResult.runtimeError;
            }
          } else {
            _runtimeError(
              "Acesso por índice requer uma lista e um índice inteiro.",
            );
>>>>>>> origin/dev
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
            return InterpretResult.runtimeError;
          }
          break;
        case OpCode.indexAssign:
          final value = _pop();
          final index = _pop();
          final list = _pop();
          if (list is List && index is int) {
            if (index >= 0 && index < list.length) {
              list[index] = value;
              _push(value); // Retorna o valor atribuído
            } else {
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
              _runtimeError("Índice $index fora do alcance da lista (tamanho: ${list.length}).");
              return InterpretResult.runtimeError;
            }
          } else {
            _runtimeError("Atribuição por índice requer uma lista e um índice inteiro.");
<<<<<<< HEAD
=======
              _runtimeError(
                "Índice $index fora do alcance da lista (tamanho: ${list.length}).",
              );
              return InterpretResult.runtimeError;
            }
          } else {
            _runtimeError(
              "Atribuição por índice requer uma lista e um índice inteiro.",
            );
>>>>>>> origin/dev
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
            return InterpretResult.runtimeError;
          }
          break;
        case OpCode.listSize:
          final list = _pop();
          if (list is List) {
            _push(list.length);
          } else {
            _runtimeError("Método 'tamanho' só pode ser chamado em listas.");
            return InterpretResult.runtimeError;
          }
          break;
        case OpCode.listAdd:
          final value = _pop();
          final list = _pop();
<<<<<<< HEAD
          list.add(value);
          _push(null); // Método não retorna valor
                  break;
        case OpCode.listRemove:
          final list = _pop();
          if (list.isNotEmpty) {
            final removedValue = list.removeLast();
            _push(removedValue);
          } else {
            _runtimeError("Não é possível remover elemento de lista vazia.");
            return InterpretResult.runtimeError;
          }
                  break;
        case OpCode.listEmpty:
          final list = _pop();
          _push(list.isEmpty);
                  break;
        case OpCode.createList:
          final elementCount = instruction.operand!;
          final list = <Object?>[];
<<<<<<< HEAD
          
=======

>>>>>>> origin/dev
=======
          if (list is List) {
            list.add(value);
            _push(null); // Método não retorna valor
          } else {
            _runtimeError("Método 'adicionar' só pode ser chamado em listas.");
            return InterpretResult.runtimeError;
          }
          break;
        case OpCode.listRemove:
          final list = _pop();
          if (list is List) {
            if (list.isNotEmpty) {
              final removedValue = list.removeLast();
              _push(removedValue);
            } else {
              _runtimeError("Não é possível remover elemento de lista vazia.");
              return InterpretResult.runtimeError;
            }
          } else {
            _runtimeError("Método 'remover' só pode ser chamado em listas.");
            return InterpretResult.runtimeError;
          }
          break;
        case OpCode.listEmpty:
          final list = _pop();
          if (list is List) {
            _push(list.isEmpty);
          } else {
            _runtimeError("Método 'vazio' só pode ser chamado em listas.");
            return InterpretResult.runtimeError;
          }
          break;
        case OpCode.createList:
          final elementCount = instruction.operand!;
          final list = <Object?>[];
          
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
          // Retira elementos da pilha em ordem reversa (último empurrado primeiro)
          for (int i = 0; i < elementCount; i++) {
            list.insert(0, _pop());
          }
<<<<<<< HEAD
<<<<<<< HEAD
          
=======

>>>>>>> origin/dev
=======
          
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
          _push(list);
          break;
        case OpCode.return_:
          return InterpretResult.ok;
      }
    }
  }

  void _binaryOp(Object Function(num a, num b) op) {
    final b = _pop();
    final a = _pop();
    if (a is num && b is num) {
      _push(op(a, b));
    } else {
      _runtimeError("Operandos devem ser números.");
    }
  }

  bool _isTruthy(Object? value) {
    if (value == null) return false;
    if (value is bool) return value;
    return true; // Números e strings são 'truthy'
  }

<<<<<<< HEAD
  String _stringify(Object? value) {
    if (value == null) return "nulo";
    return value.toString();
  }
=======
  // String _stringify(Object? value) {
  //   if (value == null) return "nulo";
  //   return value.toString();
  // }
>>>>>>> origin/dev

  void _push(Object? value) => _stack.add(value);
  Object? _pop() => _stack.removeLast();
  Object? _peek(int distance) => _stack[_stack.length - 1 - distance];

<<<<<<< HEAD
=======
  /// Retorna o frame de chamada atual
  CallFrame _currentFrame() {
    if (_frames.isEmpty) {
      // Se não há frames, cria um frame dummy para o escopo global
      return CallFrame(
        function: CompiledFunction(
          name: "__global__",
          arity: 0,
          chunk: BytecodeChunk(),
          paramNames: [],
        ),
        slots: 0,
      );
    }
    return _frames.last;
  }

>>>>>>> origin/dev
  void _runtimeError(String message) {
    final currentLocation = _getCurrentSourceLocation();
    if (currentLocation != null) {
      throw VmRuntimeError('$message\n[$currentLocation]');
    } else {
      throw VmRuntimeError(message);
    }
  }

  /// Obtém a localização atual do código fonte
  SourceLocation? _getCurrentSourceLocation() {
    // _ip - 1 porque _ip já foi incrementado para a próxima instrução
    final instructionIndex = _ip - 1;
    return _chunk.getSourceLocation(instructionIndex);
  }

  // ===== MÉTODOS PARA CHAMADAS DE FUNÇÃO =====

  /// Chama um valor (que deve ser uma função)
  bool _callValue(Object? callee, int argCount) {
    if (callee is String) {
      // Primeiro verifica se é uma função nativa
      final nativeFunction = _standardLibrary.getFunction(callee);
      if (nativeFunction != null) {
        return _callNative(nativeFunction, argCount);
      }
<<<<<<< HEAD
      
=======

>>>>>>> origin/dev
      // Se não é nativa, verifica se é uma função compilada
      final function = _functions[callee];
      if (function != null) {
        return _call(function, argCount);
      } else {
        _runtimeError("Função '$callee' não encontrada.");
        return false;
      }
    } else if (callee is CompiledFunction) {
      return _call(callee, argCount);
    } else {
<<<<<<< HEAD
      _runtimeError("Só é possível chamar funções. Recebido: ${callee.runtimeType}");
=======
      _runtimeError(
        "Só é possível chamar funções. Recebido: ${callee.runtimeType}",
      );
>>>>>>> origin/dev
      return false;
    }
  }

  /// Executa uma chamada de função nativa
  bool _callNative(NativeFunction nativeFunction, int argCount) {
    if (argCount != nativeFunction.arity) {
<<<<<<< HEAD
      _runtimeError("Esperado ${nativeFunction.arity} argumentos mas recebeu $argCount.");
=======
      _runtimeError(
        "Esperado ${nativeFunction.arity} argumentos mas recebeu $argCount.",
      );
>>>>>>> origin/dev
      return false;
    }

    // Remove a função que está no topo
    _pop(); // Remove o nome da função da pilha
<<<<<<< HEAD
    
=======

>>>>>>> origin/dev
    // Coleta os argumentos da pilha
    final args = <Object?>[];
    for (int i = 0; i < argCount; i++) {
      args.insert(0, _pop()); // Remove argumentos na ordem reversa
    }
<<<<<<< HEAD
    
    try {
      // Executa a função nativa
      final result = nativeFunction.call(args);
      
      // Coloca o resultado na pilha (mesmo que seja null)
      _push(result);
      
=======

    try {
      // Executa a função nativa
      final result = nativeFunction.call(args);

      // Coloca o resultado na pilha (mesmo que seja null)
      _push(result);

>>>>>>> origin/dev
      return true;
    } catch (e) {
      _runtimeError("Erro na função nativa ${nativeFunction.name}: $e");
      return false;
    }
  }

  /// Executa uma chamada de função
  bool _call(CompiledFunction function, int argCount) {
    if (argCount != function.arity) {
<<<<<<< HEAD
      _runtimeError("Esperado ${function.arity} argumentos mas recebeu $argCount.");
=======
      _runtimeError(
        "Esperado ${function.arity} argumentos mas recebeu $argCount.",
      );
>>>>>>> origin/dev
      return false;
    }

    // Remove a função que está no topo
    _pop(); // Remove a função da pilha
<<<<<<< HEAD
    
    // Salva os argumentos em variáveis globais temporárias para os parâmetros
    final args = <Object?>[];
    for (int i = 0; i < argCount; i++) {
      args.insert(0, _pop()); // Remove argumentos na ordem reversa
    }
    
    // Callback para debugger
    if (onFunctionCall != null) {
      onFunctionCall!(function.name, args);
    }
    
    // Salva as variáveis globais que podem ser sobrescritas pelos parâmetros
    final savedGlobals = <String, Object?>{};
    for (int i = 0; i < function.paramNames.length; i++) {
      final paramName = function.paramNames[i];
      if (_globals.containsKey(paramName)) {
        savedGlobals[paramName] = _globals[paramName];
      }
      _globals[paramName] = args[i];
    }

    // Cria um novo frame de chamada
    final frame = CallFrame(
      function: function,
      ip: 0,
      slots: _stack.length,
=======

    // Os argumentos já estão na pilha na ordem correta para serem variáveis locais
    // Não precisamos removê-los da pilha

    // Callback para debugger
    if (onFunctionCall != null) {
      final args = <Object?>[];
      for (int i = 0; i < argCount; i++) {
        args.add(_stack[_stack.length - argCount + i]);
      }
      onFunctionCall!(function.name, args);
    }

    // Cria um novo frame de chamada
    // slots aponta para onde os parâmetros começam na pilha
    final frame = CallFrame(
      function: function,
      ip: 0,
      slots: _stack.length - argCount,
>>>>>>> origin/dev
    );
    _frames.add(frame);

    // Executa a função
    final result = _executeFunction(frame);
<<<<<<< HEAD
    
    // Restaura as variáveis globais originais
    for (final paramName in function.paramNames) {
      if (savedGlobals.containsKey(paramName)) {
        _globals[paramName] = savedGlobals[paramName];
      } else {
        _globals.remove(paramName);
      }
    }
    
=======

>>>>>>> origin/dev
    return result;
  }

  /// Executa o bytecode de uma função
  bool _executeFunction(CallFrame frame) {
    final oldChunk = _chunk;
    final oldIp = _ip;

    _chunk = frame.function.chunk;
    _ip = frame.ip;

    try {
      while (true) {
        final instruction = _chunk.code[_ip++];
        switch (instruction.opcode) {
          case OpCode.pushConst:
            _push(_chunk.constants[instruction.operand!]);
            break;
          case OpCode.return_:
            // Remove o frame
            _frames.removeLast();
<<<<<<< HEAD
            
            // Resultado já está no topo da pilha
            final result = _pop();
            
<<<<<<< HEAD
=======

            // Resultado já está no topo da pilha
            final result = _pop();

            // Remove todas as variáveis locais da pilha (incluindo parâmetros)
            while (_stack.length > frame.slots) {
              _pop();
            }

>>>>>>> origin/dev
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
            // Callback para debugger
            if (onFunctionReturn != null) {
              onFunctionReturn!(frame.function.name, result);
            }
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
            
            // Restaura contexto anterior
            _chunk = oldChunk;
            _ip = oldIp;
            
            // Coloca o resultado na pilha
            _push(result);
            
=======

            // Restaura contexto anterior
            _chunk = oldChunk;
            _ip = oldIp;

            // Coloca o resultado na pilha
            _push(result);

>>>>>>> origin/dev
            return true;
          default:
            // Para outras operações, usa a implementação padrão
            _executeInstruction(instruction);
            break;
        }
      }
    } catch (e) {
      _chunk = oldChunk;
      _ip = oldIp;
      rethrow;
    }
  }

  /// Executa uma instrução individual
  void _executeInstruction(Instruction instruction) {
    switch (instruction.opcode) {
      case OpCode.pushConst:
        _push(_chunk.constants[instruction.operand!]);
        break;
      case OpCode.pop:
        _pop();
        break;
      case OpCode.defineGlobal:
        final name = _chunk.constants[instruction.operand!] as String;
        _globals[name] = _pop();
        break;
      case OpCode.getGlobal:
        final name = _chunk.constants[instruction.operand!] as String;
<<<<<<< HEAD
        if (!_globals.containsKey(name)) {
          _runtimeError("Variável global indefinida '$name'.");
        }
        _push(_globals[name]);
=======
        if (_globals.containsKey(name)) {
          _push(_globals[name]);
        } else if (_standardLibrary.hasFunction(name)) {
          // É uma função nativa, coloca o nome na pilha para posterior chamada
          _push(name);
        } else {
          _runtimeError("Variável global indefinida '$name'.");
        }
>>>>>>> origin/dev
        break;
      case OpCode.setGlobal:
        final name = _chunk.constants[instruction.operand!] as String;
        if (!_globals.containsKey(name)) {
          _runtimeError("Variável global indefinida '$name'.");
        }
        _globals[name] = _peek(0); // Atribui sem desempilhar
        break;
<<<<<<< HEAD
=======
      case OpCode.getLocal:
        final slot = instruction.operand!;
        _push(_stack[_currentFrame().slots + slot]);
        break;
      case OpCode.setLocal:
        final slot = instruction.operand!;
        _stack[_currentFrame().slots + slot] = _peek(0);
        break;
>>>>>>> origin/dev
      case OpCode.add:
        final b = _pop();
        final a = _pop();
        if (a is num && b is num) {
          _push(a + b);
        } else if (a is String && b is String) {
          _push(a + b);
        } else {
          _runtimeError("Operandos devem ser números ou strings.");
        }
        break;
      case OpCode.subtract:
        _binaryOp((a, b) => a - b);
        break;
      case OpCode.multiply:
        _binaryOp((a, b) => a * b);
        break;
      case OpCode.divide:
        _binaryOp((a, b) => a / b);
        break;
      case OpCode.modulo:
        _binaryOp((a, b) => a % b);
        break;
      case OpCode.negate:
        final a = _pop();
        if (a is num) {
          _push(-a);
        } else {
          _runtimeError("Operando deve ser um número.");
        }
        break;
      case OpCode.not:
        _push(_isFalsey(_pop()));
        break;
      case OpCode.typeof_:
        final value = _pop();
        _push(_getTypeName(value));
        break;
      case OpCode.toInt:
        final value = _pop();
        if (value is double) {
          _push(value.toInt());
        } else {
          _push(value); // Se já é int ou outro tipo, mantém
        }
        break;
      case OpCode.toDouble:
        final value = _pop();
        if (value is int) {
          _push(value.toDouble());
        } else {
          _push(value); // Se já é double ou outro tipo, mantém
        }
        break;
      case OpCode.equal:
        final b = _pop();
        final a = _pop();
        _push(a == b);
        break;
      case OpCode.greater:
        _binaryOp((a, b) => a > b);
        break;
      case OpCode.less:
        _binaryOp((a, b) => a < b);
        break;
      case OpCode.print:
        final value = _pop();
        // Se é um número e é inteiro, imprimir como inteiro
<<<<<<< HEAD
        if (value is double && value == value.truncate()) {
          print(value.toInt());
        } else {
          print(value);
=======
        String output;
        if (value is double && value == value.truncate()) {
          output = value.toInt().toString();
        } else {
          output = value.toString();
        }
        
        // Use callback se disponível, senão use print padrão
        if (_printCallback != null) {
          _printCallback!(output);
        } else {
          print(output);
>>>>>>> origin/dev
        }
        break;
      case OpCode.jump:
        _ip += instruction.operand!;
        break;
      case OpCode.jumpIfFalse:
        if (!_isTruthy(_peek(0))) {
          _ip += instruction.operand!;
        }
        _pop(); // Remove a condição da pilha após verificá-la
        break;
      case OpCode.loop:
        _ip -= instruction.operand!;
        break;
      case OpCode.call:
        final argCount = instruction.operand!;
        if (!_callValue(_peek(0), argCount)) {
          _runtimeError("Erro na chamada de função.");
        }
        break;
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
      case OpCode.return_:
        // No contexto principal (sem frames), return_ marca fim do programa
        if (_frames.isEmpty) {
          // Programa principal terminando - isso é normal
          return;
        } else {
          // Retorno de função - isso deve ser tratado pelo callFunction
          _runtimeError("Return inesperado fora de contexto de função.");
        }
        break;
<<<<<<< HEAD
=======
      case OpCode.break_:
        // break_ é tratado durante a compilação com jumps - não deveria chegar aqui
        _runtimeError("Instrução 'break' inválida.");
        break;
      case OpCode.continue_:
        // continue_ é tratado durante a compilação com jumps - não deveria chegar aqui
        _runtimeError("Instrução 'continue' inválida.");
        break;
      case OpCode.indexAccess:
        final index = _pop();
        final list = _pop();
        if (list is List && index is int) {
          if (index >= 0 && index < list.length) {
            _push(list[index]);
          } else {
            _runtimeError(
              "Índice $index fora do alcance da lista (tamanho: ${list.length}).",
            );
          }
        } else {
          _runtimeError(
            "Acesso por índice requer uma lista e um índice inteiro.",
          );
        }
        break;
      case OpCode.indexAssign:
        final value = _pop();
        final index = _pop();
        final list = _pop();
        if (list is List && index is int) {
          if (index >= 0 && index < list.length) {
            list[index] = value;
            _push(value); // Retorna o valor atribuído
          } else {
            _runtimeError(
              "Índice $index fora do alcance da lista (tamanho: ${list.length}).",
            );
          }
        } else {
          _runtimeError(
            "Atribuição por índice requer uma lista e um índice inteiro.",
          );
        }
        break;
      case OpCode.listSize:
        final list = _pop();
        if (list is List) {
          _push(list.length);
        } else {
          _runtimeError("Método 'tamanho' só pode ser chamado em listas.");
        }
        break;
      case OpCode.listAdd:
        final value = _pop();
        final list = _pop();
        if (list is List) {
          list.add(value);
          _push(null); // Método não retorna valor
        } else {
          _runtimeError("Método 'adicionar' só pode ser chamado em listas.");
        }
        break;
      case OpCode.listRemove:
        final list = _pop();
        if (list is List) {
          if (list.isNotEmpty) {
            final removedValue = list.removeLast();
            _push(removedValue);
          } else {
            _runtimeError("Não é possível remover elemento de lista vazia.");
          }
        } else {
          _runtimeError("Método 'remover' só pode ser chamado em listas.");
        }
        break;
      case OpCode.listEmpty:
        final list = _pop();
        if (list is List) {
          _push(list.isEmpty);
        } else {
          _runtimeError("Método 'vazio' só pode ser chamado em listas.");
        }
        break;
      case OpCode.createList:
        final elementCount = instruction.operand!;
        final list = <Object?>[];

        // Retira elementos da pilha em ordem reversa (último empurrado primeiro)
        for (int i = 0; i < elementCount; i++) {
          list.insert(0, _pop());
        }

        _push(list);
        break;
>>>>>>> origin/dev
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
      default:
        _runtimeError("Operação não suportada: ${instruction.opcode}");
        break;
    }
  }

  /// Verifica se um valor é falsey (nulo ou false)
  bool _isFalsey(Object? value) {
    if (value == null) return true;
    if (value is bool) return !value;
    return false;
  }

  /// Debug: mostra informações da instrução atual
  void _debugInstruction(Instruction instruction) {
    // Mostra posição atual e instrução
<<<<<<< HEAD
<<<<<<< HEAD
    print('🔍 [VM] IP: ${_ip - 1} | ${instruction.opcode}${instruction.operand != null ? ' ${instruction.operand}' : ''}');
    
=======
    print(
      '🔍 [VM] IP: ${_ip - 1} | ${instruction.opcode}${instruction.operand != null ? ' ${instruction.operand}' : ''}',
    );

>>>>>>> origin/dev
=======
    print('🔍 [VM] IP: ${_ip - 1} | ${instruction.opcode}${instruction.operand != null ? ' ${instruction.operand}' : ''}');
    
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
    // Mostra pilha atual
    stdout.write('    Stack: [');
    for (int i = 0; i < _stack.length; i++) {
      if (i > 0) stdout.write(', ');
      final value = _stack[i];
      if (value is String) {
        stdout.write('"$value"');
      } else {
        stdout.write('$value');
      }
    }
    print(']');
<<<<<<< HEAD
<<<<<<< HEAD
    
=======

>>>>>>> origin/dev
=======
    
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
    // Mostra globals relevantes (apenas se não vazio)
    if (_globals.isNotEmpty && _globals.length <= 5) {
      stdout.write('    Globals: {');
      final entries = _globals.entries.toList();
      for (int i = 0; i < entries.length; i++) {
        if (i > 0) stdout.write(', ');
        final entry = entries[i];
        stdout.write('${entry.key}: ${entry.value}');
      }
      print('}');
    }
    print('');
  }

  // ===== MÉTODOS PARA DEBUGGER INTERATIVO =====

  /// Executa uma única instrução (para step-by-step)
  InterpretResult interpretStep(BytecodeChunk chunk) {
    // Inicializa se necessário
    try {
      if (_chunk != chunk) {
        _chunk = chunk;
        _ip = 0;
        _stack.clear();
        _globals.clear();
        _frames.clear();
      }
    } catch (e) {
      // Se _chunk não foi inicializada ainda
      _chunk = chunk;
      _ip = 0;
      _stack.clear();
      _globals.clear();
      _frames.clear();
    }
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
    
    if (_ip >= chunk.code.length) {
      return InterpretResult.ok;
    }
    
    final instruction = chunk.code[_ip++];
    
    if (_debugMode) {
      _debugInstruction(instruction);
    }
    
    if (onInstructionExecute != null) {
      onInstructionExecute!(_ip - 1, instruction.opcode, List.from(_stack), Map.from(_globals));
    }
    
<<<<<<< HEAD
=======

    if (_ip >= chunk.code.length) {
      return InterpretResult.ok;
    }

    final instruction = chunk.code[_ip++];

    if (_debugMode) {
      _debugInstruction(instruction);
    }

    if (onInstructionExecute != null) {
      onInstructionExecute!(
        _ip - 1,
        instruction.opcode,
        List.from(_stack),
        Map.from(_globals),
      );
    }

>>>>>>> origin/dev
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
    try {
      _executeInstruction(instruction);
      return InterpretResult.ok;
    } on VmRuntimeError catch (e) {
      stderr.writeln('Erro de Execução: ${e.message}');
      return InterpretResult.runtimeError;
    }
  }

  /// Verifica se chegou ao fim do programa
  bool isAtEnd() {
    return _ip >= _chunk.code.length;
  }

  /// Obtém valor de uma variável global
  Object? getGlobalValue(String name) {
    if (_globals.containsKey(name)) {
      return _globals[name];
    }
    throw VmRuntimeError("Variável '$name' não encontrada");
  }

  /// Obtém todas as variáveis globais
  Map<String, Object?> getAllGlobals() {
    return Map.from(_globals);
  }

  /// Obtém valores da pilha
  List<Object?> getStackValues() {
    return List.from(_stack);
  }

  /// Obtém call stack atual
  List<CallFrame> getCallStack() {
    return List.from(_frames);
  }

  /// Retorna o nome do tipo de um valor para o operador typeof
  String _getTypeName(dynamic value) {
    if (value == null) return 'nulo';
    if (value is bool) return 'logico';
    if (value is int) return 'inteiro';
    if (value is double) return 'real';
    if (value is String) return 'texto';
    if (value is CompiledFunction) return 'funcao';
    return 'desconhecido';
  }

  /// Define callback para execução de instrução
<<<<<<< HEAD
<<<<<<< HEAD
  void setOnInstructionExecute(Function(int ip, OpCode opCode, List<dynamic> stack, Map<String, dynamic> globals) callback) {
=======
  void setOnInstructionExecute(
    Function(
      int ip,
      OpCode opCode,
      List<dynamic> stack,
      Map<String, dynamic> globals,
    )
    callback,
  ) {
>>>>>>> origin/dev
=======
  void setOnInstructionExecute(Function(int ip, OpCode opCode, List<dynamic> stack, Map<String, dynamic> globals) callback) {
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
    onInstructionExecute = callback;
  }

  /// Define callback para chamada de função
<<<<<<< HEAD
<<<<<<< HEAD
  void setOnFunctionCall(Function(String functionName, List<dynamic> args) callback) {
=======
  void setOnFunctionCall(
    Function(String functionName, List<dynamic> args) callback,
  ) {
>>>>>>> origin/dev
=======
  void setOnFunctionCall(Function(String functionName, List<dynamic> args) callback) {
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
    onFunctionCall = callback;
  }

  /// Define callback para retorno de função
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
  void setOnFunctionReturn(Function(String functionName, dynamic returnValue) callback) {
    onFunctionReturn = callback;
  }

<<<<<<< HEAD
=======
  void setOnFunctionReturn(
    Function(String functionName, dynamic returnValue) callback,
  ) {
    onFunctionReturn = callback;
  }
>>>>>>> origin/dev
=======
>>>>>>> 6652597 (docs: adiciona documentação com DocMD)
}

class VmRuntimeError implements Exception {
  final String message;
  VmRuntimeError(this.message);
}
