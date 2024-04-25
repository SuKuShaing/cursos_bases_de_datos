--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-04-25 18:12:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = UTF8;
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config(search_path, , false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 16540)
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS connect to other PostgreSQL databases from within a database;


--
-- TOC entry 3 (class 3079 OID 16632)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS determine similarities and distance between strings;


--
-- TOC entry 236 (class 1255 OID 16534)
-- Name: dele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dele() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec record;
    contador integer := 0;
BEGIN
 FOR rec IN SELECT * FROM pasajero LOOP
    contador := contador + 1;
 END LOOP;
    INSERT INTO cont_pasajero (total, tiempo) 
        VALUES (contador, now());                  
    RAISE NOTICE El conteo es % , contador;
	RETURN NEW;
END
$$;


ALTER FUNCTION public.dele() OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 16532)
-- Name: impl(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.impl() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec record;
    contador integer := 0;
BEGIN
 FOR rec IN SELECT * FROM pasajero LOOP
	 -- RAISE NOTICE Un pasajero se llama % , rec.nombre;
     contador := contador + 1;
 END LOOP;
    INSERT INTO cont_pasajero (total, tiempo) -- Se agregó esta línea
    VALUES (contador, now());                 -- que va a insertar el contador y la fecha actual en la tabla cont_pasajero 
    RAISE NOTICE El contateo es % , contador;
	RETURN NEW; -- OLD, NEW; los triggers deben retornar algo, sino falla al momento de ejecutarse, OLD lo que estaba antes del cambio, NEW es el cambio
END
$$;


ALTER FUNCTION public.impl() OWNER TO postgres;

SET default_tablespace = ;

--
-- TOC entry 228 (class 1259 OID 16467)
-- Name: bitacora_viajes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bitacora_viajes (
    id integer NOT NULL,
    id_viaje integer,
    fecha date
)
PARTITION BY RANGE (fecha);


ALTER TABLE public.bitacora_viajes OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16466)
-- Name: bitacora_viajes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bitacora_viajes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bitacora_viajes_id_seq OWNER TO postgres;

--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 227
-- Name: bitacora_viajes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitacora_viajes_id_seq OWNED BY public.bitacora_viajes.id;


SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 16471)
-- Name: bitacora_viajes_201001; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bitacora_viajes_201001 (
    id integer DEFAULT nextval(public.bitacora_viajes_id_seq::regclass) NOT NULL,
    id_viaje integer,
    fecha date
);


ALTER TABLE public.bitacora_viajes_201001 OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16524)
-- Name: cont_pasajero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_pasajero (
    total integer,
    tiempo time with time zone,
    id integer NOT NULL
);


ALTER TABLE public.cont_pasajero OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16523)
-- Name: cont_pasajero_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cont_pasajero_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cont_pasajero_id_seq OWNER TO postgres;

--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 232
-- Name: cont_pasajero_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cont_pasajero_id_seq OWNED BY public.cont_pasajero.id;


--
-- TOC entry 226 (class 1259 OID 16455)
-- Name: viaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.viaje (
    id integer NOT NULL,
    id_pasajero integer,
    id_trayecto integer,
    inicio timestamp without time zone,
    fin timestamp without time zone
);


ALTER TABLE public.viaje OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16516)
-- Name: despues_2000_mview; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.despues_2000_mview AS
 SELECT id,
    id_pasajero,
    id_trayecto,
    inicio,
    fin,
    now() AS updated
   FROM public.viaje
  WHERE (inicio > 2000-01-01 00:00:00::timestamp without time zone)
  ORDER BY inicio
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.despues_2000_mview OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16439)
-- Name: estacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estacion (
    id integer NOT NULL,
    nombre character varying(100),
    direccion character varying
);


ALTER TABLE public.estacion OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16438)
-- Name: estacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estacion_id_seq OWNER TO postgres;

--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 221
-- Name: estacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estacion_id_seq OWNED BY public.estacion.id;


--
-- TOC entry 218 (class 1259 OID 16421)
-- Name: pasajero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pasajero (
    id integer NOT NULL,
    nombre character varying(100),
    direccion_residencia character varying,
    fecha_nacimiento date
);


ALTER TABLE public.pasajero OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16420)
-- Name: pasajero_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pasajero_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pasajero_id_seq OWNER TO postgres;

--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 217
-- Name: pasajero_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pasajero_id_seq OWNED BY public.pasajero.id;


--
-- TOC entry 230 (class 1259 OID 16502)
-- Name: rango_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.rango_view AS
 SELECT id,
    nombre,
    direccion_residencia,
    fecha_nacimiento,
        CASE
            WHEN (fecha_nacimiento > 2002-01-01::date) THEN Niño::text
            ELSE Mayor::text
        END AS mas_18
   FROM public.pasajero;


