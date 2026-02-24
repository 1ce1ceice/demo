--
-- PostgreSQL database dump
--

\restrict PuCRKcLZ1bivYEfyqHBWyROXjr24KC4GUE7YwZb6XtNFadUKtUSljYBXaV278f7

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

-- Started on 2026-02-18 20:03:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 245 (class 1255 OID 16801)
-- Name: try_parse_date(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.try_parse_date(p_text text) RETURNS date
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF p_text IS NULL OR btrim(p_text) = '' THEN
    RETURN NULL;
  END IF;

  BEGIN
    RETURN (p_text::timestamp)::date;
  EXCEPTION WHEN others THEN
    NULL;
  END;

  BEGIN
    RETURN to_date(p_text, 'DD.MM.YYYY');
  EXCEPTION WHEN others THEN
    RETURN NULL;
  END;
END;
$$;


ALTER FUNCTION public.try_parse_date(p_text text) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 227 (class 1259 OID 16614)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16613)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 226
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 231 (class 1259 OID 16640)
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturers (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.manufacturers OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16639)
-- Name: manufacturers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manufacturers_id_seq OWNER TO postgres;

--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 230
-- Name: manufacturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturers_id_seq OWNED BY public.manufacturers.id;


--
-- TOC entry 243 (class 1259 OID 16766)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    qty integer NOT NULL,
    CONSTRAINT order_items_qty_check CHECK ((qty > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16765)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 242
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 237 (class 1259 OID 16679)
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_statuses (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16678)
-- Name: order_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_statuses_id_seq OWNER TO postgres;

--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 236
-- Name: order_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_statuses_id_seq OWNED BY public.order_statuses.id;


--
-- TOC entry 241 (class 1259 OID 16735)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    order_number integer NOT NULL,
    order_date date NOT NULL,
    delivery_date date,
    pickup_point_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    pickup_code integer NOT NULL,
    status_id bigint NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16734)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 240
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 235 (class 1259 OID 16666)
-- Name: pickup_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_points (
    id bigint NOT NULL,
    address text NOT NULL
);


ALTER TABLE public.pickup_points OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16665)
-- Name: pickup_points_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pickup_points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pickup_points_id_seq OWNER TO postgres;

--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 234
-- Name: pickup_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickup_points_id_seq OWNED BY public.pickup_points.id;


--
-- TOC entry 239 (class 1259 OID 16692)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    article text NOT NULL,
    name text NOT NULL,
    unit_id bigint NOT NULL,
    price numeric(12,2) NOT NULL,
    supplier_id bigint,
    manufacturer_id bigint,
    category_id bigint,
    discount integer DEFAULT 0 NOT NULL,
    stock_qty integer DEFAULT 0 NOT NULL,
    description text,
    photo text,
    CONSTRAINT products_discount_check CHECK ((discount >= 0)),
    CONSTRAINT products_price_check CHECK ((price >= (0)::numeric)),
    CONSTRAINT products_stock_qty_check CHECK ((stock_qty >= 0))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16691)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 238
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 223 (class 1259 OID 16580)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16579)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 222
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 244 (class 1259 OID 16796)
-- Name: stg_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stg_orders (
    order_number text,
    items_raw text,
    order_date text,
    delivery_date text,
    pickup_point_no text,
    customer_full_name text,
    pickup_code text,
    status_name text
);


ALTER TABLE public.stg_orders OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16574)
-- Name: stg_pickup_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stg_pickup_points (
    address text
);


ALTER TABLE public.stg_pickup_points OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16564)
-- Name: stg_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stg_products (
    article text,
    product_name text,
    unit_name text,
    price numeric,
    supplier_name text,
    manufacturer_name text,
    category_name text,
    discount integer,
    stock_qty integer,
    description text,
    photo text
);


ALTER TABLE public.stg_products OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16559)
-- Name: stg_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stg_users (
    role_name text,
    full_name text,
    login text,
    password text
);


ALTER TABLE public.stg_users OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16627)
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16626)
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_id_seq OWNER TO postgres;

--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 228
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- TOC entry 233 (class 1259 OID 16653)
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.units OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16652)
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.units_id_seq OWNER TO postgres;

