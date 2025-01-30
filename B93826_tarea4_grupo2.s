# IE0320 I S 2023
# Estudiante: Juan Ignacio Hernández Zamora
# Carné: B93826 

.data
# Constantes de uso en el programa
#
# Constante 1.0
unoflotante:	.double 1.0
# Constante miscelánea para fp double
varflotante:	.double 1.0

# Separadores y cabeceras
nL:		.asciiz	"\n"
barra:		.asciiz "/"
final:		.asciiz " rad) = "
pedir:		.asciiz	"Ingrese un número x (rad) mayor o igual a 0 para calcular\nsen(x), cos(x), y tan(x): "
res:		.asciiz "Para el número ingresado se tienen los siguientes resultados:\n"
sen:		.asciiz "\tsen("
cos:		.asciiz "\tcos("
tan:		.asciiz "\ttan("
ellol:		.asciiz "Error, se ingresó un número menor a 0, se termina la ejecución del programa.\n"

# Inicio del programa
.text
# Código que resuelve el problema planteado
# La precisión utilizada para todos los
# números de punto flotante es doble
.globl main
main:

	jal cosechar_trigo	# Obtiene los valores
				# trigonométricos solicitados

	# Código para cerrar el programa
	addi $v0, $0, 0x0000000A
	syscall

.globl ene_factorial 
ene_factorial: # Lista y verificada
	# Esta función recibe por $a0 un número entero n,
	# obtiene en $f2 el resultado de n!, y lo devuelve
	# por $v0 y $v1
	# Trabaja con un for, no es recursiva
	# Recibe:
	#	$a0: Número n
	# Entrega:
	#	$f2: n!
	#	$v0: Primeros 32 bits del resultado
	#	$v1: Segundos 32 bits del resultado

	# Se alojan recursos para variables
	addi $sp, $sp, -20
	sw $ra, 16($sp)		# Return address
	sw $a0, 12($sp)		# int:	Número n
	sw $s0, 8($sp)		# int:	Iteración i
	sw $s1, 4($sp)		# int:	Variable miscelánea
	sw $s2, 0($sp)		# bool:	If salida de for

	# Copia el número de inicio
	add $s0, $a0, $0

	# Empieza por cargar el número 1 al registro $f2,
	# esto tendrá sentido después
	la  $s1, unoflotante
	ldc1 $f2, 0($s1)

	for_factorial:
		# Se verifica la condición de salida
		sltu $s2, $0, $s0	# Comparación de salida
					# $s1 = 1 si 0<i
					# Recorre de n a 0 y se sale
					# resta uno a n en cada ciclo

		# Salida de for_factorial
		beq $s2, $0, for_factorial_end

		# Inicio del código de for_factorial

		# Salva n en memoria para pasarlo a
		# los registros fp
		la $s1, varflotante
		sw $s0, 0($s1)

		# Carga n como int de memoria
		# a los regsitros fp
		lwc1 $f10, 0($s1)

		# Se convierte de int a double
		cvt.d.w $f10, $f10

		# Se multiplica la n por (n-1)
		# y se mantiene el valor en regs fp
		mul.d $f2, $f2, $f10

		# Final de código de for_factorial

		# Incremento de la variable de iteración
		addi $s0, $s0, -1	# i--
		j for_factorial
	for_factorial_end:

	# Si el pc llega hasta aquí, en $f2 se tiene el
	# valor de n!

	# Se salvan los bits del double de a dos
	la $s1, varflotante 
	swc1 $f2, 0($s1)
	swc1 $f3, 4($s1)

	# Se cargan los datos de punto flontante
	# en los registros $v0 y $v1
	lw $v0, 0($s1)
	lw $v1, 4($s1)

	# Se investigó, y las instrucciones  TODO poner que las instr usadas no son pseudo instrucciones dospuntosuber

	# Con las operaciones de valores listas, se 
	# termina la ejecución de la función
	# Se desalojan recursos y se vuelve el PC a la
	# función que la llamó
	lw $ra, 16($sp)		# Return address
	lw $a0, 12($sp)		# int:	Número n
	lw $s0, 8($sp)		# int:	Iteración i
	lw $s1, 4($sp)		# int:	Variable miscelánea
	lw $s2, 0($sp)		# bool:	If salida de for
	addi $sp, $sp, 20	# TODO pasar los args por regs :v
	jr $ra

