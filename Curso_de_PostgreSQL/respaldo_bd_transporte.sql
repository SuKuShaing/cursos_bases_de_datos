PGDMP                      |         
   transporte    16.2    16.2 N    >           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            @           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            A           1262    16419 
   transporte    DATABASE     }   CREATE DATABASE transporte WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Chile.1252';
    DROP DATABASE transporte;
                postgres    false                        3079    16540    dblink 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;
    DROP EXTENSION dblink;
                   false            B           0    0    EXTENSION dblink    COMMENT     _   COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';
                        false    2                        3079    16632    fuzzystrmatch 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;
    DROP EXTENSION fuzzystrmatch;
                   false            C           0    0    EXTENSION fuzzystrmatch    COMMENT     ]   COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';
                        false    3            �            1255    16534    dele()    FUNCTION     }  CREATE FUNCTION public.dele() RETURNS trigger
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
    RAISE NOTICE 'El conteo es % ', contador;
	RETURN NEW;
END
$$;
    DROP FUNCTION public.dele();
       public          postgres    false            �            1255    16532    impl()    FUNCTION     �  CREATE FUNCTION public.impl() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec record;
    contador integer := 0;
BEGIN
 FOR rec IN SELECT * FROM pasajero LOOP
	 -- RAISE NOTICE 'Un pasajero se llama %' , rec.nombre;
     contador := contador + 1;
 END LOOP;
    INSERT INTO cont_pasajero (total, tiempo) -- Se agregó esta línea
    VALUES (contador, now());                 -- que va a insertar el contador y la fecha actual en la tabla cont_pasajero 
    RAISE NOTICE 'El contateo es % ', contador;
	RETURN NEW; -- OLD, NEW; los triggers deben retornar algo, sino falla al momento de ejecutarse, OLD lo que estaba antes del cambio, NEW es el cambio