ALTER VIEW public.rango_view OWNER TO postgres;

--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 230
-- Name: VIEW rango_view; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.rango_view IS Vista volatil;


--
-- TOC entry 224 (class 1259 OID 16448)
-- Name: trayecto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trayecto (
    id integer NOT NULL,
    id_tren integer,
    id_estacion integer,
    nombre character varying(100)
);


ALTER TABLE public.trayecto OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16447)
-- Name: trayecto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trayecto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trayecto_id_seq OWNER TO postgres;

--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 223
-- Name: trayecto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trayecto_id_seq OWNED BY public.trayecto.id;


--
-- TOC entry 220 (class 1259 OID 16430)
-- Name: tren; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tren (
    id integer NOT NULL,
    modelo character varying,
    capacidad integer
);


ALTER TABLE public.tren OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16429)
-- Name: tren_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tren_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tren_id_seq OWNER TO postgres;

--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 219
-- Name: tren_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tren_id_seq OWNED BY public.tren.id;


--
-- TOC entry 225 (class 1259 OID 16454)
-- Name: viaje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.viaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.viaje_id_seq OWNER TO postgres;

--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 225
-- Name: viaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.viaje_id_seq OWNED BY public.viaje.id;


--
-- TOC entry 4737 (class 0 OID 0)
-- Name: bitacora_viajes_201001; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora_viajes ATTACH PARTITION public.bitacora_viajes_201001 FOR VALUES FROM (2010-01-01) TO (2010-02-01);


--
-- TOC entry 4743 (class 2604 OID 16470)
-- Name: bitacora_viajes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora_viajes ALTER COLUMN id SET DEFAULT nextval(public.bitacora_viajes_id_seq::regclass);


--
-- TOC entry 4745 (class 2604 OID 16527)
-- Name: cont_pasajero id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_pasajero ALTER COLUMN id SET DEFAULT nextval(public.cont_pasajero_id_seq::regclass);


--
-- TOC entry 4740 (class 2604 OID 16442)
-- Name: estacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estacion ALTER COLUMN id SET DEFAULT nextval(public.estacion_id_seq::regclass);


--
-- TOC entry 4738 (class 2604 OID 16424)
-- Name: pasajero id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasajero ALTER COLUMN id SET DEFAULT nextval(public.pasajero_id_seq::regclass);


--
-- TOC entry 4741 (class 2604 OID 16451)
-- Name: trayecto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trayecto ALTER COLUMN id SET DEFAULT nextval(public.trayecto_id_seq::regclass);


--
-- TOC entry 4739 (class 2604 OID 16433)
-- Name: tren id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tren ALTER COLUMN id SET DEFAULT nextval(public.tren_id_seq::regclass);


--
-- TOC entry 4742 (class 2604 OID 16458)
-- Name: viaje id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viaje ALTER COLUMN id SET DEFAULT nextval(public.viaje_id_seq::regclass);


--
-- TOC entry 4920 (class 0 OID 16471)
-- Dependencies: 229
-- Data for Name: bitacora_viajes_201001; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bitacora_viajes_201001 (id, id_viaje, fecha) FROM stdin;
\.


--
-- TOC entry 4923 (class 0 OID 16524)
-- Dependencies: 233
-- Data for Name: cont_pasajero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cont_pasajero (total, tiempo, id) FROM stdin;
100	12:32:55.684262-04	1
99	12:35:39.493998-04	2
100	13:01:47.612271-04	4
101	13:02:20.154536-04	5
99	13:13:44.661592-04	6
98	13:14:01.112657-04	7
99	13:14:21.185264-04	8
98	13:14:35.885151-04	9
\.


