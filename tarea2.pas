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
function esFrontera(indicePelota: TIndicePelota; zonaPelotas: TZonaPelotas): boolean;
  var eval: boolean;
  begin
  eval := zonaPelotas[indicePelota.i,indicePelota.j].ocupada;
  if eval and
          (indicePelota.i > 1) and
          (indicePelota.j > 1) and
          (indicePelota.i < CANT_COLUMNAS) and
          (indicePelota.j < CANT_FILAS) then
      if zonaPelotas[indicePelota.i-1,indicePelota.j].ocupada and
          zonaPelotas[indicePelota.i+1,indicePelota.j].ocupada and
            zonaPelotas[indicePelota.i,indicePelota.j-1].ocupada and
              zonaPelotas[indicePelota.i,indicePelota.j+1].ocupada then
          eval := False;
  esFrontera := eval
  end;

  (***********************)
  procedure obtenerFrontera(zonaPelotas: TZonaPelotas; var frontera: TSecPelotas);
  begin
  frontera.tope := 0;
    for k := 1 to CANT_FILAS do
      for l := 1 to CANT_COLUMNAS do
        if esFrontera(zonaPelotas.pelota.posicion, zonaPelotas) then
          tope := tope + 1
          frontera.sec[tope].i = k;
          frontera.sec[tope].j = l;
      end;
    end;
  end;
