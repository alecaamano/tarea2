(* Tarea 2 - Alejandro Caamaño 4.949.596-5 *)

(***********************)
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

(***********************)
function estanChocando(p1, p2: TPelota): boolean;
  var dist: real;
  begin
    dist := sqrt( sqr(p1.posicion.x - p2.posicion.x) + sqr(p1.posicion.y - p2.posicion.y) );
    estanChocando := dist < (2*RADIO)
end;

(***********************)