--
-- TOC entry 4914 (class 0 OID 16439)
-- Dependencies: 222
-- Data for Name: estacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estacion (id, nombre, direccion) FROM stdin;
2	Estación Norte	St 100#112
3	Durgan and Sons	0 Westerfield Circle
4	Olson, Kiehn and Bartoletti	6 Bowman Junction
5	Fadel-Walsh	42008 Truax Avenue
6	Fisher, Howell and Hane	2 Golf View Hill
7	Olson-Witting	7279 Barby Court
8	Harber-Schroeder	11 Emmet Drive
9	Marks Inc	78 Thackeray Alley
10	Daugherty-Smitham	3 Coleman Lane
11	Rodriguez, Stamm and Schiller	37 Troy Park
12	Gorczany and Sons	6182 Loftsgordon Pass
13	Lindgren-Effertz	4 Golf Course Crossing
14	Roberts-Stehr	2686 Fairview Street
15	Aufderhar LLC	2 Alpine Pass
16	Pollich LLC	84948 Kinsman Alley
17	Botsford-Goyette	48 Briar Crest Trail
18	Rogahn, MacGyver and Rosenbaum	70 Quincy Court
19	OReilly, Ruecker and Barton	203 Dapin Place
20	Gerlach-Gerlach	49060 Emmet Road
21	Jacobs-Hills	94 Nobel Circle
22	Wolff, Considine and DAmore	2571 Sauthoff Circle
23	Kunze-Nikolaus	516 Londonderry Lane
24	Von, Veum and Raynor	763 Ridgeway Lane
25	Gorczany, Pouros and Jacobson	501 Washington Alley
26	Labadie, Sporer and Goyette	1066 Sullivan Place
27	Kassulke, Gerhold and Gutkowski	30 Farwell Lane
28	Zboncak LLC	94 Hoard Circle
29	Bayer-Zulauf	60455 Fordem Park
30	Gusikowski-Greenholt	2570 Evergreen Avenue
31	White, OConner and Runolfsson	88 Dexter Center
32	Hane, Pagac and Batz	9691 Graedel Center
33	Schaden-Kuhn	965 Grayhawk Alley
34	Kiehn-OKeefe	57 Hollow Ridge Trail
35	Cremin, Trantow and Miller	83 Bultman Hill
36	DuBuque Inc	323 Katie Junction
37	Durgan and Sons	23391 Killdeer Circle
38	Shanahan Group	4278 Gina Point
39	Hirthe Group	395 Claremont Way
40	Lind-Veum	7001 Oak Valley Avenue
41	DAmore, Koepp and Kirlin	390 Dixon Center
42	Keebler-Kessler	63 Almo Plaza
43	Hartmann-Zieme	12853 Elgar Way
44	Runolfsdottir Inc	2 Waywood Pass
45	Hodkiewicz Group	83810 Longview Court
46	Hessel LLC	7700 Bashford Crossing
47	Gulgowski Group	64389 Melrose Avenue
48	McDermott Group	13701 Brown Circle
49	Volkman Group	351 Service Circle
50	Nolan Group	9071 Bashford Park
51	OKeefe, Kshlerin and Kutch	225 Acker Terrace
52	Crooks-Moen	996 Gulseth Junction
53	Brakus, Boyle and Streich	28 Upham Crossing
54	Gutmann, Daugherty and Olson	2 Merrick Avenue
55	Klocko LLC	96507 Vernon Terrace
56	OConner-Hills	43711 Towne Street
57	Abernathy Inc	372 Brown Park
58	Larkin, Mills and Flatley	134 Darwin Pass
59	Gleichner, Armstrong and Daniel	790 Longview Terrace
60	Oberbrunner-Daugherty	935 Erie Plaza
61	Spinka, Orn and Conn	02 Emmet Circle
62	Mayer and Sons	973 Erie Park
63	Adams Inc	3 Loomis Lane
64	Beatty, Hessel and Turner	7 Warbler Junction
65	Fritsch and Sons	167 Novick Circle
66	Hegmann, Moore and Herman	62300 Warbler Hill
67	Rice, Ferry and Mills	7740 Park Meadow Lane
68	Abbott-Mills	7629 Armistice Avenue
69	Koss, Brown and Huels	9 Fremont Trail
70	Goldner-Anderson	7 Morrow Pass
71	Legros, Schimmel and Rolfson	1 Dawn Junction
72	Blick, Hermann and Farrell	9611 Bashford Road
73	Rippin, Schneider and Labadie	51819 Stuart Parkway
74	Hickle Inc	1417 Coleman Place
75	Gibson and Sons	64 Debs Court
76	Brakus-Sawayn	9 Pond Park
77	Rath, Ondricka and Carroll	32 Hermina Hill
78	Kuhlman, Bahringer and Dare	91450 Mayer Avenue
79	Kovacek, Jacobi and Keeling	91267 Miller Place
80	Terry Inc	3362 Barby Point
81	Cormier, Murray and Fay	9 Haas Hill
82	Lehner-Stark	2767 Ludington Circle
83	Mertz Group	8 Morningstar Pass
84	Heathcote Inc	927 Surrey Terrace
85	Yundt Inc	92752 Messerschmidt Avenue
86	Durgan LLC	69 Loftsgordon Point
87	Mueller, Funk and Nolan	0 Dexter Trail
88	Dickinson, Howell and Collier	394 Northland Road
89	Goyette and Sons	69 Lotheville Road
90	McCullough Inc	495 Sundown Parkway
91	Wilkinson-McDermott	25 Raven Drive
92	Kessler Inc	00 Autumn Leaf Circle
93	Stehr, Zemlak and Barrows	9 Scoville Pass
94	Flatley Inc	51 Porter Road
95	McCullough-Greenfelder	6059 Kingsford Crossing
96	Dietrich, Herman and Reichel	42354 Upham Park
97	Strosin and Sons	7 Granby Junction
98	Rosenbaum-Muller	62208 Butterfield Center
99	Hilpert and Sons	71623 Gulseth Terrace
100	Waters-Parisian	4 Mayer Drive
101	Hahn, Sipes and Heller	5731 Westridge Road
102	Langosh Group	66 Hazelcrest Park
1	Nombre	Dire
103	Ret	otro
104	Estacion Transac	direcccccctiooiin
\.


