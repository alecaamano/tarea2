(* Tarea 2 - Alejandro Caamaño 4.949.596-5 *)

procedure darUnPaso(var balin: TBalin);
  with balin do
  begin
  posicion.x = posicion.x + velocidad.vx;
  posicion.y = posicion.y + velocidad.vy;

  (* verificación de rebote luego de dar un paso *)
  if (posicion.x + RADIO) > ANCHO or posicion.x < RADIO then
    velocidad.vx = -velocidad.vx;
  if (posicion.y + RADIO) > ALTO then
    velocidad.vy = -velocidad.vy;
  end;
end;



function estanChocando(x1,y1,x2,y2: integer): boolean;
var dist: real;
Begin
  dist := sqrt( sqr(x1-x2) + sqr(y1-y2) );
  estanChocando := dist < (2*RADIO)
End;