--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 232
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- TOC entry 225 (class 1259 OID 16593)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    full_name text NOT NULL,
    login text NOT NULL,
    password text NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16592)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4824 (class 2604 OID 16617)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4826 (class 2604 OID 16643)
-- Name: manufacturers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers ALTER COLUMN id SET DEFAULT nextval('public.manufacturers_id_seq'::regclass);


--
-- TOC entry 4834 (class 2604 OID 16769)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 4829 (class 2604 OID 16682)
-- Name: order_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses ALTER COLUMN id SET DEFAULT nextval('public.order_statuses_id_seq'::regclass);


--
-- TOC entry 4833 (class 2604 OID 16738)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4828 (class 2604 OID 16669)
-- Name: pickup_points id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points ALTER COLUMN id SET DEFAULT nextval('public.pickup_points_id_seq'::regclass);


--
-- TOC entry 4830 (class 2604 OID 16695)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 4822 (class 2604 OID 16583)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4825 (class 2604 OID 16630)
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- TOC entry 4827 (class 2604 OID 16656)
-- Name: units id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- TOC entry 4823 (class 2604 OID 16596)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5048 (class 0 OID 16614)
-- Dependencies: 227
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name) FROM stdin;
7	Женская обувь
8	Мужская обувь
\.


--
-- TOC entry 5052 (class 0 OID 16640)
-- Dependencies: 231
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manufacturers (id, name) FROM stdin;
19	Рос
20	Marco Tozzi
21	Rieker
22	Alessio Nesca
23	Kari
24	CROSBY
\.


--
-- TOC entry 5064 (class 0 OID 16766)
-- Dependencies: 243
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, qty) FROM stdin;
1	12	91	2
2	12	92	2
3	5	93	1
4	5	94	1
5	6	95	10
6	6	96	10
7	8	97	5
8	8	98	4
9	11	91	2
10	11	92	2
11	4	93	1
12	4	94	1
13	7	97	5
14	7	98	4
15	10	99	5
16	10	100	1
17	9	101	5
18	9	102	5
\.


--
-- TOC entry 5058 (class 0 OID 16679)
-- Dependencies: 237
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_statuses (id, name) FROM stdin;
7	Новый 
8	Завершен
\.


--
-- TOC entry 5062 (class 0 OID 16735)
-- Dependencies: 241
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_number, order_date, delivery_date, pickup_point_id, customer_id, pickup_code, status_id) FROM stdin;
4	6	2025-03-01	2025-04-25	15	41	906	8
5	2	2022-09-28	2025-04-21	11	41	902	8
6	3	2025-03-21	2025-04-22	2	42	903	8
7	8	2025-03-31	2025-04-27	19	43	908	7
8	4	2025-02-20	2025-04-23	11	43	904	8
9	10	2025-04-03	2025-04-29	19	44	910	7
10	9	2025-04-02	2025-04-28	5	44	909	7
11	5	2025-03-17	2025-04-24	2	44	905	8
12	1	2025-02-27	2025-04-20	1	44	901	8
\.


--
-- TOC entry 5056 (class 0 OID 16666)
-- Dependencies: 235
-- Data for Name: pickup_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pickup_points (id, address) FROM stdin;
1	125837, г. Лесной, ул. Шоссейная, 40
2	394242, г. Лесной, ул. Коммунистическая, 43
3	625283, г. Лесной, ул. Победы, 46
4	603002, г. Лесной, ул. Дзержинского, 28
5	625683, г. Лесной, ул. 8 Марта
6	630370, г. Лесной, ул. Шоссейная, 24
7	410661, г. Лесной, ул. Школьная, 50
8	660540, г. Лесной, ул. Солнечная, 25
9	420151, г. Лесной, ул. Вишневая, 32
10	603036, г. Лесной, ул. Садовая, 4
11	450558, г. Лесной, ул. Набережная, 30
12	190949, г. Лесной, ул. Мичурина, 26
13	450983, г.Лесной, ул. Комсомольская, 26
14	454311, г.Лесной, ул. Новая, 19
15	614510, г. Лесной, ул. Маяковского, 47
16	443890, г. Лесной, ул. Коммунистическая, 1
17	410542, г. Лесной, ул. Светлая, 46
18	394060, г.Лесной, ул. Фрунзе, 43
19	394782, г. Лесной, ул. Чехова, 3
20	630201, г. Лесной, ул. Комсомольская, 17
21	614164, г.Лесной,  ул. Степная, 30
22	125061, г. Лесной, ул. Подгорная, 8
23	625560, г. Лесной, ул. Некрасова, 12
24	426030, г. Лесной, ул. Маяковского, 44
25	625590, г. Лесной, ул. Коммунистическая, 20
26	614753, г. Лесной, ул. Полевая, 35
27	400562, г. Лесной, ул. Зеленая, 32
28	344288, г. Лесной, ул. Чехова, 1
29	660007, г.Лесной, ул. Октябрьская, 19
30	603379, г. Лесной, ул. Спортивная, 46
31	614611, г. Лесной, ул. Молодежная, 50
32	603721, г. Лесной, ул. Гоголя, 41
33	450375, г. Лесной ул. Клубная, 44
34	410172, г. Лесной, ул. Северная, 13
35	620839, г. Лесной, ул. Цветочная, 8
36	125703, г. Лесной, ул. Партизанская, 49
\.