--
-- TOC entry 4910 (class 0 OID 16421)
-- Dependencies: 218
-- Data for Name: pasajero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pasajero (id, nombre, direccion_residencia, fecha_nacimiento) FROM stdin;
2	Harris Magill	Maywood	2000-09-10
3	Peyter Maffiotti	Doe Crossing	1986-06-06
4	Ursala Deluca	Hintze	1980-01-21
5	Othella Bulter	Grasskamp	1998-09-17
6	Adelind Bradley	Crest Line	1971-09-16
7	Sidoney Kilshall	Michigan	1992-08-01
8	Melany Hempel	Hallows	1952-05-19
9	Elsey Siege	Dottie	1954-08-23
15	Thorstein Fronks	Pankratz	2006-04-22
16	Samson Saddler	Colorado	1969-09-12
17	Christel Diviny	Wayridge	2007-01-14
18	Maxy Dosdale	Arapahoe	1969-10-12
19	Liuka Houltham	Dapin	1982-01-24
20	Kalil Petlyura	Mayer	1980-02-05
21	Julian Fidelli	Pine View	1956-09-26
22	Loree Buxey	Bashford	1956-06-20
23	Lulita Donke	Lawn	2014-02-11
24	Kennie Hercules	Boyd	1973-06-06
25	Selestina Shercliff	Elmside	1959-12-10
26	Paige Gladdolph	Sheridan	1966-09-27
27	Seana MacCheyne	Esker	2009-08-16
28	Angelle Wauchope	Park Meadow	1996-07-22
29	Rudie Jedrzejczyk	Amoth	1990-05-11
30	Ludvig McMenamy	Meadow Valley	1989-06-13
31	Karlene Pickin	Lyons	1954-11-12
32	Theodore Cosyns	Corry	1984-08-21
33	Krispin Lawford	Clyde Gallagher	2009-11-28
34	Kathryn Eagar	Crest Line	1954-10-06
35	Sawyer Lagadu	Thompson	1952-06-09
36	Gunter Maunton	Montana	2003-04-19
37	Merilyn Cattermoul	Algoma	1966-07-06
38	Cyrille Wetherell	Utah	2013-06-13
39	Delainey Rands	Helena	1979-09-22
40	Leonhard Whinray	Towne	1971-01-19
41	Dell Symmers	Ruskin	2015-12-25
42	Dasya Jakubovski	Manitowish	1966-10-16
43	Friederike Wike	Ridgeway	1965-06-22
44	Ogdon Darragh	Lakewood Gardens	2008-05-30
45	Thia Cobby	Lake View	1989-07-14
46	Portia Hewkin	Corry	1966-09-17
47	Olav Ucceli	Chive	1990-01-01
48	Shayne Losseljong	Carberry	1985-11-22
49	Alexis Sturley	Judy	1998-09-11
50	Nicki Longfield	Buena Vista	1972-06-08
51	De Derle	Vernon	1986-03-01
52	Luther Hardiman	Sherman	1962-11-17
53	Marion Dumberell	Tennessee	2014-09-08
54	Maddi Dawidowsky	Forster	2013-11-12
55	Marisa Rapelli	Golf Course	1955-10-14
56	Emili Dysert	Pearson	1967-10-07
57	Raimondo Pach	Calypso	1998-11-14
58	Bartlett Ryrie	Bobwhite	2013-10-08
59	Gilly Lomasney	Algoma	1966-06-03
60	Rhys Dufore	Melrose	1988-10-15
61	Jeromy Philler	South	1970-12-31
62	Demott Dondon	Maple Wood	1984-03-22
63	Tessa Crosen	Continental	2009-09-12
64	Samuel Laxtonne	Schmedeman	1950-09-03
65	Bel Valintine	Buell	1959-12-30
66	Paule Moggle	Mcbride	1987-04-20
67	Fan Sympson	Carioca	2010-07-17
68	Debra Sloegrave	Anthes	1955-02-16
69	Karlotte Aleksandrev	Mockingbird	2009-11-14
70	Jereme Planke	Manufacturers	2012-01-21
71	Mozelle Emer	Elmside	1977-08-26
72	Tate Cammell	Victoria	1986-03-16
73	Calhoun Baugh	Nobel	2005-12-11
74	Reena Farnish	Shelley	1991-08-26
75	Marlowe Learmont	Crescent Oaks	1964-04-27
76	Marillin Saffran	Jana	1992-12-11
77	Vassily Schwandt	Loeprich	1985-12-29
78	Danie Knutton	Kropf	1995-05-10
79	Philippe Kendall	Hagan	1993-09-07
80	Torrie Crocetti	Harbort	1958-12-30
81	Toby Matcham	Weeping Birch	1991-12-30
82	Jere Camber	Green Ridge	1957-11-08
83	Calla Grebner	Mcguire	2010-06-16
84	Fidela Withams	Vidon	1990-03-21
85	Avigdor Orrill	Valley Edge	1958-05-18
86	Bailey Gladebeck	Lighthouse Bay	1984-01-11
87	Karel Phythian	Welch	1968-10-16
88	Worden Niles	Lukken	1997-09-09
89	Maxy Whale	Manitowish	2002-08-02
90	Jillene Gulliford	Lindbergh	2017-08-09
91	Merv Simoneau	Butterfield	2011-03-03
92	Emelen Hagerty	7th	2007-04-16
93	Hasty Kings	Sullivan	1964-12-30
94	Mag MacGille	Artisan	2013-10-04
95	Kathleen Glentz	Golf	2011-05-22
96	Noach Gherarducci	Morrow	1978-10-21
97	Devlen Schurig	Manufacturers	2002-05-26
98	Roselia Philippeaux	Summerview	1981-03-24
99	Bronny Annetts	Clemons	2004-11-20
100	Rodi Andor	Pond	1986-08-02
1	\N	Larry	1990-12-10
102	Nombre Trigger	Dirección acá	2000-01-01
103	Nombre Trigger 2	Dirección ALLÁ	2000-01-02
104	Nombre Trigger 3	Dirección pallá	2000-01-03
\.


