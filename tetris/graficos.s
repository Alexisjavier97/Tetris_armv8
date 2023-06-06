.include "datos.s" 

pintar_cielo_noche:

	sub sp,sp,#8
	str lr,[sp]

	ldr x10,color_cielo_noche_1

	mov x1,0                // posicion x inicial del pixel
	mov x2,0		       // posicion y inicial del pixel
	mov x3,SCREEN_WIDTH   //posicion x final del pixel
	mov x4,20           // posicion y final del pixel

	bl ubicar_pixel
	bl pintar_rectangulo


	ldr x10,color_cielo_noche_2
	mov x2,21		       // posicion y inicial del pixel
	mov x4,41           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo

	ldr x10,color_cielo_noche_3
	mov x2,42		       // posicion y inicial del pixel
	mov x4,62           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo

	ldr x10,color_cielo_noche_4
	mov x2,63		       // posicion y inicial del pixel
	mov x4,83           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo

	ldr x10,color_cielo_noche_5
	mov x2,84		       // posicion y inicial del pixel
	mov x4,104           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo

	ldr x10,color_cielo_noche_6
	mov x2,105		       // posicion y inicial del pixel
	mov x4,125           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo


	ldr x10,color_cielo_noche_7
	mov x2,126		       // posicion y inicial del pixel
	mov x4,146           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_noche_8
	mov x2,147		       // posicion y inicial del pixel
	mov x4,167           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_noche_9
	mov x2,168		       // posicion y inicial del pixel
	mov x4,188           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_noche_10
	mov x2,189		       // posicion y inicial del pixel
	mov x4,209           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_noche_11
	mov x2,210		       // posicion y inicial del pixel
	mov x4,230           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo

	ldr x10,color_cielo_noche_12
	mov x2,231		       // posicion y inicial del pixel
	mov x4,251           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo


	ldr x10,color_cielo_noche_13
	mov x2,252		       // posicion y inicial del pixel
	mov x4,272           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_noche_14
	mov x2,273		       // posicion y inicial del pixel
	mov x4,314           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo


	ldr x10,color_cielo_noche_15
	mov x2,315		       // posicion y inicial del pixel
	mov x4,335           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	

	ldr x10,color_cielo_noche_16
	mov x2,336		       // posicion y inicial del pixel
	mov x4,356           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	

	ldr x10,color_cielo_noche_17
	mov x2,357		       // posicion y inicial del pixel
	mov x4,377           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_noche_18
	mov x2,378		       // posicion y inicial del pixel
	mov x4,389           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	
	ldr lr,[sp]
	add sp,sp,#8

	br lr


pintar_un_pixel:

	str w10, [x0, x5]		

	br lr