--
-- TOC entry 5060 (class 0 OID 16692)
-- Dependencies: 239
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, discount, stock_qty, description, photo) FROM stdin;
91	А112Т4	Ботинки	4	4990.00	8	23	7	3	6	Женские Ботинки демисезонные kari	1.jpg
92	F635R4	Ботинки	4	3244.00	7	20	7	2	13	Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый	2.jpg
93	H782T5	Туфли	4	4499.00	8	23	8	4	5	Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный	3.jpg
94	G783F5	Ботинки	4	5900.00	8	19	8	2	8	Мужские ботинки Рос-Обувь кожаные с натуральным мехом	4.jpg
95	J384T6	Ботинки	4	3800.00	7	21	8	2	16	B3430/14 Полуботинки мужские Rieker	5.jpg
96	D572U8	Кроссовки	4	4100.00	7	19	8	3	6	129615-4 Кроссовки мужские	6.jpg
97	F572H7	Туфли	4	2700.00	8	20	7	2	14	Туфли Marco Tozzi женские летние, размер 39, цвет черный	7.jpg
98	D329H3	Полуботинки	4	1890.00	7	22	7	4	4	Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый	8.jpg
99	B320R5	Туфли	4	4300.00	8	21	7	2	6	Туфли Rieker женские демисезонные, размер 41, цвет коричневый	9.jpg
100	G432E4	Туфли	4	2800.00	8	23	7	3	15	Туфли kari женские TR-YR-413017, размер 37, цвет: черный	10.jpg
101	S213E3	Полуботинки	4	2156.00	7	24	8	3	6	407700/01-01 Полуботинки мужские CROSBY	\N
102	E482R4	Полуботинки	4	1800.00	8	23	7	2	14	Полуботинки kari женские MYZ20S-149, размер 41, цвет: черный	\N
103	S634B5	Кеды	4	5500.00	7	24	8	3	6	Кеды Caprice мужские демисезонные, размер 42, цвет черный	\N
104	K345R4	Полуботинки	4	2100.00	7	24	8	2	3	407700/01-02 Полуботинки мужские CROSBY	\N
105	O754F4	Туфли	4	5400.00	7	21	7	4	18	Туфли женские демисезонные Rieker артикул 55073-68/37	\N
106	G531F4	Ботинки	4	6600.00	8	23	7	2	9	Ботинки женские зимние ROMER арт. 893167-01 Черный	\N
107	J542F5	Тапочки	4	500.00	8	23	8	3	12	Тапочки мужские Арт.70701-55-67син р.41	\N
108	B431R5	Ботинки	4	2700.00	7	21	8	2	5	Мужские кожаные ботинки/мужские ботинки	\N
109	P764G4	Туфли	4	6800.00	8	24	7	3	15	Туфли женские, ARGO, размер 38	\N
110	C436G5	Ботинки	4	10200.00	8	22	7	2	9	Ботинки женские, ARGO, размер 40	\N
111	F427R5	Ботинки	4	11800.00	7	21	7	4	11	Ботинки на молнии с декоративной пряжкой FRAU	\N
112	N457T5	Полуботинки	4	4600.00	8	24	7	3	13	Полуботинки Ботинки черные зимние, мех	\N
113	D364R4	Туфли	4	12400.00	8	23	7	2	5	Туфли Luiza Belly женские Kate-lazo черные из натуральной замши	\N
114	S326R5	Тапочки	4	9900.00	7	24	8	3	15	Мужские кожаные тапочки Профиль С.Дали 	\N
115	L754R4	Полуботинки	4	1700.00	8	23	7	2	7	Полуботинки kari женские WB2020SS-26, размер 38, цвет: черный	\N
116	M542T5	Кроссовки	4	2800.00	7	21	8	5	3	Кроссовки мужские TOFA	\N
117	D268G5	Туфли	4	4399.00	7	21	7	3	12	Туфли Rieker женские демисезонные, размер 36, цвет коричневый	\N
118	T324F5	Сапоги	4	4699.00	8	24	7	2	5	Сапоги замша Цвет: синий	\N
119	K358H6	Тапочки	4	599.00	8	21	8	3	2	Тапочки мужские син р.41	\N
120	H535R5	Ботинки	4	2300.00	7	21	7	2	7	Женские Ботинки демисезонные	\N
\.


