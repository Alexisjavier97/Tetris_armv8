.equ SCREEN_WIDTH,   640
.equ SCREEN_HEIGH,   480
.equ BITS_PER_PIXEL, 32

.equ GPIO_BASE,    0x3f200000
.equ GPIO_GPFSEL0, 0x00
.equ GPIO_GPLEV0,  0x34

.globl main

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




pintar:

	sub sp,sp,#8
	str lr,[sp]


		mov x5,x8         // Y Size
	loop1:
		mov x6,x7         // X Size
	loop0:	
		stur w10,[x9]       // Set color of pixel N
		add x9,x9,4       // Next pixel
	    sub x6,x6,1       // decrement X counter
	    cbnz x6,loop0      // If not end row jump
	    sub x5,x5,1       // Decrement Y counter
	    add x9,x9,#2560
	    lsl x13,x7,2
	    sub x9,x9,x13
	    cbnz x5,loop1      // if not last row, jump	
	
	ldr lr,[sp]
	add sp,sp,#8


	br lr


pintar_cuadrado:

		sub sp,sp,#8
		str lr,[sp]
	
		bl pintar
		
		ldr lr,[sp]
		add sp,sp,#8
		br lr	




pintar_rectangulo:
		
		sub sp,sp,#8
		str lr,[sp]

		bl pintar

		ldr lr,[sp]
		add sp,sp,#8
		br lr



ubicar_pixel : 
		
		sub sp,sp,#8
		str lr,[sp]

		
		mov x3,SCREEN_WIDTH // valor de 640
		mul x4,x3,x2 	//x4 = 640*y
		add x4,x4,x1 // x4 = x +(640*y)
			   
		lsl x4,x4,2   // 4*(x+(640*y))

		add x9,x0,x4	//direccion del pixel [x,y]		   	
	
		ldr lr,[sp]
		add sp,sp,#8
		br lr

pintar_linea_vertical:
		
		sub sp,sp,#8
		str lr,[sp]

		bl pintar

		ldr lr,[sp]
		add sp,sp,#8
		br lr

pintar_linea_horizontal:
		
		sub sp,sp,#8
		str lr,[sp]

		bl pintar

		ldr lr,[sp]
		add sp,sp,#8
		br lr

pintar_bordes_amarillos:

	sub sp,sp,#8
	str lr,[sp]

	ldr x10,color_bordea_al_bloque_amarillo

	//linea horizontal del bloque
		mov x1,91     //posicion x del pixel N
		mov x2,417  //posicion y del pixel N
		bl ubicar_pixel

		mov x7,182 // ancho del borde
		mov x8,6 // largo del borde
		bl pintar_linea_horizontal

		ldr lr,[sp]
		add sp,sp,#8



	br lr

pintar_bordes_verdes:
		
		sub sp,sp,#8
		str lr,[sp]

		ldr x10,color_bordea_al_bloque_verde
		
		//linea vertical izq
		mov x1,0     //posicion x del pixel N
		mov x2,240  //posicion y del pixel N
		bl ubicar_pixel

		mov x7,3 // ancho del borde
		mov x8,240 // largo del borde
		bl pintar_linea_vertical

		//linea horizontal superior
		mov x1,0     //posicion x del pixel N
		mov x2,240  //posicion y del pixel N
		bl ubicar_pixel

		mov x7,91 // ancho del borde
		mov x8,3 // largo del borde
		bl pintar_linea_horizontal

		//linea vertical der
		mov x1,88   //posicion x del pixel N
		mov x2,240  //posicion y del pixel N
		bl ubicar_pixel

		mov x7,3 // ancho del borde
		mov x8,240 // largo del borde
		bl pintar_linea_vertical


		//linea horizontal  del bloque 
		mov x1,0     //posicion x del pixel N
		mov x2,297  //posicion y del pixel N
		bl ubicar_pixel

		mov x7,91 // ancho del borde
		mov x8,6 // largo del borde
		bl pintar_linea_horizontal

		//linea horizontal  del bloque
		mov x1,0     //posicion x del pixel N
		mov x2,357  //posicion y del pixel N
		bl ubicar_pixel

		mov x7,91 // ancho del borde
		mov x8,6 // largo del borde
		bl pintar_linea_horizontal

		//linea horizontal del bloque
		mov x1,0     //posicion x del pixel N
		mov x2,417  //posicion y del pixel N
		bl ubicar_pixel

		mov x7,91 // ancho del borde
		mov x8,6 // largo del borde
		bl pintar_linea_horizontal

		ldr lr,[sp]
		add sp,sp,#8
		br lr

