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


color_de_fondo_superior: .word 0x306082
color_cuadrado_pequeno_fondo_sup: .word 0x323c39

color_cuadrado_pequeno_fondo_inf: .word 0x306082
color_de_fondo_inferior: .word 0x323c39





//pintar_triangulo:
//		br lr




pintar_rectangulo:

		
		mov x2, x3        // Y Size
	loop1:
		mov x1, x4         // X Size
	loop0:
		stur w10,[x0]  // Colorear el pixel N
		add x0,x0,4    // Siguiente pixel
		sub x1,x1,1    // Decrementar contador X
		cbnz x1,loop0  // Si no terminó la fila, salto
		sub x2,x2,1    // Decrementar contador Y
		cbnz x2,loop1  // Si no es la última fila, salto

		br lr 


pintarfondo:

		ldr x10, color_de_fondo_superior
		mov x3,160
		mov x4,640
		bl pintar_rectangulo
		br lr 

pintartetris:

		bl pintarfondo

		br lr 




main:
	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	
	bl pintartetris

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