--
-- TOC entry 4916 (class 0 OID 16448)
-- Dependencies: 224
-- Data for Name: trayecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trayecto (id, id_tren, id_estacion, nombre) FROM stdin;
64	47	98	Bytecard
65	70	10	Pannier
66	20	89	Domainer
67	62	77	Bigtax
4	1	1	Ruta 2
68	93	89	Bytecard
69	7	9	Cardify
70	51	4	Prodder
71	75	36	Duobam
72	24	8	Bamity
73	75	74	Latlux
74	56	26	Span
75	5	29	Prodder
76	21	89	Otcom
77	1	43	Sonair
78	15	7	Zathin
79	43	43	Bamity
80	12	52	Zontrax
81	16	83	Stringtough
82	95	74	Sub-Ex
83	13	13	Lotlux
84	64	4	Veribet
85	43	23	Viva
86	49	59	Sonair
87	60	31	Vagram
88	35	42	Lotstring
89	57	21	Veribet
90	41	59	Redhold
91	87	48	Kanlam
92	4	13	Vagram
93	96	64	Kanlam
94	48	33	Bamity
95	92	65	Matsoft
96	82	45	Kanlam
97	52	3	Greenlam
98	90	28	Subin
99	70	34	Daltfresh
100	53	4	Hatity
101	98	31	Asoka
102	51	18	Zamit
103	50	83	Zoolab
104	73	40	Andalax
105	14	73	Asoka
106	82	68	Quo Lux
107	29	50	Lotstring
108	45	50	Veribet
109	41	101	Regrant
110	35	78	Bigtax
111	98	53	Cardguard
112	67	54	Zamit
113	25	78	Matsoft
114	50	81	Y-find
115	4	80	Ronstring
116	38	29	Lotlux
117	98	28	Fintone
118	65	6	Zamit
119	64	21	Andalax
120	16	41	Treeflex
121	33	81	Zoolab
122	22	12	Sonair
123	3	93	Domainer
124	102	13	It
125	52	97	Bamity
126	24	51	Domainer
127	28	42	Flowdesk
128	16	98	Namfix
129	50	100	Bamity
130	91	66	Voyatouch
131	101	74	Viva
132	83	74	Transcof
133	17	24	Lotstring
134	53	50	Tin
135	72	70	Kanlam
136	88	5	Temp
137	84	20	Fixflex
138	1	3	Zathin
139	63	90	Holdlamis
140	51	11	Lotstring
141	92	101	Cardify
142	95	50	It
143	53	31	Quo Lux
144	21	41	Trippledex
145	57	60	Ventosanzap
146	84	96	Zamit
147	64	42	Flexidy
148	52	24	Overhold
149	9	43	Job
150	102	48	Zamit
151	94	92	Bamity
152	30	70	Solarbreeze
153	47	12	Ronstring
154	18	89	Overhold
155	11	57	Kanlam
156	87	49	Bytecard
157	53	40	Fixflex
158	17	59	Zamit
159	101	98	Zontrax
160	18	38	Fix San
161	45	61	Viva
162	36	32	Stim
163	39	50	Viva
\.