.globl equis_a_la_ene
equis_a_la_ene: # Lista y verificada
	# Esta función recibe por $a0 un número entero n,
	# por $a1 y $a2 recive los valores dobles para x,
	# calcula x^(n) por $f4, y lo devuelve por $v0 y $v1
	# Trabaja con un for, no es recursiva
	# Recibe:
	#	$a0: Número n
	#	$a0: Primeros 32 bits de X
	#	$a0: Segundos 32 bits de X
	# Entrega:
	#	$f4: n!
	#	$v0: Primeros 32 bits del resultado
	#	$v1: Segundos 32 bits del resultado

	# Se alojan recursos para variables
	addi $sp, $sp, -28
	sw $ra, 24($sp)		# Return address
	sw $a0, 20($sp)		# int:		Número n
	sw $a1, 16($sp)		# double:	Primeros 32 bits x
	sw $a2, 12($sp)		# double:	Primeros 32 bits x
	sw $s0, 8($sp)		# int:		Iteración i
	sw $s1, 4($sp)		# int:		Variable miscelánea
	sw $s2, 0($sp)		# bool:		If salida de for

	# Luego, se carga la variable X a los registros
	# de punto flotante
	# Se salvan los bits del double de a dos
	la $s1, varflotante 
	sw $a1, 0($s1)
	sw $a2, 4($s1)

	# Se cargan los datos de punto flontante
	lwc1 $f0, 0($s1)
	lwc1 $f1, 4($s1)

	# Copia el número de inicio
	add $s0, $a0, $0

	# Empieza por cargar el número 1 al registro $f4,
	# esto tendrá sentido después
	la  $s1, unoflotante
	ldc1 $f4, 0($s1)

	for_exponencial:
		# Se verifica la condición de salida
		sltu $s2, $0, $s0	# Comparación de salida
					# $s1 = 1 si 0<i
					# Recorre de n a 0 y se sale
					# resta uno a n en cada ciclo

		# Salida de for_exponencial
		beq $s2, $0, for_exponencial_end

		# Inicio del código de for_exponencial

		# Se multiplica la x*x y lo salva
		# en $f4
		mul.d $f4, $f0, $f4

		# Final de código de for_exponencial

		# Incremento de la variable de iteración
		addi $s0, $s0, -1	# i--
		j for_exponencial
	for_exponencial_end:

	# Si el pc llega hasta aquí, en $f4 se tiene el
	# valor de n!

	# Se salvan los bits del double de a dos
	la $s1, varflotante 
	swc1 $f4, 0($s1)
	swc1 $f5, 4($s1)

	# Se cargan los datos de punto flontante
	# en los registros $v0 y $v1
	lw $v0, 0($s1)
	lw $v1, 4($s1)

	# Con las operaciones de valores listas, se 
	# termina la ejecución de la función
	# Se desalojan recursos y se vuelve el PC a la
	# función que la llamó
	lw $ra, 24($sp)		# Return address
	lw $a0, 20($sp)		# int:		Número n
	lw $a1, 16($sp)		# double:	Primeros 32 bits x
	lw $a2, 12($sp)		# double:	Primeros 32 bits x
	lw $s0, 8($sp)		# int:		Iteración i
	lw $s1, 4($sp)		# int:		Variable miscelánea
	lw $s2, 0($sp)		# bool:		If salida de for
	addi $sp, $sp, 28
	jr $ra