--
-- TOC entry 5044 (class 0 OID 16580)
-- Dependencies: 223
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	Авторизированный клиент
2	Менеджер
3	Администратор
\.


--
-- TOC entry 5065 (class 0 OID 16796)
-- Dependencies: 244
-- Data for Name: stg_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stg_orders (order_number, items_raw, order_date, delivery_date, pickup_point_no, customer_full_name, pickup_code, status_name) FROM stdin;
1	А112Т4, 2, F635R4, 2	2025-02-27 00:00:00	2025-04-20	1	Степанов Михаил Артёмович	901	Завершен
2	H782T5, 1, G783F5, 1	2022-09-28 00:00:00	2025-04-21	11	Никифорова Весения Николаевна	902	Завершен
3	J384T6, 10, D572U8, 10	2025-03-21 00:00:00	2025-04-22	2	Сазонов Руслан Германович	903	Завершен
4	F572H7, 5, D329H3, 4	2025-02-20 00:00:00	2025-04-23	11	Одинцов Серафим Артёмович	904	Завершен
5	А112Т4, 2, F635R4, 2	2025-03-17 00:00:00	2025-04-24	2	Степанов Михаил Артёмович	905	Завершен
6	H782T5, 1, G783F5, 1	2025-03-01 00:00:00	2025-04-25	15	Никифорова Весения Николаевна	906	Завершен
7	J384T6, 10, D572U8, 10	30.02.2025	2025-04-26	3	Сазонов Руслан Германович	907	Завершен
8	F572H7, 5, D329H3, 4	2025-03-31 00:00:00	2025-04-27	19	Одинцов Серафим Артёмович	908	Новый 
9	B320R5, 5, G432E4, 1	2025-04-02 00:00:00	2025-04-28	5	Степанов Михаил Артёмович	909	Новый 
10	S213E3, 5, E482R4, 5	2025-04-03 00:00:00	2025-04-29	19	Степанов Михаил Артёмович	910	Новый 
\.


