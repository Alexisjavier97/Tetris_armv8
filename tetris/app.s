.include "graficos.s" 

main:
	
	mov x20, x0 // Guarda la dirección base del framebuffer en x20

	//bl pintar_fondo_de_dia
	//bl pintar_sol
	bl pintar_fondo_de_noche

InfLoop:
	b InfLoop