--
-- TOC entry 4912 (class 0 OID 16430)
-- Dependencies: 220
-- Data for Name: tren; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tren (id, modelo, capacidad) FROM stdin;
1	Modelo 2	150
3	Sportvan G20	1
4	Pilot	2
5	3 Series	3
6	Stratus	4
7	E150	5
8	Prizm	6
9	G-Series G10	7
10	Truck	8
11	Tacoma	9
12	Astra	10
13	V40	11
14	Esprit	12
15	NSX	13
16	Ram 1500 Club	14
17	Justy	15
18	Prowler	16
19	Legacy	17
20	GL-Class	18
21	Safari	19
22	240SX	20
23	A4	21
24	Hombre	22
25	QX	23
26	S2000	24
27	del Sol	25
28	Cobalt	26
29	Venture	27
30	Laser	28
31	Vantage	29
32	Ram 3500 Club	30
33	5 Series	31
34	ES	32
35	Escort	33
36	Accord	34
37	S4	35
38	Grand Marquis	36
39	A8	37
40	Aurora	38
41	C-Class	39
42	Murano	40
43	Focus	41
44	Esperante	42
45	Caliber	43
46	LTD Crown Victoria	44
47	Corvette	45
48	Neon	46
49	Classic	47
50	Park Avenue	48
51	Focus	49
52	Impala	50
53	Alcyone SVX	51
54	Justy	52
55	L-Series	53
56	RX-7	54
57	Suburban 1500	55
58	Grand Caravan	56
59	LTD Crown Victoria	57
60	Ram 3500	58
61	Talon	59
62	Monte Carlo	60
63	S80	61
64	Corvette	62
65	900	63
66	911	64
67	Mustang	65
68	F-Series	66
69	X6 M	67
70	Econoline E250	68
71	Exige	69
72	Continental GT	70
73	Ram 1500 Club	71
74	Corvette	72
75	Yukon XL 1500	73
76	Reliant	74
77	Truck	75
78	Bronco	76
79	Passat	77
80	Solara	78
81	Precis	79
82	DeVille	80
83	Blazer	81
84	RX-7	82
85	GTI	83
86	Quest	84
87	Civic Si	85
88	Fox	86
89	Acadia	87
90	Quattro	88
91	Town Car	89
92	Camaro	90
93	Camry Hybrid	91
94	Flex	92
95	Acadia	93
96	Stratus	94
97	Ascender	95
98	Trooper	96
99	Challenger	97
100	Golf	98
101	Monza	99
102	GX	100
103	Tren Trans	123
\.