--
-- TOC entry 5042 (class 0 OID 16574)
-- Dependencies: 221
-- Data for Name: stg_pickup_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stg_pickup_points (address) FROM stdin;
420151, г. Лесной, ул. Вишневая, 32
125061, г. Лесной, ул. Подгорная, 8
630370, г. Лесной, ул. Шоссейная, 24
400562, г. Лесной, ул. Зеленая, 32
614510, г. Лесной, ул. Маяковского, 47
410542, г. Лесной, ул. Светлая, 46
620839, г. Лесной, ул. Цветочная, 8
443890, г. Лесной, ул. Коммунистическая, 1
603379, г. Лесной, ул. Спортивная, 46
603721, г. Лесной, ул. Гоголя, 41
410172, г. Лесной, ул. Северная, 13
614611, г. Лесной, ул. Молодежная, 50
454311, г.Лесной, ул. Новая, 19
660007, г.Лесной, ул. Октябрьская, 19
603036, г. Лесной, ул. Садовая, 4
394060, г.Лесной, ул. Фрунзе, 43
410661, г. Лесной, ул. Школьная, 50
625590, г. Лесной, ул. Коммунистическая, 20
625683, г. Лесной, ул. 8 Марта
450983, г.Лесной, ул. Комсомольская, 26
394782, г. Лесной, ул. Чехова, 3
603002, г. Лесной, ул. Дзержинского, 28
450558, г. Лесной, ул. Набережная, 30
344288, г. Лесной, ул. Чехова, 1
614164, г.Лесной,  ул. Степная, 30
394242, г. Лесной, ул. Коммунистическая, 43
660540, г. Лесной, ул. Солнечная, 25
125837, г. Лесной, ул. Шоссейная, 40
125703, г. Лесной, ул. Партизанская, 49
625283, г. Лесной, ул. Победы, 46
614753, г. Лесной, ул. Полевая, 35
426030, г. Лесной, ул. Маяковского, 44
450375, г. Лесной ул. Клубная, 44
625560, г. Лесной, ул. Некрасова, 12
630201, г. Лесной, ул. Комсомольская, 17
190949, г. Лесной, ул. Мичурина, 26
\.


--
-- TOC entry 5041 (class 0 OID 16564)
-- Dependencies: 220
-- Data for Name: stg_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stg_products (article, product_name, unit_name, price, supplier_name, manufacturer_name, category_name, discount, stock_qty, description, photo) FROM stdin;
А112Т4	Ботинки	шт.	4990	Kari	Kari	Женская обувь	3	6	Женские Ботинки демисезонные kari	1.jpg
F635R4	Ботинки	шт.	3244	Обувь для вас	Marco Tozzi	Женская обувь	2	13	Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый	2.jpg
H782T5	Туфли	шт.	4499	Kari	Kari	Мужская обувь	4	5	Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный	3.jpg
G783F5	Ботинки	шт.	5900	Kari	Рос	Мужская обувь	2	8	Мужские ботинки Рос-Обувь кожаные с натуральным мехом	4.jpg
J384T6	Ботинки	шт.	3800	Обувь для вас	Rieker	Мужская обувь	2	16	B3430/14 Полуботинки мужские Rieker	5.jpg
D572U8	Кроссовки	шт.	4100	Обувь для вас	Рос	Мужская обувь	3	6	129615-4 Кроссовки мужские	6.jpg
F572H7	Туфли	шт.	2700	Kari	Marco Tozzi	Женская обувь	2	14	Туфли Marco Tozzi женские летние, размер 39, цвет черный	7.jpg
D329H3	Полуботинки	шт.	1890	Обувь для вас	Alessio Nesca	Женская обувь	4	4	Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый	8.jpg
B320R5	Туфли	шт.	4300	Kari	Rieker	Женская обувь	2	6	Туфли Rieker женские демисезонные, размер 41, цвет коричневый	9.jpg
G432E4	Туфли	шт.	2800	Kari	Kari	Женская обувь	3	15	Туфли kari женские TR-YR-413017, размер 37, цвет: черный	10.jpg
S213E3	Полуботинки	шт.	2156	Обувь для вас	CROSBY	Мужская обувь	3	6	407700/01-01 Полуботинки мужские CROSBY	\N
E482R4	Полуботинки	шт.	1800	Kari	Kari	Женская обувь	2	14	Полуботинки kari женские MYZ20S-149, размер 41, цвет: черный	\N
S634B5	Кеды	шт.	5500	Обувь для вас	CROSBY	Мужская обувь	3	6	Кеды Caprice мужские демисезонные, размер 42, цвет черный	\N
K345R4	Полуботинки	шт.	2100	Обувь для вас	CROSBY	Мужская обувь	2	3	407700/01-02 Полуботинки мужские CROSBY	\N
O754F4	Туфли	шт.	5400	Обувь для вас	Rieker	Женская обувь	4	18	Туфли женские демисезонные Rieker артикул 55073-68/37	\N
G531F4	Ботинки	шт.	6600	Kari	Kari	Женская обувь	2	9	Ботинки женские зимние ROMER арт. 893167-01 Черный	\N
J542F5	Тапочки	шт.	500	Kari	Kari	Мужская обувь	3	12	Тапочки мужские Арт.70701-55-67син р.41	\N
B431R5	Ботинки	шт.	2700	Обувь для вас	Rieker	Мужская обувь	2	5	Мужские кожаные ботинки/мужские ботинки	\N
P764G4	Туфли	шт.	6800	Kari	CROSBY	Женская обувь	3	15	Туфли женские, ARGO, размер 38	\N
C436G5	Ботинки	шт.	10200	Kari	Alessio Nesca	Женская обувь	2	9	Ботинки женские, ARGO, размер 40	\N
F427R5	Ботинки	шт.	11800	Обувь для вас	Rieker	Женская обувь	4	11	Ботинки на молнии с декоративной пряжкой FRAU	\N
N457T5	Полуботинки	шт.	4600	Kari	CROSBY	Женская обувь	3	13	Полуботинки Ботинки черные зимние, мех	\N
D364R4	Туфли	шт.	12400	Kari	Kari	Женская обувь	2	5	Туфли Luiza Belly женские Kate-lazo черные из натуральной замши	\N
S326R5	Тапочки	шт.	9900	Обувь для вас	CROSBY	Мужская обувь	3	15	Мужские кожаные тапочки Профиль С.Дали 	\N
L754R4	Полуботинки	шт.	1700	Kari	Kari	Женская обувь	2	7	Полуботинки kari женские WB2020SS-26, размер 38, цвет: черный	\N
M542T5	Кроссовки	шт.	2800	Обувь для вас	Rieker	Мужская обувь	5	3	Кроссовки мужские TOFA	\N
D268G5	Туфли	шт.	4399	Обувь для вас	Rieker	Женская обувь	3	12	Туфли Rieker женские демисезонные, размер 36, цвет коричневый	\N
T324F5	Сапоги	шт.	4699	Kari	CROSBY	Женская обувь	2	5	Сапоги замша Цвет: синий	\N
K358H6	Тапочки	шт.	599	Kari	Rieker	Мужская обувь	3	2	Тапочки мужские син р.41	\N
H535R5	Ботинки	шт.	2300	Обувь для вас	Rieker	Женская обувь	2	7	Женские Ботинки демисезонные	\N
\.