/*
	//Este procedimiento pinta los cuatro circulitos verdes que estan al fondo de la pantalla

pintar_mini_circulitos_verdes:
		
		ldr x10,circulo_fondo_verde // cargo el color verde

		//primer circulito de la primera fila verde 
		mov x1,50 //posicion x del pixel  N 
		mov x2,100 //posicion y del pixel  N

		bl ubicar_pixel 
		bl pintar_circulito

		//segundo circulito de la primera fila verde 
		//se utiliza el mismo valor de altura x2
		mov x1,400 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_circulito

		//primer circulito de la segunda fila verde
		mov x1,50 //posicion x del pixel  N 
		mov x2,300//posicion y del pixel  N
		
		bl ubicar_pixel
		bl pintar_circulito

		//segundo circulito de la segunda fila verde
		//se utiliza el mismo valor de altura x2
		mov x1,400 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_circulito

		br lr 

	//Este procedimiento pinta los cuatro circulitos rojos que estan al fondo de la pantalla

pintar_mini_circulitos_rojos:
		
		ldr x10,circulo_fondo_rojo // cargo el color rojo

		//primer circulito de la primera fila roja 
		mov x1,50 //posicion x del pixel  N 
		mov x2,100 //posicion y del pixel  N

		bl ubicar_pixel 
		bl pintar_circulito

		//segundo circulito de la primera fila roja 
		//se utiliza el mismo valor de altura x2
		mov x1,400 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_circulito

		//primer circulito de la segunda fila roja
		mov x1,50 //posicion x del pixel  N 
		mov x2,300//posicion y del pixel  N
		
		bl ubicar_pixel
		bl pintar_circulito

		//segundo circulito de la segunda fila roja
		//se utiliza el mismo valor de altura x2
		mov x1,400 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_circulito

		br lr 

	//Este procedimiento pinta los cuatro triangulitos amarillos que estan al fondo de la pantalla

pintar_mini_triangulitos_amarillos:
		
		ldr x10,triangulo_fondo_amarillo // cargo el color amarillo

		//primer triangulito de la primera fila amarillo 
		mov x1,50 //posicion x del pixel  N 
		mov x2,100 //posicion y del pixel  N

		bl ubicar_pixel 
		bl pintar_triangulo

		//segundo triangulito de la primera fila amarillo
		//se utiliza el mismo valor de altura x2
		mov x1,400 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_triangulo

		//primer triangulito de la segunda fila amarillo
		mov x1,50 //posicion x del pixel  N 
		mov x2,300//posicion y del pixel  N
		
		bl ubicar_pixel
		bl pintar_triangulo

		//segundo triangulito de la segunda fila amarillo
		//se utiliza el mismo valor de altura x2
		mov x1,400 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_triangulo

		br lr 


	//Este procedimiento pinta los cuatro triangulitos rosados que estan al fondo de la pantalla


pintar_mini_triangulitos_rosados:
	
		ldr x10,triangulo_fondo_rosa // cargo el color rosa

		//primer triangulito de la primera fila rosa 
		mov x1,50 //posicion x del pixel  N 
		mov x2,100 //posicion y del pixel  N

		bl ubicar_pixel 
		bl pintar_triangulo

		//segundo triangulito de la primera fila rosa 
		//se utiliza el mismo valor de altura x2
		mov x1,400 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_triangulo

		//primer triangulito de la segunda fila rosa
		mov x1,50 //posicion x del pixel  N 
		mov x2,300//posicion y del pixel  N
		
		bl ubicar_pixel
		bl pintar_triangulo

		//segundo triangulito de la segunda fila rosa
		//se utiliza el mismo valor de altura x2
		mov x1,400 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_triangulo

		br lr 


	//Este procedimiento pinta los cuatro cuadraditos violetas que estan al fondo de la pantalla
*/
pintar_mini_cuadrados_violetas:
		
		sub sp,sp,#8
		str lr,[sp]


		ldr x10,cuadrado_fondo_violeta // cargo el color Violeta

		//primer cuadradito de la primera fila violeta 
		mov x1,50 //posicion x del pixel  N 
		mov x2,190 //posicion y del pixel  N

		bl ubicar_pixel 
		bl pintar_cuadrado


		//segundo cuadradito de la primera fila violeta 
		//se utiliza el mismo valor de altura x2
		mov x1,420 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_cuadrado


		//primer cuadradito de la segunda fila violeta
		mov x1,50 //posicion x del pixel  N 
		mov x2,430 //posicion y del pixel  N
		
		bl ubicar_pixel
		bl pintar_cuadrado

		//segundo cuadradito de fila uno
		//se utiliza el mismo valor de altura x2
		mov x1,420 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_cuadrado

		ldr lr,[sp]
		add sp,sp,#8

		br lr 




	//Este procedimiento pinta los cuatro cuadraditos celestes que estan al fondo de la pantalla