.globl seno
seno: # Lista y verificada
	# Esta función recibe por $a0 el orden de la serie de
	# Taylor a calcular, por $a1 y $a2 los 64 bits la
	# preimagen x de la función sen(x), calcula esta
	# última, y devuelve el resultado en 64 bits por
	# $v0 y $v1
	# Recibe:
	#	$a0: Número n
	#	$a1: Primeros 32 bits de X
	#	$a2: Segundos 32 bits de X
	#	
	# Entrega:
	#	$v0: Primeros 32 bits del resultado
	#	$v1: Segundos 32 bits del resultado
	#	$f4: n!

	# Se alojan recursos para variables
	addi $sp, $sp, -24
	sw $ra, 20($sp)		# Return address
	sw $a0, 16($sp)		# int:	Número n
	sw $s0, 12($sp)		# int:	Iteración i
	sw $s1, 8($sp)		# int:	Variable de salida for
	sw $s2, 4($sp)		# int:	Variable miscelánea
	sw $s3, 0($sp)		# bool:	If salida de for

	# Se carga x de los argumentos $a1 y $a2 a $f0 y $f1
	# Se salvan los bits del double de a dos
	la $s2, varflotante 
	sw $a1, 0($s2)
	sw $a2, 4($s2)

	# Se cargan los datos de punto flontante
	lwc1 $f0, 0($s2)
	lwc1 $f1, 4($s2)

	# Se copia n+1 para calcular la constante de salida
	addi $s1, $a0, 1	# Se sale cuando se llega a n+1

	# La variable de iteración inicia en 0
	addi $s0, $0, 0

	# Se inicia el cálculo del seno en 0
	la  $s2, unoflotante
	ldc1 $f8, 0($s2)
	sub.d $f8, $f8, $f8	# $f8 = 0 = sen

	for_seno:
		# Se verifica la condición de salida
		sltu $s3, $s0, $s1	# Comparación de salida
					# $s1 = 1 si $s0 < $s1
		# Salida de for_seno
		beq $s3, $0, for_seno_end

		# Inicio del código de for_seno

		# Se empieza por detectar si i del ciclo es par o
		# impar y se sigue con la serie según se requiera
		addi $s2, $0, 2		# Constante par división
		div $s0, $s2		# División
		mfhi $s2		# Se toma el módulo de la div

		# if para caso par o impar
		bne $s2, $0, if_paridad_seno_else
			addi $s2, $0, 1	# 1 para caso par
			j if_paridad_seno_end
		if_paridad_seno_else:
			addi $s2, $0, -1# -1 para caso impar
			j if_paridad_seno_end
		if_paridad_seno_end:

		# Se salva $s2 en $f6
		la $t0, varflotante
		sw $s2, 0($t0)

		# Carga n como int de memoria
		# a los regsitros fp
		lwc1 $f6, 0($t0)

		# Se convierte de int a double
		cvt.d.w $f6, $f6

		# Calcula x^(2n+1)
		add $a0, $s0, $s0	# $s0 + $s0 = 2$s0
		addi $a0, $a0, 1

		# Se descargan los valores de x de los registros de
		# punto flotante a $a1 y $a0
		# Se salvan los bits del double de a dos
		la $s2, varflotante 
		lwc1 $f0, 0($s2)
		lwc1 $f1, 4($s2)

		# Se cargan los datos en los registros $a0 y $a1
		sw $a0, 0($s2)
		sw $a1, 4($s2)

		# Se calcula x^(n)
		jal equis_a_la_ene

		# Se pasan los valores de los registros $v0 y $v1
		# a los de punto flotante
		# Se salvan los bits del double de a dos
		la $t0, varflotante 
		sw $v0, 0($t0)
		sw $v1, 4($t0)

		# Se cargan los datos de punto flontante
		# en los registros $v0 y $v1
		lwc1 $f4, 0($t0)
		lwc1 $f5, 4($t0)

		# Calcula (2n+1)!
		add $a0, $s0, $s0	# $s0 + $s0 = 2$s0
		addi $a0, $a0, 1
		jal ene_factorial

		# Se pasa el resultado de los registros normales
		# a los de punto flotante
		# Se salvan los bits del double de a dos
		la $s2, varflotante 
		sw $v0, 0($s2)
		sw $v1, 4($s2)

		# Se cargan los datos de punto flontante
		# en los registros $v0 y $v1
		lwc1 $f2, 0($s2)
		lwc1 $f3, 4($s2)

		# Obtiene el número temporal de la serie
		# en $f10
		mul.d $f10, $f6, $f4
		div.d $f10, $f10, $f2

		# Con el elemento de la serie listo,
		# se suma el resultado al valor final del seno
		add.d $f8, $f8, $f10 

		# Final de código de for_seno

		# Incremento de la variable de iteración
		addi $s0, $s0, 1	# l++
		j for_seno
	for_seno_end:

	# Si el pc llega a este punto, se tiene en $f8 el
	# valor de sen(x) calculado mediante una serie de
	# Taylor de orden n
	
	# Así, se salvan los valores en $v0 y $v1
	# Se salvan los bits del double de a dos
	la $s2, varflotante 
	swc1 $f8, 0($s2)
	swc1 $f9, 4($s2)

	# Se cargan los datos de punto flontante
	# en los registros $v0 y $v1
	lw $v0, 0($s2)
	lw $v1, 4($s2)

	# Con las operaciones de valores listas, se 
	# termina la ejecución de la función
	# Se desalojan recursos y se vuelve el PC a la
	# función que la llamó
	lw $ra, 20($sp)		# Return address
	lw $a0, 16($sp)		# int:	Número n
	lw $s0, 12($sp)		# int:	Iteración i
	lw $s1, 8($sp)		# int:	Variable de salida for
	lw $s2, 4($sp)		# int:	Variable miscelánea
	lw $s3, 0($sp)		# bool:	If salida de for
	addi $sp, $sp, 24
	jr $ra

