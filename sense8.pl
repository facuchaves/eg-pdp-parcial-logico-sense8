grupoSensante(angelica, capheus).
grupoSensante(angelica, sun).
grupoSensante(angelica, nomi).
grupoSensante(angelica, kala).
grupoSensante(angelica, riley).
grupoSensante(angelica, lito).
grupoSensante(angelica, will).
grupoSensante(angelica, wolfgang).

%Punto 1

%Si es la madre
conectadoCon(Persona1,Persona2):- grupoSensante(Persona1,Persona2).
conectadoCon(Persona1,Persona2):- grupoSensante(Persona2,Persona1).

%Si tiene la  misma madre
conectadoCon(Persona1,Persona2):- 
	pertenecenAlMismoGrupo(Persona1,Persona2),
	Persona1 \= Persona2.

conectadoCon(jonas,angelica).


vioALosOjos(whispers,jonas).
vioALosOjos(whispers,angelica).

conectadoCon(whispers,Persona):- vioALosOjos(whispers,Persona).

%Punto 2

leGusta(capheus, actor(jeanClaudeVanDamme)).
leGusta(capheus, cancion(whatsUp)).
leGusta(sun, deporte(kickboxing)).
leGusta(sun, cancion(whatsUp)).
leGusta(nomi, persona(amanita)).
leGusta(nomi, cancion(whatsUp)).
leGusta(kala, persona(wolfgang)).
leGusta(kala, cancion(whatsUp)).
leGusta(riley, persona(will)).
leGusta(riley, cancion(whatsUp)).
leGusta(lito, persona(hernando)).
leGusta(lito, cancion(whatsUp)).
leGusta(will, cancion(whatsUp)).
leGusta(wolfgang, persona(kala)).
leGusta(wolfgang, cancion(whatsUp)).

parejaSensante(Persona1,Persona2):-
	leGusta(Persona1,persona(Persona2)),
	leGusta(Persona2,persona(Persona1)),
	pertenecenAlMismoGrupo(Persona1,Persona2).

pertenecenAlMismoGrupo(Persona1,Persona2):-
	grupoSensante(Madre,Persona1),
	grupoSensante(Madre,Persona2).

sintonizador(Gusto):- 
	forall( grupoSensante(Madre, Integrante) , leGusta(Integrante,Gusto) ). %Chequear esto.

%Punto 3

viveEn(capheus, nairobi).
viveEn(sun, seul).
viveEn(nomi, sanFrancisco).
viveEn(kala, mumbai).
viveEn(riley, londres).
viveEn(lito, mexicoDF).
viveEn(will, chicago).
viveEn(wolfgang, berlin).

%disperso(Madre):-
%	grupoSensante(Madre,Integrante1),
%	grupoSensante(Madre,Integrante2),
%	Integrante1 \= Integrante2,
%	not( vivenEnLaMismaCiudad(Integrante1,Integrante2) ).

% Revisar Esto !
disperso(Madre):-
	forall( grupoSensante(Madre,Integrante1) , 
												( grupoSensante(Madre,Integrante2) ,
													Integrante2 \= Integrante1 , 
													not( vivenEnLaMismaCiudad(Integrante1, Integrante2 ) )
												) 
		).

vivenEnLaMismaCiudad(Integrante1,Integrante2):-
	viveEn(Integrante1,Ciudad1),
	viveEn(Integrante2,Ciudad2),
	Ciudad1 = Ciudad2.

%Punto 4

% habilidad(Persona, conductor(NombreDeVehículo,CantPasajeros)).
habilidad(capheus, conductor(vanDamm, 25)).
habilidad(sun, negocios).
habilidad(sun, pelear).
habilidad(sun, coser).
habilidad(nomi, bloguera).
habilidad(nomi, delincuente(hacker)).
habilidad(kala, quimica).
habilidad(riley, dj).
habilidad(lito, actor).
habilidad(will, policia).
habilidad(wolfgang, inteligente).
habilidad(wolfgang, pelear).
habilidad(wolfgang, delincuente(ladronDeJoyas)).

habilidosa(Persona):-
	forall( habilidad(Persona , Habilidad) , not( habilidadMala(Habilidad) ) ).

habilidadMala(delincuente(_)).
habilidadMala(policia).
habilidadMala(conductor(_,CantPasajeros)):- CantPasajeros < 20.

%Test punto 1
:- begin_tests(jona_y_angelica_conectados).
test(jona_y_angelica_conectados):- conectadoCon(jonas,angelica).
:- end_tests(jona_y_angelica_conectados).

%Test punto 2
:- begin_tests(kala_wolfgang_pareja_sesante).
test(kala_wolfgang_pareja_sesante):- parejaSensante(kala,wolfgang).
:- end_tests(kala_wolfgang_pareja_sesante).

:- begin_tests(whatsUp_es_sintonizador).
test(whatsUp_es_sintonizador):- sintonizador(cancion(whatsUp)).
:- end_tests(whatsUp_es_sintonizador).

%Test punto 3
:- begin_tests(grupo_angelica__disperso).
test(grupo_angelica__disperso):- disperso(angelica).
:- end_tests(grupo_angelica__disperso).

%Test punto 4
:- begin_tests(sun_es_habilidosa).
test(sun_es_habilidosa):- habilidosa(sun).
:- end_tests(sun_es_habilidosa).