--
-- TOC entry 4918 (class 0 OID 16455)
-- Dependencies: 226
-- Data for Name: viaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.viaje (id, id_pasajero, id_trayecto, inicio, fin) FROM stdin;
1	61	151	2017-05-17 00:00:00	2017-05-17 00:00:00
2	49	86	2010-07-25 00:00:00	2010-07-25 00:00:00
4	90	161	2012-02-25 00:00:00	2012-02-25 00:00:00
5	43	109	2021-11-25 00:00:00	2021-11-25 00:00:00
6	32	114	2022-10-09 00:00:00	2022-10-09 00:00:00
7	3	92	2014-05-04 00:00:00	2014-05-04 00:00:00
8	21	111	2006-06-01 00:00:00	2006-06-01 00:00:00
9	49	133	2000-06-16 00:00:00	2000-06-16 00:00:00
10	54	128	2001-10-22 00:00:00	2001-10-22 00:00:00
11	65	95	2010-07-21 00:00:00	2010-07-21 00:00:00
12	75	71	2019-08-13 00:00:00	2019-08-13 00:00:00
13	84	163	2003-12-14 00:00:00	2003-12-14 00:00:00
14	85	120	2017-05-17 00:00:00	2017-05-17 00:00:00
15	38	112	2004-11-11 00:00:00	2004-11-11 00:00:00
16	29	159	2015-06-25 00:00:00	2015-06-25 00:00:00
17	2	113	2000-11-10 00:00:00	2000-11-10 00:00:00
18	37	100	2018-03-18 00:00:00	2018-03-18 00:00:00
20	9	83	2007-04-24 00:00:00	2007-04-24 00:00:00
21	65	105	2018-12-15 00:00:00	2018-12-15 00:00:00
22	34	141	2016-07-09 00:00:00	2016-07-09 00:00:00
23	6	153	2014-02-23 00:00:00	2014-02-23 00:00:00
24	68	160	2012-02-25 00:00:00	2012-02-25 00:00:00
25	76	110	2017-01-30 00:00:00	2017-01-30 00:00:00
26	57	106	2014-02-27 00:00:00	2014-02-27 00:00:00
27	30	162	2016-08-24 00:00:00	2016-08-24 00:00:00
28	65	136	2014-02-12 00:00:00	2014-02-12 00:00:00
29	37	159	2003-12-16 00:00:00	2003-12-16 00:00:00
30	18	118	2014-07-07 00:00:00	2014-07-07 00:00:00
31	79	147	2009-10-13 00:00:00	2009-10-13 00:00:00
32	18	137	2007-10-20 00:00:00	2007-10-20 00:00:00
33	70	82	2016-12-23 00:00:00	2016-12-23 00:00:00
34	90	81	2017-04-27 00:00:00	2017-04-27 00:00:00
35	55	81	2003-09-18 00:00:00	2003-09-18 00:00:00
36	42	83	2019-04-19 00:00:00	2019-04-19 00:00:00
37	69	69	2002-02-06 00:00:00	2002-02-06 00:00:00
38	28	108	2015-10-18 00:00:00	2015-10-18 00:00:00
39	2	96	2003-12-14 00:00:00	2003-12-14 00:00:00
41	92	130	2001-01-29 00:00:00	2001-01-29 00:00:00
42	84	114	2008-04-20 00:00:00	2008-04-20 00:00:00
43	78	134	2021-10-08 00:00:00	2021-10-08 00:00:00
44	51	93	2014-03-20 00:00:00	2014-03-20 00:00:00
45	4	162	2004-02-24 00:00:00	2004-02-24 00:00:00
46	65	129	2018-04-16 00:00:00	2018-04-16 00:00:00
47	92	140	2011-01-07 00:00:00	2011-01-07 00:00:00
48	20	94	2013-08-13 00:00:00	2013-08-13 00:00:00
50	59	153	2003-05-13 00:00:00	2003-05-13 00:00:00
51	87	152	2004-01-08 00:00:00	2004-01-08 00:00:00
52	43	124	2012-12-13 00:00:00	2012-12-13 00:00:00
53	56	87	2014-11-27 00:00:00	2014-11-27 00:00:00
54	46	147	2010-03-10 00:00:00	2010-03-10 00:00:00
55	63	139	2003-03-17 00:00:00	2003-03-17 00:00:00
56	7	143	2010-07-12 00:00:00	2010-07-12 00:00:00
57	62	162	2017-07-20 00:00:00	2017-07-20 00:00:00
58	16	117	2018-11-03 00:00:00	2018-11-03 00:00:00
59	69	150	2007-08-07 00:00:00	2007-08-07 00:00:00
60	54	82	2012-03-18 00:00:00	2012-03-18 00:00:00
61	79	147	2019-08-07 00:00:00	2019-08-07 00:00:00
62	27	129	2002-07-05 00:00:00	2002-07-05 00:00:00
63	18	153	2002-07-19 00:00:00	2002-07-19 00:00:00
64	86	102	2022-04-10 00:00:00	2022-04-10 00:00:00
65	9	153	2007-11-29 00:00:00	2007-11-29 00:00:00
66	92	116	2021-01-12 00:00:00	2021-01-12 00:00:00
67	45	133	2004-03-26 00:00:00	2004-03-26 00:00:00
68	4	95	2011-08-20 00:00:00	2011-08-20 00:00:00
69	71	80	2003-01-09 00:00:00	2003-01-09 00:00:00
70	42	94	2012-07-30 00:00:00	2012-07-30 00:00:00
71	30	156	2021-11-28 00:00:00	2021-11-28 00:00:00
72	100	69	2007-08-27 00:00:00	2007-08-27 00:00:00
73	94	108	2021-04-05 00:00:00	2021-04-05 00:00:00
74	54	79	2014-06-16 00:00:00	2014-06-16 00:00:00
75	100	144	2012-01-23 00:00:00	2012-01-23 00:00:00
76	50	158	2013-12-29 00:00:00	2013-12-29 00:00:00
77	98	157	2002-07-26 00:00:00	2002-07-26 00:00:00
78	72	162	2015-08-10 00:00:00	2015-08-10 00:00:00
79	3	116	2001-07-04 00:00:00	2001-07-04 00:00:00
80	75	163	2011-11-11 00:00:00	2011-11-11 00:00:00
81	40	137	2002-07-21 00:00:00	2002-07-21 00:00:00
83	39	91	2006-07-20 00:00:00	2006-07-20 00:00:00
84	25	158	2013-02-20 00:00:00	2013-02-20 00:00:00
85	70	80	2001-07-25 00:00:00	2001-07-25 00:00:00
86	79	114	2022-06-28 00:00:00	2022-06-28 00:00:00
87	66	99	2013-02-17 00:00:00	2013-02-17 00:00:00
88	85	114	2002-03-21 00:00:00	2002-03-21 00:00:00
89	88	75	2003-07-22 00:00:00	2003-07-22 00:00:00
90	18	92	2009-12-22 00:00:00	2009-12-22 00:00:00
91	18	79	2000-09-16 00:00:00	2000-09-16 00:00:00
92	95	140	2014-11-29 00:00:00	2014-11-29 00:00:00
93	58	149	2016-07-18 00:00:00	2016-07-18 00:00:00
94	96	101	2022-07-02 00:00:00	2022-07-02 00:00:00
95	39	71	2008-01-05 00:00:00	2008-01-05 00:00:00
96	25	80	2003-12-25 00:00:00	2003-12-25 00:00:00
97	24	64	2014-05-31 00:00:00	2014-05-31 00:00:00
98	38	157	2017-08-06 00:00:00	2017-08-06 00:00:00
99	28	90	2005-02-22 00:00:00	2005-02-22 00:00:00
100	71	111	2014-05-04 00:00:00	2014-05-04 00:00:00
\.


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 227
-- Name: bitacora_viajes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(public.bitacora_viajes_id_seq, 1, false);


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 232
-- Name: cont_pasajero_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(public.cont_pasajero_id_seq, 9, true);