.globl coseno
coseno: # 
	# Esta función recibe por $a0 el orden de la serie de
	# Taylor a calcular, por $a1 y $a2 los 64 bits la
	# preimagen x de la función cos(x), calcula esta
	# última, y devuelve el resultado en 64 bits por
	# $v0 y $v1
	# Recibe:
	#	$a0: Número n
	#	$a1: Primeros 32 bits de X
	#	$a2: Segundos 32 bits de X
	#	
	# Entrega:
	#	$v0: Primeros 32 bits del resultado
	#	$v1: Segundos 32 bits del resultado
	#	$f4: n!

	# Se alojan recursos para variables
	addi $sp, $sp, -24
	sw $ra, 20($sp)		# Return address
	sw $a0, 16($sp)		# int:	Número n
	sw $s0, 12($sp)		# int:	Iteración i
	sw $s1, 8($sp)		# int:	Variable de salida for
	sw $s2, 4($sp)		# int:	Variable miscelánea
	sw $s3, 0($sp)		# bool:	If salida de for

	# Se carga x de los argumentos $a1 y $a2 a $f0 y $f1
	# Se salvan los bits del double de a dos
	la $s2, varflotante 
	sw $a1, 0($s2)
	sw $a2, 4($s2)

	# Se cargan los datos de punto flontante
	lwc1 $f0, 0($s2)
	lwc1 $f1, 4($s2)

	# Se copia n+1 para calcular la constante de salida
	addi $s1, $a0, 1	# Se sale cuando se llega a n+1

	# La variable de iteración inicia en 0
	addi $s0, $0, 0

	# Se inicia el cálculo del coso en 0
	la  $s2, unoflotante
	ldc1 $f8, 0($s2)
	sub.d $f8, $f8, $f8	# $f8 = 0 = cos

	for_coseno:
		# Se verifica la condición de salida
		sltu $s3, $s0, $s1	# Comparación de salida
					# $s1 = 1 si $s0 < $s1
		# Salida de for_coseno
		beq $s3, $0, for_coseno_end

		# Inicio del código de for_coseno

		# Se empieza por detectar si i del ciclo es par o
		# impar y se sigue con la serie según se requiera
		addi $s2, $0, 2		# Constante par división
		div $s0, $s2		# División
		mfhi $s2		# Se toma el módulo de la div

		# if para caso par o impar
		bne $s2, $0, if_paridad_coseno_else
			addi $s2, $0, 1	# 1 para caso par
			j if_paridad_coseno_end
		if_paridad_coseno_else:
			addi $s2, $0, -1# -1 para caso impar
			j if_paridad_coseno_end
		if_paridad_coseno_end:

		# Se salva $s2 en $f6
		la $t0, varflotante
		sw $s2, 0($t0)

		# Carga n como int de memoria
		# a los regsitros fp
		lwc1 $f6, 0($t0)

		# Se convierte de int a double
		cvt.d.w $f6, $f6

		# Calcula x^(2n)
		add $a0, $s0, $s0	# $s0 + $s0 = 2$s0
		addi $a0, $a0, 0

		# Se descargan los valores de x de los registros de
		# punto flotante a $a1 y $a0
		# Se salvan los bits del double de a dos
		la $s2, varflotante 
		lwc1 $f0, 0($s2)
		lwc1 $f1, 4($s2)

		# Se cargan los datos en los registros $a0 y $a1
		sw $a0, 0($s2)
		sw $a1, 4($s2)

		# Se calcula x^(n)
		jal equis_a_la_ene

		# Se pasan los valores de los registros $v0 y $v1
		# a los de punto flotante
		# Se salvan los bits del double de a dos
		la $t0, varflotante 
		sw $v0, 0($t0)
		sw $v1, 4($t0)

		# Se cargan los datos de punto flontante
		# en los registros $v0 y $v1
		lwc1 $f4, 0($t0)
		lwc1 $f5, 4($t0)

		# Calcula (2n)!
		add $a0, $s0, $s0	# $s0 + $s0 = 2$s0
		addi $a0, $a0, 0
		jal ene_factorial

		# Se pasa el resultado de los registros normales
		# a los de punto flotante
		# Se salvan los bits del double de a dos
		la $s2, varflotante 
		sw $v0, 0($s2)
		sw $v1, 4($s2)

		# Se cargan los datos de punto flontante
		# en los registros $v0 y $v1
		lwc1 $f2, 0($s2)
		lwc1 $f3, 4($s2)

		# Obtiene el número temporal de la serie
		# en $f10
		mul.d $f10, $f6, $f4
		div.d $f10, $f10, $f2

		# Con el elemento de la serie listo,
		# se suma el resultado al valor final del coso
		add.d $f8, $f8, $f10 

		# Final de código de for_coseno

		# Incremento de la variable de iteración
		addi $s0, $s0, 1	# l++
		j for_coseno
	for_coseno_end:

	# Si el pc llega a este punto, se tiene en $f8 el
	# valor de cos(x) calculado mediante una serie de
	# Taylor de orden n
	
	# Así, se salvan los valores en $v0 y $v1
	# Se salvan los bits del double de a dos
	la $s2, varflotante 
	swc1 $f8, 0($s2)
	swc1 $f9, 4($s2)

	# Se cargan los datos de punto flontante
	# en los registros $v0 y $v1
	lw $v0, 0($s2)
	lw $v1, 4($s2)


	# Con las operaciones de valores listas, se 
	# termina la ejecución de la función
	# Se desalojan recursos y se vuelve el PC a la
	# función que la llamó
	lw $ra, 20($sp)		# Return address
	lw $a0, 16($sp)		# int:	Número n
	lw $s0, 12($sp)		# int:	Iteración i
	lw $s1, 8($sp)		# int:	Variable de salida for
	lw $s2, 4($sp)		# int:	Variable miscelánea
	lw $s3, 0($sp)		# bool:	If salida de for
	addi $sp, $sp, 24
	jr $ra