pintarLineaVertical:
		sub sp, sp, #16 // Guardo el puntero de retorno en el stack
        stur lr, [sp, #8]
        stur x2, [sp] // Guardo en el stack la coordenada en y del comienzo de la linea 

    loop_pintarLineaVertical:
        cmp x2, x4
        b.lt end_loop_pintarLineaVertical
        bl pintar_un_pixel
        sub x2,x2,#1
        bl ubicar_pixel;
        b loop_pintarLineaVertical

    end_loop_pintarLineaVertical:
        ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
        ldur x2,[sp] // Recupero la coordenada en x del comienzo de la linea
        add sp, sp, #16 

        br lr // return



pintar_triangulo_rectangulo:

	sub sp,sp,#8
	str lr,[sp]

    loop_triangulo_rectangulo: // loop para avanzar en y
		cmp x1,x3
       	b.lt end_loop_pintarTriangulo_rectangulo
       
       	add x11,xzr,xzr //inicializo x11 en cero
       	
       	loop_t_rec: 
			cmp x11,x13
			b.gt nueva_seccion_triangulo_rectangulo
				
			bl pintarLineaVertical	
			
			add x11,x11,#1
			sub x1,x1,#1 //decremento x_i inicial
       		bl ubicar_pixel

		b loop_t_rec 	

        nueva_seccion_triangulo_rectangulo:
			
        	sub x2,x2,#1
        	b loop_triangulo_rectangulo        

		b loop_triangulo_rectangulo

	end_loop_pintarTriangulo_rectangulo:
		ldr lr,[sp]
		add sp,sp,#8

        br lr

pintarLineaHorizontal:
        sub sp, sp, #16 // Guardo el puntero de retorno en el stack
        stur lr, [sp, #8]
        stur x1, [sp] // Guardo en el stack la coordenada en x del comienzo de la linea 

    loop_pintarLineaHorizontal:
        cmp x1, x3
        b.gt end_loop_pintarLineaHorizontal
        bl pintar_un_pixel
        add x1, x1, #1
        bl ubicar_pixel;
        b loop_pintarLineaHorizontal

    end_loop_pintarLineaHorizontal:
        ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
        ldur x1, [sp] // Recupero la coordenada en x del comienzo de la linea
        add sp, sp, #16 

        br lr 



pintar_triangulo:

	sub sp,sp,#8
	str lr,[sp]

    loop_pintarTriangulo: // loop para avanzar en y
        cmp x2,x4
       	b.lt end_loop_pintarTriangulo

		add x11,xzr,xzr //inicializo x11 en cero
       	loop: 
			cmp x11,x13
			b.gt nueva_seccion_triangulo
			bl pintarLineaHorizontal	
			add x11,x11,#1
			sub x2,x2,#1 //decremento y_i inicial
        	bl ubicar_pixel
		b loop

		nueva_seccion_triangulo:
			add x1,x1,x14 // recupero x1 y aumento 1
        	sub x3,x3,x14 //decremento x1_f final
    		b loop_pintarTriangulo        

        b loop_pintarTriangulo
    
    end_loop_pintarTriangulo:

	    ldr lr,[sp]
		add sp,sp,#8

        br lr 

pintar_piramides:

		sub sp,sp,#8
		str lr,[sp]
		
		ldr x10,color_piramide_cara_frente

		//triangulo de la derecha al fondo
		mov x1,480               // posicion x inicial del pixel
		mov x2,350		       // posicion y inicial del pixel
		mov x3,640		      //posicion x final del pixel
		mov x4,110           // posicion y final del pixel
		mov x13,#2			//indica la cantidad de veces que que pinta una seccion del triangulo
		mov x14,#1        //indica cuanto pixeles se debe achicar de los lados al triangulo cada fila
		bl ubicar_pixel
		bl pintar_triangulo

		//bl pintar_relieve

		//triangulo de la izquierda al fondo
		mov x1,300               // posicion x inicial del pixel
		mov x2,350		       // posicion y inicial del pixel
		mov x3,460		      //posicion x final del pixel
		mov x4,100           // posicion y final del pixel
		mov x13,#1			//indica la cantidad de veces que que pinta una seccion del triangulo

		bl ubicar_pixel
		bl pintar_triangulo



		//sombra piramide izquierda

		ldr x10,color_sombra_en_suelo

        mov x1,460              // posicion x inicial del pixel
        mov x2,430             // posicion y inicial del pixel
        mov x3,300            //posicion x final del pixel
        mov x4,350           // posicion y final del pixel

        bl ubicar_pixel
        bl pintar_triangulo_rectangulo
       // bl pintar_relieve_piramide




        //sombra piramide derecha

		ldr x10,color_sombra_en_suelo

        mov x1,640              // posicion x inicial del pixel
        mov x2,440            // posicion y inicial del pixel
        mov x3,480            //posicion x final del pixel
        mov x4,350           // posicion y final del pixel
        mov x13,#1
        bl ubicar_pixel
        bl pintar_triangulo_rectangulo

		ldr lr,[sp]
		add sp,sp,#8
        br lr 


pintarCirculo:
        sub sp, sp, #8 // Guardo el puntero de retorno en el stack
        str lr, [sp]

        mov x15, x2 // Guardo en x15 la condenada del centro en x
        mov x16, x3 // Guardo en x16 la condenada del centro en y
        add x17, x2, x4 // Guardo en x17 la posición final en x
        add x11, x3, x4 // Guardo en x11 la posición final en y
        mul x12, x4, x4 // x12 = r^2 // para comparaciones en el loop
        sub x2, x2, x4 // Pongo en x2 la posición inicial en x

    loop0_pintarCirculo: // loop para avanzar en x
        cmp x2, x17
        b.gt end_loop0_pintarCirculo
        sub x3, x11, x4
        sub x3, x3, x4 // Pongo en x3 la posición inicial en y

    loop1_pintarCirculo: // loop para avanzar en y
        cmp x3, x11
        b.gt end_loop1_pintarCirculo // Veo si tengo que pintar el pixel actual
        sub x13, x2, x15 // x13 = distancia en x desde el pixel actual al centro
        smull x13, w13, w13 // x13 = w13 * w13 // Si los valores iniciales estaban en el rango permitido, x13 = w13 (sumll es producto signado)
        sub x14, x3, x16 // x14 = distancia en y desde el pixel actual al centro
        smaddl x13, w14, w14, x13 // x13 = x14*x14 + x13 // x13 = cuadrado de la distancia entre el centro y el pixel actual
        cmp x13, x12
        b.gt fi_pintarCirculo 
        bl pintar_un_pixel // Pinto el pixel actual

    fi_pintarCirculo:
        add x3, x3, #1
        b loop1_pintarCirculo

    end_loop1_pintarCirculo:
        add x2, x2, #1
        b loop0_pintarCirculo

    end_loop0_pintarCirculo:
        mov x2, x15 // Restauro en x2 la condenada del centro en x
        mov x3, x16 // Restauro en x3 la condenada del centro en y
        ldr lr, [sp] // Recupero el puntero de retorno del stack
        add sp, sp, #8 

        br lr // return


pintar_sol:
	
	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    str lr, [sp]

	ldr x10,color_del_sol
	mov x2,110
	mov x3,30
	mov x4,20	
	
	bl pintarCirculo

	ldr lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr // return


pintar_rectangulo:
		
		sub sp,sp,#8
		str lr,[sp]
		
	
    loop_pintarRectangulo: 
        cmp x2, x4
        b.gt end_loop_pintarRectangulo
        bl pintarLineaHorizontal
        add x2, x2, #1
        bl ubicar_pixel
        b loop_pintarRectangulo
    
    end_loop_pintarRectangulo:

	    ldr lr,[sp]
		add sp,sp,#8

        br lr 

ubicar_pixel : 
		
		sub sp,sp,#8
		str lr,[sp]
		
		mov x5,SCREEN_WIDTH //cargo el valor de 640 
		madd x5, x5,x2,x1 //x5 =(x5*y) + x 
		lsl x5,x5,2   // 4*(x+(640*y))

		ldr lr,[sp]
		add sp,sp,#8
		br lr

pintar_cielo_dia:

	sub sp,sp,#8
	str lr,[sp]

	ldr x10,color_cielo_dia_1

	mov x1,0                // posicion x inicial del pixel
	mov x2,0		       // posicion y inicial del pixel
	mov x3,SCREEN_WIDTH   //posicion x final del pixel
	mov x4,20           // posicion y final del pixel

	bl ubicar_pixel
	bl pintar_rectangulo


	ldr x10,color_cielo_dia_2
	mov x2,21		       // posicion y inicial del pixel
	mov x4,41           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo

	ldr x10,color_cielo_dia_3
	mov x2,42		       // posicion y inicial del pixel
	mov x4,62           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo

	ldr x10,color_cielo_dia_4
	mov x2,63		       // posicion y inicial del pixel
	mov x4,83           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo

	ldr x10,color_cielo_dia_5
	mov x2,84		       // posicion y inicial del pixel
	mov x4,104           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo

	ldr x10,color_cielo_dia_6
	mov x2,105		       // posicion y inicial del pixel
	mov x4,125           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo


	ldr x10,color_cielo_dia_7
	mov x2,126		       // posicion y inicial del pixel
	mov x4,146           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_dia_8
	mov x2,147		       // posicion y inicial del pixel
	mov x4,167           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_dia_9
	mov x2,168		       // posicion y inicial del pixel
	mov x4,188           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_dia_10
	mov x2,189		       // posicion y inicial del pixel
	mov x4,209           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_dia_11
	mov x2,210		       // posicion y inicial del pixel
	mov x4,230           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo

	ldr x10,color_cielo_dia_12
	mov x2,231		       // posicion y inicial del pixel
	mov x4,251           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo


	ldr x10,color_cielo_dia_13
	mov x2,252		       // posicion y inicial del pixel
	mov x4,272           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_dia_14
	mov x2,273		       // posicion y inicial del pixel
	mov x4,293           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_dia_15
	mov x2,273		       // posicion y inicial del pixel
	mov x4,293           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_dia_16
	mov x2,294		       // posicion y inicial del pixel
	mov x4,304           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	

	ldr x10,color_cielo_dia_17
	mov x2,305		       // posicion y inicial del pixel
	mov x4,315           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	

	ldr x10,color_cielo_dia_18
	mov x2,316		       // posicion y inicial del pixel
	mov x4,326           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_dia_19
	mov x2,327		       // posicion y inicial del pixel
	mov x4,337           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr x10,color_cielo_dia_20
	mov x2,338		       // posicion y inicial del pixel
	mov x4,349           // posicion y final del pixel
	bl ubicar_pixel
	bl pintar_rectangulo
	
	ldr lr,[sp]
	add sp,sp,#8

	br lr

pintar_desierto:
		
		sub sp,sp,#8
		str lr,[sp]

		ldr x10,color_desierto

		mov x1,0                // posicion x inicial del pixel
		mov x2,350		       // posicion y inicial del pixel
		mov x3,SCREEN_WIDTH   //posicion x final del pixel		
		mov x4,480           // posicion y final del pix20el

		bl ubicar_pixel

		bl pintar_rectangulo

		ldr lr,[sp]
		add sp,sp,#8

		br lr



pintar_fondo_de_dia:

		sub sp,sp,#8
		str lr,[sp]

		bl pintar_desierto
		bl pintar_cielo_dia
		bl pintar_piramides
		//bl pintar_sol

		ldr lr,[sp]
		add sp,sp,#8
		br lr


//SECCION PINTADO DE NOCHE


pintar_piramides_noche:

		sub sp,sp,#8
		str lr,[sp]
		
		ldr x10,color_piramide_frente_noche

		//triangulo de la derecha al fondo
		mov x1,180               // posicion x inicial del pixel
		mov x2,480		       // posicion y inicial del pixel
		mov x3,640		      //posicion x final del pixel
		mov x4,300           // posicion y final del pixel
		mov x13,#2			//indica la cantidad de veces que se pinta una seccion del triangulo
		mov x14,#4			//indica cuanto pixeles se debe achicar de los lados al triangulo en  cada fila

		bl ubicar_pixel
		bl pintar_triangulo

		//piramide izquierda

		ldr x10,color_piramide_atras_noche

		//triangulo de la derecha al fondo
		mov x1,80               // posicion x inicial del pixel
		mov x2,390		       // posicion y inicial del pixel
		mov x3,250		      //posicion x final del pixel
		mov x4,300           // posicion y final del pixel
		mov x13,#1			//indica la cantidad de veces que se pinta una seccion del triangulo
		mov x14,#2			//indica cuanto pixeles se debe achicar de los lados al triangulo en  cada fila

		bl ubicar_pixel
		bl pintar_triangulo

		ldr lr,[sp]
		add sp,sp,#8
        br lr 

pintar_desierto_noche:	

		sub sp,sp,#8
		str lr,[sp]

		ldr x10,color_base_inferior_noche

		mov x1,0                // posicion x inicial del pixel
		mov x2,420		       // posicion y inicial del pixel
		mov x3,SCREEN_WIDTH   //posicion x final del pixel
		mov x4,480           // posicion y final del pixel

		bl ubicar_pixel
		bl pintar_rectangulo


		ldr x10,color_base_superior_noche

		mov x1,0                // posicion x inicial del pixel
		mov x2,390		       // posicion y inicial del pixel
		mov x3,SCREEN_WIDTH   //posicion x final del pixel
		mov x4,420           // posicion y final del pixel

		bl ubicar_pixel
		bl pintar_rectangulo

		ldr lr,[sp]
		add sp,sp,#8

		br lr
	
pintar_fondo_de_noche:

		sub sp,sp,#8
		str lr,[sp]

		bl pintar_desierto_noche
		bl pintar_cielo_noche
		bl pintar_piramides_noche

		ldr lr,[sp]
		add sp,sp,#8
		br lr
