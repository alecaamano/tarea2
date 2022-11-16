(* Tarea 2 - Alejandro Caamaño 4.949.596-5 *)

(***********************)
procedure darUnPaso(var balin: TBalin);
begin
  with balin do
  begin
    pelota.posicion.x := pelota.posicion.x + velocidad.vx;
    pelota.posicion.y := pelota.posicion.y + velocidad.vy;

    (* verificacion de rebote luego de dar un paso *)
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
    estanChocando := dist < (2 * RADIO)
  end;

(***********************)
function esFrontera(indicePelota: TIndicePelota; zonaPelotas: TZonaPelotas): boolean;
  var esFronteraIzq, esFronteraDer, esFronteraSup, esFronteraInf, esFronteraInterno: boolean;
  begin
    esFronteraIzq := (indicePelota.i = 1) and zonaPelotas[indicePelota.i, indicePelota.j].ocupada;
    esFronteraDer := (indicePelota.i = CANT_COLUMNAS) and zonaPelotas[indicePelota.i, indicePelota.j].ocupada;
    esFronteraSup := (indicePelota.j = 1) and zonaPelotas[indicePelota.i, indicePelota.j].ocupada;
    esFronteraInf := (indicePelota.j = CANT_FILAS) and zonaPelotas[indicePelota.i, indicePelota.j].ocupada;
    esFronteraInterno := zonaPelotas[indicePelota.i, indicePelota.j].ocupada
      and not(esFronteraIzq or esFronteraDer or esFronteraSup or esFronteraInf)
      and not(zonaPelotas[indicePelota.i, indicePelota.j-1].ocupada
        and zonaPelotas[indicePelota.i, indicePelota.j+1].ocupada
        and zonaPelotas[indicePelota.i-1, indicePelota.j].ocupada
        and zonaPelotas[indicePelota.i+1, indicePelota.j].ocupada);
    esFrontera := esFronteraIzq or esFronteraDer or esFronteraSup or esFronteraInf or esFronteraInterno;
  end;

(***********************)
procedure obtenerFrontera(zonaPelotas: TZonaPelotas; var frontera: TSecPelotas);
  var k,l: integer;
  indice: TIndicePelota;
  begin
    frontera.tope := 0;
    for k := 1 to CANT_FILAS do
      for l := 1 to CANT_COLUMNAS do
        begin
          indice.i := k;
          indice.j := l;
          if esFrontera(indice,zonaPelotas) then
            begin
              frontera.tope := frontera.tope + 1;
              frontera.sec[frontera.tope].i := k;
              frontera.sec[frontera.tope].j := l;
            end;
        end;
  end;

(***********************)
procedure disparar(b: TBalin;
                    frontera: TSecPelotas;
                    zona: TZonaPelotas;
                    var indicePelota: TIndicePelota;
                    var chocaFrontera: boolean);
var k: integer;
begin
  chocaFrontera := False;
  while (b.pelota.posicion.y > 0) and not chocaFrontera do
  begin
    darUnPaso(b);
    k := 1;
    while (k <= frontera.tope) and not chocaFrontera do
    begin
      indicePelota.i := frontera.sec[k].i;
      indicePelota.j := frontera.sec[k].j;
      chocaFrontera := estanChocando(b.pelota, zona[indicePelota.i,indicePelota.j].pelota);
      k := k+1;
    end;
  end;
  chocaFrontera := chocaFrontera and (b.pelota.color = zona[indicePelota.i, indicePelota.j].pelota.color);
end;

(***********************)
procedure eliminarPelotas(var zonaPelotas: TZonaPelotas; aEliminar: TSecPelotas);
  var k: integer;
  begin
    for k := 1 to aEliminar.tope do
      zonaPelotas[aEliminar.sec[k].i, aEliminar.sec[k].j].ocupada := False
  end;

(***********************)
function esZonaVacia(zonaPelotas: TZonaPelotas): boolean;
  var k,l: integer;
      hayPelotas: boolean;
  begin
    k := 1;
    l := 1;
    hayPelotas := False;
    repeat
      repeat
        hayPelotas := zonaPelotas[k,l].ocupada;
        l := l+1;
      until hayPelotas or (l > CANT_COLUMNAS);
      k := k+1;
      l := 1;
    until hayPelotas or (k > CANT_FILAS);
    esZonaVacia := not hayPelotas
  end;