pintar_mini_cuadrados_celestes:
		
		sub sp,sp,#8
		str lr,[sp]



		ldr x10,cuadrado_fondo_celeste// cargo el color celeste

		//primer cuadradito de fila uno
		mov x1,30 //posicion x del pixel  N 
		mov x2,65 //posicion y del pixel  N

		bl ubicar_pixel 

		bl pintar_cuadrado
		
		//segundo cuadradito de fila uno
		//se utiliza el mismo valor de altura x2
		mov x1,400 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_cuadrado


		//primer cuadradito de fila dos
		mov x1,30 //posicion x del pixel  N 
		mov x2,300//posicion y del pixel  N
		
		bl ubicar_pixel
		bl pintar_cuadrado

		//segundo cuadradito de fila uno
		//se utiliza el mismo valor de altura x2
		mov x1,400 //posicion x del pixel  N 
		
		bl ubicar_pixel 
		bl pintar_cuadrado

		ldr lr,[sp]
		add sp,sp,#8

		br lr 

color_fondo:
		
		sub sp,sp,#8
		str lr,[sp]

		ldr x10,color_rosa_fondo

		mov x1,0
		mov x2,0

		bl ubicar_pixel

		mov x7,SCREEN_WIDTH //contiene el ancho en x del cuadrado
		mov x8,SCREEN_HEIGH //contiene el ancho en y del cuadrado

		bl pintar_cuadrado


		ldr lr,[sp]
		add sp,sp,#8

		br lr


pintar_figuras_de_fondo:

		sub sp,sp,#8
		str lr,[sp]

		bl color_fondo

		mov x7,35
		mov x8,35


		bl pintar_mini_cuadrados_celestes	
		bl pintar_mini_cuadrados_violetas
		//bl pintar_mini_triangulitos_rosados
		//bl pintar_mini_triangulitos_amarillos
		//bl pintar_mini_circulos_rojos
		//bl pintar_mini_circulos_verdes

		ldr lr,[sp]
		add sp,sp,#8

		br lr



pintar_bloques_celestes:
		
		sub sp,sp,#8
		str lr,[sp]

		ldr x10,color_bloque_celeste

		mov x1,364  //posicion x del pixel N
		mov x2,420  //posicion y del pixel N

		bl ubicar_pixel

		mov x7,276  //contiene el ancho en x del cuadrado
		mov x8,60  //contiene el alto en y del cuadrado
		
		bl pintar_cuadrado


		bl pintar

		ldr lr,[sp]
		add sp,sp,#8


		br lr