--
-- TOC entry 5040 (class 0 OID 16559)
-- Dependencies: 219
-- Data for Name: stg_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stg_users (role_name, full_name, login, password) FROM stdin;
Администратор	Никифорова Весения Николаевна	94d5ous@gmail.com	uzWC67
Администратор	Сазонов Руслан Германович	uth4iz@mail.com	2L6KZG
Администратор	Одинцов Серафим Артёмович	yzls62@outlook.com	JlFRCZ
Менеджер	Степанов Михаил Артёмович	1diph5e@tutanota.com	8ntwUp
Менеджер	Ворсин Петр Евгеньевич	tjde7c@yahoo.com	YOyhfR
Менеджер	Старикова Елена Павловна	wpmrc3do@tutanota.com	RSbvHv
Авторизированный клиент	Михайлюк Анна Вячеславовна	5d4zbu@tutanota.com	rwVDh9
Авторизированный клиент	Ситдикова Елена Анатольевна	ptec8ym@yahoo.com	LdNyos
Авторизированный клиент	Ворсин Петр Евгеньевич	1qz4kw@mail.com	gynQMT
Авторизированный клиент	Старикова Елена Павловна	4np6se@mail.com	AtnDjr
\.


--
-- TOC entry 5050 (class 0 OID 16627)
-- Dependencies: 229
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, name) FROM stdin;
7	Обувь для вас
8	Kari
\.


--
-- TOC entry 5054 (class 0 OID 16653)
-- Dependencies: 233
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.units (id, name) FROM stdin;
4	шт.
\.