END
$$;
    DROP FUNCTION public.impl();
       public          postgres    false            �            1259    16467    bitacora_viajes    TABLE     �   CREATE TABLE public.bitacora_viajes (
    id integer NOT NULL,
    id_viaje integer,
    fecha date
)
PARTITION BY RANGE (fecha);
 #   DROP TABLE public.bitacora_viajes;
       public            postgres    false            D           0    0    TABLE bitacora_viajes    ACL     P   GRANT SELECT,INSERT,UPDATE ON TABLE public.bitacora_viajes TO usuario_consulta;
          public          postgres    false    228            �            1259    16466    bitacora_viajes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bitacora_viajes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.bitacora_viajes_id_seq;
       public          postgres    false    228            E           0    0    bitacora_viajes_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.bitacora_viajes_id_seq OWNED BY public.bitacora_viajes.id;
          public          postgres    false    227            �            1259    16471    bitacora_viajes_201001    TABLE     �   CREATE TABLE public.bitacora_viajes_201001 (
    id integer DEFAULT nextval('public.bitacora_viajes_id_seq'::regclass) NOT NULL,
    id_viaje integer,
    fecha date
);
 *   DROP TABLE public.bitacora_viajes_201001;
       public         heap    postgres    false    227    228            F           0    0    TABLE bitacora_viajes_201001    ACL     W   GRANT SELECT,INSERT,UPDATE ON TABLE public.bitacora_viajes_201001 TO usuario_consulta;
          public          postgres    false    229            �            1259    16524    cont_pasajero    TABLE     r   CREATE TABLE public.cont_pasajero (
    total integer,
    tiempo time with time zone,
    id integer NOT NULL
);
 !   DROP TABLE public.cont_pasajero;
       public         heap    postgres    false            �            1259    16523    cont_pasajero_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cont_pasajero_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cont_pasajero_id_seq;
       public          postgres    false    233            G           0    0    cont_pasajero_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.cont_pasajero_id_seq OWNED BY public.cont_pasajero.id;
          public          postgres    false    232            �            1259    16455    viaje    TABLE     �   CREATE TABLE public.viaje (
    id integer NOT NULL,
    id_pasajero integer,
    id_trayecto integer,
    inicio timestamp without time zone,
    fin timestamp without time zone
);
    DROP TABLE public.viaje;
       public         heap    postgres    false            H           0    0    TABLE viaje    ACL     F   GRANT SELECT,INSERT,UPDATE ON TABLE public.viaje TO usuario_consulta;
          public          postgres    false    226            �            1259    16516    despues_2000_mview    MATERIALIZED VIEW       CREATE MATERIALIZED VIEW public.despues_2000_mview AS
 SELECT id,
    id_pasajero,
    id_trayecto,
    inicio,
    fin,
    now() AS updated
   FROM public.viaje
  WHERE (inicio > '2000-01-01 00:00:00'::timestamp without time zone)
  ORDER BY inicio
  WITH NO DATA;
 2   DROP MATERIALIZED VIEW public.despues_2000_mview;
       public         heap    postgres    false    226    226    226    226    226            �            1259    16439    estacion    TABLE     ~   CREATE TABLE public.estacion (
    id integer NOT NULL,
    nombre character varying(100),
    direccion character varying
);
    DROP TABLE public.estacion;
       public         heap    postgres    false            I           0    0    TABLE estacion    ACL     I   GRANT SELECT,INSERT,UPDATE ON TABLE public.estacion TO usuario_consulta;
          public          postgres    false    222            �            1259    16438    estacion_id_seq    SEQUENCE     �   CREATE SEQUENCE public.estacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.estacion_id_seq;
       public          postgres    false    222            J           0    0    estacion_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.estacion_id_seq OWNED BY public.estacion.id;
          public          postgres    false    221            �            1259    16421    pasajero    TABLE     �   CREATE TABLE public.pasajero (
    id integer NOT NULL,
    nombre character varying(100),
    direccion_residencia character varying,
    fecha_nacimiento date
);
    DROP TABLE public.pasajero;
       public         heap    postgres    false            K           0    0    TABLE pasajero    ACL     I   GRANT SELECT,INSERT,UPDATE ON TABLE public.pasajero TO usuario_consulta;
          public          postgres    false    218            �            1259    16420    pasajero_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pasajero_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.pasajero_id_seq;
       public          postgres    false    218            L           0    0    pasajero_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.pasajero_id_seq OWNED BY public.pasajero.id;
          public          postgres    false    217            �            1259    16502 
   rango_view    VIEW       CREATE VIEW public.rango_view AS
 SELECT id,
    nombre,
    direccion_residencia,
    fecha_nacimiento,
        CASE
            WHEN (fecha_nacimiento > '2002-01-01'::date) THEN 'Niño'::text
            ELSE 'Mayor'::text
        END AS mas_18
   FROM public.pasajero;
    DROP VIEW public.rango_view;
       public          postgres    false    218    218    218    218            M           0    0    VIEW rango_view    COMMENT     6   COMMENT ON VIEW public.rango_view IS 'Vista volatil';
          public          postgres    false    230            �            1259    16448    trayecto    TABLE     �   CREATE TABLE public.trayecto (
    id integer NOT NULL,
    id_tren integer,
    id_estacion integer,
    nombre character varying(100)
);
    DROP TABLE public.trayecto;
       public         heap    postgres    false            N           0    0    TABLE trayecto    ACL     I   GRANT SELECT,INSERT,UPDATE ON TABLE public.trayecto TO usuario_consulta;
          public          postgres    false    224            �            1259    16447    trayecto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.trayecto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.trayecto_id_seq;
       public          postgres    false    224            O           0    0    trayecto_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.trayecto_id_seq OWNED BY public.trayecto.id;
          public          postgres    false    223            �            1259    16430    tren    TABLE     k   CREATE TABLE public.tren (
    id integer NOT NULL,
    modelo character varying,
    capacidad integer
);
    DROP TABLE public.tren;
       public         heap    postgres    false            P           0    0 
   TABLE tren    ACL     E   GRANT SELECT,INSERT,UPDATE ON TABLE public.tren TO usuario_consulta;
          public          postgres    false    220            �            1259    16429    tren_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tren_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.tren_id_seq;
       public          postgres    false    220            Q           0    0    tren_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.tren_id_seq OWNED BY public.tren.id;
          public          postgres    false    219            �            1259    16454    viaje_id_seq    SEQUENCE     �   CREATE SEQUENCE public.viaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.viaje_id_seq;
       public          postgres    false    226            R           0    0    viaje_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.viaje_id_seq OWNED BY public.viaje.id;
          public          postgres    false    225            �           0    0    bitacora_viajes_201001    TABLE ATTACH     �   ALTER TABLE ONLY public.bitacora_viajes ATTACH PARTITION public.bitacora_viajes_201001 FOR VALUES FROM ('2010-01-01') TO ('2010-02-01');
          public          postgres    false    229    228            �           2604    16470    bitacora_viajes id    DEFAULT     x   ALTER TABLE ONLY public.bitacora_viajes ALTER COLUMN id SET DEFAULT nextval('public.bitacora_viajes_id_seq'::regclass);
 A   ALTER TABLE public.bitacora_viajes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    16527    cont_pasajero id    DEFAULT     t   ALTER TABLE ONLY public.cont_pasajero ALTER COLUMN id SET DEFAULT nextval('public.cont_pasajero_id_seq'::regclass);
 ?   ALTER TABLE public.cont_pasajero ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    233    233            �           2604    16442    estacion id    DEFAULT     j   ALTER TABLE ONLY public.estacion ALTER COLUMN id SET DEFAULT nextval('public.estacion_id_seq'::regclass);
 :   ALTER TABLE public.estacion ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    16424    pasajero id    DEFAULT     j   ALTER TABLE ONLY public.pasajero ALTER COLUMN id SET DEFAULT nextval('public.pasajero_id_seq'::regclass);
 :   ALTER TABLE public.pasajero ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            �           2604    16451    trayecto id    DEFAULT     j   ALTER TABLE ONLY public.trayecto ALTER COLUMN id SET DEFAULT nextval('public.trayecto_id_seq'::regclass);
 :   ALTER TABLE public.trayecto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    16433    tren id    DEFAULT     b   ALTER TABLE ONLY public.tren ALTER COLUMN id SET DEFAULT nextval('public.tren_id_seq'::regclass);
 6   ALTER TABLE public.tren ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    16458    viaje id    DEFAULT     d   ALTER TABLE ONLY public.viaje ALTER COLUMN id SET DEFAULT nextval('public.viaje_id_seq'::regclass);
 7   ALTER TABLE public.viaje ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            8          0    16471    bitacora_viajes_201001 
   TABLE DATA           E   COPY public.bitacora_viajes_201001 (id, id_viaje, fecha) FROM stdin;
    public          postgres    false    229   <V       ;          0    16524    cont_pasajero 
   TABLE DATA           :   COPY public.cont_pasajero (total, tiempo, id) FROM stdin;
    public          postgres    false    233   YV       2          0    16439    estacion 
   TABLE DATA           9   COPY public.estacion (id, nombre, direccion) FROM stdin;
    public          postgres    false    222   �V       .          0    16421    pasajero 
   TABLE DATA           V   COPY public.pasajero (id, nombre, direccion_residencia, fecha_nacimiento) FROM stdin;
    public          postgres    false    218   �_       4          0    16448    trayecto 
   TABLE DATA           D   COPY public.trayecto (id, id_tren, id_estacion, nombre) FROM stdin;
    public          postgres    false    224   rh       0          0    16430    tren 
   TABLE DATA           5   COPY public.tren (id, modelo, capacidad) FROM stdin;
    public          postgres    false    220   -l       6          0    16455    viaje 
   TABLE DATA           J   COPY public.viaje (id, id_pasajero, id_trayecto, inicio, fin) FROM stdin;
    public          postgres    false    226   �o       S           0    0    bitacora_viajes_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.bitacora_viajes_id_seq', 1, false);
          public          postgres    false    227            T           0    0    cont_pasajero_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.cont_pasajero_id_seq', 9, true);
          public          postgres    false    232            U           0    0    estacion_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.estacion_id_seq', 104, true);
          public          postgres    false    221            V           0    0    pasajero_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.pasajero_id_seq', 104, true);
          public          postgres    false    217            W           0    0    trayecto_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.trayecto_id_seq', 163, true);
          public          postgres    false    223            X           0    0    tren_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.tren_id_seq', 104, true);
          public          postgres    false    219            Y           0    0    viaje_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.viaje_id_seq', 100, true);
          public          postgres    false    225            �           2606    16529     cont_pasajero cont_pasajero_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.cont_pasajero
    ADD CONSTRAINT cont_pasajero_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cont_pasajero DROP CONSTRAINT cont_pasajero_pkey;
       public            postgres    false    233            �           2606    16446    estacion estacion_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.estacion
    ADD CONSTRAINT estacion_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.estacion DROP CONSTRAINT estacion_pkey;
       public            postgres    false    222            �           2606    16428    pasajero pasajero_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.pasajero
    ADD CONSTRAINT pasajero_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.pasajero DROP CONSTRAINT pasajero_pkey;
       public            postgres    false    218            �           2606    16453    trayecto trayecto_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.trayecto
    ADD CONSTRAINT trayecto_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.trayecto DROP CONSTRAINT trayecto_pkey;
       public            postgres    false    224            Z           0    0 $   CONSTRAINT trayecto_pkey ON trayecto    COMMENT     @   COMMENT ON CONSTRAINT trayecto_pkey ON public.trayecto IS 'id';
          public          postgres    false    4753            �           2606    16437    tren tren_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.tren
    ADD CONSTRAINT tren_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.tren DROP CONSTRAINT tren_pkey;
       public            postgres    false    220            �           2606    16460    viaje viaje_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.viaje
    ADD CONSTRAINT viaje_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.viaje DROP CONSTRAINT viaje_pkey;
       public            postgres    false    226            �           2620    16533    pasajero mitrigger    TRIGGER     f   CREATE TRIGGER mitrigger AFTER INSERT ON public.pasajero FOR EACH ROW EXECUTE FUNCTION public.impl();
 +   DROP TRIGGER mitrigger ON public.pasajero;
       public          postgres    false    235    218            �           2620    16535    pasajero trigger_delete    TRIGGER     k   CREATE TRIGGER trigger_delete AFTER DELETE ON public.pasajero FOR EACH ROW EXECUTE FUNCTION public.dele();
 0   DROP TRIGGER trigger_delete ON public.pasajero;
       public          postgres    false    236    218            �           2606    16481    trayecto trayecto_estacion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trayecto
    ADD CONSTRAINT trayecto_estacion_fkey FOREIGN KEY (id_estacion) REFERENCES public.estacion(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 I   ALTER TABLE ONLY public.trayecto DROP CONSTRAINT trayecto_estacion_fkey;
       public          postgres    false    224    4751    222            �           2606    16486    trayecto trayecto_tren_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trayecto
    ADD CONSTRAINT trayecto_tren_fkey FOREIGN KEY (id_tren) REFERENCES public.tren(id) ON UPDATE CASCADE ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.trayecto DROP CONSTRAINT trayecto_tren_fkey;
       public          postgres    false    220    224    4749            �           2606    16496    viaje viaje_pasajero_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.viaje
    ADD CONSTRAINT viaje_pasajero_fkey FOREIGN KEY (id_pasajero) REFERENCES public.pasajero(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 C   ALTER TABLE ONLY public.viaje DROP CONSTRAINT viaje_pasajero_fkey;
       public          postgres    false    226    218    4747            �           2606    16491    viaje viaje_trayecto_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.viaje
    ADD CONSTRAINT viaje_trayecto_fkey FOREIGN KEY (id_trayecto) REFERENCES public.trayecto(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 C   ALTER TABLE ONLY public.viaje DROP CONSTRAINT viaje_trayecto_fkey;
       public          postgres    false    224    4753    226            9           0    16516    despues_2000_mview    MATERIALIZED VIEW DATA     5   REFRESH MATERIALIZED VIEW public.despues_2000_mview;
          public          postgres    false    231    4925            8      x������ � �      ;   v   x�E�KC1׏���������J�f���H��;G��|�=��˽��J�r��A{�ms@dc��+�e1�\c��&�sf��Ty��.$|߿���.a��W�L��ᢗ��L�$	      2   �  x�eW�r�\�_��,f#��~,%{l��O�ɸ2�DA"J���5�o��ci<(�V\�%��9}����k?�V��?�~�f�d3�$���$i������L��F�����7{����J��I�Z��J��/^23hɇA��.���M�U;���ܱ��&���i���o�x�j�QI�D�q3��̥t[>0�IJ��ӟ��郐2������ԁTi��ӷz�G3D5y�'n曶3��!IB��N|��F��!kf�=��jI�H:��a���_�$&�l< ��2ߜ�бɰ��6�G�%	y�;##����N'�Y�!H�U�P_�w�%)�צ}g��l��)}���?h��
K�>J2�(��`�����;�=6������GI�����7�I˺�wL�7��f0�QR�Ÿ
3����.�P<�W��ZJ�v�a�7y���ަ��R�Q���5���F`�z U&d����:c����7.�g�s�e�T1��(T;�*i�ӗg�.3�<r[�:)���e��~���Q�{n�o7I��e����.J�k���[������-�yӔ� ��1�^�,���/��6`\Q%t�ơ�������F�����QK6��HJTO�p��\<-Ҝ�����GχgvQڐ������M+�+%f�;�н{���ԋ8�/��Pi J���m�Np���z���$qY�͈r��+dY�У<���i�ؽ4G}d1Xc��|l5��ժeG�	 �����?mȒ] �_#�ؓ2΋�ށ�����Lc/���{�P���B�R���$�,!/����DM���[,����p!z��DYJ�; 9v`m`�ҔMB����umF�J�����NaMa�\:v>X��8'�?}Yq�礨�������t?	_����k��:��QV7Ψ�f��=rg4Y����Ŭ�?�M������t=�YM6S�]���P׽P�j���<3t<<Ϛ��H�h���K���X斚�!�����d��yB�
`횿���V�H��eLo�op1 ��hm��|���b �/�I[꽳(Ϭ[D����'4���~�8�
�˼Ӱs�J����;�PyA��K�{H���$��;8��f���q��r)���ևi��)��a�2�ꆮ��~��&�����
뒬jK�����]O׺d��À[>�)b��1�hb��5.'�"!�x��� ��X�.M�p��Nc5]� ���~���nJ�Y�|�>�܌,;����"��ٞ �5��+��.E\\�f����;�ݢ(k.��PQ����Q{�(����~\�,ɤ���yV�� �|�OEEhb����J���g�VtVh�%�$�[�$G��,B�,r/m���s��xg
3��Oę"-c� �ft�^ MVЯ���.�A7:2x��5���8(ԼL1b\��9a7U6�I�Y��ɏ ��'�{�-s��l���?F��Hi���:���z4��aIY���jMYm|y����)�Z�vv�UV���;��&��!�<v9�l�A�(�R��Ue�X�E?X%LS^CV��,��E0rۢ�]p*o��ڔ-�¶WK�
q��]%�@ޙ���������i�R�Đs������z]�M>i�MU ^_-�6�Nb��/��4 ��s���GUn��[~�'�ul�ݸB����Aa�탉Ue��|ð#��W�(*T:���j�y"4+t��m
~R�1�t�q��T!H��&ɋ�z��U�@o�8�ADx�\�Q�IR˷��O��!��Y��Q�w�:!7Y1�GcGl;����>�:E1�d1�"M�V8�q܅�'P���ڎ�S�|PX�ی񤨁>�ӵz�h�
�j|�*�.�?G���56��@@'��u9�fkoe��I�gW�5�+mvw�:�ܜ������&�(�j;~�������ܐ��-=�A�V�ǺOT�a�ɿ��eM�>u��Oò\R9Z�)Njy�`��0��5�cP��t/��5r�<a1�	pv���S��1���I��4�C�VțV��\E���v;�9~�WNb/>����=n�v�����B���w��>��ݤd/{��0�<͊<�6���B�x[|\e�?�^ݡ��pG��G7Εi�[�r>.�~�i�%_A�O[&��k���[5yax��#�0#��'q��^�6������E�%��m�� Kb(����iv)��w.[w�M��-~+�=F���>���o�4@�YKvXֺ`��Pѿ�E�� fx*�      .   |  x�eW�r۸\_��ߏ�-;v�R�{3��H�@B�V��|����	������ܪ��tp�ݧO+b�9=��l�1l'狵5�� �
ʫ0�1{R���ڎ�f�V���à���e�]�'����V����A��wE'P,��B���c���LEٽ��p�����_��]���7N�F�l��0���Z�s��^׶W�x�fh%=@W�ndO墫 C^��2��Ń�������ˀ#)��Wa�Kvg��k�(����҄JD1S���n���g����drr�N`���U�0c{��{Y�s�6�X<¢ZV��q*g���ʈ[��������w�XN`�	Ѹ�6�[;��(v��Y�V-����*�VO'), me�n�Y���c��(`��h#��h��Ib�-�<
���h��i o4{��E���Q�Qƣ�m�S
�})7rh�����*
x�-*�� @Rl+/=�&tS�(a������؍��D�*�R�W�`Խ�ǌ>AP7�9��@$iFHЍ�h[sn�׵�?[��y�(�b;YmZ5CDw�	 �����]���ī��֞j���)�G(�(��Qɞ�/��j�]�U}�O캳cK��������t#v�N����RJ�@~@���0�q��Q��IW'з�m?,C�9� @ek�/6v����:��,"ŕ1{��@� 잙��k��eӾ����`B���{q'��9ctq@l�`C^��ld=�tg(|������$�?>��~�taL���s ���9�pɲk��N�t��Ƃm0�
�p`�}eK:��!+LFj�g��{�fz*��1Q	(P�o���k�{'g��^~zHH]%!2b?w�r�� \��ʢ�'fj���(O����sLP�G{�C�tN�����U�W��<��g�$�����J���%n��CrRd� ��
���t<!����?�>�$��|"�X7�Ѓ�P���X& ���쳑o�kU�Wa>�M�b%xR`p$Cl����ea��j�X�E��K��aa��ɑ�?N��˻���DF��9jejv3�t=���E4O	y�
�a/��^R�Kbj)��Lľ���u�����ю�X�<�A�ӄ���|��(�B��S���k�/���4����"�e����$Du�Fxo��On�c�z��f����A�;R�e(��Oz�ٳԝ�k+�d�P3cr�Bo�iu�Q�(�!z7<\Z=����7_�{��L;9@�����g{n�8`�m<,h�{�r�3��r���SK����N޴rZ%Wq�3H]��Fr��X�i),F�
�  �B�"��0k��7���5�%�',���S������|,,�>bP�)��)���H1 ���19=���٦�^v��-ˠ���ő�}��{wڐ,*2 φ�^wpX*ƪ�I��u����2��ދ����i��8�C#cn��?]���:87"�0e�� 7���}�5��s��m��7p���Ľ	/ /�����\P�IG��zq#'��'{Pv�W��<aϊ&�t=9Ԟ��8e�~��9R&ʅHG��H�� ��l�����b�����G�k�4g/Hrpw�/ mDVPg�<�̴�98����i�E����H�R�8������gR}M��A��.���y��\}��R��.H\�j��3��XQ4zU
˱7������`�Y$�>�?᭛���5ư��#���C�s����S��2��H��P�Oql ���2ۘ�P��� �\|v+[��[�������7꠪�^ӎ`@���?$����1zj���s�fV���(ث�#>iJ^��tR����Z�\"�kK��-}-q:�%$O��mq?A>h 6Ԁ��K���ʐ6�R5�䄹���l���Ǽ�`������tf�خI8����#���؞�}[6A�RX��7��*),������&�L}�1D�=nCt'w_;I�������5�;SUa�Ci>�HPX�p�7jb��n�o�}��I+��D�ﲖ�7<���ۺ�=��e�n��?U��㈐g��K"�QF�z�Uv�vX�}���'d~BNXw�Q9"��;@�_�/Pf��.��㿽�Տ����|��_�E�������߿��K���_���
��������u�0      4   �  x�MU�n�F}��
�@
�^��Ǥ��6Υ�!�F_V&%/Bq�J�|}ϬIY� �{�9sΙQm�6<}x���8��v�T�}�Ð�Q�5�|�뼏i���jMMC�n�'e��;N�J��S0r�-b ����/
���ocn[Dk�G���c�Ľj4iK@�i�q#ۍ��8�Ǔ��V�qP�r��[0l�d�:=f�j �Z�!&�zbĢ�8=%\���ʣnMN�C��y�U���iL�n��ݓ�B�:n���C��|os�-�`��ݘ6ݤ����:����d��@��"ô���{O�D;��
ոF�Z"��,K���}�}�Jn�z��A�F~ �cB�P�e��Ys������C�"�Fw��+����u"W��p "C�Kױ��cwxR\Af�K�$9�b�
}��#޵؀=� �r�p��s7X��mE�6�P�+G\�&��1_��D#f@�7���R	���
 ��@Ѐ%������\T ����s���.���.�����m� W�%�WwyX��Q���/̥A�M�<tX�F}�D<��aP�=���,�(��}��г�4қ�>f���:�B����lF��T���P���?���K^���/q�M��( X��`Q�u~��G�ü*�>*}�F��x��"�Ǽ�ڪj�d�8��c�L��f�2�:��}��[C�F�u�N�,�y� 6`ֈ�?�� �2���EV0���c[� �uhp�BIg'�"XQ(=?�]+�Ň����>��WJ[�p�Y�pܝR+��("������!R���R��4���yQ@ڷ�V0Ǹ�k~�gҠ�X��7�'���9���1�e�\�xƮ+�z��yQSj�h�xe0�\F��Za�s�Ҭ�}5�f�(����B+S�Uv��M)�?8��9      0   {  x�mT�n�F<W}@�=s\���ɐ��Br���
!��pIE�ק��� Þ�.��rh�Ri(W�`{_��!�F�P����2A��T�v��#=�Ә��ˀSI�c���=��3as�z�ڨ�����J�*7�.#Qi��R��2�Yi��,N��c7Ai*�o�k(C��[���W]��ye�~��ӓ<�j�_����S%��7��P���9?Y��x���
��#�T��ж���6XYhEm����ZS;|�����u]ג@ �U��C;�u��^���	�v��%;��8�Gy��4
�<L�F"�F�d>2B����Y�[M��F��14�FK��0�&b3��P]�񯹓|O���0���j�@m"����h5.fI,�5��Yi^��Z	M-��uX���,��z�_}���P��f*c�a-m,ƇvZ�mķ���6�k���f.�x[��a���N�7Ot_��s�!�t�K�<�����k8Eg߈w�L��7��:���I��t�ͼ�ǽ�y���{�i��,B��t��fq����.�/��e���"�,u�_����^�۟xM����H� ��A�8����G����=}µ�.�C�Ӧ��d�S-��Ƞp�؉�|b��k�$,���B�`��+A1��QA38�>ߖ��>�&���;!A;�-mp��24�3$a�x�r+P&�%,"��l_H���]��-b�h���"���+GQ3:l��"F��s{�-���{�j�!��>��3���|zb`�%#O�X#���(� &&&�e����,��������dqַ�H�ɽM�駹%�Ģ�v8�Óc��I)��I|N�g������s�4���$FW�E!�RT���؈��bt���P]�ŏ�X����?��^:      6   �  x���ˑ�8D�L+�m�slY���EU@&�NO-��%���$H����+�K�?1�Y�7����x�~�j��3�0c��HWL��PC�A���$��{�`h!� R�a��Ӽ�z�a&=��u��y�]$jAl������a��$g}��4�g�j	��>�nJ���۴f��\^��s'I���W��%ټ�$��;�eE�'1~:�Qi�k޼�Ԑ]���E�*ֵ�A�x�m�쐪~t���͎�\t��2B�L���q����h1Kb�@˕��<CZ��Xﯩ�;�2�2�QV��������rh�S���>�C*�1��(_51�x�<��+GoÐZ�����A�կڰVU>�6r8�,"un��!�<㇁	�_9����d�O��4o��=�0YBgޖ�ߛZͶ��4����BZ�ѥ�e����v�!�yi�x���hx�\C��t��y8GYF���4TaX�6m=�mS��J�hC�����q�:�V�g��x���e�E�f!y1�q0��ew$f�:ц�3��uv���m�8J	l����8
��.�x����3��
)ͭyŕ����VO��tyŕ�g(�0�l�/]�3TvʹuMӭ�:�����~�ڃ��H*������3�:��1��:�x9���t�-������c+��EJ�vo�a��hwɟq��g�43=���5@zn�6&z�M�~�.E,C]�-�i�å����lt�Zz�ƞ��H�=ָ,�jqߙ��s�Wà�O��V��Vth���T+�8�`���9����S���U~:"�`��h"~0�J}&�[1������SV��lΜ��Pqs���F����h��)<?�����npH�a�iMww�Y��^r�\{��MF�X\��h����د C��RR�ŷo��᫪��VJmz�N�ִ�MG{5�J��	u����g��y'�{�^L5~-k�wK����=f�F��~N T���p^��o���jk�η����N__��|0PT���U�����Fk|~�w��gcmd� ���tT���"34wmv��z��F�M�����A��2t�/˱a�)8{�(����3�������Ɦβ��M>��W��ާ���o�A'��QB����0����Jx�'�řmX���n���Ϡ�4t��u%��gP���?C��'�����@-     