pintar_bloques_rojos:
		
		sub sp,sp,#8
		str lr,[sp]

		ldr x10,color_bloque_rojo

		//pinto el primer rectangulo rojo
		mov x1,91  //posicion x del pixel N
		mov x2,180  //posicion y del pixel N

		bl ubicar_pixel
		
		mov x7,91   //contiene el ancho en x del cuadrado
		mov x8,120  //contiene el alto en y del cuadrado
		

		bl pintar_cuadrado

		//pinto el segundo rectangulo rojo
		mov x1,182  //posicion x del pixel N
		mov x2,120  //posicion y del pixel N

		bl ubicar_pixel
		
		mov x7,91   //contiene el ancho en x del cuadrado
		mov x8,120  //contiene el alto en y del cuadrado
		

		bl pintar_cuadrado
		
		//pinto el tercer rectangulo rojo
		mov x1,273  //posicion x del pixel N
		mov x2,360  //posicion y del pixel N

		bl ubicar_pixel
		
		mov x7,91   //contiene el ancho en x del cuadrado
		mov x8,120  //contiene el alto en y del cuadrado
		

		bl pintar_cuadrado
			
		//pinto el cuarto rectangulo rojo
		mov x1,364  //posicion x del pixel N
		mov x2,300  //posicion y del pixel N

		bl ubicar_pixel
		
		mov x7,91   //contiene el ancho en x del cuadrado
		mov x8,120  //contiene el alto en y del cuadrado
		

		bl pintar_cuadrado

		ldr lr,[sp]
		add sp,sp,#8

		br lr


pintar_bloques_violetas:
		
		sub sp,sp,#8
		str lr,[sp]

		ldr x10,color_bloque_violeta

		//pinto el rectangulo violeta
		mov x1,91  //posicion x del pixel N
		mov x2,300  //posicion y del pixel N

		bl ubicar_pixel

		mov x7,273   //contiene el ancho en x del cuadrado
		mov x8,60  //contiene el alto en y del cuadrado
		
		
		bl pintar_cuadrado

		//pinto el cuadrado violeta
		mov x1,182  //posicion x del pixel N
		mov x2,240  //posicion y del pixel N

		bl ubicar_pixel

		mov x7,91   //contiene el ancho en x del cuadrado
		mov x8,60  //contiene el alto en y del cuadrado

		bl pintar_cuadrado

		//pinto el rectangulo violeta

		mov x1,455  //posicion x del pixel N
		mov x2,240  //posicion y del pixel N

		bl ubicar_pixel

		mov x7,91   //contiene el ancho en x del cuadrado
		mov x8,180  //contiene el alto en y del cuadrado

		bl pintar_cuadrado


		//pinto cuadrado violeta

		mov x1,546  //posicion x del pixel N
		mov x2,360  //posicion y del pixel N

		bl ubicar_pixel

		mov x7,94   //contiene el ancho en x del cuadrado
		mov x8,60  //contiene el alto en y del cuadrado

		bl pintar_cuadrado


		ldr lr,[sp]
		add sp,sp,#8

		br lr

pintar_bloques_amarillos:
		
		sub sp,sp,#8
		str lr,[sp]

		ldr x10,color_bloque_amarillo

		//pinto el primer cuadrado amarillo
		mov x1,91  //posicion x del pixel N
		mov x2,360  //posicion y del pixel N

		bl ubicar_pixel

		mov x7,182   //contiene el ancho en x del cuadrado
		mov x8,120  //contiene el alto en y del cuadrado
		
		
		bl pintar_cuadrado

		//pinto el segundo cuadrado amarillo
		mov x1,273  //posicion x del pixel N
		mov x2,180  //posicion y del pixel N

		bl ubicar_pixel

		mov x7,182  //contiene el ancho en x del cuadrado
		mov x8,120  //contiene el alto en y del cuadrado

		bl pintar_cuadrado

		//bl pintar_bordes_amarillos


		ldr lr,[sp]
		add sp,sp,#8

		br lr

pintar_bloques_verdes:

		sub sp,sp,#8
		str lr,[sp]

		ldr x10,color_bloque_verde
		
		mov x1,0     //posicion x del pixel N
		mov x2,240  //posicion y del pixel N

		bl ubicar_pixel

		mov x7,37   //contiene el ancho en x del rectangulo
		mov x8,240	//contiene el alto en y del  rectangulo

		bl pintar_rectangulo

		//bl pintar_bordes_verdes

		ldr lr,[sp]
		add sp,sp,#8

		br lr	

		

pintar_tetris:
		
		bl pintar_bloques_verdes
		bl pintar_bloques_amarillos
		bl pintar_bloques_violetas
		bl pintar_bloques_rojos
		bl pintar_bloques_celestes
	 	ret
main:
	
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	bl pintar_figuras_de_fondo
	bl pintar_tetris
	bl pintar_bloques_verdes


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