--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 221
-- Name: estacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(public.estacion_id_seq, 104, true);


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 217
-- Name: pasajero_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(public.pasajero_id_seq, 104, true);


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 223
-- Name: trayecto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(public.trayecto_id_seq, 163, true);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 219
-- Name: tren_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(public.tren_id_seq, 104, true);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 225
-- Name: viaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval(public.viaje_id_seq, 100, true);


--
-- TOC entry 4757 (class 2606 OID 16529)
-- Name: cont_pasajero cont_pasajero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_pasajero
    ADD CONSTRAINT cont_pasajero_pkey PRIMARY KEY (id);


--
-- TOC entry 4751 (class 2606 OID 16446)
-- Name: estacion estacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estacion
    ADD CONSTRAINT estacion_pkey PRIMARY KEY (id);


--
-- TOC entry 4747 (class 2606 OID 16428)
-- Name: pasajero pasajero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasajero
    ADD CONSTRAINT pasajero_pkey PRIMARY KEY (id);


--
-- TOC entry 4753 (class 2606 OID 16453)
-- Name: trayecto trayecto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trayecto
    ADD CONSTRAINT trayecto_pkey PRIMARY KEY (id);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 4753
-- Name: CONSTRAINT trayecto_pkey ON trayecto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT trayecto_pkey ON public.trayecto IS id;


--
-- TOC entry 4749 (class 2606 OID 16437)
-- Name: tren tren_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tren
    ADD CONSTRAINT tren_pkey PRIMARY KEY (id);


--
-- TOC entry 4755 (class 2606 OID 16460)
-- Name: viaje viaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viaje
    ADD CONSTRAINT viaje_pkey PRIMARY KEY (id);


--
-- TOC entry 4762 (class 2620 OID 16533)
-- Name: pasajero mitrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER mitrigger AFTER INSERT ON public.pasajero FOR EACH ROW EXECUTE FUNCTION public.impl();


--
-- TOC entry 4763 (class 2620 OID 16535)
-- Name: pasajero trigger_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_delete AFTER DELETE ON public.pasajero FOR EACH ROW EXECUTE FUNCTION public.dele();


--
-- TOC entry 4758 (class 2606 OID 16481)
-- Name: trayecto trayecto_estacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trayecto
    ADD CONSTRAINT trayecto_estacion_fkey FOREIGN KEY (id_estacion) REFERENCES public.estacion(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4759 (class 2606 OID 16486)
-- Name: trayecto trayecto_tren_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trayecto
    ADD CONSTRAINT trayecto_tren_fkey FOREIGN KEY (id_tren) REFERENCES public.tren(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4760 (class 2606 OID 16496)
-- Name: viaje viaje_pasajero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viaje
    ADD CONSTRAINT viaje_pasajero_fkey FOREIGN KEY (id_pasajero) REFERENCES public.pasajero(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4761 (class 2606 OID 16491)
-- Name: viaje viaje_trayecto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viaje
    ADD CONSTRAINT viaje_trayecto_fkey FOREIGN KEY (id_trayecto) REFERENCES public.trayecto(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE bitacora_viajes; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.bitacora_viajes TO usuario_consulta;


--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE bitacora_viajes_201001; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.bitacora_viajes_201001 TO usuario_consulta;


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE viaje; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.viaje TO usuario_consulta;


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE estacion; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.estacion TO usuario_consulta;


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE pasajero; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.pasajero TO usuario_consulta;


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE trayecto; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.trayecto TO usuario_consulta;


--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE tren; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.tren TO usuario_consulta;


--
-- TOC entry 4921 (class 0 OID 16516)
-- Dependencies: 231 4925
-- Name: despues_2000_mview; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: postgres
--

REFRESH MATERIALIZED VIEW public.despues_2000_mview;


-- Completed on 2024-04-25 18:12:51

--
-- PostgreSQL database dump complete
--