.globl cosechar_trigo
cosechar_trigo: # 
	# Esta función pide, un ángulo x en radianes e imprime el valor
	# de sen(x), cos(x), tan(x).
	# Se mantiene pidiendo x hasta que se recibe un número negativo
	# Recibe:
	#	Nada
	#	
	# Entrega:
	#	Nada

	# Se alojan recursos para variables
	addi $sp, $sp, -8
	sw $ra, 4($sp)		# Return address
	sw $s0, 0($sp)		# int: Variable miscelánea

	# Se imprime el mensaje que solicita el ángulo

	# Carga pedir
	la $a0, pedir
	# Imprime str en $a0
	addi $v0, $0, 4
	syscall

	# Lee double del usuario
	addi $v0, $0, 7
	syscall

	# Carga nL
	la $a0, nL
	# Imprime str en $a0
	addi $v0, $0, 4
	syscall

	# Coloca un 0 en fp para compara el valor obtenido
	sub.d $f2, $f0, $f0

	# Comparación de salida
	c.lt.d $f0, $f2

	# if para caso par o impar
	bc1t if_num_neg_else
		# Caso positivo o cero :)

		# Se asigna el límite para las series de Taylor
		# por defecto es 7 pero se podría poner cualquiera
		# que sea mayor a cero
		addi $a0, $0, 7

		# Se descargan los valores de x de los registros de
		# punto flotante a $a1 y $a0
		# Se salvan los bits del double de a dos
		la $s0, varflotante 
		swc1 $f0, 0($s0)
		swc1 $f1, 4($s0)

		# Se cargan los datos en los registros $a0 y $a1
		lw $a1, 0($s0)
		lw $a2, 4($s0)

		# Se calcula el seno de x
		jal seno

		# Se salvan los datos obtenidos en $f14 y $f15
		# Se salvan los bits del double de a dos
		la $s0, varflotante 
		sw $v0, 0($s0)
		sw $v1, 4($s0)

		# Se cargan los datos de punto flontante
		# en los registros $v0 y $v1
		lwc1 $f14, 0($s0)
		lwc1 $f15, 4($s0)

		# Se calcula el coseno de x
		jal coseno

		# Se salvan los datos obtenidos en $f16 y $f17
		# Se salvan los bits del double de a dos
		la $s0, varflotante 
		sw $v0, 0($s0)
		sw $v1, 4($s0)

		# Se cargan los datos de punto flontante
		# en los registros $v0 y $v1
		lwc1 $f16, 0($s0)
		lwc1 $f17, 4($s0)

		# Finalmente, se calcula la tangente como
		# la división entre el seno y el coseno
		div.d $f18, $f14, $f16



		# Con los valores listos, se imprimen los
		# resultados y se vuelve a empezar

		# Carga sen
		la $a0, sen
		# Imprime str en $a0	
		addi $v0, $0, 4
		syscall

		# Imprime X en $f0
		addi $v0, $0, 3
		sub.d $f12, $f12, $f12	# Se coloca un 0 en $f12
		add.d $f12, $f0, $f12	# Se copia el valor al registro
					# del que se imprime
		syscall

		# Carga final
		la $a0, final
		# Imprime str en $a0	
		addi $v0, $0, 4
		syscall

		# Imprime double en $f12
		addi $v0, $0, 3
		sub.d $f12, $f2, $f2	# Se coloca un 0 en $f12
		add.d $f12, $f14, $f12	# Se copia el valor al registro
					# del que se imprime
		syscall

		# Carga nL
		la $a0, nL
		# Imprime str en $a0	
		addi $v0, $0, 4
		syscall

		# Carga cos
		la $a0, cos
		# Imprime str en $a0	
		addi $v0, $0, 4
		syscall
		
		# Imprime X en $f0
		addi $v0, $0, 3
		sub.d $f12, $f12, $f12	# Se coloca un 0 en $f12
		add.d $f12, $f0, $f12	# Se copia el valor al registro
					# del que se imprime
		syscall

		# Carga final
		la $a0, final
		# Imprime str en $a0	
		addi $v0, $0, 4
		syscall

		# Imprime double en $f12
		addi $v0, $0, 3
		sub.d $f12, $f12, $f12	# Se coloca un 0 en $f12
		add.d $f12, $f16, $f12	# Se copia el valor al registro
					# del que se imprime
		syscall

		# Carga nL
		la $a0, nL
		# Imprime str en $a0	
		addi $v0, $0, 4
		syscall

		# Carga tan
		la $a0, tan
		# Imprime str en $a0	
		addi $v0, $0, 4
		syscall
		
		# Imprime X en $f0
		addi $v0, $0, 3
		sub.d $f12, $f12, $f12	# Se coloca un 0 en $f12
		add.d $f12, $f0, $f12	# Se copia el valor al registro
					# del que se imprime
		syscall

		# Carga final
		la $a0, final
		# Imprime str en $a0	
		addi $v0, $0, 4
		syscall

		# Imprime double en $f12
		addi $v0, $0, 3
		sub.d $f12, $f12, $f12	# Se coloca un 0 en $f12
		add.d $f12, $f18, $f12	# Se copia el valor al registro
					# del que se imprime
		syscall

		# Carga nL
		la $a0, nL
		# Imprime str en $a0	
		addi $v0, $0, 4
		syscall

		# Carga nL
		la $a0, nL
		# Imprime str en $a0	
		addi $v0, $0, 4
		syscall
		

		# Una vez impresos los datos,
		# vuelve a ejecutarse
		jal cosechar_trigo		


		j if_num_neg_end
	if_num_neg_else:
		# Caso negativo ;v, el programa se acaba :(

		# Carga ellol
		la $a0, ellol
		# Imprime str en $a0
		addi $v0, $0, 4
		syscall

		j if_num_neg_end
	if_num_neg_end:

	# Si el pc llega aquí, ya no hay nada que
	# hacer y se termina la función
	
	# Se alojan recursos para variables
	lw $ra, 4($sp)		# Return address
	lw $a0, 0($sp)		# int: Variable miscelánea
	addi $sp, $sp, 8
	jr $ra

