precio(kiosco, cafe,2000).
precio(buffet, cafe,2000).
precio(buffet, medialuna,500).
precio(kiosco, agua,1200).
precio(kiosco, gaseosa,1700).
precio(buffet, agua,1300).
precio(resto, agua,2300).
precio(resto, cafe,5000).
precio(resto, medialuna,300).
precio(resto, mila,10000).
precio(carni, bondiola,5000).
precio(carni, grasa,900).

negocioVendePromedio(Negocio,Promedio):-
    precio(Negocio,_,_),
    findall(Precio, precio(Negocio,_,Precio) ,ListaPrecios),
    length(ListaPrecios, Cantidad),
    sumlist(ListaPrecios, Total),
    Promedio is Total / Cantidad.
   



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
    
    


algoMasCaroQueOtro(Negocio, OtroNegocio):-
    precio(Negocio, Producto, Precio1),
    precio(OtroNegocio, Producto, Precio2),
    OtroNegocio \= Negocio,
    Precio1 > Precio2.

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



