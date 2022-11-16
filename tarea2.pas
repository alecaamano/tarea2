(* Tarea 2 - Alejandro Caamaño 4.949.596-5 *)

(***********************)
procedure darUnPaso(var balin: TBalin);
begin
  with balin do
  begin
  pelota.posicion.x := pelota.posicion.x + velocidad.vx;
  pelota.posicion.y := pelota.posicion.y + velocidad.vy;

  (* verificación de rebote luego de dar un paso *)
  if ((pelota.posicion.x + RADIO) > ANCHO) or (pelota.posicion.x < RADIO) then
    velocidad.vx := -velocidad.vx;
  if (pelota.posicion.y + RADIO) > ALTO then
    velocidad.vy := -velocidad.vy;
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
  var k,l: integer;
  begin
  frontera.tope := 0;
    for k := 1 to CANT_FILAS do
      for l := 1 to CANT_COLUMNAS do
        if esFrontera(zonaPelotas.pelota.posicion, zonaPelotas) then
          begin
          tope := tope + 1;
          frontera.sec[tope].i = k;
          frontera.sec[tope].j = l;
          end;
  end;

(***********************)
procedure disparar(b: TBalin;
                    frontera: TSecPelotas;
                    zona: TZonaPelotas;
                    var indicePelota: TIndicePelota;
                    var chocaFrontera: boolean);
    var m,k: integer;
    begin
    chocaFrontera := False;
    while (b.pelota.posicion.y > 0) and not chocaFrontera do
    begin
      darUnPaso(b);
      k := 1;
      while k <= frontera.tope and not chocaFrontera do
        indicePelota.i := frontera.sec[k].i;
        indicePelota.j := frontera.sec[k].j;
        chocaFrontera := estanChocando(b, frontera.sec[k]) and (b.pelota.color = zonaPelotas[indicePelota.i, indicePelota.j]);
        k := k+1;
    end;
    end;

(***********************)
procedure eliminarPelotas(var zonaPelotas: TZonaPelotas; aEliminar: TSecPelotas);
  var k: integer;
  begin
  for k := 1 to aEliminar.tope do
    zonaPelotas[aEliminar.sec.i, aEliminar.sec.j].ocupada := False
  end;

(***********************)