--
-- TOC entry 5046 (class 0 OID 16593)
-- Dependencies: 225
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, full_name, login, password, role_id) FROM stdin;
41	Никифорова Весения Николаевна	94d5ous@gmail.com	uzWC67	3
42	Сазонов Руслан Германович	uth4iz@mail.com	2L6KZG	3
43	Одинцов Серафим Артёмович	yzls62@outlook.com	JlFRCZ	3
44	Степанов Михаил Артёмович	1diph5e@tutanota.com	8ntwUp	2
45	Ворсин Петр Евгеньевич	tjde7c@yahoo.com	YOyhfR	2
46	Старикова Елена Павловна	wpmrc3do@tutanota.com	RSbvHv	2
47	Михайлюк Анна Вячеславовна	5d4zbu@tutanota.com	rwVDh9	1
48	Ситдикова Елена Анатольевна	ptec8ym@yahoo.com	LdNyos	1
49	Ворсин Петр Евгеньевич	1qz4kw@mail.com	gynQMT	1
50	Старикова Елена Павловна	4np6se@mail.com	AtnDjr	1
\.


--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 226
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 8, true);


--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 230
-- Name: manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturers_id_seq', 24, true);


--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 242
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 18, true);


--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 236
-- Name: order_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_statuses_id_seq', 8, true);


--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 240
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 21, true);


--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 234
-- Name: pickup_points_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickup_points_id_seq', 36, true);


--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 238
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 120, true);


--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 222
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 18, true);


--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 228
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 8, true);


--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 232
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.units_id_seq', 4, true);


--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 50, true);


--
-- TOC entry 4848 (class 2606 OID 16625)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4850 (class 2606 OID 16623)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4856 (class 2606 OID 16651)
-- Name: manufacturers manufacturers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_name_key UNIQUE (name);


--
-- TOC entry 4858 (class 2606 OID 16649)
-- Name: manufacturers manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY (id);


--
-- TOC entry 4880 (class 2606 OID 16778)
-- Name: order_items order_items_order_id_product_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_product_id_key UNIQUE (order_id, product_id);


--
-- TOC entry 4882 (class 2606 OID 16776)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4868 (class 2606 OID 16690)
-- Name: order_statuses order_statuses_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_name_key UNIQUE (name);


--
-- TOC entry 4870 (class 2606 OID 16688)
-- Name: order_statuses order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 4876 (class 2606 OID 16749)
-- Name: orders orders_order_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_number_key UNIQUE (order_number);


--
-- TOC entry 4878 (class 2606 OID 16747)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 16677)
-- Name: pickup_points pickup_points_address_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_address_key UNIQUE (address);


--
-- TOC entry 4866 (class 2606 OID 16675)
-- Name: pickup_points pickup_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);


--
-- TOC entry 4872 (class 2606 OID 16713)
-- Name: products products_article_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_article_key UNIQUE (article);


--
-- TOC entry 4874 (class 2606 OID 16711)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4840 (class 2606 OID 16591)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4842 (class 2606 OID 16589)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4852 (class 2606 OID 16638)
-- Name: suppliers suppliers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_name_key UNIQUE (name);


--
-- TOC entry 4854 (class 2606 OID 16636)
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- TOC entry 4860 (class 2606 OID 16664)
-- Name: units units_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_name_key UNIQUE (name);


--
-- TOC entry 4862 (class 2606 OID 16662)
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- TOC entry 4844 (class 2606 OID 16607)
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- TOC entry 4846 (class 2606 OID 16605)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4891 (class 2606 OID 16779)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4892 (class 2606 OID 16784)
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 4888 (class 2606 OID 16755)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.users(id);


--
-- TOC entry 4889 (class 2606 OID 16750)
-- Name: orders orders_pickup_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pickup_point_id_fkey FOREIGN KEY (pickup_point_id) REFERENCES public.pickup_points(id);


--
-- TOC entry 4890 (class 2606 OID 16760)
-- Name: orders orders_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_statuses(id);


--
-- TOC entry 4884 (class 2606 OID 16729)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 4885 (class 2606 OID 16724)
-- Name: products products_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturers(id);


--
-- TOC entry 4886 (class 2606 OID 16719)
-- Name: products products_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- TOC entry 4887 (class 2606 OID 16714)
-- Name: products products_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- TOC entry 4883 (class 2606 OID 16608)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


-- Completed on 2026-02-18 20:03:24

--
-- PostgreSQL database dump complete
--

\unrestrict PuCRKcLZ1bivYEfyqHBWyROXjr24KC4GUE7YwZb6XtNFadUKtUSljYBXaV278f7

