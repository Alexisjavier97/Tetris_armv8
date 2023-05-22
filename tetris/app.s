.equ SCREEN_WIDTH,   640
.equ SCREEN_HEIGH,   480
.equ BITS_PER_PIXEL, 32

.equ GPIO_BASE,    0x3f200000
.equ GPIO_GPFSEL0, 0x00
.equ GPIO_GPLEV0,  0x34

.globl main

//SECCION COLORES 

//Bloque Verde 

color_bloque_verde: .word  0x6abe30
color_bordea_al_bloque_verde: .word 0x37946e
color_adentro_del_bloque_verde: .word 0xa0e570
 
//Bloque Amarillo

color_bloque_amarillo: .word 0xfbf236
color_bordea_al_bloque_amarillo: .word 0xaba62a
color_adentro_del_bloque_amarillo: .word 0xfffcbc

//Bloque Rojo

color_bloque_rojo: .word 0xd95763
color_bordea_al_bloque_rojo: .word 0xac3232
color_adentro_del_bloque_rojo: .word 0xe07e87

//Bloque Celeste

color_bloque_celeste: .word 0x639bff
color_bordea_al_celeste: .word 0x5b6ee1
color_adentro_del_bloque_celeste: .word 0x85abed

//Bloque Violeta

color_bloque_violeta: .word 0x76428a 
color_bordea_al_bloque_violeta: .word 0x3f3f74
color_adentro_del_bloque_violeta: .word 0xc487dc


//Colores de fondo

color_rosa_fondo:  .word 0xfffbf2

cuadrado_fondo_violeta: .word 0xba9dc9
cuadrado_fondo_celeste: .word 0x66caec
circulo_fondo_verde:.word 0xa7d278
circulo_fondo_rojo: .word 0xe55d47
triangulo_fondo_amarillo: .word 0xfbbb3a
triangulo_fondo_rosa: .word 0xf9a0a6
color_sombra_oscura: .word 0x1c1a18
color_escaleritas: .word 0xe8b942


/*
pintar_mini_cuadrados_celestes:
		
		ldur x10,cuadrado_fondo_celeste
		//posicion x
		//posicion y

		bl pintar_cuadrado
		br lr 

pintar_mini_cuadrados_violetas :
		
		ldur x10,cuadrado_fondo_violeta
		//posicion x
		//posicion y

		bl pintar_cuadrado
		br lr 


pintar_mini_circulos_rojos:
		
		ldur x10,circulo_fondo_rojo
		bl pintar_circulo
		br lr 


pintar_mini_circulos_verdes:
		
		ldr x10,circulo_fondo_verde
		bl pintar_circulo
		br lr 

pintar_mini_triangulos_rosados:

		ldr x10,triangulo_fondo_rosa

		bl pintar_triangulo
		br lr 

pintar_mini_triangulos_amarillos:

		ldr x10,triangulo_fondo_amarillo
		bl pintar_triangulo

		br lr 
*/
ubicar_pixel:

	   	
	   mul x9,x2,x4 // =640*y
	   
	   add x9,x9,x1 //x+[640*y]
	   lsl x9,x9,#2  // 4*[x + (y * 640)     
	   add x9,x9,x0 // x0 + 4*[x + (y * 640)]		
	   br lr 


pintar_cuadrado :

		mov x5,x4         // Y Size
	loop1:
		mov x6,x3         // X Size
	loop0:
		
		stur w10,[x9]  // Colorear el pixel N
		add x9,x9,4    // Siguiente pixel
		sub x6,x6,1    // Decrementar contador X
		cbnz x6,loop0  // Si no terminó la fila, salto
		sub x5,x5,1    // Decrementar contador Y
		cbnz x5,loop1  // Si no termino la columna,salto 

		br lr 

pintar_mini_cuadrados_celestes:
		
		ldr x10,cuadrado_fondo_celeste
		mov x1,150 //posicion x
		mov x2,150 //posicion y
		mov x3,75 //ancho x
		mov x4,75 //altura y

		bl ubicar_pixel //devuelve el pixel desde donde comenzar a pintar

		bl pintar_cuadrado
		br lr 

color_fondo:
		
		ldr x10,color_rosa_fondo
		mov x1,0 //posicion x
		mov x2,0 //posicion y
		mov x3,SCREEN_WIDTH //ancho x
		mov x4,SCREEN_HEIGH //altura y

		bl ubicar_pixel //devuelve el pixel desde donde comenzar a pintar

		bl pintar_cuadrado
		br lr


pintar_fondo:
		
		bl color_fondo
		//bl pintar_mini_cuadrados_celestes
		
		
		/*bl pintar_mini_cuadrados_violetas
		bl pintar_mini_circulos_verdes
		bl pintar_mini_circulos_rojos
		bl pintar_mini_triangulos_rosados
		bl pintar_mini_triangulos_amarillos
		*/
		br lr 


tetris:

	br lr 

main:
	// x0 contiene la direccion base del framebuffer
	//mov x20, x0 // Guarda la dirección base del framebuffer en x20
	
	bl pintar_fondo //se hace la llamada para pintar el fondo de la escenografia
	//bl tetris se pinta el tetris


	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

	// Lee el estado de los GPIO 0 - 31
	ldr w10, [x9, GPIO_GPLEV0]

	// And bit a bit mantiene el resultado del bit 2 en w10 (notar 0b... es binario)
	// al inmediato se lo refiere como "máscara" en este caso:
	// - Al hacer AND revela el estado del bit 2
	// - Al hacer OR "setea" el bit 2 en 1
	// - Al hacer AND con el complemento "limpia" el bit 2 (setea el bit 2 en 0)
	and w11, w10, 0b00000010

	// si w11 es 0 entonces el GPIO 1 estaba liberado
	// de lo contrario será distinto de 0, (en este caso particular 2)
	// significando que el GPIO 1 fue presionado

	//---------------------------------------------------------------
	// Infinite Loop






	
	

InfLoop:
	b InfLoop
