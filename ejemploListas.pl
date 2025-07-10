precio(kiosco, cafe,2000).
precio(buffet, cafe,2000).
precio(buffet, medialuna,500).
precio(kiosco, agua,1200).
precio(kiosco, gaseosa,1700).
precio(buffet, agua,300).
precio(resto, agua,2300).
precio(resto, cafe,5000).
precio(resto, medialuna,3000).
precio(resto, mila,10000).
precio(carni, bondiola,500).
precio(carni, grasa,900).

negocioVendeBaratoPromedio(Negocio):-
    precio(Negocio,_,_),
    not(negocioVendeCaroPromedio(Negocio)).

negocioVendeCaroPromedio(Negocio):-
    precio(Negocio,_,_),
    findall(Precio, precio(Negocio,_,Precio) ,ListaPrecios),
    length(ListaPrecios, Cantidad),
    sumlist(ListaPrecios, Total),
    Promedio is Total / Cantidad,
    Promedio > 1000.
   
vendeMayoriaCaro(Negocio) :-
    cantidadProductosVendidos(Negocio,CantidadTotal),
    cantidadProductosCaros(Negocio,CantidadCaro),
    CantidadCaro > CantidadTotal / 2.

cantidadProductosCaros(Negocio,CantidadCaro):-
    precio(Negocio, _, _),
    findall(_, vendeAlgoCaro(Negocio), ListaPreciosCaros),
    length(ListaPreciosCaros, CantidadCaro).

cantidadProductosVendidos(Negocio,CantidadTotal):-
    precio(Negocio, _, _),
    findall(_, precio(Negocio, _ ,_), ListaPreciosTotal),
    length(ListaPreciosTotal, CantidadTotal).

preciosVigentes(kiosco,[4000,6000,300,700]).
preciosVigentes(resto,[300,700]).
preciosVigentes(carni,[300,7000]).


tienenUnMismoPrecio(N1,N2):-
    preciosVigentes(N1,Precios1),
    preciosVigentes(N2,Precios2),
    member(Precio,Precios1),
    member(Precio,Precios2).

promedioNegocio(Negocio,Promedio):-
    preciosVigentes(Negocio,ListaPrecios),
    length(ListaPrecios, Cantidad),
    sumlist(ListaPrecios, Total),
    Promedio is Total / Cantidad.
    
    


algoMasCaroQueOtro(Negocio, OtroNegocio,Producto):-
    precio(Negocio, Producto, Precio1),
    precio(OtroNegocio, Producto, Precio2),
    OtroNegocio \= Negocio,
    Precio1 > Precio2.

vendeAlgoMasCaro(N1,N2,ProductosMasCarosN1):-
    precio(N1,_,_),
    precio(N2,_,_),
    findall(
        Pr,
        (precio(N1,Pr,Precio1), precio(N2,Pr,Precio2),Precio1>Precio2),
        ProductosMasCarosN1
    ).


vendeTodoCaro(Negocio):- %todos mas que 1000
    precio(Negocio,_,_),
    forall(
        precio(Negocio, _, Precio),
        Precio > 1000
    ).

promedio(Negocio,Resultado):-
    precio(Negocio,P1,Precio1),
    precio(Negocio,P2,Precio2),
    precio(Negocio,P3,Precio3),
    P1 \= P2, P2 \= P3, P1 \= P3,
    Resultado is (Precio1+Precio2+Precio3)/3.


vendeAlgoCaro(Negocio):- %alguno mas que 1000
    precio(Negocio, _, Precio),
    Precio > 1000.

vendeMasDeUnoCaro(Negocio):- %al menos dos cosas a mas que 1000
    precio(Negocio, P1, Precio1),
    precio(Negocio, P2, Precio2),
    P1 \= P2,
    Precio1 > 1000,
    Precio2 > 1000.

vendeSoloUnoCaro(Negocio):-
    vendeAlgoCaro(Negocio),
    not(vendeMasDeUnoCaro(Negocio)).

longitud([],0).
%longitud([_],1).
%longitud([_,_],2).
longitud([_|XS],N):-
    longitud(XS,Cant),
    N is Cant + 1.

cantidadNegociosCafeteros(C):-
    findall(N ,precio(N,cafe,_), Lista),
    length(Lista,C).




vendeMayoriaMasCaroQue(Negocio,OtroNegocio) :-
    cantidadProductosVendidos(Negocio,CantidadTotal),
    cantidadProductosMasCarosQue(Negocio,OtroNegocio,CantidadCaro),
    CantidadCaro > CantidadTotal / 2.
    
cantidadProductosMasCarosQue(Negocio,OtroNegocio,CantidadCaro):-
    precio(Negocio, _, _),
    precio(OtroNegocio, _, _),
    findall(_, algoMasCaroQueOtro(Negocio,OtroNegocio,_), ListaPreciosCaros),
    length(ListaPreciosCaros, CantidadCaro).
    
    
