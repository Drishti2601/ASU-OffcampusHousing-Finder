--
-- PostgreSQL database dump
--

\restrict 6mmFNLmPp3ls7QD61dgn7MjjuDMkr1Y6xAJLncSAvTgK3eDJXEgLiYZNilh3Ta9

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: apartmentunit; Type: TABLE; Schema: public; Owner: drish
--

CREATE TABLE public.apartmentunit (
    unitid integer NOT NULL,
    propertyid integer NOT NULL,
    unitnumber character varying(20) NOT NULL,
    bedrooms integer NOT NULL,
    bathrooms integer NOT NULL,
    squarefeet integer NOT NULL,
    floornumber integer NOT NULL,
    monthlyrent numeric(10,2) NOT NULL,
    securitydeposit numeric(10,2) NOT NULL,
    leaselength character varying(50) NOT NULL,
    availabledate date NOT NULL,
    unitamenities text,
    utilities text,
    unitimageurl character varying(500),
    isavailable boolean DEFAULT true NOT NULL,
    CONSTRAINT apartmentunit_bathrooms_check CHECK ((bathrooms >= 1)),
    CONSTRAINT apartmentunit_bedrooms_check CHECK ((bedrooms >= 0)),
    CONSTRAINT apartmentunit_floornumber_check CHECK ((floornumber >= 1)),
    CONSTRAINT apartmentunit_monthlyrent_check CHECK ((monthlyrent > (0)::numeric)),
    CONSTRAINT apartmentunit_securitydeposit_check CHECK ((securitydeposit >= (0)::numeric)),
    CONSTRAINT apartmentunit_squarefeet_check CHECK ((squarefeet > 0))
);


ALTER TABLE public.apartmentunit OWNER TO drish;

--
-- Name: apartmentunit_unitid_seq; Type: SEQUENCE; Schema: public; Owner: drish
--

CREATE SEQUENCE public.apartmentunit_unitid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.apartmentunit_unitid_seq OWNER TO drish;

--
-- Name: apartmentunit_unitid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drish
--

ALTER SEQUENCE public.apartmentunit_unitid_seq OWNED BY public.apartmentunit.unitid;


--
-- Name: favorite; Type: TABLE; Schema: public; Owner: drish
--

CREATE TABLE public.favorite (
    favoriteid integer NOT NULL,
    studentid integer NOT NULL,
    unitid integer NOT NULL,
    datesaved timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.favorite OWNER TO drish;

--
-- Name: favorite_favoriteid_seq; Type: SEQUENCE; Schema: public; Owner: drish
--

CREATE SEQUENCE public.favorite_favoriteid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favorite_favoriteid_seq OWNER TO drish;

--
-- Name: favorite_favoriteid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drish
--

ALTER SEQUENCE public.favorite_favoriteid_seq OWNED BY public.favorite.favoriteid;


--
-- Name: property; Type: TABLE; Schema: public; Owner: drish
--

CREATE TABLE public.property (
    propertyid integer NOT NULL,
    managerid integer NOT NULL,
    propertyname character varying(200) NOT NULL,
    streetaddress character varying(300) NOT NULL,
    city character varying(100) NOT NULL,
    state character varying(2) NOT NULL,
    zipcode character varying(10) NOT NULL,
    distancefromcampus numeric(4,2) NOT NULL,
    propertytype character varying(50) NOT NULL,
    availableunits jsonb NOT NULL,
    buildingamenities text,
    petpolicy character varying(255),
    description text,
    propertyimageurl character varying(500),
    CONSTRAINT property_distancefromcampus_check CHECK ((distancefromcampus >= (0)::numeric)),
    CONSTRAINT property_propertytype_check CHECK (((propertytype)::text = ANY ((ARRAY['Apartment Complex'::character varying, 'Townhomes'::character varying, 'Student Housing'::character varying])::text[])))
);


ALTER TABLE public.property OWNER TO drish;

--
-- Name: property_propertyid_seq; Type: SEQUENCE; Schema: public; Owner: drish
--

CREATE SEQUENCE public.property_propertyid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.property_propertyid_seq OWNER TO drish;

--
-- Name: property_propertyid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drish
--

ALTER SEQUENCE public.property_propertyid_seq OWNED BY public.property.propertyid;


--
-- Name: propertymanager; Type: TABLE; Schema: public; Owner: drish
--

CREATE TABLE public.propertymanager (
    managerid integer NOT NULL,
    companyname character varying(200) NOT NULL,
    contactpersonname character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phonenumber character varying(15) NOT NULL,
    password character varying(255) NOT NULL,
    website character varying(255),
    officeaddress character varying(300) NOT NULL,
    licensenumber character varying(50) NOT NULL,
    description text,
    registrationdate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.propertymanager OWNER TO drish;

--
-- Name: propertymanager_managerid_seq; Type: SEQUENCE; Schema: public; Owner: drish
--

CREATE SEQUENCE public.propertymanager_managerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.propertymanager_managerid_seq OWNER TO drish;

--
-- Name: propertymanager_managerid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drish
--

ALTER SEQUENCE public.propertymanager_managerid_seq OWNED BY public.propertymanager.managerid;


--
-- Name: student; Type: TABLE; Schema: public; Owner: drish
--

CREATE TABLE public.student (
    studentid integer NOT NULL,
    firstname character varying(100) NOT NULL,
    lastname character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phonenumber character varying(15) NOT NULL,
    password character varying(255) NOT NULL,
    major character varying(100) NOT NULL,
    currentyear character varying(20) NOT NULL,
    preferredmoveindate date,
    registrationdate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT student_currentyear_check CHECK (((currentyear)::text = ANY ((ARRAY['Freshman'::character varying, 'Sophomore'::character varying, 'Junior'::character varying, 'Senior'::character varying, 'Graduate'::character varying])::text[])))
);


ALTER TABLE public.student OWNER TO drish;

--
-- Name: student_studentid_seq; Type: SEQUENCE; Schema: public; Owner: drish
--

CREATE SEQUENCE public.student_studentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_studentid_seq OWNER TO drish;

--
-- Name: student_studentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drish
--

ALTER SEQUENCE public.student_studentid_seq OWNED BY public.student.studentid;


--
-- Name: apartmentunit unitid; Type: DEFAULT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.apartmentunit ALTER COLUMN unitid SET DEFAULT nextval('public.apartmentunit_unitid_seq'::regclass);


--
-- Name: favorite favoriteid; Type: DEFAULT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.favorite ALTER COLUMN favoriteid SET DEFAULT nextval('public.favorite_favoriteid_seq'::regclass);


--
-- Name: property propertyid; Type: DEFAULT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.property ALTER COLUMN propertyid SET DEFAULT nextval('public.property_propertyid_seq'::regclass);


--
-- Name: propertymanager managerid; Type: DEFAULT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.propertymanager ALTER COLUMN managerid SET DEFAULT nextval('public.propertymanager_managerid_seq'::regclass);


--
-- Name: student studentid; Type: DEFAULT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.student ALTER COLUMN studentid SET DEFAULT nextval('public.student_studentid_seq'::regclass);


--
-- Data for Name: apartmentunit; Type: TABLE DATA; Schema: public; Owner: drish
--

COPY public.apartmentunit (unitid, propertyid, unitnumber, bedrooms, bathrooms, squarefeet, floornumber, monthlyrent, securitydeposit, leaselength, availabledate, unitamenities, utilities, unitimageurl, isavailable) FROM stdin;
1	1	101	2	2	1047	1	1550.00	1550.00	9 months	2025-06-06	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
2	1	#102	2	2	1144	1	2100.00	2100.00	12 months	2025-08-13	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
3	1	#103	1	1	690	1	1250.00	1250.00	15 months	2025-07-17	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
4	1	E104	0	1	589	1	1150.00	1150.00	6 months	2025-08-26	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
5	1	#105	2	2	1037	1	1500.00	1500.00	9 months	2025-05-09	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
6	1	#106	3	3	1489	1	2300.00	2300.00	9 months	2025-08-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
7	1	#107	1	1	842	1	1100.00	1100.00	6 months	2025-05-13	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
8	1	108	0	1	449	1	900.00	900.00	15 months	2025-06-13	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
9	1	#201	2	2	1174	2	1450.00	1450.00	12 months	2025-07-10	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
10	1	#202	2	2	1099	2	1550.00	1550.00	12 months (academic year)	2025-08-09	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
11	1	203	3	3	1544	2	2400.00	2400.00	12 months	2025-07-06	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
12	1	204	3	3	1426	2	2250.00	2250.00	12 months	2025-05-23	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
13	1	#205	1	1	698	2	1100.00	1100.00	6 months	2025-06-12	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
14	1	#206	1	1	740	2	1250.00	1250.00	6 months	2025-05-29	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	f
15	1	H207	2	2	905	2	1450.00	1450.00	12 months	2025-06-05	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
16	1	208	2	2	1121	2	1700.00	1700.00	12 months	2025-08-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	f
17	1	B301	2	2	1019	3	1550.00	1550.00	6 months	2025-07-04	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
18	1	302	1	1	582	3	1400.00	1400.00	12 months (academic year)	2025-08-08	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	f
19	1	D303	2	2	864	3	1800.00	1800.00	15 months	2025-06-17	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
20	1	#304	1	1	765	3	1050.00	1050.00	9 months	2025-05-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
21	1	#305	1	1	571	3	1250.00	1250.00	9 months	2025-05-16	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
22	1	#306	2	2	928	3	1850.00	1850.00	12 months	2025-07-05	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
23	1	#307	1	1	688	3	1000.00	1000.00	15 months	2025-05-10	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
24	1	#308	1	1	790	3	1000.00	1000.00	12 months (academic year)	2025-07-27	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
25	1	401	0	1	580	4	850.00	850.00	15 months	2025-06-18	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
26	1	#402	1	1	753	4	1050.00	1050.00	12 months	2025-06-08	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
27	1	#403	1	1	596	4	1250.00	1250.00	6 months	2025-07-15	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	f
28	1	#404	0	1	513	4	950.00	950.00	12 months (academic year)	2025-08-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
29	1	F405	1	1	818	4	1450.00	1450.00	9 months	2025-08-04	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
30	1	G406	0	1	573	4	900.00	900.00	12 months	2025-06-21	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
31	1	407	1	1	836	4	1100.00	1100.00	9 months	2025-07-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
32	1	#408	3	3	1566	4	2550.00	2550.00	12 months (academic year)	2025-07-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
33	1	B501	1	1	759	5	1050.00	1050.00	15 months	2025-07-26	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
34	1	C502	0	1	591	5	900.00	900.00	9 months	2025-05-31	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
35	1	D503	3	3	1331	5	2050.00	2050.00	15 months	2025-06-16	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
36	1	E504	2	2	894	5	1450.00	1450.00	9 months	2025-06-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
37	1	F505	3	3	1332	5	2600.00	2600.00	15 months	2025-07-14	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	f
38	1	506	2	2	1094	5	2150.00	2150.00	9 months	2025-05-09	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
39	1	507	3	3	1409	5	2150.00	2150.00	12 months (academic year)	2025-07-11	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
40	1	I508	2	2	934	5	1650.00	1650.00	15 months	2025-08-09	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
41	1	B601	1	1	789	6	1100.00	1100.00	12 months (academic year)	2025-07-22	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
42	1	602	1	1	652	6	1250.00	1250.00	12 months (academic year)	2025-05-05	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
43	1	#603	1	1	763	6	1350.00	1350.00	12 months (academic year)	2025-06-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	f
44	1	E604	2	2	872	6	1950.00	1950.00	15 months	2025-06-26	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
45	1	F605	1	1	579	6	1050.00	1050.00	6 months	2025-07-22	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
46	1	#606	2	2	966	6	1500.00	1500.00	9 months	2025-07-23	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
47	1	#607	3	3	1548	6	1800.00	1800.00	6 months	2025-06-13	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
48	1	I608	0	1	455	6	900.00	900.00	9 months	2025-05-17	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
49	1	701	2	2	1179	7	2050.00	2050.00	15 months	2025-06-30	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
50	1	C702	2	2	924	7	1700.00	1700.00	15 months	2025-08-11	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
51	1	D703	0	1	554	7	950.00	950.00	12 months	2025-05-19	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
52	1	704	2	2	1035	7	1900.00	1900.00	15 months	2025-07-12	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
53	1	705	1	1	840	7	1000.00	1000.00	12 months	2025-06-11	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
54	1	#706	3	3	1265	7	1850.00	1850.00	6 months	2025-07-24	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
55	1	707	3	3	1360	7	2500.00	2500.00	6 months	2025-08-27	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
56	1	708	2	2	1029	7	2000.00	2000.00	15 months	2025-05-22	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
57	2	#101	0	1	530	1	1000.00	1000.00	6 months	2025-06-25	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
58	2	#102	0	1	425	1	900.00	900.00	9 months	2025-07-21	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
59	2	#103	1	1	715	1	1100.00	1100.00	9 months	2025-06-24	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
60	2	#104	1	1	666	1	1150.00	1150.00	6 months	2025-08-03	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
61	2	#105	1	1	553	1	1300.00	1300.00	15 months	2025-08-07	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
62	2	#106	0	1	449	1	850.00	850.00	12 months	2025-06-10	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
63	2	#201	2	2	1132	2	1600.00	1600.00	15 months	2025-06-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
64	2	C202	0	1	433	2	1100.00	1100.00	12 months (academic year)	2025-08-08	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
65	2	203	2	2	1157	2	1800.00	1800.00	6 months	2025-06-14	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
66	2	E204	2	2	1047	2	1600.00	1600.00	15 months	2025-08-26	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
67	2	#205	2	2	1178	2	1950.00	1950.00	6 months	2025-08-12	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
68	2	G206	2	2	973	2	2050.00	2050.00	12 months	2025-07-21	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
69	2	301	1	1	576	3	1300.00	1300.00	12 months	2025-08-26	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
70	2	#302	2	2	1197	3	1500.00	1500.00	9 months	2025-05-05	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
71	2	#303	3	3	1576	3	2550.00	2550.00	12 months (academic year)	2025-06-01	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
72	2	304	2	2	1200	3	1900.00	1900.00	9 months	2025-08-29	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
73	2	F305	3	3	1216	3	1900.00	1900.00	12 months	2025-06-30	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
74	2	G306	3	3	1450	3	1800.00	1800.00	6 months	2025-06-27	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	f
75	2	B401	2	2	1124	4	1850.00	1850.00	6 months	2025-08-11	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
76	2	C402	2	2	1120	4	1650.00	1650.00	12 months (academic year)	2025-07-19	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
77	2	D403	1	1	613	4	1150.00	1150.00	6 months	2025-08-13	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
78	2	E404	1	1	827	4	1200.00	1200.00	6 months	2025-06-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
79	2	F405	3	3	1228	4	2050.00	2050.00	9 months	2025-08-02	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
80	2	#406	2	2	866	4	2000.00	2000.00	12 months	2025-07-01	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
81	2	#501	2	2	1009	5	1450.00	1450.00	15 months	2025-05-15	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
82	2	C502	1	1	754	5	1150.00	1150.00	12 months (academic year)	2025-08-12	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
83	2	503	1	1	716	5	1150.00	1150.00	6 months	2025-08-22	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
84	2	E504	3	3	1464	5	2300.00	2300.00	6 months	2025-07-21	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
85	2	#505	2	2	1152	5	1550.00	1550.00	15 months	2025-06-08	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
86	2	506	1	1	644	5	1350.00	1350.00	12 months (academic year)	2025-08-08	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
87	2	601	0	1	414	6	800.00	800.00	6 months	2025-06-15	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
88	2	C602	1	1	733	6	1250.00	1250.00	6 months	2025-05-28	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
89	2	D603	1	1	695	6	1100.00	1100.00	12 months (academic year)	2025-07-02	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
90	2	604	1	1	725	6	1300.00	1300.00	12 months (academic year)	2025-06-30	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
91	2	#605	1	1	687	6	1050.00	1050.00	12 months	2025-05-23	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
92	2	G606	2	2	1060	6	1450.00	1450.00	6 months	2025-08-23	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
93	2	701	3	3	1413	7	2400.00	2400.00	12 months	2025-06-28	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
94	2	C702	1	1	627	7	1250.00	1250.00	12 months	2025-06-11	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
95	2	703	2	2	1157	7	2000.00	2000.00	12 months (academic year)	2025-08-27	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
96	2	#704	0	1	551	7	800.00	800.00	6 months	2025-06-20	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
97	2	#705	3	3	1495	7	2500.00	2500.00	12 months	2025-06-24	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
98	2	706	0	1	529	7	850.00	850.00	12 months (academic year)	2025-08-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
99	2	#801	1	1	778	8	1300.00	1300.00	9 months	2025-07-28	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
100	2	802	2	2	925	8	1600.00	1600.00	6 months	2025-05-28	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
101	2	#803	3	3	1580	8	1950.00	1950.00	12 months	2025-07-10	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
102	2	804	1	1	734	8	1000.00	1000.00	12 months	2025-08-21	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
103	2	805	2	2	1144	8	1450.00	1450.00	6 months	2025-08-27	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	f
104	3	B101	0	1	517	1	900.00	900.00	9 months	2025-05-20	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
105	3	102	1	1	842	1	1050.00	1050.00	9 months	2025-08-23	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
106	3	D103	2	2	939	1	1950.00	1950.00	6 months	2025-08-25	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
107	3	E104	3	3	1409	1	2400.00	2400.00	12 months	2025-07-14	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
108	3	#105	0	1	400	1	800.00	800.00	12 months (academic year)	2025-06-27	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
109	3	106	1	1	556	1	1150.00	1150.00	9 months	2025-05-08	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
110	3	H107	0	1	477	1	850.00	850.00	6 months	2025-06-24	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
111	3	I108	1	1	686	1	1200.00	1200.00	6 months	2025-06-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
112	3	109	1	1	774	1	1450.00	1450.00	12 months	2025-07-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
113	3	K110	3	3	1517	1	2500.00	2500.00	15 months	2025-07-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	f
114	3	#111	2	2	1140	1	1650.00	1650.00	12 months (academic year)	2025-07-18	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
115	3	#112	1	1	722	1	1300.00	1300.00	6 months	2025-06-14	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
116	3	#201	2	2	858	2	1900.00	1900.00	15 months	2025-07-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
117	3	202	0	1	476	2	1050.00	1050.00	12 months	2025-09-01	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
118	3	#203	2	2	871	2	1850.00	1850.00	6 months	2025-05-13	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
119	3	E204	1	1	825	2	1450.00	1450.00	15 months	2025-08-15	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
120	3	F205	0	1	577	2	1050.00	1050.00	12 months (academic year)	2025-08-30	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
121	3	#206	2	2	1154	2	2150.00	2150.00	9 months	2025-07-10	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	f
122	3	#207	1	1	661	2	1200.00	1200.00	9 months	2025-08-03	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
123	3	208	1	1	605	2	1050.00	1050.00	6 months	2025-08-13	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
124	3	209	0	1	512	2	1100.00	1100.00	15 months	2025-07-12	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
125	3	210	1	1	776	2	1000.00	1000.00	12 months	2025-08-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
126	3	#211	2	2	1120	2	1950.00	1950.00	12 months (academic year)	2025-09-01	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
127	3	M212	1	1	756	2	1450.00	1450.00	9 months	2025-06-17	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
128	3	301	1	1	726	3	1350.00	1350.00	15 months	2025-07-15	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
129	3	C302	3	3	1364	3	2750.00	2750.00	12 months	2025-08-06	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
130	3	303	1	1	664	3	1350.00	1350.00	12 months (academic year)	2025-06-24	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
131	3	#304	1	1	792	3	1350.00	1350.00	9 months	2025-06-07	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
132	3	F305	1	1	654	3	1150.00	1150.00	12 months	2025-07-15	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
133	3	G306	2	2	1089	3	2050.00	2050.00	15 months	2025-07-18	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
134	3	#307	1	1	756	3	1300.00	1300.00	6 months	2025-08-03	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
135	3	#308	2	2	921	3	1400.00	1400.00	12 months	2025-08-06	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
136	3	J309	1	1	810	3	1200.00	1200.00	12 months	2025-08-27	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
137	3	K310	1	1	572	3	1200.00	1200.00	12 months (academic year)	2025-05-08	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
138	3	311	2	2	987	3	1850.00	1850.00	12 months (academic year)	2025-05-13	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
139	3	#312	2	2	870	3	2150.00	2150.00	12 months (academic year)	2025-06-09	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
140	3	401	2	2	940	4	2100.00	2100.00	12 months	2025-06-19	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
141	3	402	3	3	1454	4	2200.00	2200.00	12 months (academic year)	2025-08-20	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
142	3	D403	2	2	867	4	1600.00	1600.00	15 months	2025-06-10	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
143	3	E404	3	3	1571	4	1800.00	1800.00	9 months	2025-08-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
144	3	#405	0	1	509	4	800.00	800.00	12 months	2025-07-07	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	f
145	3	406	2	2	972	4	1950.00	1950.00	12 months	2025-05-12	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
146	3	407	1	1	659	4	1450.00	1450.00	12 months	2025-07-25	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	f
147	3	#408	1	1	710	4	1200.00	1200.00	15 months	2025-08-03	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
148	3	J409	0	1	413	4	950.00	950.00	6 months	2025-06-11	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
149	3	410	3	3	1472	4	1850.00	1850.00	12 months	2025-08-05	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
150	3	#411	2	2	1125	4	1650.00	1650.00	6 months	2025-08-31	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
151	3	M412	2	2	1018	4	1500.00	1500.00	12 months	2025-07-10	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
152	3	501	1	1	832	5	1400.00	1400.00	15 months	2025-07-17	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
153	3	C502	2	2	1027	5	1950.00	1950.00	12 months (academic year)	2025-05-24	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
154	3	D503	2	2	892	5	2100.00	2100.00	12 months (academic year)	2025-07-27	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
155	3	#504	0	1	435	5	1100.00	1100.00	15 months	2025-07-12	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
156	3	#505	3	3	1251	5	2050.00	2050.00	15 months	2025-05-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
157	3	G506	2	2	1102	5	1800.00	1800.00	12 months (academic year)	2025-06-18	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
158	3	507	1	1	828	5	1050.00	1050.00	15 months	2025-08-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
159	3	I508	2	2	1086	5	1500.00	1500.00	12 months (academic year)	2025-06-20	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
160	3	#509	2	2	886	5	2000.00	2000.00	15 months	2025-07-18	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	f
161	3	510	3	3	1386	5	1850.00	1850.00	6 months	2025-08-12	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
162	3	#511	2	2	898	5	2100.00	2100.00	12 months	2025-05-19	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
163	3	512	3	3	1407	5	2650.00	2650.00	6 months	2025-06-03	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
164	4	B101	2	2	859	1	1750.00	1750.00	9 months	2025-05-28	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
165	4	102	3	3	1300	1	2150.00	2150.00	15 months	2025-07-15	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
166	4	D103	1	1	756	1	1400.00	1400.00	9 months	2025-08-24	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
167	4	104	0	1	553	1	850.00	850.00	9 months	2025-07-03	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
168	4	F105	1	1	555	1	1400.00	1400.00	9 months	2025-08-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
169	4	#106	0	1	527	1	1100.00	1100.00	9 months	2025-07-29	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
170	4	107	2	2	1110	1	2150.00	2150.00	12 months (academic year)	2025-07-25	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
171	4	108	0	1	482	1	950.00	950.00	6 months	2025-07-08	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
172	4	#109	2	2	1042	1	2100.00	2100.00	15 months	2025-05-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
173	4	110	2	2	1139	1	1900.00	1900.00	12 months	2025-08-13	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
174	4	#111	1	1	716	1	1250.00	1250.00	12 months (academic year)	2025-06-25	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
175	4	#112	1	1	709	1	1000.00	1000.00	12 months (academic year)	2025-06-21	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
176	4	#113	2	2	1018	1	1550.00	1550.00	15 months	2025-08-27	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
177	4	#114	1	1	791	1	1100.00	1100.00	12 months	2025-08-23	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
178	4	P115	3	3	1286	1	2100.00	2100.00	15 months	2025-05-31	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
179	4	Q116	0	1	573	1	900.00	900.00	12 months	2025-06-01	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	f
180	4	R117	2	2	1177	1	1800.00	1800.00	12 months (academic year)	2025-06-01	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
181	4	S118	1	1	635	1	1400.00	1400.00	6 months	2025-06-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
182	4	119	3	3	1343	1	2400.00	2400.00	12 months (academic year)	2025-09-01	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
183	4	B201	0	1	471	2	950.00	950.00	12 months	2025-06-28	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
184	4	#202	1	1	560	2	1350.00	1350.00	9 months	2025-06-24	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
185	4	D203	1	1	590	2	1100.00	1100.00	6 months	2025-07-06	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
186	4	E204	2	2	1076	2	1450.00	1450.00	15 months	2025-06-12	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
187	4	205	2	2	1129	2	2100.00	2100.00	15 months	2025-06-11	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
188	4	#206	1	1	659	2	1150.00	1150.00	12 months	2025-06-15	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
189	4	H207	0	1	526	2	950.00	950.00	6 months	2025-06-19	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
190	4	#208	3	3	1389	2	2050.00	2050.00	6 months	2025-07-28	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
191	4	209	1	1	825	2	1100.00	1100.00	9 months	2025-07-05	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
192	4	#210	2	2	998	2	1500.00	1500.00	12 months (academic year)	2025-08-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	f
193	4	211	2	2	925	2	2000.00	2000.00	15 months	2025-08-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	f
194	4	#212	3	3	1544	2	2300.00	2300.00	12 months (academic year)	2025-08-25	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
195	4	#213	3	3	1336	2	1950.00	1950.00	12 months	2025-06-11	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
196	4	O214	2	2	955	2	1950.00	1950.00	6 months	2025-05-12	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
197	4	215	1	1	815	2	1150.00	1150.00	12 months (academic year)	2025-05-06	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
198	4	216	2	2	1044	2	1600.00	1600.00	15 months	2025-07-21	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
199	4	#217	2	2	1174	2	1850.00	1850.00	12 months (academic year)	2025-05-05	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
200	4	218	2	2	979	2	2000.00	2000.00	15 months	2025-05-13	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
201	4	219	1	1	683	2	1450.00	1450.00	6 months	2025-06-15	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	f
202	4	301	1	1	679	3	1300.00	1300.00	15 months	2025-07-29	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
203	4	C302	2	2	1117	3	1500.00	1500.00	6 months	2025-06-10	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
204	4	303	2	2	883	3	1750.00	1750.00	15 months	2025-08-20	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
205	4	#304	2	2	1074	3	1950.00	1950.00	9 months	2025-05-17	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
206	4	305	1	1	699	3	1250.00	1250.00	12 months	2025-07-20	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
207	4	G306	1	1	684	3	1000.00	1000.00	6 months	2025-08-20	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
208	4	H307	2	2	1146	3	1950.00	1950.00	12 months (academic year)	2025-06-27	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
209	4	I308	3	3	1510	3	2500.00	2500.00	12 months	2025-06-24	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
210	4	309	1	1	790	3	1150.00	1150.00	9 months	2025-08-13	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
211	4	310	3	3	1594	3	2500.00	2500.00	12 months	2025-08-05	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
212	4	#311	1	1	580	3	1400.00	1400.00	12 months (academic year)	2025-05-30	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
213	4	312	0	1	448	3	950.00	950.00	6 months	2025-08-19	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
214	4	313	3	3	1424	3	2600.00	2600.00	9 months	2025-08-20	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
215	4	#314	3	3	1270	3	2700.00	2700.00	12 months	2025-05-07	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
216	4	#315	1	1	772	3	1050.00	1050.00	9 months	2025-05-14	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
217	4	316	1	1	633	3	1050.00	1050.00	12 months	2025-06-24	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
218	4	R317	0	1	429	3	900.00	900.00	12 months	2025-08-31	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
219	4	318	2	2	1195	3	2100.00	2100.00	9 months	2025-08-31	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
220	4	319	1	1	554	3	1350.00	1350.00	9 months	2025-05-05	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
221	4	401	2	2	1072	4	1850.00	1850.00	12 months (academic year)	2025-07-15	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
222	5	B101	0	1	433	1	850.00	850.00	12 months	2025-08-20	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	f
223	5	102	2	2	1041	1	1650.00	1650.00	6 months	2025-06-03	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
224	5	D103	0	1	595	1	1000.00	1000.00	6 months	2025-07-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
225	5	E104	2	2	872	1	2100.00	2100.00	9 months	2025-07-26	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
226	5	F105	3	3	1406	1	2550.00	2550.00	12 months	2025-08-28	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
227	5	B201	1	1	639	2	1150.00	1150.00	9 months	2025-05-03	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
228	5	C202	0	1	499	2	950.00	950.00	6 months	2025-06-04	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
229	5	#203	3	3	1446	2	2350.00	2350.00	12 months	2025-08-20	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
230	5	#204	2	2	1170	2	1550.00	1550.00	6 months	2025-08-25	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
231	5	#205	2	2	914	2	1600.00	1600.00	9 months	2025-07-21	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	f
232	5	#301	2	2	1089	3	1500.00	1500.00	15 months	2025-06-17	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
233	5	302	1	1	557	3	1100.00	1100.00	12 months	2025-06-24	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
234	5	#303	2	2	948	3	2050.00	2050.00	15 months	2025-07-23	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
235	5	304	1	1	727	3	1250.00	1250.00	6 months	2025-08-04	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
236	5	305	0	1	451	3	900.00	900.00	9 months	2025-08-21	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
237	5	#401	1	1	580	4	1350.00	1350.00	6 months	2025-07-25	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
238	5	402	0	1	514	4	950.00	950.00	15 months	2025-07-20	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
239	5	D403	3	3	1517	4	1850.00	1850.00	12 months	2025-07-22	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
240	5	E404	1	1	576	4	1450.00	1450.00	12 months	2025-06-22	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	f
241	5	F405	0	1	458	4	800.00	800.00	6 months	2025-06-16	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
242	5	B501	2	2	960	5	2150.00	2150.00	15 months	2025-05-07	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
243	5	502	1	1	820	5	1150.00	1150.00	9 months	2025-07-04	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
244	5	D503	3	3	1535	5	2650.00	2650.00	12 months	2025-08-02	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
245	5	E504	2	2	1170	5	1550.00	1550.00	12 months (academic year)	2025-06-10	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
246	5	505	2	2	963	5	1550.00	1550.00	15 months	2025-06-22	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
247	5	B601	2	2	1021	6	1500.00	1500.00	6 months	2025-07-11	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
248	5	C602	1	1	720	6	1000.00	1000.00	15 months	2025-06-12	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
249	5	603	1	1	729	6	1400.00	1400.00	15 months	2025-05-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
250	5	#604	1	1	580	6	1100.00	1100.00	6 months	2025-08-09	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
251	5	#605	1	1	745	6	1100.00	1100.00	12 months (academic year)	2025-05-10	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
252	5	B701	1	1	719	7	1400.00	1400.00	9 months	2025-06-17	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
253	5	C702	1	1	799	7	1000.00	1000.00	12 months	2025-07-28	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
254	5	D703	1	1	605	7	1200.00	1200.00	12 months (academic year)	2025-05-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
255	5	#704	2	2	1085	7	1850.00	1850.00	15 months	2025-05-06	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
256	5	705	2	2	1157	7	1950.00	1950.00	12 months	2025-08-05	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
257	5	#801	1	1	781	8	1250.00	1250.00	12 months (academic year)	2025-06-13	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
258	5	C802	3	3	1289	8	2150.00	2150.00	12 months	2025-05-13	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
259	5	D803	3	3	1413	8	2600.00	2600.00	9 months	2025-07-09	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
260	5	804	3	3	1514	8	2050.00	2050.00	12 months (academic year)	2025-06-10	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
261	5	#805	2	2	964	8	1550.00	1550.00	15 months	2025-05-31	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
262	5	901	2	2	1038	9	1700.00	1700.00	9 months	2025-06-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
263	5	#902	1	1	558	9	1100.00	1100.00	12 months (academic year)	2025-08-06	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
264	5	#903	2	2	1125	9	2150.00	2150.00	12 months	2025-08-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
265	6	101	2	2	1189	1	1650.00	1650.00	12 months	2025-06-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
266	6	C102	1	1	759	1	1400.00	1400.00	6 months	2025-08-04	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
267	6	#103	0	1	447	1	900.00	900.00	6 months	2025-05-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
268	6	104	1	1	713	1	1050.00	1050.00	12 months (academic year)	2025-05-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
269	6	105	0	1	405	1	1050.00	1050.00	9 months	2025-08-09	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
270	6	106	3	3	1538	1	2600.00	2600.00	9 months	2025-07-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	f
271	6	H107	2	2	1098	1	1750.00	1750.00	6 months	2025-07-10	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
272	6	#108	1	1	733	1	1400.00	1400.00	15 months	2025-08-28	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	f
273	6	#201	1	1	768	2	1300.00	1300.00	9 months	2025-08-11	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
274	6	202	2	2	952	2	1950.00	1950.00	9 months	2025-07-16	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	f
275	6	#203	1	1	807	2	1100.00	1100.00	9 months	2025-07-30	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
276	6	#204	1	1	640	2	1250.00	1250.00	12 months (academic year)	2025-06-03	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	f
277	6	#205	1	1	644	2	1250.00	1250.00	12 months (academic year)	2025-07-09	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
278	6	G206	3	3	1557	2	2550.00	2550.00	9 months	2025-05-04	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
279	6	207	2	2	883	2	2100.00	2100.00	9 months	2025-05-10	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
280	6	#208	1	1	737	2	1350.00	1350.00	12 months (academic year)	2025-07-24	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
281	6	301	0	1	548	3	1000.00	1000.00	12 months (academic year)	2025-07-01	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
282	6	#302	3	3	1583	3	1800.00	1800.00	12 months	2025-05-20	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
283	6	303	2	2	918	3	1900.00	1900.00	15 months	2025-07-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
284	6	304	3	3	1530	3	2550.00	2550.00	6 months	2025-07-15	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
285	6	305	1	1	717	3	1000.00	1000.00	12 months (academic year)	2025-06-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
286	6	G306	1	1	733	3	1050.00	1050.00	6 months	2025-06-20	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	f
287	6	307	1	1	700	3	1350.00	1350.00	6 months	2025-07-02	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
288	6	#308	2	2	1081	3	1700.00	1700.00	6 months	2025-06-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
289	6	401	2	2	1048	4	1950.00	1950.00	12 months	2025-06-20	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	f
290	6	C402	1	1	634	4	1250.00	1250.00	6 months	2025-06-08	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
291	6	403	2	2	873	4	1750.00	1750.00	12 months (academic year)	2025-06-21	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
292	6	#404	0	1	465	4	1100.00	1100.00	12 months (academic year)	2025-06-01	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
293	6	F405	0	1	500	4	1150.00	1150.00	12 months (academic year)	2025-08-29	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
294	6	G406	2	2	869	4	2100.00	2100.00	9 months	2025-07-02	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
295	6	407	3	3	1352	4	2700.00	2700.00	12 months	2025-07-19	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
296	6	#408	1	1	743	4	1450.00	1450.00	12 months	2025-07-27	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
297	6	B501	1	1	759	5	1150.00	1150.00	12 months (academic year)	2025-06-03	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
298	6	C502	2	2	1044	5	1850.00	1850.00	12 months	2025-05-23	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
299	6	503	2	2	887	5	1500.00	1500.00	12 months	2025-06-12	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
300	6	#504	2	2	1013	5	1450.00	1450.00	12 months (academic year)	2025-06-20	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
301	6	#505	1	1	676	5	1350.00	1350.00	6 months	2025-06-21	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
302	6	506	3	3	1548	5	2650.00	2650.00	6 months	2025-07-26	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
303	6	#507	2	2	1108	5	1500.00	1500.00	9 months	2025-07-15	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
304	6	#508	0	1	462	5	850.00	850.00	15 months	2025-05-27	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
305	6	601	2	2	1095	6	1650.00	1650.00	12 months	2025-07-26	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
306	6	#602	2	2	894	6	2050.00	2050.00	12 months (academic year)	2025-06-28	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
307	6	#603	1	1	560	6	1150.00	1150.00	12 months	2025-08-11	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
308	6	604	2	2	1165	6	2000.00	2000.00	9 months	2025-08-12	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
309	6	F605	3	3	1574	6	1900.00	1900.00	9 months	2025-05-02	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
310	6	606	0	1	598	6	1100.00	1100.00	12 months (academic year)	2025-08-09	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
311	6	607	1	1	695	6	1350.00	1350.00	12 months	2025-07-07	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
312	6	608	2	2	1015	6	1900.00	1900.00	6 months	2025-06-04	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
313	6	#701	3	3	1554	7	1800.00	1800.00	12 months	2025-08-26	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
314	7	B101	1	1	728	1	1300.00	1300.00	6 months	2025-07-05	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
315	7	102	2	2	1044	1	2150.00	2150.00	12 months	2025-08-16	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
316	7	#103	2	2	1035	1	1550.00	1550.00	12 months (academic year)	2025-07-12	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
317	7	#104	3	3	1424	1	2200.00	2200.00	9 months	2025-08-09	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
318	7	#105	3	3	1538	1	2750.00	2750.00	12 months (academic year)	2025-08-24	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
319	7	B201	2	2	984	2	2000.00	2000.00	15 months	2025-06-24	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
320	7	202	3	3	1318	2	2500.00	2500.00	9 months	2025-07-10	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
321	7	203	1	1	755	2	1100.00	1100.00	12 months (academic year)	2025-08-16	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
322	7	204	1	1	611	2	1200.00	1200.00	15 months	2025-06-29	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
323	7	F205	2	2	960	2	1550.00	1550.00	6 months	2025-06-20	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
324	7	#301	2	2	1109	3	1600.00	1600.00	9 months	2025-07-21	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
325	7	C302	2	2	1158	3	1500.00	1500.00	15 months	2025-05-08	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
326	7	#303	1	1	612	3	1100.00	1100.00	15 months	2025-07-18	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
327	7	#304	0	1	540	3	800.00	800.00	12 months (academic year)	2025-07-10	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
328	7	305	3	3	1371	3	2600.00	2600.00	6 months	2025-07-31	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
329	7	#401	0	1	498	4	1050.00	1050.00	9 months	2025-08-24	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
330	7	402	1	1	567	4	1400.00	1400.00	9 months	2025-08-10	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
331	7	D403	0	1	513	4	1100.00	1100.00	12 months	2025-08-04	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
332	7	#404	1	1	841	4	1300.00	1300.00	6 months	2025-07-02	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
333	7	#405	3	3	1239	4	2000.00	2000.00	6 months	2025-07-27	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
334	7	B501	0	1	493	5	900.00	900.00	6 months	2025-07-26	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
335	7	502	2	2	1036	5	2150.00	2150.00	12 months	2025-08-04	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	f
336	7	503	1	1	743	5	1400.00	1400.00	12 months (academic year)	2025-06-21	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
337	7	#504	2	2	881	5	1850.00	1850.00	12 months	2025-05-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	f
338	7	F505	3	3	1387	5	2450.00	2450.00	9 months	2025-05-17	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
339	7	#601	2	2	870	6	2150.00	2150.00	12 months (academic year)	2025-08-06	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
340	7	C602	1	1	659	6	1250.00	1250.00	6 months	2025-05-31	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
341	7	#603	1	1	766	6	1000.00	1000.00	12 months (academic year)	2025-08-17	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
342	7	E604	0	1	443	6	950.00	950.00	6 months	2025-05-16	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
343	7	#605	1	1	747	6	1000.00	1000.00	12 months (academic year)	2025-07-17	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
344	7	701	1	1	790	7	1100.00	1100.00	12 months	2025-08-30	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	f
345	7	#702	2	2	1029	7	1750.00	1750.00	12 months	2025-08-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
346	7	D703	3	3	1224	7	2500.00	2500.00	12 months	2025-05-17	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
347	7	E704	2	2	931	7	2150.00	2150.00	12 months	2025-06-25	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
348	7	F705	2	2	1118	7	1750.00	1750.00	12 months	2025-07-15	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	f
349	7	801	1	1	814	8	1450.00	1450.00	9 months	2025-08-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
350	7	802	2	2	931	8	1850.00	1850.00	9 months	2025-05-11	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
351	7	803	2	2	940	8	1950.00	1950.00	6 months	2025-06-27	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
352	7	#804	0	1	542	8	1000.00	1000.00	9 months	2025-08-05	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
353	7	#805	1	1	709	8	1450.00	1450.00	12 months	2025-07-02	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
354	7	#901	1	1	609	9	1200.00	1200.00	12 months	2025-06-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
355	7	#902	2	2	1124	9	1600.00	1600.00	15 months	2025-05-11	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
356	7	903	3	3	1282	9	2550.00	2550.00	15 months	2025-05-04	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
357	7	E904	1	1	806	9	1450.00	1450.00	6 months	2025-08-01	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
358	8	101	3	3	1302	1	2750.00	2750.00	12 months	2025-07-14	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
359	8	102	2	2	1068	1	1950.00	1950.00	12 months	2025-08-27	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
360	8	#103	1	1	749	1	1000.00	1000.00	12 months (academic year)	2025-07-20	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	f
361	8	E104	2	2	880	1	1850.00	1850.00	9 months	2025-07-31	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
362	8	F105	1	1	841	1	1350.00	1350.00	12 months	2025-08-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
363	8	G106	3	3	1225	1	2700.00	2700.00	12 months	2025-05-03	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
364	8	107	2	2	930	1	1800.00	1800.00	6 months	2025-07-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	f
365	8	#108	1	1	558	1	1400.00	1400.00	6 months	2025-06-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
366	8	109	1	1	744	1	1200.00	1200.00	15 months	2025-05-25	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
367	8	110	1	1	789	1	1400.00	1400.00	6 months	2025-05-09	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
368	8	111	1	1	576	1	1300.00	1300.00	6 months	2025-07-24	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	f
369	8	#112	0	1	476	1	1150.00	1150.00	12 months	2025-06-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
370	8	#113	1	1	645	1	1200.00	1200.00	6 months	2025-08-01	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
371	8	O114	1	1	596	1	1450.00	1450.00	9 months	2025-08-08	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	f
372	8	P115	0	1	571	1	1100.00	1100.00	12 months (academic year)	2025-05-21	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
373	8	B201	3	3	1387	2	2100.00	2100.00	15 months	2025-07-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
374	8	C202	2	2	1059	2	1750.00	1750.00	6 months	2025-07-24	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
375	8	203	0	1	545	2	1050.00	1050.00	12 months (academic year)	2025-05-09	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
376	8	#204	1	1	629	2	1450.00	1450.00	9 months	2025-08-25	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
377	8	#205	2	2	1051	2	1900.00	1900.00	6 months	2025-05-19	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
378	8	206	1	1	734	2	1200.00	1200.00	12 months	2025-05-09	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
379	8	#207	1	1	696	2	1250.00	1250.00	15 months	2025-05-26	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
380	8	I208	1	1	649	2	1000.00	1000.00	9 months	2025-08-09	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
381	8	J209	2	2	995	2	1800.00	1800.00	6 months	2025-07-20	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
382	8	#210	2	2	1037	2	1550.00	1550.00	15 months	2025-05-01	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
383	8	#211	2	2	999	2	1850.00	1850.00	12 months	2025-08-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
384	8	#212	1	1	604	2	1000.00	1000.00	12 months	2025-07-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	f
385	8	N213	1	1	831	2	1000.00	1000.00	9 months	2025-07-02	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	f
386	8	214	0	1	569	2	1000.00	1000.00	9 months	2025-07-05	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
387	8	#215	2	2	1179	2	1650.00	1650.00	12 months	2025-05-01	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
388	8	#301	2	2	956	3	2050.00	2050.00	12 months	2025-09-01	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
389	8	302	2	2	1126	3	1550.00	1550.00	15 months	2025-07-14	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
390	8	#303	3	3	1366	3	1850.00	1850.00	15 months	2025-05-15	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
391	8	304	2	2	1021	3	2000.00	2000.00	15 months	2025-06-28	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
392	8	305	3	3	1486	3	2500.00	2500.00	12 months (academic year)	2025-06-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
393	8	#306	1	1	786	3	1050.00	1050.00	9 months	2025-06-29	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
394	8	307	2	2	1128	3	1400.00	1400.00	6 months	2025-06-26	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
395	8	I308	3	3	1512	3	2100.00	2100.00	15 months	2025-06-09	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
396	8	J309	3	3	1411	3	2650.00	2650.00	6 months	2025-07-15	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
397	8	K310	2	2	948	3	1800.00	1800.00	12 months (academic year)	2025-08-06	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
398	8	#311	2	2	944	3	2050.00	2050.00	12 months (academic year)	2025-05-05	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	f
399	8	#312	3	3	1475	3	2250.00	2250.00	12 months	2025-07-21	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
400	8	N313	1	1	571	3	1100.00	1100.00	6 months	2025-05-09	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
401	8	314	0	1	447	3	1000.00	1000.00	9 months	2025-08-23	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
402	8	#315	0	1	415	3	1150.00	1150.00	12 months (academic year)	2025-05-03	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
403	8	B401	2	2	1148	4	1500.00	1500.00	12 months (academic year)	2025-06-22	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	f
404	8	C402	0	1	460	4	1100.00	1100.00	9 months	2025-08-18	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
405	9	101	0	1	479	1	1000.00	1000.00	12 months (academic year)	2025-05-27	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	f
406	9	C102	1	1	594	1	1000.00	1000.00	12 months (academic year)	2025-08-26	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
407	9	103	1	1	734	1	1200.00	1200.00	9 months	2025-08-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
408	9	104	2	2	968	1	2000.00	2000.00	12 months	2025-08-28	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
409	9	105	0	1	509	1	850.00	850.00	6 months	2025-05-10	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
410	9	G106	2	2	1098	1	1950.00	1950.00	12 months	2025-07-03	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
411	9	107	1	1	772	1	1050.00	1050.00	12 months	2025-05-01	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
412	9	108	3	3	1220	1	2650.00	2650.00	12 months (academic year)	2025-06-05	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
413	9	#201	1	1	783	2	1050.00	1050.00	12 months	2025-07-12	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
414	9	#202	1	1	605	2	1450.00	1450.00	12 months (academic year)	2025-08-09	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
415	9	D203	3	3	1370	2	2000.00	2000.00	12 months (academic year)	2025-05-11	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
416	9	204	2	2	1095	2	1700.00	1700.00	15 months	2025-06-21	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
417	9	#205	3	3	1588	2	2600.00	2600.00	9 months	2025-05-26	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
418	9	G206	1	1	847	2	1050.00	1050.00	12 months (academic year)	2025-05-05	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
419	9	#207	2	2	1091	2	1450.00	1450.00	12 months	2025-06-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
420	9	#208	2	2	1055	2	1800.00	1800.00	9 months	2025-07-01	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
421	9	B301	2	2	1087	3	1650.00	1650.00	12 months	2025-06-23	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
422	9	#302	3	3	1591	3	1950.00	1950.00	12 months	2025-06-14	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
423	9	#303	0	1	533	3	1000.00	1000.00	6 months	2025-05-11	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
424	9	E304	1	1	697	3	1150.00	1150.00	12 months	2025-08-18	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
425	9	F305	2	2	905	3	1450.00	1450.00	15 months	2025-08-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
426	9	306	1	1	783	3	1300.00	1300.00	15 months	2025-08-06	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
427	9	307	2	2	887	3	1650.00	1650.00	12 months	2025-06-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
428	9	I308	1	1	801	3	1300.00	1300.00	9 months	2025-08-05	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
429	9	#401	1	1	677	4	1200.00	1200.00	9 months	2025-08-13	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
430	9	#402	1	1	575	4	1450.00	1450.00	6 months	2025-05-27	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
431	9	D403	3	3	1325	4	2200.00	2200.00	6 months	2025-08-21	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
432	9	#404	1	1	815	4	1200.00	1200.00	15 months	2025-07-15	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
433	9	#405	3	3	1594	4	2400.00	2400.00	12 months (academic year)	2025-06-28	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
434	9	406	2	2	1154	4	1950.00	1950.00	6 months	2025-08-28	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
435	9	#407	3	3	1301	4	2150.00	2150.00	12 months (academic year)	2025-07-12	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
436	9	#408	1	1	781	4	1050.00	1050.00	9 months	2025-07-26	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
437	9	B501	2	2	1091	5	2150.00	2150.00	9 months	2025-08-10	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
438	9	C502	2	2	1107	5	2150.00	2150.00	12 months (academic year)	2025-07-28	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
439	9	503	3	3	1370	5	2050.00	2050.00	9 months	2025-06-27	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
440	9	#504	0	1	532	5	1000.00	1000.00	12 months	2025-08-21	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
441	9	F505	2	2	1156	5	2000.00	2000.00	12 months (academic year)	2025-08-06	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
442	9	G506	0	1	483	5	1150.00	1150.00	15 months	2025-07-11	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
443	9	H507	3	3	1558	5	2450.00	2450.00	12 months	2025-08-05	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
444	9	508	0	1	591	5	850.00	850.00	9 months	2025-08-03	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	f
445	9	B601	2	2	1054	6	1700.00	1700.00	9 months	2025-08-04	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
446	9	C602	2	2	1130	6	1800.00	1800.00	6 months	2025-07-17	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
447	9	D603	1	1	739	6	1250.00	1250.00	6 months	2025-06-03	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
448	9	E604	2	2	1167	6	2000.00	2000.00	6 months	2025-07-22	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
449	9	605	0	1	443	6	900.00	900.00	6 months	2025-08-09	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
450	9	#606	2	2	1091	6	1550.00	1550.00	15 months	2025-07-23	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
451	9	607	1	1	570	6	1250.00	1250.00	15 months	2025-06-02	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
452	9	#608	2	2	1184	6	1450.00	1450.00	15 months	2025-05-10	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
453	9	#701	1	1	620	7	1300.00	1300.00	9 months	2025-06-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
454	9	#702	1	1	588	7	1100.00	1100.00	9 months	2025-06-25	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
455	10	101	2	2	1172	1	1400.00	1400.00	6 months	2025-05-24	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
456	10	102	1	1	753	1	1200.00	1200.00	15 months	2025-06-06	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
457	10	D103	3	3	1338	1	2400.00	2400.00	12 months (academic year)	2025-07-18	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
458	10	#104	2	2	865	1	2000.00	2000.00	6 months	2025-08-05	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
459	10	#105	0	1	507	1	800.00	800.00	9 months	2025-07-30	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
460	10	106	0	1	538	1	800.00	800.00	12 months (academic year)	2025-06-18	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
461	10	#201	3	3	1494	2	2000.00	2000.00	9 months	2025-05-14	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
462	10	202	1	1	713	2	1450.00	1450.00	12 months (academic year)	2025-07-21	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
463	10	D203	1	1	556	2	1300.00	1300.00	9 months	2025-07-14	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
464	10	#204	2	2	1147	2	1800.00	1800.00	12 months (academic year)	2025-05-15	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
696	14	#216	0	1	575	2	1000.00	1000.00	6 months	2025-08-19	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
465	10	#205	2	2	1150	2	1900.00	1900.00	12 months (academic year)	2025-06-22	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
466	10	#206	2	2	855	2	2100.00	2100.00	6 months	2025-07-09	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
467	10	#301	2	2	1159	3	1450.00	1450.00	9 months	2025-07-16	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
468	10	302	1	1	582	3	1250.00	1250.00	12 months	2025-07-29	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
469	10	D303	0	1	435	3	850.00	850.00	9 months	2025-07-09	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
470	10	304	0	1	571	3	1100.00	1100.00	12 months (academic year)	2025-07-10	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
471	10	F305	3	3	1329	3	2650.00	2650.00	6 months	2025-07-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
472	10	#306	2	2	1142	3	1950.00	1950.00	12 months (academic year)	2025-07-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
473	10	B401	1	1	733	4	1000.00	1000.00	15 months	2025-06-13	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
474	10	402	3	3	1339	4	2700.00	2700.00	15 months	2025-06-06	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
475	10	#403	2	2	1198	4	2000.00	2000.00	12 months (academic year)	2025-06-19	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
476	10	E404	2	2	1021	4	2000.00	2000.00	12 months (academic year)	2025-07-21	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
477	10	405	0	1	561	4	800.00	800.00	15 months	2025-05-16	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
478	10	G406	0	1	446	4	1050.00	1050.00	9 months	2025-06-03	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
479	10	B501	1	1	716	5	1300.00	1300.00	9 months	2025-05-12	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
480	10	#502	1	1	837	5	1400.00	1400.00	9 months	2025-05-19	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
481	10	503	3	3	1278	5	2550.00	2550.00	9 months	2025-08-26	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
482	10	#504	2	2	976	5	1800.00	1800.00	9 months	2025-05-03	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
483	10	#505	1	1	691	5	1350.00	1350.00	15 months	2025-08-04	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
484	10	#506	1	1	606	5	1050.00	1050.00	12 months	2025-05-31	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
485	10	B601	2	2	1059	6	1850.00	1850.00	12 months	2025-06-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	f
486	10	602	2	2	1079	6	2150.00	2150.00	12 months (academic year)	2025-06-06	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	f
487	10	603	1	1	644	6	1450.00	1450.00	12 months (academic year)	2025-08-25	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
488	10	E604	0	1	412	6	950.00	950.00	9 months	2025-07-29	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
489	10	#605	1	1	627	6	1200.00	1200.00	15 months	2025-05-03	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	f
490	10	#606	2	2	1189	6	1900.00	1900.00	12 months (academic year)	2025-05-08	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
491	10	#701	2	2	1129	7	1600.00	1600.00	15 months	2025-08-21	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
492	10	702	1	1	599	7	1400.00	1400.00	9 months	2025-07-27	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
493	10	703	2	2	851	7	2150.00	2150.00	6 months	2025-07-31	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
494	10	E704	3	3	1254	7	1850.00	1850.00	15 months	2025-08-01	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
495	10	#705	2	2	1116	7	1750.00	1750.00	12 months	2025-06-09	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
496	10	G706	1	1	811	7	1000.00	1000.00	9 months	2025-05-10	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
497	10	#801	3	3	1506	8	1900.00	1900.00	15 months	2025-06-18	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
498	10	C802	3	3	1360	8	2350.00	2350.00	12 months	2025-08-04	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
499	10	803	3	3	1383	8	2300.00	2300.00	6 months	2025-08-22	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	f
500	10	804	1	1	574	8	1100.00	1100.00	9 months	2025-06-19	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
501	10	805	1	1	706	8	1100.00	1100.00	6 months	2025-06-02	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
502	10	#806	1	1	798	8	1400.00	1400.00	12 months	2025-05-27	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
503	11	#101	3	3	1565	1	2350.00	2350.00	9 months	2025-08-19	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
504	11	#102	1	1	704	1	1450.00	1450.00	15 months	2025-07-01	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
505	11	D103	0	1	578	1	950.00	950.00	6 months	2025-06-28	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
506	11	104	1	1	694	1	1450.00	1450.00	12 months (academic year)	2025-05-27	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
507	11	105	3	3	1293	1	1900.00	1900.00	12 months (academic year)	2025-08-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
508	11	G106	1	1	569	1	1450.00	1450.00	15 months	2025-06-12	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
509	11	201	1	1	723	2	1200.00	1200.00	12 months (academic year)	2025-06-24	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	f
510	11	#202	2	2	935	2	1850.00	1850.00	12 months	2025-07-31	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
511	11	#203	2	2	1149	2	2100.00	2100.00	15 months	2025-07-30	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
512	11	204	3	3	1214	2	1950.00	1950.00	6 months	2025-05-02	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
513	11	#205	2	2	904	2	1700.00	1700.00	12 months	2025-05-23	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
514	11	G206	2	2	903	2	2050.00	2050.00	12 months (academic year)	2025-07-14	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
515	11	#301	2	2	1049	3	1450.00	1450.00	6 months	2025-08-11	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
516	11	C302	0	1	575	3	1150.00	1150.00	9 months	2025-08-27	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
517	11	#303	0	1	422	3	1000.00	1000.00	9 months	2025-05-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
518	11	E304	0	1	443	3	1050.00	1050.00	15 months	2025-07-26	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
519	11	F305	1	1	590	3	1200.00	1200.00	9 months	2025-07-26	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
520	11	306	2	2	901	3	2150.00	2150.00	6 months	2025-07-10	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
521	11	#401	2	2	978	4	1550.00	1550.00	6 months	2025-07-17	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
522	11	402	2	2	951	4	2050.00	2050.00	12 months	2025-08-11	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
523	11	403	3	3	1569	4	2150.00	2150.00	6 months	2025-05-06	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	f
524	11	E404	1	1	727	4	1350.00	1350.00	12 months	2025-05-26	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
525	11	405	1	1	702	4	1250.00	1250.00	6 months	2025-08-09	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
526	11	406	1	1	753	4	1050.00	1050.00	6 months	2025-06-17	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
527	11	B501	2	2	944	5	1500.00	1500.00	12 months	2025-05-18	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
528	11	C502	1	1	826	5	1450.00	1450.00	12 months (academic year)	2025-06-27	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
529	11	D503	2	2	1050	5	2000.00	2000.00	12 months (academic year)	2025-05-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
530	11	#504	2	2	989	5	1600.00	1600.00	9 months	2025-07-25	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
531	11	505	1	1	747	5	1400.00	1400.00	15 months	2025-08-09	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	f
532	11	G506	1	1	630	5	1300.00	1300.00	9 months	2025-07-25	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
533	11	601	1	1	809	6	1250.00	1250.00	9 months	2025-05-05	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
534	11	602	1	1	838	6	1400.00	1400.00	9 months	2025-07-30	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
535	11	603	2	2	1033	6	1900.00	1900.00	6 months	2025-06-02	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
536	11	E604	1	1	780	6	1350.00	1350.00	9 months	2025-06-13	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
537	11	F605	3	3	1382	6	2000.00	2000.00	6 months	2025-08-29	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
538	11	606	1	1	840	6	1100.00	1100.00	6 months	2025-08-29	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
539	11	B701	0	1	505	7	1050.00	1050.00	12 months (academic year)	2025-07-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
540	11	C702	3	3	1401	7	2450.00	2450.00	12 months (academic year)	2025-08-09	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
541	11	703	2	2	1012	7	1450.00	1450.00	12 months (academic year)	2025-08-08	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
542	11	704	2	2	1005	7	1450.00	1450.00	15 months	2025-08-17	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
543	11	705	1	1	587	7	1150.00	1150.00	12 months (academic year)	2025-05-10	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
544	11	706	3	3	1213	7	2750.00	2750.00	9 months	2025-06-20	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
545	11	B801	1	1	661	8	1200.00	1200.00	12 months (academic year)	2025-05-11	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
546	11	802	3	3	1254	8	2750.00	2750.00	9 months	2025-07-20	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
547	11	#803	0	1	456	8	800.00	800.00	9 months	2025-07-12	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
548	11	#804	2	2	1010	8	1550.00	1550.00	6 months	2025-05-18	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
549	11	#805	2	2	1103	8	1800.00	1800.00	12 months	2025-07-04	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
550	11	806	2	2	961	8	1500.00	1500.00	12 months	2025-05-01	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
551	11	B901	0	1	427	9	900.00	900.00	12 months	2025-08-22	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
552	11	#902	3	3	1483	9	2000.00	2000.00	9 months	2025-07-26	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
553	12	#101	2	2	1060	1	2050.00	2050.00	12 months (academic year)	2025-08-15	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
554	12	#102	0	1	511	1	850.00	850.00	9 months	2025-08-02	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	f
555	12	#103	3	3	1302	1	2050.00	2050.00	12 months (academic year)	2025-07-15	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
556	12	104	0	1	451	1	1050.00	1050.00	9 months	2025-06-18	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
557	12	105	1	1	563	1	1250.00	1250.00	12 months (academic year)	2025-06-25	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
558	12	106	3	3	1278	1	2750.00	2750.00	12 months (academic year)	2025-05-14	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
559	12	H107	1	1	551	1	1350.00	1350.00	9 months	2025-07-03	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
560	12	I108	1	1	756	1	1000.00	1000.00	6 months	2025-07-07	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
561	12	#109	2	2	929	1	1550.00	1550.00	12 months (academic year)	2025-05-31	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
562	12	#110	2	2	943	1	1650.00	1650.00	12 months (academic year)	2025-05-18	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
563	12	111	1	1	812	1	1100.00	1100.00	12 months (academic year)	2025-05-22	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
564	12	M112	2	2	880	1	1650.00	1650.00	15 months	2025-07-17	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
565	12	201	2	2	1151	2	2000.00	2000.00	9 months	2025-08-24	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
566	12	#202	3	3	1503	2	2450.00	2450.00	9 months	2025-05-30	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
567	12	D203	0	1	593	2	800.00	800.00	6 months	2025-07-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
568	12	204	3	3	1525	2	2500.00	2500.00	9 months	2025-08-28	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
569	12	205	3	3	1421	2	2600.00	2600.00	9 months	2025-07-01	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
570	12	206	3	3	1453	2	2350.00	2350.00	6 months	2025-06-12	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	f
571	12	#207	2	2	945	2	1850.00	1850.00	12 months	2025-05-22	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	f
572	12	I208	2	2	1039	2	1500.00	1500.00	9 months	2025-07-04	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
573	12	#209	2	2	999	2	1800.00	1800.00	12 months	2025-05-16	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
574	12	#210	2	2	1176	2	1950.00	1950.00	12 months	2025-08-18	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	f
575	12	L211	2	2	1088	2	1550.00	1550.00	9 months	2025-07-18	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
576	12	M212	0	1	410	2	950.00	950.00	9 months	2025-05-07	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
577	12	B301	2	2	1130	3	1950.00	1950.00	12 months	2025-08-26	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
578	12	C302	0	1	562	3	850.00	850.00	15 months	2025-06-12	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
579	12	D303	1	1	824	3	1450.00	1450.00	15 months	2025-06-14	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
580	12	#304	2	2	1189	3	1800.00	1800.00	9 months	2025-07-24	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
581	12	305	1	1	558	3	1050.00	1050.00	12 months (academic year)	2025-06-13	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	f
582	12	#306	1	1	637	3	1200.00	1200.00	9 months	2025-08-02	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
583	12	#307	1	1	666	3	1400.00	1400.00	15 months	2025-08-31	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
584	12	I308	2	2	963	3	1900.00	1900.00	9 months	2025-06-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
585	12	J309	1	1	805	3	1300.00	1300.00	6 months	2025-06-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
586	12	310	2	2	1000	3	1400.00	1400.00	9 months	2025-06-02	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
587	12	311	2	2	1019	3	1450.00	1450.00	9 months	2025-05-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
588	12	#312	1	1	677	3	1300.00	1300.00	12 months (academic year)	2025-08-29	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
589	12	#401	1	1	580	4	1350.00	1350.00	12 months (academic year)	2025-05-18	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
590	12	C402	1	1	683	4	1000.00	1000.00	9 months	2025-05-13	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
591	12	D403	3	3	1346	4	2200.00	2200.00	15 months	2025-05-30	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
592	12	404	3	3	1248	4	1800.00	1800.00	9 months	2025-05-17	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
593	12	F405	1	1	709	4	1200.00	1200.00	6 months	2025-07-12	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	f
594	12	406	1	1	684	4	1300.00	1300.00	6 months	2025-05-30	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
595	12	H407	3	3	1342	4	2450.00	2450.00	15 months	2025-07-23	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	f
596	12	#408	1	1	800	4	1400.00	1400.00	12 months (academic year)	2025-06-28	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
597	12	J409	2	2	899	4	2050.00	2050.00	12 months	2025-07-03	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
598	12	K410	1	1	648	4	1000.00	1000.00	9 months	2025-07-04	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	f
599	12	411	0	1	496	4	950.00	950.00	15 months	2025-07-17	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
600	12	#412	2	2	886	4	1800.00	1800.00	6 months	2025-05-16	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
601	12	B501	0	1	582	5	850.00	850.00	12 months	2025-05-22	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
602	12	C502	1	1	817	5	1350.00	1350.00	15 months	2025-08-23	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
603	13	#101	3	3	1563	1	2500.00	2500.00	6 months	2025-07-12	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
604	13	C102	2	2	862	1	1600.00	1600.00	6 months	2025-08-31	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
605	13	D103	1	1	554	1	1300.00	1300.00	15 months	2025-05-20	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
606	13	E104	3	3	1283	1	2250.00	2250.00	15 months	2025-06-19	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
607	13	105	1	1	831	1	1450.00	1450.00	12 months	2025-07-17	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
608	13	106	2	2	1064	1	1550.00	1550.00	15 months	2025-06-11	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
609	13	H107	2	2	1088	1	1950.00	1950.00	6 months	2025-06-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
610	13	B201	2	2	926	2	1650.00	1650.00	15 months	2025-06-20	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
611	13	#202	0	1	587	2	1150.00	1150.00	6 months	2025-06-21	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
612	13	#203	1	1	768	2	1400.00	1400.00	15 months	2025-06-16	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
613	13	204	3	3	1279	2	2400.00	2400.00	15 months	2025-06-05	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
614	13	F205	2	2	1106	2	1650.00	1650.00	12 months	2025-07-05	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	f
615	13	G206	2	2	955	2	1400.00	1400.00	6 months	2025-06-24	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
616	13	207	1	1	753	2	1450.00	1450.00	15 months	2025-08-19	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
617	13	B301	1	1	578	3	1000.00	1000.00	9 months	2025-05-15	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
618	13	C302	2	2	860	3	1550.00	1550.00	9 months	2025-06-01	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
619	13	D303	1	1	646	3	1200.00	1200.00	12 months	2025-05-07	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
620	13	#304	1	1	697	3	1250.00	1250.00	12 months (academic year)	2025-07-17	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	f
621	13	305	2	2	1166	3	1550.00	1550.00	15 months	2025-08-17	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
622	13	G306	3	3	1302	3	2650.00	2650.00	6 months	2025-05-13	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
623	13	#307	0	1	403	3	1000.00	1000.00	9 months	2025-08-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
624	13	401	2	2	1108	4	2000.00	2000.00	12 months (academic year)	2025-07-19	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
625	13	402	1	1	625	4	1350.00	1350.00	12 months	2025-06-15	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
626	13	D403	3	3	1562	4	2750.00	2750.00	15 months	2025-07-04	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
627	13	E404	1	1	761	4	1400.00	1400.00	12 months	2025-07-12	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
628	13	F405	0	1	557	4	1150.00	1150.00	9 months	2025-08-01	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
629	13	#406	2	2	998	4	2050.00	2050.00	9 months	2025-07-30	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
630	13	H407	1	1	689	4	1200.00	1200.00	12 months (academic year)	2025-08-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
631	13	501	0	1	488	5	950.00	950.00	15 months	2025-06-02	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
632	13	502	0	1	569	5	800.00	800.00	9 months	2025-07-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
633	13	503	0	1	401	5	850.00	850.00	15 months	2025-08-14	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
634	13	504	2	2	891	5	2150.00	2150.00	15 months	2025-05-31	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
635	13	505	0	1	449	5	1050.00	1050.00	12 months (academic year)	2025-08-14	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
636	13	#506	2	2	992	5	1700.00	1700.00	15 months	2025-07-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
637	13	H507	1	1	677	5	1400.00	1400.00	15 months	2025-05-20	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
638	13	B601	0	1	438	6	900.00	900.00	12 months (academic year)	2025-07-12	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
639	13	#602	2	2	883	6	1800.00	1800.00	12 months (academic year)	2025-08-02	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
640	13	#603	1	1	729	6	1150.00	1150.00	6 months	2025-06-03	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
641	13	604	1	1	806	6	1300.00	1300.00	9 months	2025-08-18	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
642	13	F605	2	2	1054	6	1850.00	1850.00	12 months	2025-08-02	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
643	13	#606	3	3	1366	6	1950.00	1950.00	6 months	2025-05-13	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
644	13	H607	3	3	1567	6	2750.00	2750.00	6 months	2025-05-23	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	f
645	13	701	1	1	600	7	1100.00	1100.00	9 months	2025-07-01	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
646	13	C702	1	1	692	7	1200.00	1200.00	12 months (academic year)	2025-06-11	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
647	13	#703	2	2	1085	7	2100.00	2100.00	12 months	2025-05-30	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	f
648	13	E704	3	3	1517	7	1800.00	1800.00	9 months	2025-05-24	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
649	13	705	2	2	916	7	1900.00	1900.00	6 months	2025-07-11	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
650	13	G706	2	2	1027	7	2150.00	2150.00	15 months	2025-06-05	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
651	13	#707	1	1	786	7	1000.00	1000.00	6 months	2025-05-20	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
652	13	801	0	1	429	8	1150.00	1150.00	15 months	2025-08-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
653	13	C802	1	1	564	8	1400.00	1400.00	15 months	2025-06-21	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
654	13	#803	1	1	707	8	1150.00	1150.00	12 months (academic year)	2025-05-09	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
655	13	#804	2	2	937	8	1500.00	1500.00	9 months	2025-08-09	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
656	13	805	3	3	1208	8	2300.00	2300.00	12 months (academic year)	2025-05-31	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
657	13	G806	1	1	786	8	1100.00	1100.00	9 months	2025-07-03	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
658	13	807	2	2	1174	8	2050.00	2050.00	12 months	2025-06-11	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
659	13	#901	1	1	663	9	1250.00	1250.00	9 months	2025-06-30	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
660	13	C902	1	1	697	9	1250.00	1250.00	6 months	2025-06-20	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
661	13	D903	2	2	1191	9	1650.00	1650.00	15 months	2025-07-03	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
662	13	#904	2	2	1167	9	2150.00	2150.00	6 months	2025-08-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
663	14	101	3	3	1573	1	2750.00	2750.00	12 months	2025-08-02	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
664	14	C102	2	2	923	1	1500.00	1500.00	12 months	2025-07-27	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
665	14	#103	2	2	1133	1	1500.00	1500.00	15 months	2025-06-14	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
666	14	E104	2	2	989	1	1650.00	1650.00	12 months	2025-06-12	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
667	14	F105	3	3	1300	1	2400.00	2400.00	12 months (academic year)	2025-06-26	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
668	14	G106	3	3	1391	1	2400.00	2400.00	6 months	2025-08-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
669	14	#107	1	1	799	1	1200.00	1200.00	12 months (academic year)	2025-08-15	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
670	14	108	2	2	986	1	2150.00	2150.00	9 months	2025-08-13	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
671	14	109	0	1	456	1	1150.00	1150.00	12 months (academic year)	2025-07-06	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
672	14	#110	3	3	1550	1	2100.00	2100.00	6 months	2025-06-11	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
673	14	111	3	3	1500	1	2350.00	2350.00	15 months	2025-08-21	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
674	14	#112	2	2	1185	1	2100.00	2100.00	9 months	2025-08-26	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	f
675	14	N113	1	1	810	1	1300.00	1300.00	12 months (academic year)	2025-07-08	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
676	14	#114	3	3	1362	1	1900.00	1900.00	9 months	2025-08-04	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
677	14	#115	1	1	626	1	1100.00	1100.00	12 months (academic year)	2025-08-09	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
678	14	Q116	1	1	721	1	1300.00	1300.00	12 months (academic year)	2025-06-22	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
679	14	R117	2	2	987	1	1800.00	1800.00	9 months	2025-06-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
680	14	118	1	1	597	1	1400.00	1400.00	12 months (academic year)	2025-05-08	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
681	14	201	2	2	1014	2	1900.00	1900.00	12 months (academic year)	2025-07-29	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
682	14	#202	0	1	593	2	800.00	800.00	9 months	2025-06-06	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
683	14	203	1	1	598	2	1100.00	1100.00	9 months	2025-06-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
684	14	#204	0	1	439	2	1050.00	1050.00	15 months	2025-08-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
685	14	F205	2	2	873	2	2000.00	2000.00	15 months	2025-07-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
686	14	G206	0	1	517	2	850.00	850.00	12 months	2025-06-23	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
687	14	H207	1	1	832	2	1200.00	1200.00	6 months	2025-06-28	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
688	14	208	2	2	901	2	1700.00	1700.00	12 months (academic year)	2025-07-26	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
689	14	J209	0	1	402	2	1050.00	1050.00	6 months	2025-08-19	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
690	14	K210	1	1	608	2	1350.00	1350.00	15 months	2025-05-07	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
691	14	L211	1	1	616	2	1200.00	1200.00	9 months	2025-05-31	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
692	14	212	2	2	1140	2	1750.00	1750.00	9 months	2025-06-26	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
693	14	#213	3	3	1220	2	2050.00	2050.00	12 months (academic year)	2025-07-11	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
694	14	#214	1	1	562	2	1450.00	1450.00	15 months	2025-05-03	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	f
695	14	P215	1	1	743	2	1450.00	1450.00	12 months (academic year)	2025-07-08	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
697	14	#217	2	2	1054	2	2050.00	2050.00	12 months	2025-06-04	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
698	14	#218	1	1	715	2	1300.00	1300.00	9 months	2025-05-18	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
699	14	#301	1	1	551	3	1250.00	1250.00	15 months	2025-07-14	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
700	14	302	1	1	683	3	1300.00	1300.00	9 months	2025-05-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
701	14	303	0	1	400	3	1050.00	1050.00	12 months	2025-08-07	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	f
702	14	#304	0	1	457	3	800.00	800.00	6 months	2025-08-14	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
703	14	#305	3	3	1273	3	1800.00	1800.00	6 months	2025-07-01	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
704	14	#306	2	2	1092	3	1650.00	1650.00	15 months	2025-08-21	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	f
705	14	#307	1	1	657	3	1000.00	1000.00	12 months (academic year)	2025-05-11	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
706	14	#308	3	3	1501	3	2450.00	2450.00	15 months	2025-06-21	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
707	14	#309	1	1	785	3	1200.00	1200.00	15 months	2025-06-02	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
708	14	#310	2	2	1175	3	1450.00	1450.00	12 months	2025-05-17	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
709	14	311	2	2	1134	3	1750.00	1750.00	12 months (academic year)	2025-06-27	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
710	14	312	1	1	652	3	1300.00	1300.00	6 months	2025-06-25	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
711	14	N313	2	2	1124	3	1750.00	1750.00	6 months	2025-05-27	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
712	14	314	1	1	636	3	1150.00	1150.00	12 months	2025-06-05	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
713	14	P315	2	2	935	3	1700.00	1700.00	12 months (academic year)	2025-07-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
714	14	#316	1	1	657	3	1400.00	1400.00	12 months (academic year)	2025-08-16	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
715	14	#317	2	2	1019	3	1700.00	1700.00	6 months	2025-07-04	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
716	14	318	2	2	1053	3	1950.00	1950.00	9 months	2025-08-17	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
717	14	B401	2	2	1104	4	1950.00	1950.00	15 months	2025-05-23	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
718	15	101	2	2	1120	1	1850.00	1850.00	15 months	2025-05-28	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
719	15	102	0	1	575	1	850.00	850.00	6 months	2025-06-30	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
720	15	103	3	3	1436	1	2750.00	2750.00	12 months (academic year)	2025-06-28	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	f
721	15	#104	3	3	1577	1	2500.00	2500.00	12 months	2025-07-12	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
722	15	105	2	2	1167	1	1450.00	1450.00	9 months	2025-06-04	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
723	15	106	1	1	773	1	1200.00	1200.00	12 months (academic year)	2025-06-06	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
724	15	201	2	2	1177	2	1650.00	1650.00	15 months	2025-08-06	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
725	15	#202	2	2	930	2	2100.00	2100.00	15 months	2025-08-04	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	f
726	15	D203	0	1	482	2	800.00	800.00	12 months (academic year)	2025-07-08	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
727	15	204	1	1	675	2	1000.00	1000.00	6 months	2025-05-04	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
728	15	#205	2	2	1084	2	1550.00	1550.00	6 months	2025-05-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
729	15	206	1	1	581	2	1100.00	1100.00	12 months	2025-06-15	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
730	15	#301	2	2	1023	3	1650.00	1650.00	12 months (academic year)	2025-05-15	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
731	15	302	3	3	1562	3	2150.00	2150.00	12 months (academic year)	2025-07-24	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
732	15	303	2	2	1051	3	1900.00	1900.00	15 months	2025-05-23	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
733	15	E304	0	1	473	3	850.00	850.00	12 months (academic year)	2025-08-06	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	f
734	15	F305	2	2	985	3	1650.00	1650.00	15 months	2025-05-14	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
735	15	G306	3	3	1352	3	2200.00	2200.00	12 months (academic year)	2025-05-12	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
736	15	401	0	1	524	4	1050.00	1050.00	12 months	2025-08-31	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
737	15	#402	2	2	1076	4	1600.00	1600.00	15 months	2025-05-20	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
738	15	D403	2	2	1101	4	1750.00	1750.00	12 months (academic year)	2025-07-01	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
739	15	404	1	1	573	4	1350.00	1350.00	12 months (academic year)	2025-08-30	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
740	15	405	1	1	673	4	1450.00	1450.00	12 months	2025-05-09	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
741	15	406	0	1	405	4	1100.00	1100.00	12 months	2025-05-26	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
742	15	#501	2	2	957	5	1850.00	1850.00	15 months	2025-07-18	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
743	15	502	2	2	1106	5	1950.00	1950.00	12 months	2025-08-03	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
744	15	#503	2	2	893	5	1750.00	1750.00	12 months (academic year)	2025-08-12	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	f
745	15	504	3	3	1528	5	2450.00	2450.00	9 months	2025-06-10	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
746	15	505	1	1	741	5	1450.00	1450.00	6 months	2025-07-05	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
747	15	#506	1	1	641	5	1450.00	1450.00	6 months	2025-06-22	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
748	15	601	1	1	755	6	1200.00	1200.00	6 months	2025-09-01	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
749	15	C602	2	2	1198	6	2150.00	2150.00	12 months	2025-06-22	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
750	15	#603	2	2	1115	6	1900.00	1900.00	15 months	2025-05-20	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
751	15	#604	0	1	480	6	1100.00	1100.00	9 months	2025-05-22	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
752	15	#605	1	1	585	6	1200.00	1200.00	15 months	2025-06-26	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
753	15	606	1	1	601	6	1350.00	1350.00	9 months	2025-06-23	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	f
754	15	#701	1	1	628	7	1200.00	1200.00	12 months	2025-08-21	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
755	15	702	3	3	1365	7	1850.00	1850.00	9 months	2025-06-11	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
756	15	D703	3	3	1522	7	2150.00	2150.00	9 months	2025-05-01	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
757	15	#704	1	1	638	7	1300.00	1300.00	6 months	2025-06-22	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
758	15	F705	1	1	778	7	1350.00	1350.00	9 months	2025-08-26	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
759	15	G706	1	1	706	7	1150.00	1150.00	12 months (academic year)	2025-06-28	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
760	15	801	1	1	670	8	1300.00	1300.00	15 months	2025-08-20	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
761	16	101	0	1	542	1	1100.00	1100.00	6 months	2025-05-03	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
762	16	102	2	2	1044	1	1950.00	1950.00	12 months (academic year)	2025-07-05	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
763	16	D103	1	1	667	1	1100.00	1100.00	12 months (academic year)	2025-05-02	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
764	16	#104	1	1	788	1	1250.00	1250.00	15 months	2025-08-05	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
765	16	105	3	3	1382	1	2750.00	2750.00	9 months	2025-05-16	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
766	16	#106	1	1	762	1	1150.00	1150.00	15 months	2025-06-24	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
767	16	H107	1	1	683	1	1350.00	1350.00	15 months	2025-07-24	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
768	16	I108	2	2	851	1	1650.00	1650.00	15 months	2025-08-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
769	16	J109	3	3	1258	1	1800.00	1800.00	9 months	2025-07-02	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	f
770	16	#201	0	1	441	2	850.00	850.00	12 months (academic year)	2025-07-23	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
771	16	202	3	3	1472	2	1800.00	1800.00	6 months	2025-07-10	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
772	16	#203	1	1	762	2	1200.00	1200.00	15 months	2025-05-09	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
773	16	#204	2	2	1093	2	1400.00	1400.00	15 months	2025-05-02	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
774	16	205	0	1	563	2	1150.00	1150.00	6 months	2025-05-01	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
775	16	206	1	1	603	2	1400.00	1400.00	15 months	2025-07-26	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
776	16	H207	2	2	1110	2	1400.00	1400.00	15 months	2025-05-27	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
777	16	208	1	1	618	2	1000.00	1000.00	15 months	2025-06-14	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
778	16	J209	2	2	906	2	1950.00	1950.00	15 months	2025-05-03	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
779	16	301	2	2	1166	3	1750.00	1750.00	9 months	2025-07-10	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
780	16	C302	0	1	409	3	900.00	900.00	12 months	2025-05-23	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
781	16	303	2	2	1122	3	1750.00	1750.00	6 months	2025-08-19	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
782	16	E304	1	1	574	3	1200.00	1200.00	15 months	2025-08-17	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
783	16	305	1	1	799	3	1150.00	1150.00	15 months	2025-05-15	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
784	16	306	3	3	1442	3	2600.00	2600.00	15 months	2025-06-02	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
785	16	307	3	3	1280	3	1850.00	1850.00	15 months	2025-05-24	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
786	16	#308	3	3	1596	3	1800.00	1800.00	15 months	2025-06-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
787	16	#309	3	3	1280	3	2700.00	2700.00	12 months	2025-05-07	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
788	16	B401	0	1	519	4	1100.00	1100.00	12 months	2025-08-28	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
789	16	#402	2	2	1025	4	1650.00	1650.00	6 months	2025-07-31	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
790	16	#403	2	2	866	4	1500.00	1500.00	15 months	2025-05-19	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
791	16	404	0	1	549	4	900.00	900.00	6 months	2025-07-31	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	f
792	16	F405	2	2	865	4	2100.00	2100.00	6 months	2025-08-19	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
793	16	#406	1	1	580	4	1150.00	1150.00	12 months (academic year)	2025-08-08	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
794	16	407	1	1	573	4	1300.00	1300.00	9 months	2025-05-03	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
795	16	#408	2	2	908	4	2000.00	2000.00	15 months	2025-08-06	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
796	16	J409	2	2	1133	4	1650.00	1650.00	9 months	2025-07-21	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
797	16	501	1	1	733	5	1050.00	1050.00	15 months	2025-08-31	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
798	16	#502	2	2	1101	5	1450.00	1450.00	9 months	2025-08-16	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	f
799	16	D503	2	2	1120	5	2050.00	2050.00	9 months	2025-08-30	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
800	16	E504	2	2	979	5	1850.00	1850.00	15 months	2025-08-02	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
801	16	505	3	3	1326	5	1900.00	1900.00	12 months (academic year)	2025-08-08	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
802	16	G506	1	1	657	5	1450.00	1450.00	15 months	2025-08-08	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
803	16	507	2	2	912	5	1600.00	1600.00	6 months	2025-05-11	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
804	16	#508	2	2	1089	5	1850.00	1850.00	9 months	2025-07-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
805	16	#509	1	1	828	5	1450.00	1450.00	9 months	2025-06-18	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
806	16	#601	1	1	753	6	1400.00	1400.00	6 months	2025-05-02	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
807	16	#602	1	1	770	6	1250.00	1250.00	9 months	2025-07-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
808	16	#603	0	1	571	6	800.00	800.00	15 months	2025-07-14	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
809	16	604	1	1	811	6	1450.00	1450.00	9 months	2025-07-13	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
810	17	B101	2	2	911	1	1400.00	1400.00	9 months	2025-07-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
811	17	C102	2	2	1021	1	1450.00	1450.00	12 months (academic year)	2025-07-25	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
812	17	103	1	1	746	1	1150.00	1150.00	6 months	2025-07-16	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
813	17	E104	0	1	481	1	1100.00	1100.00	12 months	2025-06-14	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
814	17	105	2	2	1046	1	1750.00	1750.00	6 months	2025-05-03	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
815	17	106	2	2	980	1	1900.00	1900.00	6 months	2025-07-31	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	f
816	17	107	2	2	1080	1	2000.00	2000.00	6 months	2025-05-19	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
817	17	#108	1	1	820	1	1000.00	1000.00	6 months	2025-08-02	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
818	17	#201	1	1	809	2	1100.00	1100.00	12 months	2025-07-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
819	17	202	1	1	707	2	1350.00	1350.00	15 months	2025-06-16	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	f
820	17	203	1	1	635	2	1100.00	1100.00	12 months	2025-08-08	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
821	17	204	1	1	696	2	1400.00	1400.00	9 months	2025-07-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
822	17	F205	1	1	818	2	1100.00	1100.00	9 months	2025-06-24	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
823	17	206	0	1	548	2	900.00	900.00	9 months	2025-05-28	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
824	17	207	3	3	1447	2	2350.00	2350.00	9 months	2025-07-16	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
825	17	#208	1	1	673	2	1050.00	1050.00	12 months (academic year)	2025-08-05	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
826	17	#301	2	2	1196	3	2150.00	2150.00	12 months (academic year)	2025-05-29	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
827	17	302	1	1	686	3	1050.00	1050.00	12 months	2025-06-05	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
828	17	D303	2	2	1185	3	1950.00	1950.00	6 months	2025-05-30	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
829	17	#304	2	2	1122	3	2100.00	2100.00	12 months	2025-07-18	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
830	17	305	3	3	1338	3	2150.00	2150.00	6 months	2025-07-15	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
831	17	G306	1	1	621	3	1000.00	1000.00	15 months	2025-06-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
832	17	H307	0	1	518	3	950.00	950.00	6 months	2025-07-16	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
833	17	I308	1	1	657	3	1300.00	1300.00	12 months	2025-08-23	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
834	17	B401	3	3	1389	4	2600.00	2600.00	12 months (academic year)	2025-05-09	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
835	17	#402	2	2	1066	4	1550.00	1550.00	6 months	2025-08-22	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
836	17	D403	1	1	659	4	1400.00	1400.00	12 months (academic year)	2025-07-20	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	f
837	17	E404	1	1	849	4	1200.00	1200.00	9 months	2025-05-27	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
838	17	405	2	2	1120	4	2100.00	2100.00	6 months	2025-08-30	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
839	17	406	3	3	1301	4	2200.00	2200.00	9 months	2025-07-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
840	17	H407	2	2	1093	4	1800.00	1800.00	12 months (academic year)	2025-06-30	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
841	17	408	3	3	1411	4	2000.00	2000.00	15 months	2025-05-15	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
842	17	#501	2	2	995	5	1950.00	1950.00	6 months	2025-06-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
843	17	C502	3	3	1376	5	2700.00	2700.00	15 months	2025-05-18	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
844	17	D503	0	1	459	5	800.00	800.00	12 months (academic year)	2025-06-22	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
845	17	#504	0	1	412	5	950.00	950.00	9 months	2025-06-19	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
846	17	F505	1	1	568	5	1450.00	1450.00	12 months (academic year)	2025-08-08	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
847	17	G506	2	2	1114	5	2000.00	2000.00	12 months (academic year)	2025-08-25	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
848	17	H507	0	1	593	5	1000.00	1000.00	12 months	2025-05-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	f
849	17	I508	2	2	1019	5	1950.00	1950.00	12 months (academic year)	2025-06-28	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
850	18	B101	2	2	855	1	1950.00	1950.00	6 months	2025-06-15	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
851	18	#102	3	3	1350	1	2250.00	2250.00	12 months	2025-05-11	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
852	18	#103	2	2	1193	1	1900.00	1900.00	12 months	2025-05-29	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
853	18	104	1	1	604	1	1050.00	1050.00	9 months	2025-06-17	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
854	18	F105	2	2	1124	1	2000.00	2000.00	12 months	2025-07-18	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
855	18	106	1	1	717	1	1450.00	1450.00	12 months	2025-05-25	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
856	18	107	0	1	500	1	1150.00	1150.00	15 months	2025-06-01	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
857	18	#108	3	3	1446	1	2700.00	2700.00	15 months	2025-07-20	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
858	18	J109	1	1	669	1	1300.00	1300.00	9 months	2025-08-13	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
859	18	201	1	1	589	2	1300.00	1300.00	9 months	2025-05-30	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
860	18	202	2	2	963	2	2000.00	2000.00	6 months	2025-05-03	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
861	18	D203	1	1	780	2	1000.00	1000.00	15 months	2025-08-04	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	f
862	18	204	2	2	1058	2	1500.00	1500.00	6 months	2025-05-30	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
863	18	#205	1	1	665	2	1050.00	1050.00	15 months	2025-05-14	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
864	18	#206	1	1	831	2	1150.00	1150.00	12 months	2025-07-20	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
865	18	H207	1	1	841	2	1200.00	1200.00	9 months	2025-05-07	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
866	18	208	1	1	562	2	1200.00	1200.00	6 months	2025-06-26	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
867	18	209	3	3	1446	2	2550.00	2550.00	15 months	2025-07-11	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
868	18	301	3	3	1279	3	2550.00	2550.00	12 months (academic year)	2025-06-20	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
869	18	C302	1	1	762	3	1400.00	1400.00	9 months	2025-08-17	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
870	18	#303	3	3	1490	3	2600.00	2600.00	15 months	2025-06-03	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	f
871	18	E304	0	1	515	3	800.00	800.00	12 months (academic year)	2025-05-24	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	f
872	18	305	1	1	847	3	1150.00	1150.00	15 months	2025-06-09	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
873	18	306	2	2	1126	3	1750.00	1750.00	12 months	2025-08-26	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
874	18	307	2	2	1155	3	2150.00	2150.00	12 months (academic year)	2025-05-09	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
875	18	#308	0	1	442	3	1000.00	1000.00	9 months	2025-06-29	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
876	18	#309	2	2	968	3	1650.00	1650.00	6 months	2025-06-19	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
877	18	401	1	1	623	4	1000.00	1000.00	6 months	2025-07-18	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
878	18	C402	3	3	1468	4	2100.00	2100.00	12 months	2025-08-03	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
879	18	D403	3	3	1521	4	2100.00	2100.00	15 months	2025-06-12	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
880	18	404	0	1	437	4	1150.00	1150.00	6 months	2025-06-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	f
881	18	#405	3	3	1264	4	2250.00	2250.00	12 months	2025-07-23	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
882	18	406	1	1	815	4	1100.00	1100.00	12 months (academic year)	2025-07-28	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
883	18	#407	2	2	1182	4	1500.00	1500.00	6 months	2025-07-06	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	f
884	18	#408	2	2	904	4	2000.00	2000.00	12 months (academic year)	2025-07-13	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
885	18	J409	2	2	885	4	1700.00	1700.00	9 months	2025-06-07	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	f
886	18	B501	0	1	486	5	800.00	800.00	12 months (academic year)	2025-05-18	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
887	18	#502	0	1	512	5	1000.00	1000.00	6 months	2025-06-28	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
888	18	D503	2	2	910	5	1450.00	1450.00	15 months	2025-06-28	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
889	18	E504	2	2	1088	5	1450.00	1450.00	9 months	2025-07-05	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	f
890	18	505	1	1	745	5	1400.00	1400.00	12 months	2025-05-01	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	f
891	18	G506	2	2	983	5	2150.00	2150.00	12 months (academic year)	2025-07-21	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
892	18	H507	1	1	643	5	1050.00	1050.00	15 months	2025-08-29	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
893	18	#508	3	3	1562	5	2300.00	2300.00	15 months	2025-07-20	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
894	18	J509	2	2	881	5	1500.00	1500.00	12 months	2025-06-07	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
895	19	101	2	2	1008	1	1550.00	1550.00	12 months (academic year)	2025-06-12	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
896	19	102	1	1	628	1	1100.00	1100.00	15 months	2025-08-26	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
897	19	103	3	3	1385	1	2400.00	2400.00	15 months	2025-07-31	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
898	19	#104	1	1	702	1	1000.00	1000.00	15 months	2025-06-11	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
899	19	#105	1	1	718	1	1300.00	1300.00	9 months	2025-05-21	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
900	19	106	2	2	976	1	1850.00	1850.00	6 months	2025-06-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
901	19	107	2	2	1143	1	2100.00	2100.00	6 months	2025-07-10	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
902	19	108	2	2	966	1	1750.00	1750.00	15 months	2025-06-16	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
903	19	#109	1	1	757	1	1450.00	1450.00	12 months (academic year)	2025-08-30	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
904	19	K110	2	2	879	1	1900.00	1900.00	6 months	2025-05-31	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
905	19	L111	3	3	1552	1	2150.00	2150.00	12 months (academic year)	2025-05-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
906	19	M112	2	2	1178	1	2000.00	2000.00	15 months	2025-05-06	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
907	19	B201	1	1	750	2	1250.00	1250.00	15 months	2025-05-26	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
908	19	C202	1	1	676	2	1000.00	1000.00	15 months	2025-08-21	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
909	19	#203	2	2	1060	2	2050.00	2050.00	15 months	2025-08-21	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
910	19	E204	2	2	1069	2	1700.00	1700.00	9 months	2025-06-14	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
911	19	205	2	2	1048	2	1650.00	1650.00	12 months	2025-07-31	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
912	19	#206	0	1	499	2	800.00	800.00	6 months	2025-05-10	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
913	19	207	3	3	1495	2	2400.00	2400.00	12 months	2025-06-04	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
914	19	208	1	1	824	2	1000.00	1000.00	6 months	2025-06-03	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
915	19	#209	2	2	942	2	1750.00	1750.00	9 months	2025-06-20	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
916	19	210	2	2	1096	2	1750.00	1750.00	12 months	2025-06-07	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
917	19	211	0	1	540	2	950.00	950.00	15 months	2025-08-08	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	f
918	19	M212	0	1	534	2	1150.00	1150.00	6 months	2025-06-22	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
919	19	B301	1	1	639	3	1450.00	1450.00	12 months (academic year)	2025-06-06	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
920	19	302	0	1	484	3	1050.00	1050.00	6 months	2025-07-18	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
921	19	D303	0	1	422	3	850.00	850.00	12 months (academic year)	2025-06-03	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
922	19	#304	1	1	621	3	1400.00	1400.00	15 months	2025-05-28	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
923	19	#305	2	2	873	3	1950.00	1950.00	9 months	2025-05-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
924	19	G306	2	2	1099	3	2050.00	2050.00	6 months	2025-07-14	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
925	19	H307	3	3	1203	3	2750.00	2750.00	9 months	2025-08-13	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
926	19	#308	1	1	677	3	1250.00	1250.00	15 months	2025-08-01	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
927	19	309	1	1	816	3	1350.00	1350.00	15 months	2025-07-01	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
928	19	#310	0	1	504	3	1050.00	1050.00	12 months (academic year)	2025-07-10	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
929	19	311	3	3	1424	3	2500.00	2500.00	12 months (academic year)	2025-06-27	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
930	19	312	1	1	744	3	1400.00	1400.00	9 months	2025-06-01	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
931	19	B401	3	3	1376	4	2750.00	2750.00	6 months	2025-06-28	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
932	19	402	2	2	1094	4	2000.00	2000.00	12 months	2025-05-11	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
933	19	D403	1	1	796	4	1200.00	1200.00	6 months	2025-05-20	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	f
934	19	E404	1	1	685	4	1400.00	1400.00	12 months	2025-06-04	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
935	19	F405	2	2	975	4	1550.00	1550.00	6 months	2025-06-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
936	19	#406	1	1	753	4	1250.00	1250.00	12 months (academic year)	2025-07-03	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
937	19	#407	3	3	1271	4	2100.00	2100.00	6 months	2025-07-05	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
938	19	I408	2	2	1178	4	2150.00	2150.00	12 months	2025-08-03	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
939	19	409	1	1	823	4	1100.00	1100.00	12 months (academic year)	2025-08-10	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
940	19	410	0	1	524	4	950.00	950.00	9 months	2025-07-21	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	f
941	19	#411	3	3	1449	4	2500.00	2500.00	12 months	2025-08-02	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
942	19	M412	1	1	683	4	1050.00	1050.00	12 months (academic year)	2025-05-28	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
943	19	B501	2	2	1088	5	1700.00	1700.00	12 months	2025-06-30	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
944	20	B101	3	3	1553	1	1850.00	1850.00	6 months	2025-07-28	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
945	20	C102	2	2	1055	1	2150.00	2150.00	6 months	2025-07-02	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
946	20	D103	1	1	643	1	1200.00	1200.00	12 months	2025-06-18	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
947	20	E104	1	1	802	1	1300.00	1300.00	12 months	2025-08-19	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
948	20	F105	3	3	1359	1	2650.00	2650.00	12 months (academic year)	2025-08-18	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
949	20	106	0	1	447	1	800.00	800.00	12 months (academic year)	2025-07-07	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
950	20	H107	1	1	756	1	1150.00	1150.00	9 months	2025-06-21	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
951	20	108	1	1	755	1	1200.00	1200.00	9 months	2025-08-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
952	20	109	2	2	928	1	2150.00	2150.00	12 months	2025-07-22	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	f
953	20	#110	0	1	594	1	850.00	850.00	12 months	2025-05-19	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
954	20	L111	2	2	953	1	2100.00	2100.00	12 months (academic year)	2025-05-06	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
955	20	M112	1	1	733	1	1000.00	1000.00	12 months	2025-07-14	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	f
956	20	113	3	3	1559	1	2200.00	2200.00	12 months (academic year)	2025-08-20	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
957	20	#201	3	3	1327	2	2600.00	2600.00	15 months	2025-07-21	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
958	20	#202	3	3	1576	2	1950.00	1950.00	15 months	2025-05-09	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
959	20	#203	1	1	574	2	1350.00	1350.00	9 months	2025-07-08	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
960	20	E204	2	2	924	2	1450.00	1450.00	12 months (academic year)	2025-08-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	f
961	20	205	1	1	818	2	1400.00	1400.00	15 months	2025-06-16	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
962	20	#206	2	2	1070	2	2050.00	2050.00	12 months	2025-05-31	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	f
963	20	#207	0	1	535	2	900.00	900.00	15 months	2025-07-16	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
964	20	#208	2	2	1132	2	2150.00	2150.00	12 months	2025-08-07	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
965	20	209	3	3	1518	2	2300.00	2300.00	12 months (academic year)	2025-06-14	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
966	20	#210	0	1	579	2	950.00	950.00	12 months	2025-07-14	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
967	20	#211	2	2	856	2	1700.00	1700.00	9 months	2025-05-17	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
968	20	M212	2	2	1062	2	2100.00	2100.00	6 months	2025-08-31	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
969	20	213	2	2	1007	2	1550.00	1550.00	12 months	2025-07-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
970	20	301	1	1	677	3	1100.00	1100.00	9 months	2025-05-12	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
971	20	C302	2	2	1160	3	1650.00	1650.00	6 months	2025-06-15	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
972	20	303	2	2	942	3	1900.00	1900.00	9 months	2025-06-23	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	f
973	20	E304	1	1	608	3	1000.00	1000.00	12 months (academic year)	2025-08-12	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
974	20	#305	2	2	1072	3	1950.00	1950.00	6 months	2025-07-13	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
975	20	G306	1	1	641	3	1250.00	1250.00	12 months (academic year)	2025-05-13	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	f
976	20	307	2	2	1116	3	1650.00	1650.00	6 months	2025-05-23	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
977	20	308	1	1	715	3	1400.00	1400.00	9 months	2025-08-19	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
978	20	#309	1	1	779	3	1250.00	1250.00	9 months	2025-08-14	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
979	20	310	3	3	1448	3	2150.00	2150.00	15 months	2025-07-06	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
980	20	L311	1	1	755	3	1350.00	1350.00	6 months	2025-06-04	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
981	20	312	2	2	1004	3	2050.00	2050.00	12 months (academic year)	2025-06-09	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
982	20	313	1	1	824	3	1400.00	1400.00	12 months (academic year)	2025-06-28	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
983	20	#401	1	1	554	4	1050.00	1050.00	15 months	2025-08-20	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	f
984	20	C402	1	1	579	4	1000.00	1000.00	12 months (academic year)	2025-08-22	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
985	20	#403	0	1	429	4	1000.00	1000.00	6 months	2025-07-28	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
986	20	#404	0	1	531	4	800.00	800.00	6 months	2025-08-28	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
987	20	#405	2	2	1154	4	1500.00	1500.00	9 months	2025-05-09	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
988	20	406	2	2	1195	4	1550.00	1550.00	12 months	2025-08-17	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
989	20	H407	2	2	878	4	1450.00	1450.00	12 months	2025-05-03	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
990	20	I408	1	1	726	4	1350.00	1350.00	12 months	2025-07-20	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
991	20	J409	3	3	1366	4	2500.00	2500.00	6 months	2025-05-15	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
992	20	K410	0	1	585	4	800.00	800.00	6 months	2025-05-25	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
993	20	411	1	1	741	4	1400.00	1400.00	6 months	2025-07-26	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
994	20	412	3	3	1337	4	2150.00	2150.00	12 months	2025-05-07	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
995	20	413	3	3	1429	4	2450.00	2450.00	12 months (academic year)	2025-06-16	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
996	20	#501	2	2	880	5	1900.00	1900.00	9 months	2025-05-24	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
997	21	B101	1	1	843	1	1350.00	1350.00	9 months	2025-08-18	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
998	21	C102	1	1	821	1	1300.00	1300.00	12 months	2025-06-27	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
999	21	#103	2	2	857	1	1800.00	1800.00	15 months	2025-07-03	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1000	21	E104	2	2	899	1	2100.00	2100.00	12 months (academic year)	2025-08-29	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1001	21	105	0	1	590	1	800.00	800.00	6 months	2025-06-10	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1002	21	106	0	1	591	1	900.00	900.00	12 months (academic year)	2025-07-08	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1003	21	107	0	1	467	1	1150.00	1150.00	6 months	2025-06-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
1004	21	#108	1	1	717	1	1450.00	1450.00	12 months	2025-07-17	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1005	21	#201	1	1	609	2	1100.00	1100.00	12 months	2025-05-22	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1006	21	C202	2	2	884	2	2150.00	2150.00	9 months	2025-06-28	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
1007	21	D203	2	2	1136	2	1650.00	1650.00	12 months	2025-07-26	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
1008	21	E204	2	2	878	2	1650.00	1650.00	12 months (academic year)	2025-06-23	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
1009	21	F205	3	3	1529	2	2250.00	2250.00	9 months	2025-08-20	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1010	21	#206	3	3	1334	2	1950.00	1950.00	15 months	2025-06-07	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1011	21	H207	1	1	790	2	1200.00	1200.00	12 months (academic year)	2025-06-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
1012	21	208	1	1	669	2	1100.00	1100.00	15 months	2025-06-14	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1013	21	B301	1	1	563	3	1350.00	1350.00	9 months	2025-08-14	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1014	21	#302	3	3	1467	3	2100.00	2100.00	9 months	2025-05-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1015	21	#303	2	2	1076	3	1800.00	1800.00	12 months	2025-08-15	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1016	21	304	0	1	420	3	1150.00	1150.00	9 months	2025-06-11	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1017	21	F305	2	2	881	3	1700.00	1700.00	12 months (academic year)	2025-05-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1018	21	#306	2	2	968	3	2000.00	2000.00	12 months	2025-07-02	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
1019	21	307	3	3	1383	3	1950.00	1950.00	9 months	2025-06-16	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1020	21	#308	2	2	922	3	1450.00	1450.00	12 months	2025-06-02	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1021	21	#401	2	2	1004	4	2100.00	2100.00	9 months	2025-05-14	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1022	21	C402	2	2	1029	4	1600.00	1600.00	6 months	2025-06-02	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1023	21	#403	1	1	828	4	1200.00	1200.00	12 months	2025-06-10	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1024	21	404	2	2	1035	4	1850.00	1850.00	6 months	2025-06-29	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1025	21	405	3	3	1282	4	2600.00	2600.00	12 months (academic year)	2025-05-20	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1026	21	#406	3	3	1380	4	2500.00	2500.00	12 months	2025-07-02	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	f
1027	21	#407	1	1	684	4	1150.00	1150.00	12 months	2025-06-08	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1028	21	I408	1	1	759	4	1400.00	1400.00	6 months	2025-08-17	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1029	21	501	2	2	923	5	1600.00	1600.00	9 months	2025-05-25	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1030	21	502	1	1	604	5	1350.00	1350.00	15 months	2025-05-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1031	21	#503	0	1	494	5	800.00	800.00	12 months	2025-08-23	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1032	21	#504	1	1	581	5	1400.00	1400.00	15 months	2025-06-15	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1033	21	F505	2	2	1001	5	2150.00	2150.00	15 months	2025-05-23	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1034	21	#506	1	1	791	5	1400.00	1400.00	15 months	2025-08-22	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1035	21	H507	1	1	625	5	1050.00	1050.00	6 months	2025-08-26	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	f
1036	21	508	1	1	629	5	1200.00	1200.00	9 months	2025-06-29	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	f
1037	21	601	3	3	1306	6	2400.00	2400.00	6 months	2025-07-19	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1038	21	#602	1	1	577	6	1400.00	1400.00	9 months	2025-08-02	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1039	21	#603	3	3	1231	6	2000.00	2000.00	12 months	2025-07-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1040	21	604	1	1	630	6	1400.00	1400.00	12 months	2025-08-15	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1041	21	605	0	1	466	6	800.00	800.00	15 months	2025-06-25	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1042	21	G606	2	2	889	6	2150.00	2150.00	15 months	2025-05-09	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1043	21	#607	1	1	807	6	1250.00	1250.00	9 months	2025-08-19	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
1044	21	I608	2	2	1094	6	1900.00	1900.00	6 months	2025-06-18	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1045	21	701	0	1	528	7	900.00	900.00	15 months	2025-08-15	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
1046	21	C702	2	2	997	7	2150.00	2150.00	15 months	2025-06-16	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1047	21	#703	2	2	1151	7	2100.00	2100.00	9 months	2025-06-14	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
1048	21	#704	1	1	682	7	1150.00	1150.00	12 months	2025-05-09	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1049	21	F705	0	1	579	7	850.00	850.00	15 months	2025-08-05	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
1050	21	G706	2	2	1081	7	1900.00	1900.00	9 months	2025-07-13	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	f
1051	21	#707	3	3	1496	7	2000.00	2000.00	6 months	2025-06-22	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1052	21	708	1	1	595	7	1050.00	1050.00	9 months	2025-09-01	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1053	21	#801	3	3	1575	8	2550.00	2550.00	15 months	2025-08-08	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1054	21	802	2	2	963	8	1450.00	1450.00	15 months	2025-08-27	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1055	22	#101	2	2	959	1	1700.00	1700.00	12 months (academic year)	2025-05-23	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1056	22	102	2	2	914	1	1750.00	1750.00	12 months (academic year)	2025-06-19	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1057	22	#103	2	2	1134	1	1750.00	1750.00	15 months	2025-06-06	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1058	22	#104	2	2	1020	1	1450.00	1450.00	6 months	2025-05-28	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1059	22	F105	2	2	1177	1	1900.00	1900.00	12 months	2025-07-21	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1060	22	#106	0	1	551	1	950.00	950.00	9 months	2025-07-17	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
1061	22	B201	1	1	846	2	1300.00	1300.00	12 months (academic year)	2025-08-30	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1062	22	202	2	2	940	2	1700.00	1700.00	15 months	2025-08-26	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1063	22	#203	3	3	1565	2	2500.00	2500.00	9 months	2025-08-20	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
1064	22	#204	1	1	613	2	1250.00	1250.00	12 months (academic year)	2025-05-30	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	f
1065	22	205	2	2	1112	2	1450.00	1450.00	6 months	2025-06-07	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1066	22	G206	2	2	967	2	1450.00	1450.00	15 months	2025-06-15	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1067	22	#301	2	2	922	3	1650.00	1650.00	12 months	2025-07-03	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
1068	22	C302	1	1	807	3	1400.00	1400.00	9 months	2025-08-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
1069	22	#303	1	1	660	3	1200.00	1200.00	12 months (academic year)	2025-06-09	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1070	22	304	3	3	1384	3	1800.00	1800.00	6 months	2025-08-06	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1071	22	305	2	2	881	3	2000.00	2000.00	6 months	2025-06-13	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
1072	22	#306	1	1	701	3	1450.00	1450.00	15 months	2025-06-09	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
1073	22	#401	0	1	539	4	900.00	900.00	15 months	2025-05-20	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1074	22	#402	2	2	1012	4	2100.00	2100.00	6 months	2025-06-12	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
1075	22	#403	3	3	1352	4	2750.00	2750.00	12 months (academic year)	2025-08-23	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1076	22	404	3	3	1569	4	2600.00	2600.00	9 months	2025-07-14	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
1077	22	405	2	2	955	4	1700.00	1700.00	12 months	2025-07-03	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1078	22	#406	1	1	790	4	1050.00	1050.00	6 months	2025-06-04	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
1079	22	501	0	1	511	5	950.00	950.00	15 months	2025-08-05	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
1080	22	#502	3	3	1234	5	2350.00	2350.00	15 months	2025-05-15	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1081	22	D503	1	1	603	5	1100.00	1100.00	9 months	2025-08-30	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1082	22	#504	1	1	617	5	1000.00	1000.00	9 months	2025-08-22	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
1083	22	F505	1	1	562	5	1300.00	1300.00	12 months	2025-05-15	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1084	22	#506	2	2	1128	5	1450.00	1450.00	12 months	2025-07-17	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1085	22	601	1	1	849	6	1150.00	1150.00	12 months (academic year)	2025-07-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1086	22	602	1	1	801	6	1000.00	1000.00	12 months	2025-08-08	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1087	22	D603	1	1	605	6	1400.00	1400.00	6 months	2025-06-13	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1088	22	#604	3	3	1406	6	2750.00	2750.00	12 months	2025-05-31	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1089	22	F605	1	1	622	6	1300.00	1300.00	12 months	2025-05-24	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	f
1090	22	#606	2	2	949	6	1500.00	1500.00	15 months	2025-06-14	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1091	22	#701	1	1	633	7	1450.00	1450.00	12 months	2025-06-23	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1092	22	#702	0	1	410	7	800.00	800.00	12 months (academic year)	2025-06-29	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1093	22	#703	2	2	1010	7	1900.00	1900.00	6 months	2025-07-21	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1094	22	#704	2	2	1097	7	1600.00	1600.00	15 months	2025-07-24	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1095	22	#705	1	1	750	7	1000.00	1000.00	6 months	2025-05-24	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
1096	22	706	1	1	687	7	1150.00	1150.00	12 months	2025-06-16	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1097	22	801	0	1	519	8	1150.00	1150.00	15 months	2025-05-02	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1098	22	C802	1	1	566	8	1000.00	1000.00	12 months	2025-07-23	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1099	22	#803	1	1	773	8	1000.00	1000.00	15 months	2025-06-03	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1100	22	E804	2	2	1153	8	1900.00	1900.00	9 months	2025-08-24	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	f
1101	22	#805	3	3	1492	8	2450.00	2450.00	15 months	2025-07-27	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1102	22	#806	2	2	970	8	1800.00	1800.00	15 months	2025-08-29	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1103	22	B901	3	3	1402	9	2650.00	2650.00	6 months	2025-07-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1104	22	#902	0	1	536	9	850.00	850.00	12 months (academic year)	2025-08-19	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1105	22	#903	0	1	484	9	800.00	800.00	12 months	2025-08-02	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1106	22	#904	0	1	513	9	800.00	800.00	15 months	2025-07-24	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1107	22	F905	3	3	1211	9	2000.00	2000.00	12 months	2025-06-19	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
1108	22	#906	1	1	764	9	1200.00	1200.00	9 months	2025-05-27	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1109	22	1001	2	2	934	10	1950.00	1950.00	15 months	2025-07-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1110	23	#101	2	2	1153	1	2050.00	2050.00	12 months (academic year)	2025-08-07	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	f
1111	23	#102	1	1	671	1	1200.00	1200.00	6 months	2025-05-26	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
1112	23	D103	2	2	1167	1	1900.00	1900.00	12 months (academic year)	2025-08-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
1113	23	104	3	3	1270	1	2750.00	2750.00	15 months	2025-08-25	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1114	23	105	1	1	730	1	1150.00	1150.00	6 months	2025-06-04	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1115	23	G106	1	1	788	1	1450.00	1450.00	12 months	2025-05-27	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1116	23	107	1	1	594	1	1150.00	1150.00	9 months	2025-06-25	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1117	23	I108	2	2	895	1	1400.00	1400.00	6 months	2025-07-01	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
1118	23	109	1	1	701	1	1250.00	1250.00	15 months	2025-07-01	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
1119	23	#110	0	1	467	1	850.00	850.00	6 months	2025-06-07	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1120	23	#111	0	1	513	1	1150.00	1150.00	9 months	2025-08-25	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	f
1121	23	112	2	2	1117	1	1700.00	1700.00	12 months (academic year)	2025-06-12	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
1122	23	#113	3	3	1419	1	2000.00	2000.00	12 months (academic year)	2025-06-03	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
1123	23	O114	1	1	663	1	1250.00	1250.00	12 months	2025-08-20	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1124	23	P115	2	2	1007	1	1400.00	1400.00	6 months	2025-06-26	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1125	23	#116	2	2	1123	1	2050.00	2050.00	12 months (academic year)	2025-07-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
1126	23	117	2	2	872	1	1450.00	1450.00	12 months	2025-06-01	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1127	23	118	2	2	1051	1	1800.00	1800.00	9 months	2025-06-04	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
1128	23	B201	2	2	951	2	1850.00	1850.00	12 months	2025-07-24	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1129	23	C202	2	2	939	2	1800.00	1800.00	12 months (academic year)	2025-08-01	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	f
1130	23	#203	1	1	582	2	1250.00	1250.00	12 months	2025-08-22	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1131	23	E204	2	2	1162	2	1450.00	1450.00	6 months	2025-05-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1132	23	#205	0	1	463	2	950.00	950.00	9 months	2025-06-06	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1133	23	G206	0	1	588	2	800.00	800.00	12 months	2025-07-26	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
1134	23	H207	1	1	818	2	1150.00	1150.00	9 months	2025-05-05	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
1135	23	I208	2	2	1055	2	1450.00	1450.00	15 months	2025-05-11	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1136	23	209	2	2	973	2	2000.00	2000.00	12 months (academic year)	2025-07-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1137	23	210	1	1	672	2	1300.00	1300.00	9 months	2025-08-11	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1138	23	#211	1	1	652	2	1450.00	1450.00	9 months	2025-08-02	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1139	23	212	3	3	1455	2	2750.00	2750.00	12 months	2025-05-03	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1140	23	#213	1	1	589	2	1150.00	1150.00	9 months	2025-06-26	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
1141	23	214	2	2	1102	2	2150.00	2150.00	6 months	2025-08-12	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1142	23	#215	3	3	1339	2	2550.00	2550.00	6 months	2025-07-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1143	23	216	3	3	1251	2	2750.00	2750.00	9 months	2025-08-06	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1144	23	217	1	1	848	2	1050.00	1050.00	12 months	2025-07-22	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
1145	23	#218	1	1	594	2	1150.00	1150.00	12 months	2025-06-26	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
1146	23	#301	1	1	826	3	1050.00	1050.00	12 months (academic year)	2025-06-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	f
1147	23	C302	1	1	823	3	1400.00	1400.00	9 months	2025-08-09	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1148	23	303	1	1	739	3	1050.00	1050.00	12 months	2025-07-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1149	23	304	2	2	1194	3	1750.00	1750.00	12 months	2025-05-04	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1150	23	#305	2	2	1055	3	1800.00	1800.00	9 months	2025-06-29	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1151	23	#306	3	3	1305	3	2350.00	2350.00	9 months	2025-06-30	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1152	23	307	3	3	1368	3	2700.00	2700.00	12 months (academic year)	2025-05-14	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1153	23	I308	1	1	756	3	1100.00	1100.00	15 months	2025-06-01	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1154	23	J309	3	3	1587	3	2350.00	2350.00	15 months	2025-08-31	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1155	23	#310	0	1	461	3	1100.00	1100.00	15 months	2025-07-09	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	f
1156	23	311	1	1	680	3	1450.00	1450.00	12 months	2025-07-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
1157	23	M312	1	1	761	3	1450.00	1450.00	15 months	2025-05-31	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1158	23	#313	0	1	516	3	800.00	800.00	12 months	2025-08-17	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1159	23	O314	0	1	541	3	1050.00	1050.00	12 months (academic year)	2025-05-02	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1160	23	P315	2	2	1068	3	1950.00	1950.00	9 months	2025-07-19	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1161	23	316	0	1	505	3	1100.00	1100.00	9 months	2025-08-24	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1162	23	R317	3	3	1351	3	2750.00	2750.00	9 months	2025-06-16	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1163	23	318	2	2	968	3	1800.00	1800.00	12 months	2025-07-25	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1164	23	#401	2	2	1008	4	1450.00	1450.00	15 months	2025-08-12	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
1165	24	#101	1	1	783	1	1150.00	1150.00	12 months	2025-06-09	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1166	24	#102	2	2	973	1	1650.00	1650.00	15 months	2025-08-01	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1167	24	D103	2	2	1156	1	1550.00	1550.00	15 months	2025-07-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1168	24	104	2	2	1182	1	2100.00	2100.00	6 months	2025-07-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1169	24	#105	1	1	556	1	1300.00	1300.00	12 months	2025-05-30	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1170	24	#106	1	1	775	1	1000.00	1000.00	15 months	2025-06-24	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1171	24	#107	0	1	464	1	850.00	850.00	15 months	2025-07-24	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
1172	24	#108	2	2	856	1	1550.00	1550.00	9 months	2025-05-12	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
1173	24	109	2	2	889	1	1950.00	1950.00	6 months	2025-07-08	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1174	24	#110	1	1	581	1	1150.00	1150.00	12 months (academic year)	2025-07-28	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
1175	24	L111	1	1	634	1	1050.00	1050.00	12 months (academic year)	2025-08-30	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1176	24	201	1	1	675	2	1200.00	1200.00	12 months	2025-05-28	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1177	24	#202	3	3	1362	2	2050.00	2050.00	12 months (academic year)	2025-05-25	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1178	24	#203	2	2	1040	2	1750.00	1750.00	6 months	2025-05-07	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1179	24	E204	1	1	777	2	1050.00	1050.00	6 months	2025-05-16	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
1180	24	205	3	3	1259	2	2500.00	2500.00	12 months	2025-08-10	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1181	24	#206	3	3	1230	2	2350.00	2350.00	12 months	2025-06-12	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1182	24	H207	1	1	564	2	1000.00	1000.00	12 months (academic year)	2025-07-23	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1183	24	#208	3	3	1351	2	2600.00	2600.00	6 months	2025-08-21	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
1184	24	#209	0	1	488	2	1000.00	1000.00	15 months	2025-06-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
1185	24	K210	2	2	1194	2	1450.00	1450.00	12 months (academic year)	2025-08-22	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1186	24	#211	2	2	883	2	1850.00	1850.00	9 months	2025-06-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1187	24	301	1	1	665	3	1150.00	1150.00	12 months	2025-08-18	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1188	24	302	1	1	702	3	1000.00	1000.00	12 months	2025-06-28	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1189	24	303	0	1	407	3	1000.00	1000.00	12 months (academic year)	2025-05-06	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
1190	24	E304	0	1	492	3	1100.00	1100.00	15 months	2025-07-02	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1191	24	F305	1	1	706	3	1150.00	1150.00	15 months	2025-07-03	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
1192	24	#306	0	1	487	3	1000.00	1000.00	12 months	2025-07-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
1193	24	#307	1	1	624	3	1200.00	1200.00	9 months	2025-08-03	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1194	24	308	2	2	1183	3	2050.00	2050.00	15 months	2025-07-14	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
1195	24	309	2	2	989	3	1450.00	1450.00	9 months	2025-06-26	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
1196	24	#310	2	2	947	3	1400.00	1400.00	9 months	2025-08-20	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1197	24	L311	1	1	817	3	1350.00	1350.00	9 months	2025-07-20	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	f
1198	24	B401	3	3	1243	4	2200.00	2200.00	12 months	2025-06-22	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1199	24	C402	3	3	1443	4	2550.00	2550.00	15 months	2025-05-21	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1200	24	403	0	1	445	4	850.00	850.00	15 months	2025-06-30	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1201	24	#404	2	2	1066	4	1900.00	1900.00	15 months	2025-07-28	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
1202	24	F405	2	2	993	4	1600.00	1600.00	6 months	2025-05-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1203	24	406	1	1	613	4	1050.00	1050.00	9 months	2025-06-08	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1204	24	#407	2	2	909	4	1750.00	1750.00	12 months (academic year)	2025-07-11	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1205	24	I408	1	1	805	4	1250.00	1250.00	15 months	2025-06-11	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1206	24	409	1	1	800	4	1450.00	1450.00	9 months	2025-07-07	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1207	24	K410	3	3	1495	4	1800.00	1800.00	15 months	2025-05-27	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	f
1208	24	411	3	3	1420	4	2350.00	2350.00	6 months	2025-07-01	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
1209	24	#501	2	2	1163	5	1700.00	1700.00	15 months	2025-07-15	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1210	24	#502	2	2	1014	5	1650.00	1650.00	12 months (academic year)	2025-05-03	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1211	25	B101	1	1	635	1	1450.00	1450.00	15 months	2025-08-02	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1212	25	102	1	1	626	1	1200.00	1200.00	12 months (academic year)	2025-05-21	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
1213	25	103	3	3	1493	1	2600.00	2600.00	15 months	2025-06-08	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1214	25	#104	1	1	607	1	1050.00	1050.00	12 months (academic year)	2025-08-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1215	25	105	2	2	1023	1	1750.00	1750.00	12 months	2025-06-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1216	25	#106	1	1	844	1	1350.00	1350.00	12 months	2025-06-17	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
1217	25	#107	2	2	1125	1	1700.00	1700.00	9 months	2025-07-27	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	f
1218	25	#108	2	2	1004	1	2100.00	2100.00	15 months	2025-05-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
1219	25	201	1	1	628	2	1000.00	1000.00	15 months	2025-07-22	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1220	25	C202	2	2	1154	2	1800.00	1800.00	15 months	2025-07-04	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1221	25	D203	1	1	849	2	1150.00	1150.00	15 months	2025-06-15	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1222	25	204	1	1	747	2	1300.00	1300.00	15 months	2025-07-27	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1223	25	205	2	2	1152	2	1650.00	1650.00	9 months	2025-08-12	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1224	25	G206	2	2	996	2	2000.00	2000.00	6 months	2025-05-06	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
1225	25	207	0	1	525	2	950.00	950.00	9 months	2025-07-09	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
1226	25	208	1	1	819	2	1450.00	1450.00	15 months	2025-06-21	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1227	25	#301	3	3	1451	3	2650.00	2650.00	12 months (academic year)	2025-06-29	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1228	25	#302	3	3	1476	3	2400.00	2400.00	12 months	2025-07-27	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1229	25	#303	2	2	948	3	2100.00	2100.00	12 months	2025-08-30	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1230	25	#304	3	3	1526	3	1950.00	1950.00	6 months	2025-07-20	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1231	25	F305	3	3	1289	3	2600.00	2600.00	6 months	2025-08-16	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1232	25	306	2	2	1105	3	1900.00	1900.00	15 months	2025-08-21	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
1233	25	307	0	1	575	3	900.00	900.00	12 months	2025-06-23	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1234	25	308	2	2	1164	3	1700.00	1700.00	15 months	2025-05-05	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1235	25	401	1	1	794	4	1000.00	1000.00	12 months	2025-06-07	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1236	25	402	0	1	465	4	1150.00	1150.00	9 months	2025-06-03	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1237	25	D403	2	2	1143	4	2050.00	2050.00	12 months (academic year)	2025-05-15	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1238	25	E404	2	2	976	4	1650.00	1650.00	15 months	2025-07-14	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1239	25	F405	1	1	792	4	1150.00	1150.00	9 months	2025-06-12	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1240	25	406	2	2	882	4	2100.00	2100.00	6 months	2025-05-09	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1241	25	#407	0	1	495	4	1150.00	1150.00	9 months	2025-08-03	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
1242	25	#408	0	1	457	4	800.00	800.00	9 months	2025-08-27	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1243	25	B501	3	3	1304	5	2250.00	2250.00	9 months	2025-06-29	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1244	25	#502	2	2	913	5	1950.00	1950.00	12 months	2025-06-26	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1245	25	#503	1	1	744	5	1050.00	1050.00	12 months	2025-07-08	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1246	25	E504	2	2	946	5	1850.00	1850.00	12 months (academic year)	2025-05-14	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1247	25	F505	1	1	698	5	1200.00	1200.00	12 months (academic year)	2025-05-28	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	f
1248	25	#506	2	2	1029	5	1650.00	1650.00	12 months	2025-08-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
1249	25	507	3	3	1343	5	2400.00	2400.00	15 months	2025-07-13	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1250	25	#508	0	1	420	5	1150.00	1150.00	9 months	2025-07-21	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1251	25	B601	3	3	1533	6	2700.00	2700.00	15 months	2025-05-26	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
1252	25	C602	2	2	960	6	1700.00	1700.00	15 months	2025-06-19	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1253	25	603	1	1	811	6	1350.00	1350.00	12 months (academic year)	2025-05-08	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
1254	25	E604	2	2	1037	6	1850.00	1850.00	12 months	2025-07-31	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
1255	25	#605	3	3	1213	6	2350.00	2350.00	9 months	2025-07-04	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1256	25	#606	3	3	1589	6	2750.00	2750.00	12 months	2025-06-26	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
1257	25	#607	1	1	704	6	1100.00	1100.00	9 months	2025-07-05	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1258	25	#608	1	1	721	6	1100.00	1100.00	12 months (academic year)	2025-06-20	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1259	25	B701	3	3	1451	7	2700.00	2700.00	9 months	2025-06-26	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1260	25	C702	0	1	432	7	850.00	850.00	12 months	2025-05-09	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
1261	25	D703	1	1	850	7	1450.00	1450.00	12 months	2025-08-19	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1262	25	E704	1	1	562	7	1200.00	1200.00	6 months	2025-08-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	f
1263	25	#705	2	2	1196	7	1600.00	1600.00	6 months	2025-05-02	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
1264	25	#706	0	1	600	7	1050.00	1050.00	15 months	2025-06-20	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1265	25	707	2	2	1020	7	1600.00	1600.00	6 months	2025-06-29	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
1266	25	708	1	1	752	7	1150.00	1150.00	12 months	2025-08-08	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
1267	25	801	1	1	566	8	1300.00	1300.00	15 months	2025-08-04	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1268	26	101	1	1	676	1	1350.00	1350.00	12 months	2025-06-27	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
1269	26	102	1	1	631	1	1350.00	1350.00	12 months	2025-08-28	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1270	26	D103	1	1	688	1	1250.00	1250.00	6 months	2025-08-28	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1271	26	104	1	1	588	1	1450.00	1450.00	12 months	2025-08-21	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
1272	26	#105	0	1	439	1	1150.00	1150.00	12 months (academic year)	2025-08-07	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1273	26	G106	2	2	1142	1	1800.00	1800.00	9 months	2025-05-27	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1274	26	H107	2	2	852	1	1650.00	1650.00	15 months	2025-06-22	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
1275	26	#108	3	3	1358	1	2000.00	2000.00	12 months (academic year)	2025-07-10	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
1276	26	#109	2	2	874	1	2050.00	2050.00	9 months	2025-06-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1277	26	201	2	2	972	2	2000.00	2000.00	12 months (academic year)	2025-07-21	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1278	26	202	2	2	1078	2	1550.00	1550.00	15 months	2025-06-02	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1279	26	203	2	2	897	2	1950.00	1950.00	6 months	2025-06-22	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	f
1280	26	204	1	1	562	2	1100.00	1100.00	6 months	2025-08-04	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1281	26	205	2	2	1059	2	2050.00	2050.00	15 months	2025-07-13	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1282	26	#206	0	1	437	2	800.00	800.00	6 months	2025-05-28	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1283	26	H207	3	3	1390	2	2150.00	2150.00	9 months	2025-05-04	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1284	26	#208	2	2	1076	2	2050.00	2050.00	15 months	2025-06-03	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
1285	26	#209	1	1	833	2	1400.00	1400.00	12 months (academic year)	2025-08-21	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1286	26	301	3	3	1549	3	1900.00	1900.00	12 months	2025-06-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
1287	26	302	0	1	415	3	1050.00	1050.00	9 months	2025-08-23	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1288	26	D303	1	1	606	3	1250.00	1250.00	12 months (academic year)	2025-05-06	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1289	26	E304	1	1	638	3	1300.00	1300.00	15 months	2025-07-03	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1290	26	F305	0	1	490	3	800.00	800.00	6 months	2025-06-07	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1291	26	G306	2	2	1182	3	1500.00	1500.00	12 months	2025-08-24	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
1292	26	307	1	1	648	3	1450.00	1450.00	9 months	2025-05-28	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	f
1293	26	#308	3	3	1520	3	2550.00	2550.00	12 months (academic year)	2025-08-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
1294	26	J309	0	1	425	3	1000.00	1000.00	6 months	2025-06-03	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1295	26	401	2	2	857	4	1400.00	1400.00	12 months (academic year)	2025-07-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1296	26	C402	2	2	1194	4	1600.00	1600.00	9 months	2025-06-07	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
1297	26	#403	2	2	921	4	1550.00	1550.00	15 months	2025-05-31	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1298	26	#404	3	3	1382	4	2250.00	2250.00	9 months	2025-05-12	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1299	26	F405	0	1	485	4	950.00	950.00	12 months	2025-08-31	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1300	26	G406	1	1	636	4	1300.00	1300.00	15 months	2025-06-19	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1301	26	#407	2	2	1094	4	1650.00	1650.00	6 months	2025-05-29	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
1302	26	408	3	3	1578	4	1800.00	1800.00	6 months	2025-07-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1303	26	J409	3	3	1275	4	2550.00	2550.00	12 months (academic year)	2025-06-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1304	26	501	1	1	804	5	1300.00	1300.00	12 months	2025-07-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1305	26	502	2	2	891	5	1450.00	1450.00	12 months	2025-05-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	f
1306	26	503	1	1	698	5	1000.00	1000.00	12 months (academic year)	2025-07-27	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1307	26	504	1	1	650	5	1350.00	1350.00	12 months (academic year)	2025-08-17	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1308	26	F505	1	1	667	5	1100.00	1100.00	12 months (academic year)	2025-08-09	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1309	26	#506	3	3	1421	5	2350.00	2350.00	12 months	2025-06-14	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1310	26	507	1	1	618	5	1400.00	1400.00	12 months (academic year)	2025-06-24	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1311	26	#508	1	1	742	5	1050.00	1050.00	12 months (academic year)	2025-05-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	f
1312	26	J509	1	1	834	5	1450.00	1450.00	12 months (academic year)	2025-08-02	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1313	26	#601	0	1	495	6	850.00	850.00	12 months	2025-08-13	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	f
1314	26	C602	1	1	705	6	1350.00	1350.00	12 months (academic year)	2025-07-27	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
1315	26	#603	3	3	1264	6	2000.00	2000.00	15 months	2025-05-17	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1316	26	#604	2	2	900	6	2100.00	2100.00	6 months	2025-08-08	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1317	26	F605	2	2	1084	6	1850.00	1850.00	15 months	2025-05-22	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
1318	26	606	2	2	1180	6	1400.00	1400.00	6 months	2025-07-16	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1319	26	#607	2	2	874	6	1950.00	1950.00	12 months	2025-06-17	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1320	26	I608	0	1	582	6	950.00	950.00	9 months	2025-07-26	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	f
1321	26	609	2	2	1164	6	1650.00	1650.00	12 months (academic year)	2025-08-11	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1322	26	#701	3	3	1568	7	2500.00	2500.00	6 months	2025-08-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1323	26	#702	1	1	787	7	1450.00	1450.00	6 months	2025-06-05	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1324	26	703	2	2	946	7	1400.00	1400.00	6 months	2025-05-12	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1325	26	#704	1	1	652	7	1150.00	1150.00	12 months	2025-07-15	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1326	27	#101	1	1	594	1	1100.00	1100.00	6 months	2025-05-09	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1327	27	C102	1	1	827	1	1350.00	1350.00	12 months	2025-06-19	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1328	27	D103	0	1	544	1	950.00	950.00	12 months	2025-06-12	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	f
1329	27	#104	2	2	928	1	2100.00	2100.00	15 months	2025-08-24	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1330	27	#105	0	1	413	1	1050.00	1050.00	9 months	2025-08-01	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1331	27	106	2	2	1171	1	2100.00	2100.00	12 months (academic year)	2025-08-07	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
1332	27	#107	0	1	544	1	1100.00	1100.00	12 months	2025-05-05	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	f
1333	27	108	2	2	1070	1	2050.00	2050.00	12 months	2025-06-01	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
1334	27	201	2	2	916	2	1500.00	1500.00	9 months	2025-05-22	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
1335	27	C202	2	2	1118	2	2050.00	2050.00	12 months	2025-05-19	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1336	27	D203	1	1	764	2	1050.00	1050.00	12 months	2025-08-01	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1337	27	204	2	2	1111	2	2100.00	2100.00	15 months	2025-08-14	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
1338	27	205	3	3	1589	2	2250.00	2250.00	6 months	2025-05-31	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1339	27	G206	1	1	686	2	1200.00	1200.00	9 months	2025-07-15	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
1340	27	#207	2	2	1027	2	1750.00	1750.00	12 months	2025-08-06	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1341	27	208	2	2	1175	2	1600.00	1600.00	15 months	2025-08-14	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
1342	27	#301	1	1	579	3	1200.00	1200.00	15 months	2025-07-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1343	27	C302	3	3	1412	3	2550.00	2550.00	12 months	2025-08-09	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1344	27	303	3	3	1458	3	1900.00	1900.00	12 months (academic year)	2025-05-31	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
1345	27	304	1	1	730	3	1050.00	1050.00	15 months	2025-06-12	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	f
1346	27	305	0	1	409	3	1150.00	1150.00	6 months	2025-07-27	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
1347	27	#306	1	1	596	3	1050.00	1050.00	6 months	2025-06-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1348	27	H307	1	1	684	3	1000.00	1000.00	9 months	2025-06-13	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1349	27	308	2	2	951	3	2150.00	2150.00	15 months	2025-08-05	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1350	27	B401	2	2	993	4	1850.00	1850.00	12 months (academic year)	2025-07-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1351	27	402	1	1	783	4	1000.00	1000.00	12 months (academic year)	2025-08-12	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	f
1352	27	#403	1	1	601	4	1100.00	1100.00	6 months	2025-05-12	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1353	27	404	1	1	793	4	1250.00	1250.00	6 months	2025-06-01	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1354	27	#405	2	2	927	4	1850.00	1850.00	6 months	2025-05-31	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1355	27	#406	0	1	405	4	1100.00	1100.00	15 months	2025-08-12	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1356	27	#407	3	3	1299	4	2750.00	2750.00	9 months	2025-06-12	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
1357	27	#408	1	1	847	4	1250.00	1250.00	15 months	2025-06-07	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1358	27	B501	1	1	834	5	1200.00	1200.00	12 months	2025-08-21	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1359	27	C502	2	2	940	5	1400.00	1400.00	6 months	2025-06-18	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1360	27	D503	0	1	531	5	1150.00	1150.00	9 months	2025-05-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1361	27	504	2	2	1122	5	1800.00	1800.00	6 months	2025-08-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1362	27	F505	3	3	1372	5	2300.00	2300.00	6 months	2025-08-13	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1363	27	506	2	2	974	5	2150.00	2150.00	9 months	2025-05-11	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1364	27	507	3	3	1329	5	1950.00	1950.00	9 months	2025-07-10	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1365	27	I508	1	1	574	5	1100.00	1100.00	12 months (academic year)	2025-07-04	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1366	28	B101	1	1	566	1	1250.00	1250.00	9 months	2025-05-06	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1367	28	C102	0	1	494	1	950.00	950.00	12 months	2025-06-29	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1368	28	#103	1	1	748	1	1200.00	1200.00	12 months	2025-08-27	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1369	28	104	1	1	698	1	1250.00	1250.00	6 months	2025-05-27	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1370	28	#105	3	3	1318	1	2400.00	2400.00	9 months	2025-08-11	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
1371	28	G106	0	1	538	1	900.00	900.00	12 months (academic year)	2025-07-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1372	28	H107	1	1	693	1	1250.00	1250.00	12 months	2025-08-17	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1373	28	108	2	2	853	1	1750.00	1750.00	12 months	2025-06-18	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1374	28	#109	3	3	1232	1	2400.00	2400.00	12 months	2025-08-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1375	28	#110	2	2	1131	1	1400.00	1400.00	9 months	2025-05-17	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
1376	28	111	1	1	761	1	1150.00	1150.00	9 months	2025-07-13	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1377	28	#112	1	1	645	1	1000.00	1000.00	6 months	2025-08-15	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1378	28	113	3	3	1387	1	1950.00	1950.00	12 months	2025-07-15	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
1379	28	#114	1	1	833	1	1400.00	1400.00	15 months	2025-07-25	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
1380	28	#115	2	2	1061	1	1550.00	1550.00	15 months	2025-07-01	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1381	28	Q116	2	2	994	1	1650.00	1650.00	12 months (academic year)	2025-05-12	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1382	28	117	0	1	574	1	900.00	900.00	12 months	2025-05-23	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
1383	28	S118	1	1	647	1	1150.00	1150.00	9 months	2025-05-17	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1384	28	201	0	1	403	2	800.00	800.00	6 months	2025-06-09	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1385	28	202	2	2	988	2	1800.00	1800.00	9 months	2025-08-21	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1386	28	203	2	2	1161	2	1400.00	1400.00	12 months (academic year)	2025-07-28	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
1387	28	E204	1	1	719	2	1200.00	1200.00	12 months	2025-08-05	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1388	28	#205	1	1	795	2	1350.00	1350.00	9 months	2025-07-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
1389	28	#206	2	2	1039	2	2150.00	2150.00	6 months	2025-05-26	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1390	28	#207	2	2	1071	2	1450.00	1450.00	15 months	2025-06-09	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
1391	28	I208	3	3	1512	2	2050.00	2050.00	12 months (academic year)	2025-08-15	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1392	28	#209	2	2	872	2	1550.00	1550.00	6 months	2025-08-24	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1393	28	#210	2	2	873	2	2050.00	2050.00	12 months (academic year)	2025-05-04	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
1394	28	211	0	1	424	2	800.00	800.00	6 months	2025-06-17	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1395	28	#212	2	2	1183	2	1550.00	1550.00	12 months	2025-08-24	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1396	28	N213	1	1	577	2	1000.00	1000.00	12 months	2025-06-20	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
1397	28	214	1	1	672	2	1350.00	1350.00	15 months	2025-07-07	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
1398	28	P215	3	3	1348	2	2650.00	2650.00	9 months	2025-06-29	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
1399	28	Q216	0	1	514	2	900.00	900.00	6 months	2025-06-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1400	28	217	2	2	1187	2	2100.00	2100.00	9 months	2025-07-18	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1401	28	#218	1	1	785	2	1350.00	1350.00	12 months (academic year)	2025-07-19	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1402	28	301	2	2	1017	3	1500.00	1500.00	6 months	2025-07-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1403	28	302	2	2	1065	3	2000.00	2000.00	12 months (academic year)	2025-07-01	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1404	28	#303	3	3	1396	3	2750.00	2750.00	15 months	2025-05-04	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1405	28	#304	3	3	1209	3	2500.00	2500.00	12 months	2025-08-30	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1406	28	305	1	1	809	3	1250.00	1250.00	6 months	2025-08-17	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1407	28	#306	1	1	802	3	1350.00	1350.00	9 months	2025-05-21	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1408	28	#307	2	2	943	3	1500.00	1500.00	12 months (academic year)	2025-08-13	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
1409	28	#308	2	2	1115	3	1500.00	1500.00	12 months	2025-08-10	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1410	28	J309	1	1	809	3	1300.00	1300.00	6 months	2025-07-15	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
1411	28	310	2	2	891	3	1400.00	1400.00	6 months	2025-08-04	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1412	28	L311	1	1	561	3	1100.00	1100.00	12 months	2025-07-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
1413	28	312	3	3	1385	3	2050.00	2050.00	12 months	2025-05-30	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1414	28	N313	2	2	1150	3	1650.00	1650.00	15 months	2025-05-10	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1415	28	314	1	1	789	3	1400.00	1400.00	15 months	2025-07-12	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1416	28	#315	3	3	1477	3	2300.00	2300.00	12 months	2025-08-03	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1417	28	316	2	2	1197	3	1600.00	1600.00	12 months (academic year)	2025-05-29	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1418	28	R317	3	3	1578	3	2750.00	2750.00	9 months	2025-05-11	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
1419	28	#318	0	1	557	3	1150.00	1150.00	9 months	2025-05-27	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1420	28	#401	0	1	446	4	950.00	950.00	15 months	2025-07-29	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1421	28	402	1	1	805	4	1050.00	1050.00	15 months	2025-06-08	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1422	29	B101	2	2	853	1	1650.00	1650.00	12 months (academic year)	2025-06-04	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	f
1423	29	#102	2	2	1161	1	1500.00	1500.00	12 months (academic year)	2025-06-08	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1424	29	#103	3	3	1428	1	2250.00	2250.00	9 months	2025-08-21	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1425	29	104	1	1	660	1	1450.00	1450.00	6 months	2025-06-26	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
1426	29	105	1	1	599	1	1200.00	1200.00	9 months	2025-07-01	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1427	29	#106	1	1	641	1	1450.00	1450.00	15 months	2025-07-19	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
1428	29	H107	0	1	478	1	1100.00	1100.00	12 months (academic year)	2025-07-12	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1429	29	#201	2	2	1179	2	1900.00	1900.00	9 months	2025-08-07	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1430	29	C202	0	1	448	2	1050.00	1050.00	12 months (academic year)	2025-07-29	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1431	29	D203	3	3	1228	2	1900.00	1900.00	12 months	2025-06-17	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1432	29	#204	2	2	987	2	1650.00	1650.00	15 months	2025-08-14	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1433	29	#205	0	1	484	2	900.00	900.00	12 months	2025-05-23	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1434	29	206	3	3	1338	2	2200.00	2200.00	6 months	2025-05-05	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1435	29	#207	1	1	834	2	1400.00	1400.00	12 months	2025-06-02	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	f
1436	29	B301	1	1	660	3	1200.00	1200.00	12 months (academic year)	2025-07-13	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1437	29	#302	3	3	1395	3	2600.00	2600.00	6 months	2025-05-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1438	29	303	2	2	852	3	1950.00	1950.00	6 months	2025-08-21	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1439	29	E304	1	1	669	3	1250.00	1250.00	15 months	2025-05-28	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
1440	29	F305	2	2	1168	3	1600.00	1600.00	12 months	2025-07-31	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1441	29	G306	1	1	556	3	1100.00	1100.00	9 months	2025-05-12	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1442	29	307	1	1	584	3	1300.00	1300.00	6 months	2025-05-11	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1443	29	#401	0	1	518	4	900.00	900.00	15 months	2025-05-07	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1444	29	#402	2	2	994	4	1650.00	1650.00	6 months	2025-06-26	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	f
1445	29	403	2	2	968	4	1950.00	1950.00	12 months	2025-07-16	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1446	29	404	0	1	477	4	800.00	800.00	15 months	2025-06-30	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1447	29	F405	3	3	1512	4	2450.00	2450.00	9 months	2025-07-19	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1448	29	#406	2	2	914	4	2050.00	2050.00	6 months	2025-07-31	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1449	29	#407	1	1	840	4	1100.00	1100.00	15 months	2025-07-17	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
1450	29	B501	0	1	536	5	1100.00	1100.00	12 months	2025-06-30	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1451	29	502	3	3	1253	5	2000.00	2000.00	9 months	2025-05-16	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
1452	29	503	2	2	991	5	1900.00	1900.00	6 months	2025-06-26	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
1453	29	#504	1	1	810	5	1200.00	1200.00	6 months	2025-07-18	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1454	29	#505	2	2	987	5	1800.00	1800.00	12 months	2025-07-02	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1455	29	#506	1	1	787	5	1450.00	1450.00	15 months	2025-05-04	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1456	29	H507	2	2	1045	5	1750.00	1750.00	12 months (academic year)	2025-05-27	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1457	29	#601	2	2	876	6	1800.00	1800.00	15 months	2025-07-12	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1458	29	C602	1	1	827	6	1250.00	1250.00	12 months (academic year)	2025-05-04	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1459	29	#603	1	1	742	6	1250.00	1250.00	6 months	2025-08-18	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1460	29	604	1	1	581	6	1050.00	1050.00	6 months	2025-07-17	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1461	29	#605	1	1	689	6	1300.00	1300.00	12 months (academic year)	2025-08-16	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1462	29	606	2	2	913	6	2100.00	2100.00	15 months	2025-07-13	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
1463	29	H607	2	2	913	6	1500.00	1500.00	12 months (academic year)	2025-08-24	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1464	29	701	2	2	853	7	1900.00	1900.00	15 months	2025-08-11	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1465	29	C702	2	2	1045	7	1450.00	1450.00	6 months	2025-08-30	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	f
1466	29	#703	3	3	1219	7	1800.00	1800.00	15 months	2025-05-14	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1467	29	704	3	3	1329	7	1800.00	1800.00	9 months	2025-06-08	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
1468	29	705	3	3	1434	7	2550.00	2550.00	9 months	2025-07-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1469	29	#706	1	1	587	7	1050.00	1050.00	12 months	2025-05-18	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1470	29	#707	1	1	764	7	1200.00	1200.00	6 months	2025-07-06	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1471	29	801	1	1	809	8	1100.00	1100.00	15 months	2025-06-17	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1472	29	C802	0	1	477	8	950.00	950.00	12 months (academic year)	2025-08-17	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1473	29	803	2	2	1159	8	1750.00	1750.00	9 months	2025-07-05	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1474	29	E804	3	3	1257	8	2350.00	2350.00	6 months	2025-07-27	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1475	30	B101	0	1	449	1	1050.00	1050.00	12 months	2025-07-18	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
1476	30	#102	0	1	482	1	800.00	800.00	12 months (academic year)	2025-06-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
1477	30	103	2	2	1168	1	1400.00	1400.00	12 months	2025-08-18	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
1478	30	104	1	1	624	1	1450.00	1450.00	12 months	2025-06-26	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
1479	30	105	1	1	821	1	1050.00	1050.00	6 months	2025-06-12	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1480	30	106	2	2	887	1	2150.00	2150.00	12 months (academic year)	2025-06-11	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	f
1481	30	H107	0	1	487	1	800.00	800.00	15 months	2025-05-08	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1482	30	I108	0	1	522	1	1000.00	1000.00	15 months	2025-08-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1483	30	J109	1	1	660	1	1000.00	1000.00	12 months	2025-05-19	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	f
1484	30	K110	0	1	477	1	850.00	850.00	6 months	2025-07-30	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1485	30	111	0	1	499	1	800.00	800.00	6 months	2025-05-25	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1486	30	#112	1	1	673	1	1000.00	1000.00	9 months	2025-08-03	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
1487	30	#113	3	3	1458	1	2500.00	2500.00	12 months	2025-07-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1488	30	201	1	1	811	2	1350.00	1350.00	12 months	2025-08-20	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1489	30	202	2	2	1060	2	1700.00	1700.00	6 months	2025-08-15	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
1490	30	203	1	1	758	2	1050.00	1050.00	15 months	2025-08-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
1491	30	E204	2	2	965	2	1400.00	1400.00	12 months (academic year)	2025-05-07	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1492	30	205	2	2	972	2	1900.00	1900.00	9 months	2025-07-09	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
1493	30	G206	1	1	613	2	1250.00	1250.00	9 months	2025-05-30	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
1494	30	#207	2	2	938	2	1400.00	1400.00	15 months	2025-06-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
1495	30	#208	2	2	865	2	2100.00	2100.00	12 months (academic year)	2025-05-05	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
1496	30	209	3	3	1218	2	2650.00	2650.00	12 months (academic year)	2025-07-13	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1497	30	210	3	3	1228	2	2600.00	2600.00	9 months	2025-09-01	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1498	30	#211	1	1	744	2	1100.00	1100.00	15 months	2025-05-06	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
1499	30	212	3	3	1397	2	2600.00	2600.00	9 months	2025-08-08	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1500	30	#213	2	2	909	2	1800.00	1800.00	6 months	2025-05-29	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
1501	30	#301	2	2	1160	3	1450.00	1450.00	12 months (academic year)	2025-06-07	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1502	30	#302	1	1	551	3	1450.00	1450.00	15 months	2025-07-29	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1503	30	#303	2	2	1079	3	1800.00	1800.00	15 months	2025-07-05	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1504	30	E304	1	1	825	3	1400.00	1400.00	15 months	2025-08-22	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1505	30	305	1	1	850	3	1150.00	1150.00	12 months	2025-07-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
1506	30	#306	2	2	1004	3	2000.00	2000.00	12 months	2025-06-04	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1507	30	#307	1	1	552	3	1450.00	1450.00	6 months	2025-08-08	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	f
1508	30	308	1	1	582	3	1050.00	1050.00	6 months	2025-05-21	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1509	30	#309	1	1	654	3	1100.00	1100.00	12 months	2025-08-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1510	30	#310	2	2	1054	3	1450.00	1450.00	15 months	2025-05-20	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1511	30	311	3	3	1462	3	2400.00	2400.00	15 months	2025-06-27	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1512	30	#312	0	1	493	3	1100.00	1100.00	9 months	2025-08-06	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	f
1513	30	#313	3	3	1406	3	2600.00	2600.00	6 months	2025-05-02	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1514	30	B401	2	2	1192	4	2150.00	2150.00	12 months (academic year)	2025-06-16	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
1515	30	C402	3	3	1201	4	1900.00	1900.00	12 months	2025-05-12	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1516	30	403	2	2	1043	4	1700.00	1700.00	6 months	2025-05-02	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1517	30	E404	2	2	1152	4	1800.00	1800.00	6 months	2025-08-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1518	30	#405	1	1	836	4	1150.00	1150.00	15 months	2025-07-29	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1519	30	406	3	3	1550	4	1950.00	1950.00	6 months	2025-06-23	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1520	30	H407	1	1	566	4	1400.00	1400.00	6 months	2025-06-27	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1521	30	408	3	3	1399	4	1850.00	1850.00	15 months	2025-06-30	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1522	30	409	2	2	977	4	1900.00	1900.00	12 months	2025-07-05	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1523	30	#410	2	2	1008	4	1550.00	1550.00	15 months	2025-07-13	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1524	30	#411	0	1	462	4	1100.00	1100.00	15 months	2025-06-17	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1525	30	#412	2	2	1086	4	2100.00	2100.00	12 months (academic year)	2025-05-23	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1526	30	N413	1	1	819	4	1300.00	1300.00	6 months	2025-08-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1527	30	501	1	1	686	5	1150.00	1150.00	15 months	2025-06-23	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	f
1528	30	C502	3	3	1476	5	2500.00	2500.00	9 months	2025-07-04	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1529	31	#101	2	2	1181	1	1550.00	1550.00	6 months	2025-06-20	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1530	31	#102	0	1	450	1	950.00	950.00	15 months	2025-06-16	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1531	31	D103	1	1	843	1	1250.00	1250.00	12 months (academic year)	2025-08-05	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
1532	31	104	1	1	713	1	1150.00	1150.00	9 months	2025-08-24	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1533	31	F105	3	3	1559	1	1900.00	1900.00	6 months	2025-05-26	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1534	31	#106	1	1	783	1	1200.00	1200.00	12 months	2025-08-04	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1535	31	H107	2	2	1113	1	1500.00	1500.00	9 months	2025-06-04	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1536	31	108	2	2	1119	1	2050.00	2050.00	12 months (academic year)	2025-08-20	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1537	31	J109	1	1	776	1	1150.00	1150.00	9 months	2025-08-30	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	f
1538	31	201	1	1	832	2	1050.00	1050.00	12 months (academic year)	2025-05-26	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1539	31	C202	2	2	972	2	2100.00	2100.00	6 months	2025-07-08	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
1540	31	D203	0	1	410	2	800.00	800.00	9 months	2025-07-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1541	31	E204	2	2	1123	2	2000.00	2000.00	9 months	2025-06-10	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1542	31	F205	1	1	702	2	1350.00	1350.00	6 months	2025-07-10	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
1543	31	#206	1	1	708	2	1150.00	1150.00	12 months	2025-07-24	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1544	31	H207	1	1	792	2	1150.00	1150.00	9 months	2025-08-24	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1545	31	I208	0	1	534	2	1100.00	1100.00	12 months (academic year)	2025-05-27	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1546	31	209	1	1	843	2	1300.00	1300.00	15 months	2025-06-03	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1547	31	#301	0	1	473	3	1000.00	1000.00	12 months	2025-06-08	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1548	31	C302	1	1	676	3	1250.00	1250.00	6 months	2025-06-15	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1549	31	D303	2	2	1127	3	2100.00	2100.00	6 months	2025-08-04	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1550	31	E304	2	2	945	3	1400.00	1400.00	15 months	2025-05-09	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1551	31	F305	1	1	672	3	1400.00	1400.00	6 months	2025-05-12	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1552	31	#306	2	2	949	3	2100.00	2100.00	12 months (academic year)	2025-08-10	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
1553	31	307	3	3	1417	3	1950.00	1950.00	12 months	2025-08-11	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1554	31	I308	3	3	1317	3	2650.00	2650.00	12 months (academic year)	2025-08-14	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1555	31	#309	1	1	846	3	1250.00	1250.00	12 months (academic year)	2025-08-01	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
1556	31	401	3	3	1486	4	2500.00	2500.00	12 months	2025-08-20	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	f
1557	31	402	2	2	1165	4	1950.00	1950.00	12 months (academic year)	2025-07-14	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1558	31	D403	2	2	995	4	1650.00	1650.00	6 months	2025-06-11	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1559	31	404	2	2	1015	4	1700.00	1700.00	15 months	2025-06-18	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1560	31	#405	1	1	561	4	1200.00	1200.00	6 months	2025-05-24	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1561	31	#406	0	1	434	4	1100.00	1100.00	15 months	2025-07-18	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1562	31	407	1	1	735	4	1300.00	1300.00	12 months	2025-07-10	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1563	31	#408	1	1	599	4	1200.00	1200.00	6 months	2025-05-26	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1564	31	J409	0	1	440	4	1100.00	1100.00	12 months (academic year)	2025-05-07	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1565	31	#501	2	2	1043	5	1950.00	1950.00	12 months	2025-07-15	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1566	31	C502	3	3	1583	5	2000.00	2000.00	6 months	2025-06-04	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1567	31	#503	3	3	1271	5	2300.00	2300.00	12 months	2025-06-13	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1568	31	#504	2	2	986	5	1450.00	1450.00	12 months (academic year)	2025-05-13	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	f
1569	31	F505	2	2	1180	5	1800.00	1800.00	15 months	2025-05-28	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1570	31	#506	2	2	1166	5	1650.00	1650.00	12 months (academic year)	2025-05-12	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1571	31	#507	3	3	1298	5	2250.00	2250.00	15 months	2025-08-04	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1572	31	508	1	1	565	5	1050.00	1050.00	15 months	2025-08-28	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1573	31	#509	3	3	1437	5	2400.00	2400.00	12 months (academic year)	2025-05-03	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1574	31	#601	2	2	995	6	1800.00	1800.00	15 months	2025-06-08	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1575	31	602	2	2	919	6	1800.00	1800.00	15 months	2025-05-04	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1576	31	D603	1	1	579	6	1450.00	1450.00	6 months	2025-05-14	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1577	31	#604	2	2	1155	6	1950.00	1950.00	12 months	2025-05-16	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1578	31	F605	1	1	618	6	1000.00	1000.00	9 months	2025-06-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1579	31	#606	3	3	1225	6	2150.00	2150.00	6 months	2025-05-20	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	f
1580	31	607	0	1	418	6	950.00	950.00	6 months	2025-06-27	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1581	31	#608	0	1	407	6	850.00	850.00	12 months (academic year)	2025-07-31	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1582	31	J609	3	3	1404	6	2150.00	2150.00	15 months	2025-06-20	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1583	31	#701	1	1	822	7	1050.00	1050.00	15 months	2025-07-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1584	31	C702	2	2	1103	7	1750.00	1750.00	12 months (academic year)	2025-08-12	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1585	31	D703	3	3	1439	7	2300.00	2300.00	9 months	2025-07-06	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1586	32	B101	1	1	567	1	1400.00	1400.00	12 months	2025-05-29	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1587	32	C102	1	1	822	1	1450.00	1450.00	6 months	2025-08-07	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1588	32	103	3	3	1502	1	2150.00	2150.00	9 months	2025-08-28	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1589	32	104	1	1	613	1	1450.00	1450.00	12 months (academic year)	2025-05-01	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1590	32	105	1	1	615	1	1200.00	1200.00	12 months	2025-08-11	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1591	32	G106	2	2	958	1	1950.00	1950.00	12 months	2025-06-05	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	f
1592	32	B201	3	3	1202	2	2200.00	2200.00	12 months (academic year)	2025-05-16	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
1593	32	#202	2	2	918	2	2050.00	2050.00	15 months	2025-08-12	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1594	32	#203	3	3	1277	2	2250.00	2250.00	15 months	2025-07-23	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
1595	32	204	0	1	417	2	1050.00	1050.00	6 months	2025-07-05	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1596	32	F205	2	2	1154	2	1650.00	1650.00	9 months	2025-08-05	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1597	32	#206	1	1	574	2	1450.00	1450.00	9 months	2025-05-27	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1598	32	301	2	2	1148	3	1750.00	1750.00	6 months	2025-05-22	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1599	32	#302	1	1	611	3	1150.00	1150.00	9 months	2025-08-03	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1600	32	#303	1	1	671	3	1100.00	1100.00	6 months	2025-05-30	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1601	32	E304	3	3	1272	3	2050.00	2050.00	9 months	2025-07-16	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	f
1602	32	#305	2	2	859	3	1950.00	1950.00	12 months (academic year)	2025-05-11	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1603	32	306	3	3	1376	3	2100.00	2100.00	12 months (academic year)	2025-07-24	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	f
1604	32	B401	1	1	846	4	1400.00	1400.00	15 months	2025-05-22	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1605	32	C402	3	3	1256	4	2000.00	2000.00	12 months	2025-05-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
1606	32	D403	2	2	894	4	1500.00	1500.00	9 months	2025-08-19	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	f
1607	32	#404	1	1	785	4	1300.00	1300.00	12 months (academic year)	2025-06-23	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1608	32	F405	3	3	1331	4	2000.00	2000.00	15 months	2025-07-05	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
1609	32	406	3	3	1274	4	2500.00	2500.00	15 months	2025-06-28	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1610	32	501	1	1	752	5	1450.00	1450.00	9 months	2025-05-27	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
1611	32	502	2	2	1199	5	1950.00	1950.00	6 months	2025-06-09	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1612	32	#503	1	1	845	5	1050.00	1050.00	9 months	2025-05-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1613	32	E504	1	1	773	5	1150.00	1150.00	6 months	2025-05-22	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1614	32	F505	0	1	560	5	1150.00	1150.00	9 months	2025-05-30	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
1615	32	#506	3	3	1243	5	1800.00	1800.00	12 months	2025-05-16	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1616	32	601	1	1	758	6	1250.00	1250.00	12 months	2025-07-24	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
1617	32	#602	0	1	442	6	850.00	850.00	12 months	2025-08-19	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1618	32	603	1	1	582	6	1200.00	1200.00	15 months	2025-08-20	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
1619	32	#604	2	2	1047	6	1700.00	1700.00	12 months (academic year)	2025-05-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
1620	32	605	0	1	499	6	850.00	850.00	15 months	2025-07-27	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1621	32	#606	3	3	1378	6	2300.00	2300.00	15 months	2025-07-08	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1622	32	B701	1	1	672	7	1050.00	1050.00	12 months	2025-07-19	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1623	32	#702	1	1	657	7	1050.00	1050.00	12 months (academic year)	2025-07-27	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1624	32	#703	2	2	968	7	2150.00	2150.00	9 months	2025-06-14	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1625	32	#704	2	2	1001	7	2150.00	2150.00	6 months	2025-06-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
1626	32	705	2	2	1110	7	1800.00	1800.00	15 months	2025-05-08	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1627	32	#706	0	1	510	7	850.00	850.00	12 months	2025-07-21	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
1628	32	801	2	2	1127	8	1900.00	1900.00	12 months (academic year)	2025-05-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1629	32	802	2	2	1056	8	1750.00	1750.00	12 months (academic year)	2025-08-26	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1630	32	803	2	2	909	8	1950.00	1950.00	9 months	2025-05-19	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1631	32	#804	2	2	1016	8	1500.00	1500.00	12 months	2025-07-16	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1632	32	F805	1	1	652	8	1150.00	1150.00	12 months (academic year)	2025-07-17	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1633	32	#806	2	2	1056	8	2100.00	2100.00	9 months	2025-05-24	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
1634	32	#901	0	1	461	9	850.00	850.00	15 months	2025-08-17	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
1635	32	#902	2	2	1044	9	1850.00	1850.00	15 months	2025-07-02	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1636	32	#903	0	1	563	9	1050.00	1050.00	15 months	2025-05-04	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1637	32	#904	2	2	1087	9	1850.00	1850.00	6 months	2025-08-29	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	f
1638	32	905	1	1	659	9	1350.00	1350.00	6 months	2025-08-29	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1639	33	101	0	1	554	1	1000.00	1000.00	6 months	2025-08-21	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1640	33	C102	2	2	934	1	2000.00	2000.00	15 months	2025-05-05	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
1641	33	D103	1	1	745	1	1350.00	1350.00	15 months	2025-06-27	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1642	33	E104	1	1	624	1	1400.00	1400.00	12 months	2025-07-29	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1643	33	105	3	3	1321	1	2550.00	2550.00	12 months (academic year)	2025-06-18	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1644	33	G106	0	1	404	1	800.00	800.00	12 months	2025-05-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	f
1645	33	H107	2	2	935	1	1400.00	1400.00	12 months	2025-08-17	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1646	33	#108	2	2	1074	1	2100.00	2100.00	6 months	2025-05-13	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1647	33	109	3	3	1210	1	2200.00	2200.00	12 months	2025-08-10	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1648	33	110	2	2	1142	1	1450.00	1450.00	6 months	2025-08-05	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1649	33	#201	2	2	853	2	1600.00	1600.00	15 months	2025-08-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1650	33	C202	0	1	547	2	1100.00	1100.00	6 months	2025-08-27	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1651	33	#203	1	1	756	2	1400.00	1400.00	12 months (academic year)	2025-07-13	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
1652	33	204	1	1	568	2	1200.00	1200.00	6 months	2025-05-17	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1653	33	F205	3	3	1201	2	2450.00	2450.00	12 months	2025-08-27	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1654	33	206	2	2	1128	2	1750.00	1750.00	6 months	2025-07-21	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1655	33	H207	3	3	1254	2	2600.00	2600.00	12 months (academic year)	2025-08-26	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1656	33	#208	1	1	815	2	1350.00	1350.00	9 months	2025-05-06	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
1657	33	J209	1	1	826	2	1450.00	1450.00	12 months (academic year)	2025-06-20	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1658	33	K210	0	1	558	2	1100.00	1100.00	15 months	2025-06-22	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
1659	33	B301	2	2	1121	3	1800.00	1800.00	12 months (academic year)	2025-08-31	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	f
1660	33	302	2	2	1146	3	1850.00	1850.00	6 months	2025-06-29	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1661	33	303	2	2	856	3	1400.00	1400.00	12 months (academic year)	2025-08-17	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1662	33	E304	1	1	602	3	1200.00	1200.00	12 months (academic year)	2025-05-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
1663	33	F305	2	2	1076	3	1500.00	1500.00	12 months (academic year)	2025-06-30	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1664	33	306	2	2	1008	3	1850.00	1850.00	9 months	2025-05-26	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1665	33	307	3	3	1580	3	2650.00	2650.00	6 months	2025-07-26	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1666	33	I308	2	2	882	3	1900.00	1900.00	9 months	2025-07-11	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
1667	33	J309	3	3	1349	3	2000.00	2000.00	6 months	2025-06-24	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1668	33	310	1	1	804	3	1400.00	1400.00	12 months	2025-08-07	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
1669	33	B401	3	3	1354	4	2650.00	2650.00	6 months	2025-07-12	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1670	33	#402	3	3	1487	4	1800.00	1800.00	6 months	2025-08-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
1671	33	403	1	1	605	4	1100.00	1100.00	9 months	2025-06-03	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1672	33	#404	1	1	705	4	1000.00	1000.00	12 months	2025-05-29	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
1673	33	F405	1	1	824	4	1150.00	1150.00	15 months	2025-08-02	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1674	33	406	0	1	476	4	1000.00	1000.00	12 months	2025-06-29	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
1675	33	407	0	1	422	4	1150.00	1150.00	9 months	2025-06-20	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1676	33	408	2	2	888	4	1500.00	1500.00	12 months	2025-08-25	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
1677	33	#409	1	1	761	4	1450.00	1450.00	15 months	2025-07-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1678	33	K410	1	1	663	4	1300.00	1300.00	12 months (academic year)	2025-05-30	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1679	33	B501	2	2	1165	5	1450.00	1450.00	9 months	2025-05-27	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
1680	33	#502	1	1	780	5	1050.00	1050.00	15 months	2025-07-30	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	f
1681	34	#101	2	2	1104	1	1950.00	1950.00	12 months	2025-07-05	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1682	34	C102	2	2	1013	1	1400.00	1400.00	9 months	2025-07-14	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1683	34	#103	2	2	944	1	1800.00	1800.00	6 months	2025-08-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	f
1684	34	E104	3	3	1600	1	2050.00	2050.00	12 months	2025-07-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
1685	34	105	2	2	1174	1	1450.00	1450.00	15 months	2025-06-07	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1686	34	#106	1	1	589	1	1250.00	1250.00	12 months	2025-05-10	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1687	34	107	1	1	709	1	1250.00	1250.00	12 months (academic year)	2025-08-29	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1688	34	108	2	2	1059	1	1500.00	1500.00	6 months	2025-08-18	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
1689	34	#201	0	1	504	2	850.00	850.00	6 months	2025-08-29	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1690	34	C202	0	1	515	2	1000.00	1000.00	12 months (academic year)	2025-08-10	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1691	34	203	2	2	1053	2	1950.00	1950.00	6 months	2025-05-01	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1692	34	E204	1	1	608	2	1050.00	1050.00	12 months	2025-09-01	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1693	34	F205	0	1	518	2	1000.00	1000.00	12 months (academic year)	2025-08-21	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
1694	34	G206	0	1	440	2	900.00	900.00	12 months	2025-07-06	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1695	34	#207	1	1	572	2	1100.00	1100.00	6 months	2025-06-30	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1696	34	208	1	1	779	2	1300.00	1300.00	9 months	2025-08-21	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
1697	34	B301	1	1	717	3	1250.00	1250.00	15 months	2025-08-30	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1698	34	302	2	2	963	3	1700.00	1700.00	12 months	2025-08-18	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
1699	34	#303	3	3	1595	3	2550.00	2550.00	12 months (academic year)	2025-05-24	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
1700	34	304	1	1	770	3	1300.00	1300.00	15 months	2025-08-30	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1701	34	#305	1	1	699	3	1200.00	1200.00	9 months	2025-08-28	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1702	34	G306	2	2	1037	3	1850.00	1850.00	12 months (academic year)	2025-07-22	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1703	34	#307	1	1	651	3	1150.00	1150.00	9 months	2025-07-03	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1704	34	308	3	3	1484	3	2750.00	2750.00	12 months	2025-07-07	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
1705	34	401	1	1	804	4	1400.00	1400.00	12 months	2025-06-22	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1706	34	402	3	3	1488	4	1900.00	1900.00	12 months (academic year)	2025-08-25	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1707	34	#403	2	2	941	4	1950.00	1950.00	6 months	2025-06-19	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1708	34	E404	2	2	982	4	1600.00	1600.00	12 months (academic year)	2025-06-18	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1709	34	405	3	3	1566	4	1900.00	1900.00	12 months (academic year)	2025-06-04	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1710	34	G406	0	1	574	4	1050.00	1050.00	6 months	2025-08-03	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1711	34	H407	0	1	528	4	1150.00	1150.00	15 months	2025-08-06	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
1712	34	#408	2	2	955	4	1400.00	1400.00	12 months (academic year)	2025-06-30	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	f
1713	34	#501	1	1	567	5	1300.00	1300.00	9 months	2025-05-07	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1714	34	#502	2	2	1107	5	1750.00	1750.00	6 months	2025-07-16	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	f
1715	34	503	1	1	577	5	1250.00	1250.00	9 months	2025-07-28	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
1716	34	504	3	3	1363	5	2450.00	2450.00	12 months	2025-05-30	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1717	34	F505	1	1	598	5	1050.00	1050.00	6 months	2025-08-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1718	34	G506	2	2	872	5	1450.00	1450.00	12 months	2025-05-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1719	34	H507	3	3	1267	5	2150.00	2150.00	12 months	2025-05-13	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
1720	34	#508	2	2	944	5	1550.00	1550.00	12 months (academic year)	2025-08-13	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1721	34	#601	3	3	1463	6	2650.00	2650.00	15 months	2025-07-27	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1722	34	#602	1	1	790	6	1150.00	1150.00	12 months (academic year)	2025-05-26	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1723	34	#603	1	1	639	6	1000.00	1000.00	6 months	2025-08-31	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
1724	34	#604	2	2	1086	6	2100.00	2100.00	6 months	2025-05-21	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1725	34	F605	2	2	1170	6	1400.00	1400.00	9 months	2025-08-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1726	34	#606	2	2	1140	6	1650.00	1650.00	6 months	2025-06-12	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1727	34	H607	1	1	753	6	1150.00	1150.00	9 months	2025-08-31	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1728	34	I608	1	1	651	6	1200.00	1200.00	15 months	2025-05-31	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
1729	34	B701	3	3	1476	7	2550.00	2550.00	6 months	2025-08-07	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1730	34	C702	0	1	585	7	900.00	900.00	6 months	2025-05-19	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1731	35	101	0	1	514	1	1100.00	1100.00	9 months	2025-08-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
1732	35	#102	2	2	1037	1	1900.00	1900.00	12 months (academic year)	2025-07-17	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1733	35	D103	2	2	898	1	2150.00	2150.00	6 months	2025-06-05	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1734	35	E104	3	3	1442	1	2050.00	2050.00	9 months	2025-07-04	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1735	35	105	2	2	1109	1	1900.00	1900.00	9 months	2025-07-07	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	f
1736	35	#201	3	3	1460	2	1800.00	1800.00	6 months	2025-05-29	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1737	35	202	1	1	552	2	1350.00	1350.00	15 months	2025-06-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1738	35	D203	2	2	993	2	2150.00	2150.00	6 months	2025-06-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1739	35	#204	0	1	509	2	800.00	800.00	6 months	2025-07-24	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1740	35	205	0	1	508	2	800.00	800.00	6 months	2025-06-27	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1741	35	301	2	2	1158	3	1400.00	1400.00	9 months	2025-05-23	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
1742	35	302	2	2	982	3	2100.00	2100.00	9 months	2025-06-19	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1743	35	#303	3	3	1416	3	1900.00	1900.00	6 months	2025-06-08	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1744	35	E304	2	2	1196	3	1900.00	1900.00	6 months	2025-08-16	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1745	35	F305	1	1	577	3	1450.00	1450.00	9 months	2025-07-13	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
1746	35	#401	2	2	932	4	1400.00	1400.00	6 months	2025-05-23	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
1747	35	402	3	3	1464	4	2250.00	2250.00	15 months	2025-07-16	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1748	35	403	2	2	1166	4	1750.00	1750.00	9 months	2025-08-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	f
1749	35	404	1	1	825	4	1350.00	1350.00	12 months	2025-08-24	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1750	35	#405	1	1	829	4	1200.00	1200.00	12 months (academic year)	2025-05-17	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
1751	35	#501	1	1	810	5	1050.00	1050.00	12 months (academic year)	2025-07-18	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1752	35	502	3	3	1285	5	2350.00	2350.00	12 months (academic year)	2025-08-28	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1753	35	#503	1	1	759	5	1400.00	1400.00	12 months	2025-06-20	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1754	35	504	1	1	843	5	1300.00	1300.00	6 months	2025-06-16	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
1755	35	#505	2	2	960	5	2050.00	2050.00	12 months (academic year)	2025-06-08	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
1756	35	#601	2	2	1005	6	1600.00	1600.00	15 months	2025-05-31	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1757	35	#602	3	3	1418	6	2200.00	2200.00	9 months	2025-05-14	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
1758	35	D603	1	1	759	6	1050.00	1050.00	15 months	2025-07-29	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1759	35	#604	2	2	1096	6	1800.00	1800.00	12 months	2025-05-25	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1760	35	#605	0	1	590	6	1100.00	1100.00	6 months	2025-05-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
1761	35	701	0	1	480	7	1150.00	1150.00	6 months	2025-06-01	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1762	35	702	2	2	971	7	2150.00	2150.00	6 months	2025-06-05	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1763	35	#703	1	1	678	7	1000.00	1000.00	9 months	2025-06-03	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
1764	35	#704	1	1	816	7	1300.00	1300.00	12 months (academic year)	2025-05-05	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1765	35	F705	0	1	461	7	1100.00	1100.00	15 months	2025-07-27	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
1766	35	801	3	3	1412	8	2100.00	2100.00	12 months (academic year)	2025-08-14	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1767	35	802	1	1	633	8	1000.00	1000.00	9 months	2025-06-03	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1768	35	#803	2	2	930	8	1950.00	1950.00	6 months	2025-08-23	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1769	35	804	1	1	574	8	1450.00	1450.00	12 months (academic year)	2025-06-05	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1770	35	#805	3	3	1397	8	2100.00	2100.00	15 months	2025-05-23	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1771	35	#901	1	1	811	9	1000.00	1000.00	15 months	2025-05-12	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1772	35	C902	1	1	725	9	1200.00	1200.00	6 months	2025-08-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
1773	35	903	1	1	642	9	1450.00	1450.00	9 months	2025-06-24	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	f
1774	35	#904	2	2	1126	9	2050.00	2050.00	9 months	2025-06-03	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1775	35	#905	3	3	1390	9	2150.00	2150.00	12 months (academic year)	2025-05-07	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
1776	36	#101	2	2	851	1	1550.00	1550.00	15 months	2025-08-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1777	36	102	0	1	466	1	1100.00	1100.00	9 months	2025-08-26	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1778	36	D103	2	2	917	1	2050.00	2050.00	6 months	2025-08-29	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1779	36	E104	1	1	641	1	1200.00	1200.00	9 months	2025-06-24	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1780	36	#105	1	1	808	1	1250.00	1250.00	9 months	2025-08-29	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1781	36	#201	3	3	1248	2	2050.00	2050.00	6 months	2025-08-29	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1782	36	202	1	1	585	2	1350.00	1350.00	15 months	2025-05-11	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
1783	36	#203	2	2	1023	2	1950.00	1950.00	12 months (academic year)	2025-08-16	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1784	36	E204	2	2	853	2	1500.00	1500.00	12 months	2025-08-29	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1785	36	#205	3	3	1513	2	2150.00	2150.00	6 months	2025-05-26	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
1786	36	B301	1	1	777	3	1150.00	1150.00	12 months	2025-05-02	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1787	36	302	2	2	1194	3	2000.00	2000.00	12 months	2025-07-05	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
1788	36	303	2	2	912	3	1750.00	1750.00	12 months	2025-06-06	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1789	36	#304	3	3	1502	3	2450.00	2450.00	15 months	2025-08-14	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1790	36	#305	0	1	524	3	1150.00	1150.00	12 months (academic year)	2025-07-07	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
1791	36	B401	2	2	1110	4	2050.00	2050.00	6 months	2025-07-25	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1792	36	#402	0	1	531	4	800.00	800.00	9 months	2025-06-15	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
1793	36	403	3	3	1307	4	2100.00	2100.00	6 months	2025-05-01	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1794	36	#404	1	1	696	4	1350.00	1350.00	9 months	2025-06-09	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
1795	36	405	1	1	645	4	1050.00	1050.00	6 months	2025-06-15	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
1796	36	B501	2	2	972	5	1600.00	1600.00	9 months	2025-06-20	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1797	36	502	1	1	789	5	1100.00	1100.00	12 months (academic year)	2025-06-17	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1798	36	503	2	2	995	5	1950.00	1950.00	9 months	2025-07-04	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1799	36	#504	0	1	481	5	1100.00	1100.00	12 months (academic year)	2025-08-17	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
1800	36	#505	3	3	1376	5	2100.00	2100.00	15 months	2025-08-10	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	f
1801	36	#601	2	2	1142	6	1950.00	1950.00	12 months	2025-05-30	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1802	36	602	2	2	857	6	1950.00	1950.00	15 months	2025-06-30	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
1803	36	603	1	1	719	6	1450.00	1450.00	12 months	2025-06-13	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	f
1804	36	E604	1	1	699	6	1300.00	1300.00	9 months	2025-07-21	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1805	36	605	3	3	1215	6	2300.00	2300.00	12 months	2025-05-23	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1806	36	#701	2	2	899	7	1900.00	1900.00	12 months (academic year)	2025-07-22	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1807	36	702	2	2	980	7	2150.00	2150.00	6 months	2025-08-11	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
1808	36	D703	1	1	555	7	1300.00	1300.00	12 months (academic year)	2025-08-04	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	f
1809	36	704	1	1	817	7	1300.00	1300.00	15 months	2025-05-13	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	f
1810	36	#705	2	2	1022	7	1450.00	1450.00	15 months	2025-05-11	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1811	36	801	1	1	557	8	1300.00	1300.00	15 months	2025-06-01	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1905	38	310	3	3	1590	3	2050.00	2050.00	6 months	2025-05-28	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
1812	36	#802	3	3	1484	8	2450.00	2450.00	12 months (academic year)	2025-05-27	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1813	36	#803	0	1	403	8	950.00	950.00	9 months	2025-07-07	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
1814	36	#804	1	1	713	8	1350.00	1350.00	12 months	2025-08-08	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
1815	36	805	0	1	567	8	850.00	850.00	9 months	2025-05-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1816	36	#901	1	1	629	9	1050.00	1050.00	9 months	2025-08-05	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
1817	36	C902	2	2	1058	9	1500.00	1500.00	6 months	2025-06-16	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1818	36	#903	1	1	564	9	1000.00	1000.00	12 months (academic year)	2025-07-11	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1819	36	904	3	3	1204	9	2700.00	2700.00	12 months (academic year)	2025-07-07	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1820	37	B101	1	1	554	1	1050.00	1050.00	12 months	2025-06-11	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1821	37	102	1	1	714	1	1300.00	1300.00	6 months	2025-07-18	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1822	37	103	0	1	565	1	950.00	950.00	9 months	2025-06-01	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1823	37	104	0	1	548	1	1050.00	1050.00	6 months	2025-05-25	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1824	37	105	2	2	863	1	1650.00	1650.00	12 months	2025-07-18	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1825	37	B201	3	3	1566	2	2650.00	2650.00	15 months	2025-08-18	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
1826	37	C202	2	2	1107	2	1750.00	1750.00	9 months	2025-08-11	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1827	37	#203	3	3	1483	2	2550.00	2550.00	12 months (academic year)	2025-08-31	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	f
1828	37	#204	1	1	616	2	1400.00	1400.00	12 months (academic year)	2025-08-06	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1829	37	205	1	1	710	2	1250.00	1250.00	12 months (academic year)	2025-08-07	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1830	37	B301	2	2	912	3	1750.00	1750.00	9 months	2025-07-09	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
1831	37	#302	1	1	621	3	1400.00	1400.00	15 months	2025-05-03	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
1832	37	#303	1	1	679	3	1000.00	1000.00	9 months	2025-06-13	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
1833	37	E304	2	2	1054	3	2100.00	2100.00	6 months	2025-06-03	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1834	37	F305	1	1	812	3	1400.00	1400.00	12 months	2025-05-01	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
1835	37	401	1	1	845	4	1400.00	1400.00	15 months	2025-07-21	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1836	37	C402	0	1	467	4	1150.00	1150.00	9 months	2025-08-26	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1837	37	403	0	1	407	4	850.00	850.00	6 months	2025-08-11	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
1838	37	404	0	1	508	4	800.00	800.00	12 months (academic year)	2025-07-26	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	f
1839	37	F405	2	2	922	4	1550.00	1550.00	15 months	2025-06-20	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
1840	37	#501	2	2	1032	5	1650.00	1650.00	12 months	2025-07-01	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1841	37	502	3	3	1212	5	2400.00	2400.00	6 months	2025-05-26	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1842	37	#503	2	2	1179	5	1600.00	1600.00	9 months	2025-07-13	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1843	37	E504	1	1	800	5	1350.00	1350.00	9 months	2025-07-31	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1844	37	#505	2	2	917	5	1900.00	1900.00	15 months	2025-05-07	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1845	37	#601	3	3	1477	6	2550.00	2550.00	6 months	2025-07-31	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
1846	37	#602	3	3	1258	6	2750.00	2750.00	12 months (academic year)	2025-07-07	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1847	37	#603	0	1	422	6	800.00	800.00	6 months	2025-05-12	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
1848	37	#604	2	2	1136	6	1650.00	1650.00	9 months	2025-06-20	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1849	37	F605	2	2	934	6	1600.00	1600.00	12 months (academic year)	2025-07-30	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1850	37	B701	1	1	707	7	1450.00	1450.00	12 months (academic year)	2025-06-25	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
1851	37	#702	1	1	674	7	1250.00	1250.00	12 months (academic year)	2025-08-29	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
1852	37	#703	2	2	1061	7	1500.00	1500.00	12 months (academic year)	2025-08-17	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
1853	37	E704	1	1	793	7	1350.00	1350.00	9 months	2025-05-24	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1854	37	#705	3	3	1225	7	2200.00	2200.00	9 months	2025-07-24	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1855	37	#801	2	2	1040	8	1700.00	1700.00	12 months (academic year)	2025-05-15	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1856	37	802	2	2	940	8	2050.00	2050.00	12 months	2025-07-21	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1857	37	803	1	1	732	8	1350.00	1350.00	6 months	2025-07-01	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1858	37	E804	1	1	818	8	1050.00	1050.00	15 months	2025-06-06	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1859	37	805	2	2	1191	8	1600.00	1600.00	12 months (academic year)	2025-08-31	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1860	38	101	2	2	1173	1	1900.00	1900.00	12 months	2025-08-22	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
1861	38	C102	2	2	877	1	1750.00	1750.00	9 months	2025-07-06	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1862	38	D103	0	1	556	1	1050.00	1050.00	12 months	2025-08-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
1863	38	104	1	1	675	1	1050.00	1050.00	6 months	2025-05-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1864	38	105	1	1	651	1	1250.00	1250.00	12 months (academic year)	2025-05-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
1865	38	106	3	3	1364	1	2100.00	2100.00	12 months	2025-07-08	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1866	38	107	1	1	682	1	1150.00	1150.00	9 months	2025-07-21	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1867	38	#108	3	3	1366	1	2450.00	2450.00	15 months	2025-06-05	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1868	38	109	0	1	453	1	1000.00	1000.00	15 months	2025-08-12	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1869	38	K110	1	1	840	1	1200.00	1200.00	12 months	2025-08-03	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	f
1870	38	111	2	2	1141	1	1600.00	1600.00	9 months	2025-08-05	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1871	38	M112	1	1	649	1	1050.00	1050.00	12 months (academic year)	2025-05-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1872	38	#113	1	1	777	1	1200.00	1200.00	12 months	2025-08-21	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1873	38	#114	0	1	544	1	900.00	900.00	12 months (academic year)	2025-07-21	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1874	38	P115	1	1	715	1	1250.00	1250.00	15 months	2025-07-10	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
1875	38	Q116	1	1	600	1	1250.00	1250.00	12 months	2025-06-08	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1876	38	#117	2	2	1086	1	1850.00	1850.00	12 months	2025-06-01	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1877	38	#118	2	2	926	1	1700.00	1700.00	6 months	2025-08-23	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1878	38	201	1	1	711	2	1400.00	1400.00	6 months	2025-08-24	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1879	38	202	0	1	536	2	1050.00	1050.00	15 months	2025-05-20	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1880	38	203	2	2	868	2	1500.00	1500.00	6 months	2025-05-02	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1881	38	204	2	2	968	2	1750.00	1750.00	9 months	2025-08-28	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
1882	38	205	0	1	590	2	850.00	850.00	9 months	2025-07-21	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1883	38	#206	2	2	1034	2	1800.00	1800.00	12 months	2025-07-15	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1884	38	H207	2	2	1120	2	1950.00	1950.00	12 months	2025-05-12	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1885	38	#208	1	1	844	2	1400.00	1400.00	6 months	2025-05-23	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1886	38	J209	3	3	1409	2	2150.00	2150.00	9 months	2025-07-20	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1887	38	K210	2	2	1090	2	1950.00	1950.00	6 months	2025-09-01	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1888	38	L211	3	3	1350	2	2250.00	2250.00	12 months	2025-07-06	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1889	38	M212	3	3	1387	2	2500.00	2500.00	9 months	2025-07-06	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1890	38	#213	1	1	567	2	1250.00	1250.00	9 months	2025-06-16	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
1891	38	#214	1	1	668	2	1150.00	1150.00	9 months	2025-07-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1892	38	P215	3	3	1347	2	2150.00	2150.00	9 months	2025-06-30	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1893	38	216	1	1	584	2	1050.00	1050.00	15 months	2025-06-14	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
1894	38	217	2	2	952	2	1600.00	1600.00	15 months	2025-07-15	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1895	38	#218	1	1	587	2	1450.00	1450.00	9 months	2025-05-03	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1896	38	301	3	3	1473	3	2250.00	2250.00	15 months	2025-06-13	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1897	38	#302	2	2	933	3	1800.00	1800.00	15 months	2025-08-26	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1898	38	D303	0	1	571	3	1050.00	1050.00	15 months	2025-05-07	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1899	38	#304	1	1	750	3	1350.00	1350.00	15 months	2025-07-27	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1900	38	305	3	3	1253	3	2300.00	2300.00	15 months	2025-05-11	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
1901	38	306	1	1	769	3	1250.00	1250.00	12 months	2025-08-22	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
1902	38	307	1	1	708	3	1100.00	1100.00	12 months (academic year)	2025-05-05	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
1903	38	#308	2	2	1067	3	1500.00	1500.00	12 months	2025-06-15	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
1904	38	309	3	3	1206	3	2050.00	2050.00	15 months	2025-07-11	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1906	38	L311	2	2	906	3	1550.00	1550.00	12 months (academic year)	2025-08-19	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1907	38	312	0	1	543	3	900.00	900.00	12 months (academic year)	2025-08-20	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
1908	38	313	2	2	991	3	1650.00	1650.00	9 months	2025-07-10	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
1909	38	#314	2	2	1078	3	2000.00	2000.00	15 months	2025-06-06	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	f
1910	38	P315	2	2	1031	3	1700.00	1700.00	12 months	2025-08-28	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1911	38	#316	2	2	1057	3	2150.00	2150.00	12 months	2025-05-10	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
1912	38	317	1	1	833	3	1400.00	1400.00	6 months	2025-05-21	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	f
1913	38	318	0	1	433	3	950.00	950.00	12 months	2025-07-02	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
1914	39	#101	3	3	1509	1	1800.00	1800.00	9 months	2025-08-16	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1915	39	102	1	1	565	1	1350.00	1350.00	12 months	2025-08-11	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1916	39	103	1	1	807	1	1050.00	1050.00	9 months	2025-08-10	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
1917	39	#104	1	1	587	1	1300.00	1300.00	9 months	2025-08-27	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
1918	39	#105	1	1	717	1	1150.00	1150.00	15 months	2025-08-02	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1919	39	106	3	3	1360	1	2150.00	2150.00	12 months	2025-05-30	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
1920	39	#201	1	1	635	2	1250.00	1250.00	6 months	2025-08-08	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1921	39	#202	0	1	458	2	900.00	900.00	9 months	2025-08-17	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
1922	39	#203	2	2	959	2	2150.00	2150.00	9 months	2025-08-11	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1923	39	#204	2	2	851	2	1650.00	1650.00	12 months	2025-08-06	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1924	39	#205	1	1	566	2	1450.00	1450.00	12 months	2025-09-01	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	f
1925	39	#206	0	1	528	2	950.00	950.00	15 months	2025-07-08	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
1926	39	301	2	2	1122	3	2150.00	2150.00	9 months	2025-06-03	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
1927	39	C302	2	2	867	3	2050.00	2050.00	6 months	2025-06-03	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
1928	39	D303	2	2	1024	3	1950.00	1950.00	15 months	2025-06-30	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
1929	39	E304	0	1	593	3	800.00	800.00	9 months	2025-08-04	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	f
1930	39	F305	3	3	1482	3	2700.00	2700.00	6 months	2025-06-26	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
1931	39	306	2	2	1067	3	1650.00	1650.00	15 months	2025-07-11	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1932	39	B401	2	2	1185	4	1500.00	1500.00	12 months (academic year)	2025-05-24	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
1933	39	402	3	3	1556	4	1800.00	1800.00	12 months	2025-07-24	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	f
1934	39	403	1	1	617	4	1450.00	1450.00	12 months (academic year)	2025-07-14	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
1935	39	#404	3	3	1345	4	2700.00	2700.00	9 months	2025-06-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1936	39	F405	2	2	916	4	1550.00	1550.00	6 months	2025-06-10	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1937	39	#406	0	1	476	4	800.00	800.00	15 months	2025-06-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
1938	39	501	1	1	763	5	1300.00	1300.00	6 months	2025-07-05	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
1939	39	C502	2	2	982	5	1600.00	1600.00	12 months (academic year)	2025-06-11	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1940	39	503	2	2	914	5	2100.00	2100.00	15 months	2025-08-16	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	f
1941	39	#504	2	2	976	5	1650.00	1650.00	9 months	2025-05-01	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
1942	39	F505	2	2	1154	5	1900.00	1900.00	15 months	2025-07-05	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
1943	39	#506	2	2	1096	5	2100.00	2100.00	12 months	2025-05-22	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
1944	39	601	1	1	845	6	1050.00	1050.00	15 months	2025-08-16	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1945	39	C602	0	1	464	6	950.00	950.00	15 months	2025-06-04	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
1946	39	#603	1	1	626	6	1100.00	1100.00	9 months	2025-06-14	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
1947	39	E604	1	1	818	6	1100.00	1100.00	12 months (academic year)	2025-07-01	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
1948	39	#605	1	1	797	6	1200.00	1200.00	6 months	2025-08-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	f
1949	39	606	2	2	880	6	1450.00	1450.00	6 months	2025-08-12	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
1950	39	701	1	1	643	7	1400.00	1400.00	6 months	2025-06-29	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
1951	39	702	3	3	1407	7	2700.00	2700.00	9 months	2025-05-05	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
1952	39	703	1	1	774	7	1250.00	1250.00	9 months	2025-06-18	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1953	39	704	0	1	509	7	1150.00	1150.00	12 months	2025-08-13	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1954	40	B101	3	3	1554	1	2750.00	2750.00	12 months (academic year)	2025-06-22	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
1955	40	C102	1	1	726	1	1150.00	1150.00	9 months	2025-08-19	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
1956	40	#103	1	1	756	1	1150.00	1150.00	15 months	2025-07-24	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	f
1957	40	#104	1	1	664	1	1150.00	1150.00	12 months	2025-05-28	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
1958	40	105	1	1	590	1	1150.00	1150.00	12 months	2025-07-03	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
1959	40	106	2	2	1019	1	1650.00	1650.00	15 months	2025-08-31	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
1960	40	H107	3	3	1600	1	2550.00	2550.00	9 months	2025-08-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
1961	40	108	2	2	1095	1	1700.00	1700.00	12 months (academic year)	2025-08-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1962	40	#201	3	3	1586	2	2650.00	2650.00	12 months	2025-07-16	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1963	40	#202	2	2	955	2	1850.00	1850.00	9 months	2025-08-15	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
1964	40	203	2	2	1005	2	1700.00	1700.00	6 months	2025-08-01	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
1965	40	E204	0	1	443	2	850.00	850.00	12 months	2025-08-05	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
1966	40	#205	1	1	722	2	1250.00	1250.00	15 months	2025-07-25	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
1967	40	G206	1	1	818	2	1400.00	1400.00	12 months	2025-07-07	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1968	40	#207	1	1	842	2	1450.00	1450.00	6 months	2025-08-24	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
1969	40	208	1	1	686	2	1150.00	1150.00	12 months (academic year)	2025-07-10	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1970	40	B301	1	1	709	3	1250.00	1250.00	12 months	2025-06-01	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
1971	40	#302	2	2	956	3	1600.00	1600.00	12 months	2025-06-20	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
1972	40	D303	2	2	978	3	1500.00	1500.00	12 months	2025-05-23	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	f
1973	40	E304	3	3	1563	3	2300.00	2300.00	9 months	2025-07-30	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
1974	40	305	1	1	700	3	1200.00	1200.00	6 months	2025-08-17	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	f
1975	40	306	0	1	493	3	850.00	850.00	15 months	2025-05-26	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
1976	40	H307	2	2	1138	3	1850.00	1850.00	15 months	2025-07-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
1977	40	I308	3	3	1472	3	1950.00	1950.00	12 months (academic year)	2025-06-30	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
1978	40	B401	2	2	879	4	1650.00	1650.00	12 months	2025-06-27	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
1979	40	402	3	3	1541	4	2600.00	2600.00	6 months	2025-08-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1980	40	D403	1	1	739	4	1000.00	1000.00	6 months	2025-07-23	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
1981	40	404	3	3	1258	4	2700.00	2700.00	15 months	2025-08-02	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
1982	40	#405	2	2	1140	4	1800.00	1800.00	6 months	2025-07-20	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
1983	40	406	0	1	559	4	900.00	900.00	6 months	2025-08-07	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1984	40	H407	2	2	1064	4	2150.00	2150.00	6 months	2025-05-03	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
1985	40	#408	2	2	983	4	1850.00	1850.00	12 months	2025-06-11	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
1986	40	501	0	1	487	5	1150.00	1150.00	15 months	2025-08-22	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
1987	40	C502	2	2	1186	5	1650.00	1650.00	6 months	2025-08-19	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
1988	40	503	3	3	1346	5	1950.00	1950.00	12 months	2025-07-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
1989	40	E504	2	2	1137	5	1500.00	1500.00	15 months	2025-07-27	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1990	40	F505	2	2	986	5	2100.00	2100.00	6 months	2025-06-25	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1991	40	506	1	1	688	5	1250.00	1250.00	12 months	2025-06-05	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
1992	40	507	0	1	410	5	950.00	950.00	12 months	2025-05-16	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
1993	40	508	1	1	620	5	1100.00	1100.00	9 months	2025-05-04	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
1994	40	#601	0	1	530	6	1000.00	1000.00	12 months (academic year)	2025-07-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
1995	40	602	1	1	767	6	1450.00	1450.00	9 months	2025-08-03	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
1996	41	101	2	2	916	1	1900.00	1900.00	6 months	2025-06-03	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
1997	41	#102	2	2	885	1	1600.00	1600.00	6 months	2025-05-21	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
1998	41	103	1	1	822	1	1250.00	1250.00	12 months (academic year)	2025-07-05	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
1999	41	#104	1	1	753	1	1150.00	1150.00	9 months	2025-07-15	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	f
2000	41	#105	1	1	666	1	1000.00	1000.00	6 months	2025-08-10	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
2001	41	G106	2	2	936	1	1700.00	1700.00	15 months	2025-08-30	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
2002	41	H107	0	1	597	1	900.00	900.00	15 months	2025-08-04	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	f
2003	41	#201	2	2	885	2	2150.00	2150.00	6 months	2025-05-18	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
2004	41	202	3	3	1239	2	2450.00	2450.00	9 months	2025-08-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
2005	41	203	0	1	472	2	950.00	950.00	12 months (academic year)	2025-06-07	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
2006	41	#204	1	1	720	2	1050.00	1050.00	15 months	2025-08-15	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
2007	41	F205	1	1	582	2	1200.00	1200.00	9 months	2025-05-04	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
2008	41	#206	2	2	1169	2	1800.00	1800.00	12 months	2025-07-22	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
2009	41	#207	1	1	610	2	1150.00	1150.00	15 months	2025-07-30	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
2010	41	301	2	2	878	3	1550.00	1550.00	12 months	2025-05-14	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
2011	41	C302	1	1	590	3	1100.00	1100.00	15 months	2025-08-21	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
2012	41	303	3	3	1550	3	2550.00	2550.00	9 months	2025-06-19	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
2013	41	304	0	1	473	3	1150.00	1150.00	15 months	2025-08-07	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	f
2014	41	305	1	1	613	3	1300.00	1300.00	6 months	2025-06-28	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
2015	41	#306	2	2	1027	3	1600.00	1600.00	12 months (academic year)	2025-05-20	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
2016	41	307	1	1	654	3	1000.00	1000.00	12 months	2025-07-06	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
2017	41	401	3	3	1585	4	2400.00	2400.00	12 months	2025-05-02	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
2018	41	C402	2	2	1020	4	2100.00	2100.00	6 months	2025-06-21	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
2019	41	#403	3	3	1592	4	2250.00	2250.00	15 months	2025-08-26	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
2020	41	404	1	1	813	4	1350.00	1350.00	12 months	2025-05-28	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
2021	41	F405	1	1	773	4	1300.00	1300.00	15 months	2025-07-11	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
2022	41	#406	3	3	1598	4	2200.00	2200.00	9 months	2025-06-25	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
2023	41	H407	2	2	1149	4	2100.00	2100.00	12 months	2025-05-11	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
2024	41	B501	2	2	936	5	1800.00	1800.00	12 months (academic year)	2025-06-04	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
2025	41	C502	1	1	644	5	1200.00	1200.00	12 months	2025-06-12	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
2026	41	503	3	3	1291	5	2500.00	2500.00	9 months	2025-05-11	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
2027	41	504	2	2	951	5	1900.00	1900.00	12 months	2025-06-26	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
2028	41	#505	1	1	600	5	1450.00	1450.00	12 months (academic year)	2025-05-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
2029	41	#506	0	1	545	5	800.00	800.00	12 months (academic year)	2025-05-29	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	f
2030	41	H507	1	1	716	5	1300.00	1300.00	12 months	2025-05-05	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
2031	41	#601	3	3	1554	6	2250.00	2250.00	9 months	2025-06-27	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
2032	41	C602	3	3	1252	6	2100.00	2100.00	12 months	2025-08-19	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
2033	41	#603	1	1	552	6	1300.00	1300.00	12 months (academic year)	2025-08-29	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
2034	41	#604	2	2	1132	6	1750.00	1750.00	12 months (academic year)	2025-06-08	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
2035	41	F605	2	2	887	6	1800.00	1800.00	15 months	2025-06-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
2036	41	#606	1	1	655	6	1350.00	1350.00	15 months	2025-06-20	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
2037	41	H607	3	3	1530	6	2200.00	2200.00	15 months	2025-06-25	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
2038	41	B701	1	1	817	7	1200.00	1200.00	12 months	2025-05-02	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
2039	41	C702	3	3	1504	7	2650.00	2650.00	9 months	2025-05-03	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
2040	41	#703	2	2	1158	7	1600.00	1600.00	12 months	2025-07-21	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	f
2041	41	#704	2	2	958	7	1700.00	1700.00	15 months	2025-08-23	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
2042	41	F705	0	1	501	7	1050.00	1050.00	12 months (academic year)	2025-07-09	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
2043	41	G706	2	2	953	7	1950.00	1950.00	12 months (academic year)	2025-05-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
2044	41	707	2	2	1154	7	2100.00	2100.00	15 months	2025-06-03	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
2045	41	#801	2	2	869	8	1750.00	1750.00	12 months	2025-06-03	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
2046	41	802	0	1	545	8	900.00	900.00	12 months	2025-08-12	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
2047	41	#803	1	1	717	8	1400.00	1400.00	9 months	2025-08-30	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
2048	41	E804	1	1	624	8	1000.00	1000.00	9 months	2025-07-16	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
2049	41	F805	0	1	408	8	1050.00	1050.00	9 months	2025-08-19	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	f
2050	41	806	2	2	933	8	1650.00	1650.00	12 months	2025-08-05	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
2051	41	#807	3	3	1330	8	2150.00	2150.00	9 months	2025-06-13	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
2052	41	B901	0	1	472	9	850.00	850.00	12 months (academic year)	2025-09-01	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
2053	41	902	1	1	734	9	1100.00	1100.00	15 months	2025-05-23	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
2054	41	D903	2	2	1134	9	1750.00	1750.00	9 months	2025-05-16	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2055	42	B101	2	2	1128	1	1850.00	1850.00	12 months (academic year)	2025-05-17	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
2056	42	102	2	2	1036	1	1550.00	1550.00	15 months	2025-06-27	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
2057	42	D103	0	1	495	1	800.00	800.00	12 months (academic year)	2025-07-10	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
2058	42	#104	2	2	1183	1	1400.00	1400.00	15 months	2025-06-03	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
2059	42	F105	1	1	561	1	1200.00	1200.00	9 months	2025-05-17	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
2060	42	#106	1	1	796	1	1300.00	1300.00	9 months	2025-07-18	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
2061	42	H107	2	2	921	1	1450.00	1450.00	9 months	2025-06-14	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2062	42	#108	1	1	588	1	1400.00	1400.00	15 months	2025-08-05	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
2063	42	109	1	1	844	1	1450.00	1450.00	9 months	2025-07-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
2064	42	201	0	1	410	2	1100.00	1100.00	12 months	2025-06-14	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2065	42	202	1	1	554	2	1100.00	1100.00	6 months	2025-06-07	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
2066	42	203	2	2	933	2	2150.00	2150.00	15 months	2025-08-08	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
2067	42	#204	2	2	1144	2	1500.00	1500.00	12 months (academic year)	2025-07-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
2068	42	F205	1	1	668	2	1250.00	1250.00	6 months	2025-06-06	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
2069	42	206	2	2	1184	2	1950.00	1950.00	9 months	2025-08-17	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
2070	42	H207	2	2	960	2	2100.00	2100.00	6 months	2025-08-17	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
2071	42	I208	1	1	824	2	1050.00	1050.00	15 months	2025-06-11	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
2072	42	J209	1	1	721	2	1350.00	1350.00	12 months (academic year)	2025-05-02	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
2073	42	#301	3	3	1277	3	2250.00	2250.00	15 months	2025-06-16	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
2074	42	#302	2	2	1092	3	1650.00	1650.00	9 months	2025-07-11	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
2075	42	#303	3	3	1228	3	1800.00	1800.00	6 months	2025-06-04	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
2076	42	#304	3	3	1219	3	2200.00	2200.00	6 months	2025-06-20	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
2077	42	#305	1	1	565	3	1250.00	1250.00	15 months	2025-07-08	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
2078	42	G306	1	1	758	3	1450.00	1450.00	15 months	2025-07-03	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
2079	42	#307	2	2	970	3	1450.00	1450.00	12 months (academic year)	2025-06-30	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
2080	42	I308	2	2	1050	3	1450.00	1450.00	12 months	2025-05-04	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
2081	42	#309	2	2	970	3	1550.00	1550.00	15 months	2025-07-07	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
2082	42	#401	3	3	1336	4	2700.00	2700.00	6 months	2025-08-25	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
2083	42	C402	2	2	1040	4	1850.00	1850.00	9 months	2025-08-13	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
2084	42	403	1	1	578	4	1050.00	1050.00	9 months	2025-05-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
2085	42	#404	1	1	812	4	1300.00	1300.00	12 months (academic year)	2025-05-24	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	f
2086	42	405	3	3	1203	4	1900.00	1900.00	15 months	2025-08-12	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
2087	42	406	3	3	1592	4	2100.00	2100.00	12 months (academic year)	2025-07-05	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	f
2088	42	#407	1	1	811	4	1000.00	1000.00	6 months	2025-05-21	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
2089	42	I408	0	1	551	4	900.00	900.00	15 months	2025-06-29	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
2090	42	409	3	3	1218	4	2700.00	2700.00	12 months (academic year)	2025-08-27	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
2091	42	501	2	2	1071	5	1900.00	1900.00	9 months	2025-08-07	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
2092	42	#502	3	3	1556	5	2100.00	2100.00	9 months	2025-05-21	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	f
2093	42	503	1	1	590	5	1350.00	1350.00	15 months	2025-05-18	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
2094	42	504	1	1	689	5	1400.00	1400.00	15 months	2025-07-22	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
2095	42	#505	0	1	497	5	1000.00	1000.00	12 months (academic year)	2025-07-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
2096	42	506	1	1	794	5	1100.00	1100.00	15 months	2025-08-27	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
2097	42	#507	2	2	875	5	2000.00	2000.00	12 months	2025-06-18	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
2098	42	#508	0	1	474	5	850.00	850.00	6 months	2025-07-21	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
2099	42	#509	0	1	454	5	1000.00	1000.00	15 months	2025-08-16	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	f
2100	42	#601	1	1	650	6	1000.00	1000.00	6 months	2025-08-24	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
2101	42	#602	3	3	1574	6	2650.00	2650.00	6 months	2025-07-15	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
2102	42	#603	0	1	440	6	1000.00	1000.00	6 months	2025-08-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
2103	42	E604	1	1	576	6	1150.00	1150.00	12 months (academic year)	2025-08-16	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
2104	42	605	1	1	756	6	1100.00	1100.00	12 months	2025-06-28	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
2105	42	#606	2	2	1171	6	1800.00	1800.00	12 months	2025-06-10	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
2106	42	#607	2	2	1015	6	1700.00	1700.00	12 months (academic year)	2025-08-05	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
2107	42	#608	3	3	1322	6	2750.00	2750.00	12 months (academic year)	2025-08-14	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
2108	42	609	2	2	945	6	1400.00	1400.00	12 months	2025-07-20	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
2109	42	701	0	1	477	7	1050.00	1050.00	12 months (academic year)	2025-07-06	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
2110	42	C702	2	2	1086	7	1500.00	1500.00	15 months	2025-05-04	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
2111	43	#101	1	1	820	1	1400.00	1400.00	12 months	2025-06-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
2112	43	C102	1	1	659	1	1050.00	1050.00	15 months	2025-08-04	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
2113	43	103	1	1	612	1	1200.00	1200.00	6 months	2025-06-10	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
2114	43	#104	1	1	651	1	1150.00	1150.00	6 months	2025-05-05	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
2115	43	F105	2	2	977	1	1900.00	1900.00	15 months	2025-07-16	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
2116	43	106	2	2	1071	1	1850.00	1850.00	12 months	2025-08-01	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
2117	43	H107	1	1	635	1	1400.00	1400.00	6 months	2025-08-12	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2118	43	108	2	2	1166	1	1750.00	1750.00	12 months (academic year)	2025-06-24	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
2119	43	#201	1	1	563	2	1150.00	1150.00	6 months	2025-05-16	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
2120	43	#202	0	1	517	2	1100.00	1100.00	9 months	2025-08-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	f
2121	43	#203	1	1	726	2	1050.00	1050.00	9 months	2025-07-24	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
2122	43	#204	1	1	708	2	1400.00	1400.00	9 months	2025-05-06	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2123	43	F205	2	2	1161	2	2050.00	2050.00	6 months	2025-07-20	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
2124	43	206	0	1	545	2	900.00	900.00	15 months	2025-08-17	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
2125	43	207	3	3	1370	2	2100.00	2100.00	15 months	2025-05-22	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
2126	43	I208	2	2	1163	2	1400.00	1400.00	6 months	2025-08-13	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
2127	43	#301	2	2	1063	3	1500.00	1500.00	15 months	2025-06-11	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2128	43	302	3	3	1476	3	2700.00	2700.00	9 months	2025-07-11	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
2129	43	303	3	3	1569	3	2000.00	2000.00	15 months	2025-05-15	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
2130	43	304	2	2	992	3	2100.00	2100.00	12 months (academic year)	2025-06-29	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
2131	43	305	1	1	772	3	1300.00	1300.00	9 months	2025-05-20	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
2132	43	#306	3	3	1327	3	2650.00	2650.00	9 months	2025-08-04	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
2133	43	307	1	1	751	3	1000.00	1000.00	15 months	2025-05-13	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	f
2134	43	308	2	2	1034	3	1900.00	1900.00	6 months	2025-05-13	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
2135	43	#401	1	1	636	4	1450.00	1450.00	12 months (academic year)	2025-06-01	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
2136	43	402	2	2	1014	4	1950.00	1950.00	12 months (academic year)	2025-07-16	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	f
2137	43	D403	2	2	936	4	1700.00	1700.00	6 months	2025-08-23	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
2138	43	#404	2	2	1107	4	2000.00	2000.00	12 months	2025-08-03	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
2139	43	#405	2	2	892	4	1450.00	1450.00	15 months	2025-05-15	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
2140	43	406	2	2	934	4	1800.00	1800.00	12 months (academic year)	2025-06-08	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
2141	43	407	0	1	531	4	900.00	900.00	15 months	2025-06-12	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
2142	43	#408	1	1	769	4	1150.00	1150.00	15 months	2025-08-30	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
2143	43	B501	3	3	1498	5	2200.00	2200.00	15 months	2025-06-26	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
2144	43	#502	2	2	1087	5	1900.00	1900.00	12 months (academic year)	2025-06-20	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
2145	43	#503	1	1	688	5	1050.00	1050.00	9 months	2025-07-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
2146	43	504	2	2	1012	5	2150.00	2150.00	12 months (academic year)	2025-05-12	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
2147	43	F505	2	2	1126	5	2100.00	2100.00	12 months	2025-05-05	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
2148	43	G506	1	1	806	5	1100.00	1100.00	9 months	2025-08-29	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
2149	43	507	3	3	1236	5	2350.00	2350.00	9 months	2025-05-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
2150	43	508	0	1	422	5	800.00	800.00	6 months	2025-06-20	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
2151	43	601	0	1	445	6	900.00	900.00	15 months	2025-07-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
2152	43	#602	0	1	594	6	800.00	800.00	15 months	2025-07-31	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	f
2153	43	D603	1	1	700	6	1300.00	1300.00	6 months	2025-05-07	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	f
2154	43	604	1	1	715	6	1050.00	1050.00	15 months	2025-07-31	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
2155	43	F605	3	3	1569	6	2200.00	2200.00	15 months	2025-07-31	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2156	43	606	2	2	1077	6	2150.00	2150.00	12 months (academic year)	2025-05-29	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2157	43	#607	0	1	493	6	950.00	950.00	12 months	2025-07-11	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
2158	43	608	1	1	677	6	1100.00	1100.00	12 months (academic year)	2025-07-15	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
2159	43	701	3	3	1267	7	2200.00	2200.00	9 months	2025-05-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
2160	43	702	3	3	1399	7	2150.00	2150.00	12 months (academic year)	2025-05-30	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
2161	44	101	3	3	1537	1	2550.00	2550.00	6 months	2025-06-15	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	f
2162	44	C102	0	1	438	1	1000.00	1000.00	12 months	2025-08-10	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
2163	44	D103	0	1	496	1	900.00	900.00	12 months	2025-05-23	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
2164	44	104	2	2	1164	1	1450.00	1450.00	12 months	2025-08-27	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
2165	44	105	2	2	1089	1	1550.00	1550.00	12 months	2025-05-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
2166	44	106	1	1	820	1	1250.00	1250.00	12 months	2025-05-01	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
2167	44	#201	1	1	569	2	1250.00	1250.00	9 months	2025-07-28	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
2168	44	C202	3	3	1534	2	1850.00	1850.00	6 months	2025-06-26	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
2169	44	D203	1	1	724	2	1400.00	1400.00	12 months	2025-05-22	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
2170	44	#204	1	1	734	2	1050.00	1050.00	12 months (academic year)	2025-07-17	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
2171	44	#205	2	2	1162	2	1800.00	1800.00	12 months (academic year)	2025-07-20	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
2172	44	206	1	1	705	2	1100.00	1100.00	12 months	2025-08-18	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	f
2173	44	301	2	2	1038	3	1900.00	1900.00	12 months	2025-07-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	f
2174	44	C302	1	1	734	3	1050.00	1050.00	12 months	2025-08-25	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	t
2175	44	#303	2	2	1118	3	1900.00	1900.00	12 months (academic year)	2025-08-26	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
2176	44	E304	1	1	738	3	1000.00	1000.00	9 months	2025-05-04	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
2177	44	#305	3	3	1533	3	2350.00	2350.00	6 months	2025-05-24	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
2178	44	306	1	1	645	3	1350.00	1350.00	9 months	2025-05-25	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2179	44	401	2	2	930	4	2150.00	2150.00	12 months (academic year)	2025-05-25	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
2180	44	C402	2	2	1043	4	1800.00	1800.00	12 months	2025-05-10	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
2181	44	D403	0	1	576	4	800.00	800.00	12 months (academic year)	2025-08-11	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	f
2182	44	E404	2	2	1103	4	1600.00	1600.00	15 months	2025-07-28	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
2183	44	F405	1	1	733	4	1100.00	1100.00	12 months (academic year)	2025-07-09	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
2184	44	406	3	3	1459	4	2450.00	2450.00	12 months (academic year)	2025-07-11	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
2185	44	B501	3	3	1470	5	2000.00	2000.00	15 months	2025-05-07	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
2186	44	C502	3	3	1481	5	2750.00	2750.00	15 months	2025-05-07	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
2187	44	#503	3	3	1312	5	1950.00	1950.00	12 months	2025-06-05	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2188	44	#504	0	1	509	5	1150.00	1150.00	12 months (academic year)	2025-05-16	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
2189	44	F505	0	1	470	5	1000.00	1000.00	12 months (academic year)	2025-06-27	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
2190	44	G506	1	1	622	5	1050.00	1050.00	15 months	2025-05-24	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	f
2191	44	B601	1	1	725	6	1450.00	1450.00	12 months	2025-06-19	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
2192	44	#602	0	1	514	6	1100.00	1100.00	15 months	2025-06-28	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2193	44	#603	3	3	1256	6	2650.00	2650.00	12 months (academic year)	2025-07-26	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	f
2194	44	#604	2	2	929	6	2000.00	2000.00	12 months (academic year)	2025-06-13	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
2195	44	F605	2	2	959	6	1900.00	1900.00	9 months	2025-08-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
2196	44	606	2	2	1142	6	1900.00	1900.00	9 months	2025-06-22	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
2197	44	B701	3	3	1331	7	2650.00	2650.00	6 months	2025-06-30	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
2198	44	C702	2	2	956	7	2150.00	2150.00	9 months	2025-08-28	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
2199	44	#703	2	2	951	7	2150.00	2150.00	12 months	2025-06-10	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	f
2200	44	#704	2	2	908	7	1550.00	1550.00	9 months	2025-06-08	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
2201	44	705	0	1	482	7	1150.00	1150.00	9 months	2025-07-16	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
2202	44	G706	2	2	893	7	2000.00	2000.00	6 months	2025-08-21	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	f
2203	44	B801	1	1	582	8	1350.00	1350.00	6 months	2025-05-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
2204	44	C802	2	2	1175	8	1800.00	1800.00	9 months	2025-07-09	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
2205	44	803	1	1	813	8	1000.00	1000.00	12 months	2025-08-17	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
2206	44	804	1	1	713	8	1300.00	1300.00	12 months (academic year)	2025-06-04	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	f
2207	44	#805	1	1	805	8	1400.00	1400.00	12 months (academic year)	2025-06-17	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
2208	44	806	1	1	602	8	1250.00	1250.00	12 months	2025-07-28	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
2209	45	B101	0	1	507	1	1150.00	1150.00	15 months	2025-07-17	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
2210	45	#102	2	2	1194	1	1800.00	1800.00	12 months	2025-06-16	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
2211	45	D103	2	2	1132	1	1900.00	1900.00	12 months	2025-05-11	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
2212	45	104	0	1	538	1	800.00	800.00	12 months (academic year)	2025-06-08	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	f
2213	45	#105	2	2	1175	1	1400.00	1400.00	9 months	2025-07-06	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2214	45	G106	0	1	509	1	1000.00	1000.00	12 months (academic year)	2025-07-27	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
2215	45	#107	2	2	905	1	2100.00	2100.00	9 months	2025-07-04	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
2216	45	108	2	2	1115	1	2100.00	2100.00	15 months	2025-07-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
2217	45	109	3	3	1376	1	2550.00	2550.00	9 months	2025-07-14	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2218	45	110	3	3	1227	1	1800.00	1800.00	12 months (academic year)	2025-08-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
2219	45	111	2	2	884	1	1850.00	1850.00	9 months	2025-06-17	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
2220	45	B201	1	1	782	2	1450.00	1450.00	15 months	2025-08-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
2221	45	#202	1	1	720	2	1350.00	1350.00	15 months	2025-06-04	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
2222	45	#203	1	1	695	2	1100.00	1100.00	12 months	2025-07-31	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	f
2223	45	#204	1	1	780	2	1000.00	1000.00	15 months	2025-05-09	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2224	45	F205	1	1	817	2	1250.00	1250.00	15 months	2025-06-08	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
2225	45	#206	0	1	495	2	1050.00	1050.00	9 months	2025-06-20	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
2226	45	207	0	1	465	2	1150.00	1150.00	15 months	2025-05-25	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
2227	45	I208	3	3	1292	2	2600.00	2600.00	12 months (academic year)	2025-06-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	f
2228	45	#209	2	2	994	2	1400.00	1400.00	6 months	2025-05-03	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
2229	45	210	1	1	705	2	1050.00	1050.00	12 months (academic year)	2025-06-29	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
2230	45	211	2	2	1183	2	1950.00	1950.00	6 months	2025-08-06	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
2231	45	B301	1	1	585	3	1300.00	1300.00	9 months	2025-06-07	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	f
2232	45	#302	2	2	948	3	1450.00	1450.00	12 months (academic year)	2025-05-21	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
2233	45	303	1	1	822	3	1250.00	1250.00	12 months (academic year)	2025-06-15	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
2234	45	#304	3	3	1366	3	2150.00	2150.00	9 months	2025-06-30	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
2235	45	#305	3	3	1301	3	2050.00	2050.00	9 months	2025-05-14	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
2236	45	G306	2	2	922	3	1550.00	1550.00	12 months	2025-06-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
2237	45	307	3	3	1232	3	2050.00	2050.00	12 months	2025-08-07	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	f
2238	45	308	2	2	978	3	1550.00	1550.00	15 months	2025-06-28	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
2239	45	309	3	3	1406	3	2250.00	2250.00	15 months	2025-07-02	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
2240	45	K310	1	1	612	3	1000.00	1000.00	12 months	2025-06-12	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
2241	45	#311	2	2	979	3	1450.00	1450.00	15 months	2025-08-30	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
2242	45	#401	1	1	832	4	1450.00	1450.00	9 months	2025-05-25	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
2243	45	402	0	1	420	4	800.00	800.00	9 months	2025-07-17	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
2244	45	#403	3	3	1317	4	1800.00	1800.00	12 months (academic year)	2025-06-01	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
2245	45	#404	2	2	1032	4	1650.00	1650.00	12 months	2025-05-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
2246	45	405	3	3	1271	4	2350.00	2350.00	9 months	2025-07-10	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
2247	45	G406	2	2	950	4	1550.00	1550.00	12 months (academic year)	2025-05-06	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2248	45	407	1	1	818	4	1450.00	1450.00	12 months	2025-08-10	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
2249	45	408	1	1	846	4	1400.00	1400.00	9 months	2025-07-24	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
2250	45	409	1	1	792	4	1300.00	1300.00	6 months	2025-06-25	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
2251	45	K410	1	1	631	4	1350.00	1350.00	12 months (academic year)	2025-08-12	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
2252	45	#411	2	2	939	4	2100.00	2100.00	12 months (academic year)	2025-08-25	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2253	45	501	1	1	807	5	1150.00	1150.00	15 months	2025-07-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
2254	45	C502	1	1	653	5	1150.00	1150.00	6 months	2025-07-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
2255	45	D503	0	1	423	5	800.00	800.00	9 months	2025-07-10	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
2256	45	504	1	1	846	5	1150.00	1150.00	6 months	2025-08-13	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	f
2257	45	#505	3	3	1502	5	2400.00	2400.00	6 months	2025-06-01	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
2258	45	G506	1	1	822	5	1350.00	1350.00	12 months	2025-06-07	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	f
2259	45	#507	0	1	530	5	950.00	950.00	15 months	2025-05-04	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
2260	45	#508	2	2	1175	5	1400.00	1400.00	12 months (academic year)	2025-07-24	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
2261	45	509	2	2	921	5	1450.00	1450.00	15 months	2025-05-14	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
2262	45	510	2	2	858	5	1450.00	1450.00	15 months	2025-08-04	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
2263	45	511	1	1	758	5	1350.00	1350.00	6 months	2025-05-22	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
2264	45	B601	2	2	1091	6	1650.00	1650.00	12 months (academic year)	2025-07-21	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
2265	46	B101	3	3	1404	1	2650.00	2650.00	15 months	2025-05-19	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
2266	46	#102	1	1	705	1	1250.00	1250.00	12 months	2025-08-24	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
2267	46	103	2	2	963	1	1950.00	1950.00	9 months	2025-07-29	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
2268	46	#104	2	2	1057	1	2150.00	2150.00	9 months	2025-07-06	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	f
2269	46	#105	0	1	498	1	900.00	900.00	15 months	2025-08-12	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2270	46	G106	3	3	1551	1	2300.00	2300.00	12 months (academic year)	2025-07-03	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
2271	46	#107	2	2	975	1	2100.00	2100.00	9 months	2025-05-19	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
2272	46	108	2	2	960	1	1750.00	1750.00	6 months	2025-07-18	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
2273	46	109	2	2	1023	1	1750.00	1750.00	12 months	2025-05-09	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
2274	46	#110	3	3	1401	1	2600.00	2600.00	9 months	2025-08-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	t
2275	46	#111	1	1	680	1	1200.00	1200.00	6 months	2025-06-06	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
2276	46	201	2	2	898	2	1550.00	1550.00	6 months	2025-06-02	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2277	46	C202	0	1	548	2	1150.00	1150.00	6 months	2025-05-07	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
2278	46	203	1	1	814	2	1200.00	1200.00	12 months (academic year)	2025-05-19	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
2279	46	204	2	2	1068	2	2100.00	2100.00	15 months	2025-06-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
2280	46	#205	0	1	491	2	900.00	900.00	12 months	2025-08-20	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, and WiFi included	\N	t
2281	46	#206	2	2	858	2	2100.00	2100.00	15 months	2025-06-17	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
2282	46	#207	3	3	1249	2	2050.00	2050.00	15 months	2025-05-29	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
2283	46	208	2	2	898	2	1650.00	1650.00	12 months (academic year)	2025-07-14	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
2284	46	209	2	2	894	2	1900.00	1900.00	12 months (academic year)	2025-08-19	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
2285	46	210	0	1	562	2	1100.00	1100.00	12 months (academic year)	2025-08-05	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
2286	46	#211	3	3	1420	2	2700.00	2700.00	15 months	2025-07-31	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
2287	46	#301	2	2	883	3	1450.00	1450.00	6 months	2025-08-22	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	f
2288	46	C302	1	1	747	3	1050.00	1050.00	9 months	2025-07-19	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
2289	46	#303	2	2	1004	3	1500.00	1500.00	12 months	2025-08-28	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
2290	46	E304	2	2	956	3	1450.00	1450.00	12 months (academic year)	2025-05-02	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
2291	46	F305	1	1	695	3	1150.00	1150.00	12 months (academic year)	2025-05-28	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
2292	46	306	1	1	671	3	1050.00	1050.00	9 months	2025-06-01	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
2293	46	307	2	2	965	3	1500.00	1500.00	6 months	2025-06-09	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
2294	46	308	2	2	1079	3	1600.00	1600.00	12 months	2025-06-27	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
2295	46	309	1	1	840	3	1000.00	1000.00	12 months (academic year)	2025-05-24	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	f
2296	46	#310	1	1	611	3	1300.00	1300.00	9 months	2025-06-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
2297	46	L311	1	1	709	3	1000.00	1000.00	6 months	2025-08-20	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
2298	46	B401	0	1	441	4	1050.00	1050.00	6 months	2025-08-04	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
2299	46	#402	0	1	519	4	1050.00	1050.00	6 months	2025-06-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
2300	46	D403	1	1	671	4	1350.00	1350.00	12 months (academic year)	2025-06-21	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
2301	46	404	1	1	614	4	1250.00	1250.00	9 months	2025-08-25	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
2302	46	F405	1	1	712	4	1000.00	1000.00	12 months	2025-07-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	f
2303	46	#406	1	1	770	4	1300.00	1300.00	6 months	2025-05-10	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	f
2304	46	H407	1	1	752	4	1050.00	1050.00	12 months (academic year)	2025-06-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
2305	46	408	1	1	667	4	1300.00	1300.00	15 months	2025-05-06	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2306	46	409	3	3	1256	4	2400.00	2400.00	15 months	2025-06-05	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
2307	46	410	1	1	688	4	1400.00	1400.00	12 months (academic year)	2025-08-08	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	f
2308	46	#411	1	1	789	4	1300.00	1300.00	12 months	2025-05-02	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
2309	46	B501	2	2	853	5	1450.00	1450.00	12 months	2025-05-16	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
2310	46	#502	3	3	1321	5	1950.00	1950.00	6 months	2025-08-01	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
2311	46	#503	0	1	414	5	800.00	800.00	12 months (academic year)	2025-05-20	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
2312	46	E504	3	3	1308	5	1900.00	1900.00	12 months (academic year)	2025-08-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	f
2313	46	505	1	1	797	5	1400.00	1400.00	12 months (academic year)	2025-06-30	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
2314	46	G506	1	1	739	5	1100.00	1100.00	15 months	2025-05-06	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
2315	46	H507	3	3	1509	5	1850.00	1850.00	15 months	2025-05-02	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
2316	46	I508	3	3	1482	5	1800.00	1800.00	15 months	2025-05-15	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
2317	46	509	3	3	1490	5	2450.00	2450.00	15 months	2025-05-20	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
2318	46	510	2	2	867	5	1550.00	1550.00	15 months	2025-06-20	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	f
2319	46	511	2	2	1074	5	1400.00	1400.00	12 months	2025-07-19	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
2320	46	601	2	2	909	6	1600.00	1600.00	12 months	2025-08-06	Carpeted Bedroom, Tile Living Area, Private Patio	Water and Trash included	\N	t
2321	46	#602	1	1	844	6	1050.00	1050.00	9 months	2025-06-01	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	f
2322	46	#603	0	1	573	6	800.00	800.00	9 months	2025-07-14	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
2323	46	#604	2	2	1007	6	2150.00	2150.00	6 months	2025-07-01	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
2324	47	101	0	1	502	1	1000.00	1000.00	12 months	2025-05-04	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
2325	47	#102	1	1	726	1	1050.00	1050.00	12 months (academic year)	2025-07-31	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	t
2326	47	#103	1	1	640	1	1150.00	1150.00	6 months	2025-06-14	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
2327	47	104	1	1	651	1	1250.00	1250.00	9 months	2025-05-21	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
2328	47	105	0	1	468	1	1050.00	1050.00	12 months (academic year)	2025-05-09	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
2329	47	#106	1	1	654	1	1250.00	1250.00	12 months (academic year)	2025-06-11	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2330	47	H107	2	2	979	1	1550.00	1550.00	12 months	2025-07-14	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	f
2331	47	#108	2	2	867	1	1850.00	1850.00	12 months	2025-08-21	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	f
2332	47	#109	1	1	835	1	1400.00	1400.00	15 months	2025-07-15	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
2333	47	#110	3	3	1592	1	2650.00	2650.00	12 months (academic year)	2025-05-18	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
2334	47	L111	2	2	1070	1	1700.00	1700.00	6 months	2025-06-11	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	t
2335	47	#201	1	1	614	2	1400.00	1400.00	9 months	2025-07-20	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
2336	47	#202	2	2	927	2	2050.00	2050.00	15 months	2025-08-04	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
2337	47	203	0	1	519	2	850.00	850.00	9 months	2025-05-22	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
2338	47	#204	1	1	844	2	1400.00	1400.00	15 months	2025-08-18	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
2339	47	205	3	3	1500	2	2000.00	2000.00	12 months (academic year)	2025-05-11	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
2340	47	G206	2	2	877	2	1400.00	1400.00	9 months	2025-06-07	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	f
2341	47	H207	2	2	1119	2	1600.00	1600.00	12 months (academic year)	2025-06-27	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
2342	47	#208	2	2	998	2	1850.00	1850.00	12 months (academic year)	2025-07-23	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
2343	47	209	3	3	1500	2	1800.00	1800.00	12 months (academic year)	2025-06-07	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
2344	47	#210	1	1	776	2	1250.00	1250.00	12 months (academic year)	2025-08-27	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
2345	47	#211	1	1	651	2	1350.00	1350.00	9 months	2025-05-21	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	f
2346	47	301	2	2	1142	3	1750.00	1750.00	9 months	2025-05-12	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
2347	47	#302	1	1	701	3	1050.00	1050.00	9 months	2025-06-23	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
2348	47	303	0	1	586	3	1150.00	1150.00	9 months	2025-08-12	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
2349	47	#304	1	1	582	3	1150.00	1150.00	12 months	2025-06-16	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
2350	47	305	2	2	904	3	1400.00	1400.00	9 months	2025-07-03	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
2351	47	G306	3	3	1393	3	2400.00	2400.00	12 months (academic year)	2025-05-29	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
2352	47	#307	0	1	424	3	1050.00	1050.00	12 months	2025-08-03	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	f
2353	47	308	2	2	1155	3	1700.00	1700.00	6 months	2025-07-28	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	f
2354	47	309	1	1	831	3	1050.00	1050.00	9 months	2025-06-23	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
2355	47	310	3	3	1423	3	1900.00	1900.00	12 months	2025-08-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
2356	47	L311	2	2	1197	3	2100.00	2100.00	9 months	2025-06-23	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
2357	47	B401	2	2	1197	4	1750.00	1750.00	15 months	2025-06-29	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2358	47	#402	1	1	732	4	1350.00	1350.00	15 months	2025-08-31	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, Sewer included	\N	t
2359	47	D403	3	3	1307	4	2450.00	2450.00	6 months	2025-05-17	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
2360	47	#404	1	1	687	4	1250.00	1250.00	9 months	2025-06-21	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
2361	47	#405	3	3	1275	4	2500.00	2500.00	12 months	2025-06-04	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
2362	47	406	0	1	492	4	900.00	900.00	15 months	2025-06-29	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
2363	47	#407	1	1	633	4	1100.00	1100.00	6 months	2025-08-21	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
2364	47	#408	2	2	1033	4	1900.00	1900.00	15 months	2025-08-14	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
2365	47	#409	2	2	1131	4	1450.00	1450.00	12 months	2025-07-13	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
2366	47	#410	2	2	928	4	1800.00	1800.00	9 months	2025-06-19	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2367	47	#411	3	3	1492	4	2350.00	2350.00	12 months	2025-07-04	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
2368	47	501	1	1	699	5	1250.00	1250.00	12 months (academic year)	2025-07-13	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
2369	47	#502	2	2	1132	5	1950.00	1950.00	6 months	2025-05-06	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
2370	48	B101	1	1	605	1	1050.00	1050.00	6 months	2025-08-04	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
2371	48	#102	1	1	809	1	1050.00	1050.00	6 months	2025-05-28	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	f
2372	48	D103	1	1	764	1	1150.00	1150.00	15 months	2025-07-31	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	f
2373	48	E104	1	1	569	1	1400.00	1400.00	12 months (academic year)	2025-08-28	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2374	48	105	2	2	1116	1	1550.00	1550.00	12 months (academic year)	2025-06-04	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
2375	48	G106	2	2	1180	1	1750.00	1750.00	9 months	2025-08-19	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
2376	48	H107	1	1	819	1	1150.00	1150.00	6 months	2025-06-04	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
2377	48	I108	1	1	569	1	1300.00	1300.00	9 months	2025-07-13	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
2378	48	#109	2	2	910	1	1500.00	1500.00	15 months	2025-06-05	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2379	48	110	0	1	420	1	1100.00	1100.00	9 months	2025-08-13	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	t
2380	48	201	0	1	479	2	1150.00	1150.00	6 months	2025-06-16	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
2381	48	#202	2	2	862	2	2150.00	2150.00	6 months	2025-06-04	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
2382	48	D203	2	2	1029	2	1700.00	1700.00	12 months	2025-06-24	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	f
2383	48	#204	1	1	777	2	1250.00	1250.00	12 months (academic year)	2025-07-19	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	f
2384	48	F205	3	3	1316	2	2200.00	2200.00	15 months	2025-08-30	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	f
2385	48	#206	0	1	438	2	1100.00	1100.00	15 months	2025-05-29	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	f
2386	48	207	3	3	1330	2	2300.00	2300.00	12 months (academic year)	2025-08-24	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
2387	48	208	1	1	565	2	1150.00	1150.00	9 months	2025-07-17	Carpeted Bedroom, Tile Living Area, Private Patio	Water, Trash, Sewer included	\N	t
2388	48	J209	0	1	565	2	950.00	950.00	12 months	2025-08-17	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
2389	48	K210	1	1	703	2	1000.00	1000.00	12 months (academic year)	2025-06-18	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	f
2390	48	B301	1	1	590	3	1150.00	1150.00	12 months (academic year)	2025-08-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
2391	48	C302	3	3	1507	3	1850.00	1850.00	12 months (academic year)	2025-05-18	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2392	48	D303	3	3	1239	3	2600.00	2600.00	9 months	2025-06-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
2393	48	E304	1	1	620	3	1200.00	1200.00	12 months (academic year)	2025-08-07	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2394	48	305	2	2	1011	3	1800.00	1800.00	12 months	2025-05-19	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
2395	48	G306	2	2	1024	3	1900.00	1900.00	12 months	2025-08-28	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2396	48	H307	2	2	897	3	1550.00	1550.00	6 months	2025-05-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, Sewer included	\N	t
2397	48	308	2	2	1129	3	1500.00	1500.00	12 months	2025-05-23	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
2398	48	#309	2	2	1151	3	1450.00	1450.00	12 months (academic year)	2025-05-31	Wood-Style Flooring, Updated Bathroom, Storage Space	Electric and Water included	\N	f
2399	48	#310	2	2	1119	3	1450.00	1450.00	9 months	2025-06-23	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
2400	48	#401	2	2	878	4	1550.00	1550.00	9 months	2025-08-19	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
2401	48	402	1	1	581	4	1050.00	1050.00	6 months	2025-07-18	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
2402	48	403	1	1	702	4	1400.00	1400.00	9 months	2025-08-01	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
2403	48	#404	0	1	513	4	850.00	850.00	12 months (academic year)	2025-07-12	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
2404	48	#405	3	3	1401	4	2400.00	2400.00	12 months (academic year)	2025-06-26	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
2405	48	406	1	1	696	4	1250.00	1250.00	12 months (academic year)	2025-07-10	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	t
2406	48	#407	0	1	424	4	1000.00	1000.00	12 months (academic year)	2025-05-22	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	f
2407	48	#408	3	3	1574	4	1850.00	1850.00	9 months	2025-08-16	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
2408	48	J409	3	3	1215	4	2050.00	2050.00	6 months	2025-05-31	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
2409	48	410	2	2	1024	4	1900.00	1900.00	9 months	2025-08-20	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
2410	48	501	2	2	870	5	2150.00	2150.00	15 months	2025-06-23	Renovated Kitchen, Large Closets, Private Balcony	Water, Trash, and WiFi included	\N	t
2411	49	101	2	2	1093	1	2150.00	2150.00	9 months	2025-08-03	Modern Fixtures, Large Windows, Breakfast Bar	All utilities included	\N	t
2412	49	C102	3	3	1504	1	2400.00	2400.00	15 months	2025-07-26	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
2413	49	#103	3	3	1206	1	2050.00	2050.00	9 months	2025-05-24	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
2414	49	104	1	1	557	1	1100.00	1100.00	6 months	2025-08-23	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
2415	49	105	2	2	1199	1	1950.00	1950.00	6 months	2025-07-27	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	t
2416	49	106	2	2	860	1	2050.00	2050.00	9 months	2025-06-25	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, Sewer included	\N	t
2417	49	201	3	3	1417	2	1850.00	1850.00	9 months	2025-05-10	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
2418	49	#202	2	2	1022	2	1400.00	1400.00	9 months	2025-08-28	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Electric and Water included	\N	f
2419	49	203	2	2	1059	2	1400.00	1400.00	9 months	2025-05-05	Walk-in Closet, In-Unit Washer/Dryer, Balcony	No utilities included	\N	t
2420	49	E204	1	1	658	2	1400.00	1400.00	9 months	2025-06-02	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	f
2421	49	205	2	2	954	2	2150.00	2150.00	9 months	2025-08-20	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	f
2422	49	G206	0	1	564	2	1000.00	1000.00	12 months (academic year)	2025-05-06	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
2423	49	#301	0	1	561	3	950.00	950.00	9 months	2025-05-03	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
2424	49	302	3	3	1398	3	2150.00	2150.00	12 months	2025-05-24	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, and WiFi included	\N	t
2425	49	303	2	2	1195	3	2050.00	2050.00	12 months (academic year)	2025-07-27	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
2426	49	304	0	1	469	3	1050.00	1050.00	15 months	2025-05-07	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	t
2427	49	#305	3	3	1433	3	2700.00	2700.00	15 months	2025-07-22	Hardwood Floors, Granite Countertops, Stainless Appliances	No utilities included	\N	t
2428	49	G306	2	2	975	3	1900.00	1900.00	15 months	2025-07-27	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
2429	49	B401	3	3	1414	4	1850.00	1850.00	15 months	2025-06-13	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
2430	49	C402	2	2	978	4	2100.00	2100.00	9 months	2025-07-02	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
2431	49	#403	3	3	1348	4	2250.00	2250.00	15 months	2025-08-22	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2432	49	#404	1	1	712	4	1050.00	1050.00	12 months	2025-08-01	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
2433	49	F405	1	1	705	4	1450.00	1450.00	6 months	2025-05-09	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
2434	49	#406	1	1	831	4	1050.00	1050.00	12 months	2025-05-25	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water, Trash, Sewer included	\N	f
2435	49	501	0	1	496	5	1050.00	1050.00	15 months	2025-05-16	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
2436	49	C502	1	1	626	5	1450.00	1450.00	6 months	2025-06-18	Updated Kitchen, Spacious Closets, Ceiling Fans	Water, Trash, and WiFi included	\N	t
2437	49	D503	1	1	607	5	1150.00	1150.00	12 months	2025-05-22	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	f
2438	49	#504	2	2	973	5	2050.00	2050.00	9 months	2025-07-31	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Trash and Sewer included	\N	t
2439	49	F505	0	1	541	5	1000.00	1000.00	12 months (academic year)	2025-08-31	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	t
2440	49	506	1	1	561	5	1300.00	1300.00	12 months	2025-05-11	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	f
2441	49	#601	1	1	810	6	1200.00	1200.00	9 months	2025-08-20	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	t
2442	49	C602	1	1	589	6	1300.00	1300.00	6 months	2025-07-27	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
2443	49	D603	1	1	689	6	1450.00	1450.00	9 months	2025-05-15	Renovated Kitchen, Large Closets, Private Balcony	All utilities included	\N	t
2444	49	#604	1	1	704	6	1150.00	1150.00	6 months	2025-08-20	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
2445	49	#605	1	1	743	6	1200.00	1200.00	6 months	2025-07-01	High Ceilings, Open Floor Plan, Kitchen Island	All utilities included	\N	t
2446	49	606	2	2	1145	6	2050.00	2050.00	12 months	2025-06-21	High Ceilings, Open Floor Plan, Kitchen Island	Water, Trash, and WiFi included	\N	t
2447	49	B701	1	1	553	7	1450.00	1450.00	12 months (academic year)	2025-08-03	High Ceilings, Open Floor Plan, Kitchen Island	Trash and Sewer included	\N	t
2448	49	C702	2	2	896	7	1750.00	1750.00	15 months	2025-07-17	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, Sewer included	\N	t
2449	49	#703	2	2	947	7	2150.00	2150.00	15 months	2025-07-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Water and Trash included	\N	t
2450	49	704	2	2	1014	7	1900.00	1900.00	6 months	2025-07-22	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	t
2451	49	#705	0	1	589	7	1050.00	1050.00	6 months	2025-05-16	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
2452	50	B101	2	2	1172	1	1450.00	1450.00	9 months	2025-07-01	Wood-Style Flooring, Updated Bathroom, Storage Space	Water and Trash included	\N	t
2453	50	C102	3	3	1207	1	1850.00	1850.00	12 months	2025-06-17	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2454	50	103	2	2	936	1	1500.00	1500.00	6 months	2025-08-24	Wood-Style Flooring, Updated Bathroom, Storage Space	Trash and Sewer included	\N	t
2455	50	104	1	1	679	1	1000.00	1000.00	9 months	2025-06-24	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, Sewer included	\N	t
2456	50	F105	2	2	1016	1	1750.00	1750.00	9 months	2025-05-26	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2457	50	106	2	2	904	1	1450.00	1450.00	12 months (academic year)	2025-07-28	High Ceilings, Open Floor Plan, Kitchen Island	Water and Trash included	\N	f
2458	50	107	3	3	1270	1	2750.00	2750.00	15 months	2025-06-25	Updated Kitchen, Spacious Closets, Ceiling Fans	Electric and Water included	\N	f
2459	50	#201	1	1	764	2	1400.00	1400.00	15 months	2025-06-07	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2460	50	C202	1	1	697	2	1350.00	1350.00	12 months (academic year)	2025-06-13	Updated Kitchen, Spacious Closets, Ceiling Fans	Trash and Sewer included	\N	t
2461	50	D203	2	2	868	2	1650.00	1650.00	12 months	2025-06-16	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	f
2462	50	E204	1	1	703	2	1450.00	1450.00	6 months	2025-05-28	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
2463	50	205	1	1	577	2	1300.00	1300.00	12 months	2025-06-02	Walk-in Closet, In-Unit Washer/Dryer, Balcony	Water and Trash included	\N	t
2464	50	#206	2	2	1194	2	1950.00	1950.00	9 months	2025-06-05	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	t
2465	50	207	1	1	675	2	1300.00	1300.00	9 months	2025-07-31	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
2466	50	#301	2	2	1175	3	2150.00	2150.00	9 months	2025-06-05	Wood-Style Flooring, Updated Bathroom, Storage Space	No utilities included	\N	f
2467	50	#302	0	1	549	3	1000.00	1000.00	6 months	2025-06-03	Wood-Style Flooring, Updated Bathroom, Storage Space	Water, Trash, and WiFi included	\N	t
2468	50	D303	2	2	1169	3	1700.00	1700.00	6 months	2025-07-19	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
2469	50	304	2	2	866	3	1700.00	1700.00	6 months	2025-07-12	Hardwood Floors, Granite Countertops, Stainless Appliances	Water, Trash, and WiFi included	\N	t
2470	50	F305	3	3	1320	3	2000.00	2000.00	15 months	2025-08-29	Renovated Kitchen, Large Closets, Private Balcony	Electric and Water included	\N	t
2471	50	306	3	3	1585	3	1900.00	1900.00	15 months	2025-05-25	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, Sewer included	\N	t
2472	50	H307	2	2	1086	3	2150.00	2150.00	6 months	2025-07-07	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	f
2473	50	401	1	1	733	4	1150.00	1150.00	9 months	2025-06-25	Wood-Style Flooring, Updated Bathroom, Storage Space	All utilities included	\N	f
2474	50	C402	3	3	1580	4	2200.00	2200.00	9 months	2025-07-02	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	t
2475	50	403	1	1	797	4	1050.00	1050.00	9 months	2025-07-09	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
2476	50	#404	2	2	1140	4	1600.00	1600.00	12 months	2025-07-13	Carpeted Bedroom, Tile Living Area, Private Patio	Trash and Sewer included	\N	t
2477	50	405	1	1	838	4	1200.00	1200.00	12 months (academic year)	2025-08-22	Modern Fixtures, Large Windows, Breakfast Bar	Water and Trash included	\N	f
2478	50	G406	0	1	478	4	850.00	850.00	9 months	2025-05-02	Carpeted Bedroom, Tile Living Area, Private Patio	Electric and Water included	\N	f
2479	50	407	1	1	591	4	1000.00	1000.00	6 months	2025-08-08	Carpeted Bedroom, Tile Living Area, Private Patio	No utilities included	\N	t
2480	50	501	3	3	1570	5	2100.00	2100.00	12 months (academic year)	2025-06-25	Renovated Kitchen, Large Closets, Private Balcony	Trash and Sewer included	\N	f
2481	50	C502	0	1	589	5	1000.00	1000.00	12 months	2025-07-16	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2482	50	D503	3	3	1258	5	2500.00	2500.00	6 months	2025-08-04	High Ceilings, Open Floor Plan, Kitchen Island	Electric and Water included	\N	t
2483	50	504	3	3	1590	5	2100.00	2100.00	9 months	2025-05-01	Hardwood Floors, Granite Countertops, Stainless Appliances	Electric and Water included	\N	t
2484	50	#505	2	2	1090	5	1450.00	1450.00	6 months	2025-06-09	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
2485	50	G506	0	1	556	5	1150.00	1150.00	12 months	2025-07-28	Updated Kitchen, Spacious Closets, Ceiling Fans	No utilities included	\N	t
2486	50	507	2	2	1146	5	1850.00	1850.00	6 months	2025-07-28	Walk-in Closet, In-Unit Washer/Dryer, Balcony	All utilities included	\N	t
2487	50	601	3	3	1412	6	2150.00	2150.00	15 months	2025-07-03	Modern Fixtures, Large Windows, Breakfast Bar	Water, Trash, and WiFi included	\N	f
2488	50	602	2	2	1194	6	1850.00	1850.00	12 months (academic year)	2025-08-24	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
2489	50	#603	2	2	1071	6	1950.00	1950.00	15 months	2025-08-07	Updated Kitchen, Spacious Closets, Ceiling Fans	All utilities included	\N	t
2490	50	604	1	1	583	6	1200.00	1200.00	12 months (academic year)	2025-08-01	High Ceilings, Open Floor Plan, Kitchen Island	No utilities included	\N	t
2491	50	F605	1	1	803	6	1250.00	1250.00	15 months	2025-08-22	Renovated Kitchen, Large Closets, Private Balcony	No utilities included	\N	t
2492	50	606	2	2	1183	6	1400.00	1400.00	12 months	2025-06-27	Carpeted Bedroom, Tile Living Area, Private Patio	All utilities included	\N	t
2493	50	#607	2	2	885	6	1400.00	1400.00	15 months	2025-06-27	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
2494	50	#701	1	1	619	7	1200.00	1200.00	15 months	2025-05-21	Modern Fixtures, Large Windows, Breakfast Bar	Electric and Water included	\N	t
2495	50	702	1	1	793	7	1000.00	1000.00	12 months	2025-09-01	Hardwood Floors, Granite Countertops, Stainless Appliances	Trash and Sewer included	\N	t
2496	50	#703	1	1	760	7	1050.00	1050.00	12 months	2025-05-13	Hardwood Floors, Granite Countertops, Stainless Appliances	All utilities included	\N	t
2497	50	E704	1	1	769	7	1450.00	1450.00	12 months	2025-06-21	Modern Fixtures, Large Windows, Breakfast Bar	No utilities included	\N	f
2498	50	#705	0	1	541	7	1000.00	1000.00	6 months	2025-08-15	Updated Kitchen, Spacious Closets, Ceiling Fans	Water and Trash included	\N	f
2499	50	#706	1	1	758	7	1050.00	1050.00	6 months	2025-06-17	Modern Fixtures, Large Windows, Breakfast Bar	Trash and Sewer included	\N	t
2500	50	#707	0	1	526	7	1000.00	1000.00	6 months	2025-08-02	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	t
2501	50	#801	0	1	544	8	850.00	850.00	6 months	2025-07-25	Renovated Kitchen, Large Closets, Private Balcony	Water and Trash included	\N	f
\.


--
-- Data for Name: favorite; Type: TABLE DATA; Schema: public; Owner: drish
--

COPY public.favorite (favoriteid, studentid, unitid, datesaved) FROM stdin;
1	14	157	2025-10-18 16:00:02.943455
2	14	352	2025-11-05 16:00:02.943513
3	14	355	2025-09-24 16:00:02.943518
4	102	117	2025-11-02 16:00:02.943532
5	102	28	2025-09-17 16:00:02.943536
6	102	460	2025-09-25 16:00:02.943539
7	401	111	2025-11-07 16:00:02.943556
8	401	396	2025-09-15 16:00:02.943559
9	401	456	2025-10-24 16:00:02.943562
10	401	410	2025-09-14 16:00:02.943565
11	401	514	2025-10-19 16:00:02.943568
12	401	637	2025-09-12 16:00:02.943571
13	401	651	2025-09-24 16:00:02.943573
14	415	223	2025-10-21 16:00:02.943584
15	415	106	2025-10-11 16:00:02.943587
16	415	299	2025-11-05 16:00:02.94359
17	415	621	2025-10-31 16:00:02.943592
18	415	442	2025-10-02 16:00:02.943595
19	229	261	2025-10-15 16:00:02.943605
20	229	80	2025-10-26 16:00:02.943608
21	229	388	2025-09-23 16:00:02.943611
22	229	458	2025-09-22 16:00:02.943614
23	229	386	2025-09-29 16:00:02.943616
24	325	25	2025-09-18 16:00:02.943626
25	325	446	2025-11-05 16:00:02.943629
26	325	117	2025-09-11 16:00:02.943632
27	325	456	2025-09-22 16:00:02.943635
28	325	585	2025-10-12 16:00:02.943637
29	21	390	2025-10-09 16:00:02.943645
30	21	551	2025-10-25 16:00:02.943648
31	21	54	2025-09-14 16:00:02.943651
32	363	213	2025-10-10 16:00:02.943662
33	363	476	2025-10-17 16:00:02.943665
34	363	618	2025-10-31 16:00:02.943668
35	363	318	2025-10-28 16:00:02.943671
36	363	448	2025-10-30 16:00:02.943673
37	363	380	2025-10-18 16:00:02.943676
38	363	641	2025-09-30 16:00:02.943679
39	99	599	2025-10-30 16:00:02.943687
40	99	280	2025-10-25 16:00:02.94369
41	99	127	2025-10-30 16:00:02.943692
42	169	623	2025-10-11 16:00:02.943702
43	169	458	2025-09-18 16:00:02.943704
44	169	97	2025-10-14 16:00:02.943707
45	169	482	2025-09-20 16:00:02.94371
46	169	407	2025-10-16 16:00:02.943713
47	300	632	2025-09-21 16:00:02.943725
48	300	145	2025-09-29 16:00:02.943728
49	300	84	2025-10-20 16:00:02.943731
50	300	110	2025-09-17 16:00:02.943733
51	300	66	2025-11-03 16:00:02.943736
52	300	603	2025-10-15 16:00:02.943739
53	300	161	2025-10-25 16:00:02.943745
54	300	501	2025-09-11 16:00:02.943748
55	344	167	2025-10-14 16:00:02.943758
56	344	108	2025-10-09 16:00:02.943761
57	344	442	2025-10-17 16:00:02.943764
58	344	36	2025-11-01 16:00:02.943767
59	344	325	2025-11-06 16:00:02.94377
60	344	607	2025-11-07 16:00:02.943772
61	54	480	2025-10-29 16:00:02.943781
62	54	155	2025-11-01 16:00:02.943784
63	54	446	2025-10-04 16:00:02.943787
64	54	203	2025-10-15 16:00:02.943789
65	54	242	2025-09-17 16:00:02.943792
66	339	76	2025-09-29 16:00:02.943803
67	339	600	2025-09-20 16:00:02.943805
68	339	62	2025-10-31 16:00:02.943808
69	339	48	2025-09-09 16:00:02.943811
70	339	359	2025-10-10 16:00:02.943813
71	339	244	2025-09-22 16:00:02.943816
72	156	343	2025-10-29 16:00:02.943826
73	156	115	2025-10-23 16:00:02.943829
74	156	345	2025-09-12 16:00:02.943831
75	156	553	2025-10-07 16:00:02.943834
76	156	389	2025-10-19 16:00:02.943836
77	156	353	2025-09-16 16:00:02.943839
78	104	419	2025-09-27 16:00:02.94385
79	104	151	2025-09-11 16:00:02.943853
80	104	434	2025-10-06 16:00:02.943856
81	104	314	2025-11-05 16:00:02.943858
82	104	239	2025-09-26 16:00:02.943861
83	104	438	2025-11-03 16:00:02.943864
84	104	147	2025-09-30 16:00:02.943866
85	75	326	2025-11-05 16:00:02.943878
86	75	402	2025-10-14 16:00:02.943881
87	75	507	2025-10-22 16:00:02.943884
88	75	278	2025-10-17 16:00:02.943886
89	75	591	2025-09-27 16:00:02.943889
90	75	324	2025-10-14 16:00:02.943891
91	268	512	2025-09-25 16:00:02.9439
92	268	487	2025-10-22 16:00:02.943902
93	268	28	2025-09-29 16:00:02.943904
94	268	150	2025-09-24 16:00:02.943907
95	268	271	2025-09-14 16:00:02.943908
96	268	452	2025-10-24 16:00:02.94391
97	268	377	2025-11-03 16:00:02.943911
98	301	313	2025-11-07 16:00:02.943917
99	301	626	2025-10-06 16:00:02.943918
100	301	275	2025-09-11 16:00:02.943919
101	301	600	2025-10-19 16:00:02.943921
102	301	322	2025-10-20 16:00:02.943922
103	276	25	2025-10-04 16:00:02.943928
104	276	36	2025-10-16 16:00:02.943929
105	276	528	2025-10-26 16:00:02.94393
106	276	410	2025-09-15 16:00:02.943932
107	276	260	2025-11-06 16:00:02.943933
108	276	639	2025-09-13 16:00:02.943934
109	276	299	2025-10-10 16:00:02.943935
110	349	506	2025-09-09 16:00:02.94394
111	349	648	2025-10-01 16:00:02.943941
112	349	491	2025-10-26 16:00:02.943943
113	349	165	2025-09-30 16:00:02.943944
114	329	429	2025-10-15 16:00:02.943949
115	329	379	2025-09-30 16:00:02.94395
116	329	185	2025-10-09 16:00:02.943952
117	329	321	2025-09-25 16:00:02.943953
118	329	290	2025-10-01 16:00:02.943954
119	329	589	2025-10-24 16:00:02.943956
120	308	175	2025-10-14 16:00:02.943959
121	308	446	2025-10-01 16:00:02.943961
122	308	184	2025-10-15 16:00:02.943962
123	230	533	2025-09-13 16:00:02.943966
124	230	517	2025-10-13 16:00:02.943968
125	230	582	2025-10-03 16:00:02.943969
126	230	508	2025-09-24 16:00:02.94397
127	230	302	2025-10-01 16:00:02.943972
128	488	287	2025-10-17 16:00:02.943976
129	488	576	2025-11-05 16:00:02.943977
130	488	210	2025-09-11 16:00:02.943979
131	488	622	2025-10-03 16:00:02.94398
132	37	519	2025-10-21 16:00:02.943985
133	37	605	2025-11-05 16:00:02.943986
134	37	577	2025-10-20 16:00:02.943987
135	37	283	2025-10-08 16:00:02.943988
136	37	275	2025-11-06 16:00:02.94399
137	345	109	2025-10-27 16:00:02.943996
138	345	533	2025-10-14 16:00:02.943997
139	345	624	2025-10-19 16:00:02.943998
140	345	11	2025-10-22 16:00:02.944
141	345	630	2025-09-11 16:00:02.944001
142	345	204	2025-10-02 16:00:02.944002
143	439	262	2025-11-03 16:00:02.944006
144	439	11	2025-10-20 16:00:02.944007
145	439	635	2025-10-08 16:00:02.944008
146	175	436	2025-10-31 16:00:02.944014
147	175	445	2025-09-20 16:00:02.944015
148	175	474	2025-09-20 16:00:02.944016
149	175	294	2025-10-25 16:00:02.944017
150	175	126	2025-09-27 16:00:02.944019
151	175	638	2025-10-23 16:00:02.944021
152	175	12	2025-09-27 16:00:02.944022
153	5	607	2025-09-26 16:00:02.944027
154	5	310	2025-09-16 16:00:02.944028
155	5	70	2025-10-07 16:00:02.944029
156	5	262	2025-09-25 16:00:02.944031
157	5	529	2025-09-27 16:00:02.944032
158	5	363	2025-10-25 16:00:02.944033
159	125	59	2025-10-11 16:00:02.944037
160	125	235	2025-10-12 16:00:02.944039
161	125	198	2025-10-20 16:00:02.94404
162	125	538	2025-09-29 16:00:02.944041
163	186	352	2025-10-06 16:00:02.944046
164	186	505	2025-10-04 16:00:02.944047
165	186	147	2025-10-28 16:00:02.944048
166	186	569	2025-10-15 16:00:02.94405
167	186	650	2025-10-11 16:00:02.944051
168	287	569	2025-09-09 16:00:02.944055
169	287	80	2025-10-21 16:00:02.944057
170	287	275	2025-09-16 16:00:02.944058
171	287	108	2025-10-10 16:00:02.944059
172	287	44	2025-11-05 16:00:02.94406
173	380	653	2025-09-28 16:00:02.944066
174	380	23	2025-10-31 16:00:02.944067
175	380	55	2025-09-14 16:00:02.944069
176	380	534	2025-10-27 16:00:02.94407
177	380	442	2025-11-06 16:00:02.944071
178	380	349	2025-09-20 16:00:02.944073
179	380	44	2025-10-16 16:00:02.944074
180	127	407	2025-10-18 16:00:02.944078
181	127	539	2025-09-21 16:00:02.94408
182	127	465	2025-10-22 16:00:02.944081
183	127	336	2025-10-21 16:00:02.944082
184	127	566	2025-10-31 16:00:02.944084
185	454	627	2025-10-19 16:00:02.944089
186	454	366	2025-09-18 16:00:02.94409
187	454	429	2025-10-28 16:00:02.944091
188	454	378	2025-10-07 16:00:02.944093
189	454	256	2025-09-11 16:00:02.944094
190	454	430	2025-10-26 16:00:02.944095
191	454	380	2025-09-14 16:00:02.944097
192	79	423	2025-09-15 16:00:02.9441
193	79	300	2025-11-05 16:00:02.944102
194	79	480	2025-10-09 16:00:02.944103
195	79	459	2025-10-05 16:00:02.944104
196	283	359	2025-09-29 16:00:02.944109
197	283	96	2025-09-15 16:00:02.944111
198	283	77	2025-09-30 16:00:02.944112
199	283	313	2025-10-19 16:00:02.944113
200	283	449	2025-09-29 16:00:02.944115
201	283	23	2025-09-22 16:00:02.944116
202	283	397	2025-10-23 16:00:02.944118
203	259	262	2025-09-23 16:00:02.944123
204	259	611	2025-11-01 16:00:02.944124
205	259	375	2025-11-04 16:00:02.944125
206	259	483	2025-10-21 16:00:02.944127
207	259	127	2025-09-30 16:00:02.944128
208	259	10	2025-09-23 16:00:02.944129
209	471	230	2025-11-03 16:00:02.944134
210	471	271	2025-10-17 16:00:02.944135
211	471	322	2025-11-07 16:00:02.944137
212	471	79	2025-10-01 16:00:02.944138
213	471	623	2025-11-06 16:00:02.944139
214	334	426	2025-10-21 16:00:02.944145
215	334	432	2025-10-24 16:00:02.944146
216	334	191	2025-09-18 16:00:02.944148
217	334	127	2025-10-10 16:00:02.944149
218	334	435	2025-10-16 16:00:02.94415
219	334	501	2025-10-13 16:00:02.944151
220	334	234	2025-10-19 16:00:02.944153
221	334	458	2025-10-15 16:00:02.944154
222	369	166	2025-10-15 16:00:02.944159
223	369	428	2025-10-03 16:00:02.94416
224	369	464	2025-10-19 16:00:02.944162
225	369	237	2025-09-13 16:00:02.944163
226	369	9	2025-10-19 16:00:02.944164
227	369	293	2025-10-14 16:00:02.944166
228	221	169	2025-10-07 16:00:02.944169
229	221	229	2025-09-18 16:00:02.944171
230	221	526	2025-09-30 16:00:02.944172
231	258	108	2025-09-30 16:00:02.944176
232	258	514	2025-11-06 16:00:02.944178
233	258	102	2025-11-02 16:00:02.944179
234	258	294	2025-10-21 16:00:02.944181
235	258	488	2025-10-10 16:00:02.944182
236	420	394	2025-10-26 16:00:02.944186
237	420	184	2025-09-30 16:00:02.944187
238	420	263	2025-09-20 16:00:02.944189
239	217	556	2025-11-05 16:00:02.944194
240	217	390	2025-10-03 16:00:02.944196
241	217	520	2025-10-23 16:00:02.944197
242	140	566	2025-10-02 16:00:02.944203
243	140	354	2025-09-29 16:00:02.944204
244	140	246	2025-09-27 16:00:02.944206
245	140	420	2025-10-31 16:00:02.944207
246	140	87	2025-10-05 16:00:02.944208
247	140	609	2025-09-20 16:00:02.94421
248	140	648	2025-11-05 16:00:02.944211
249	140	597	2025-10-21 16:00:02.944212
250	106	559	2025-10-08 16:00:02.944216
251	106	151	2025-10-15 16:00:02.944218
252	106	143	2025-11-01 16:00:02.944219
253	164	2	2025-11-01 16:00:02.944224
254	164	432	2025-09-26 16:00:02.944225
255	164	139	2025-09-09 16:00:02.944227
256	164	204	2025-11-01 16:00:02.944228
257	164	520	2025-10-23 16:00:02.944229
258	164	547	2025-10-14 16:00:02.944231
259	164	313	2025-10-02 16:00:02.944232
260	194	553	2025-09-28 16:00:02.944236
261	194	36	2025-09-15 16:00:02.944238
262	194	505	2025-10-26 16:00:02.944239
263	194	447	2025-10-17 16:00:02.94424
264	194	382	2025-10-22 16:00:02.944242
265	426	250	2025-10-04 16:00:02.944247
266	426	442	2025-09-16 16:00:02.944249
267	426	459	2025-09-19 16:00:02.94425
268	426	452	2025-10-27 16:00:02.944252
269	135	638	2025-10-27 16:00:02.944256
270	135	353	2025-09-18 16:00:02.944258
271	135	211	2025-10-15 16:00:02.944259
272	135	267	2025-10-29 16:00:02.94426
273	135	95	2025-10-04 16:00:02.944262
274	328	151	2025-09-14 16:00:02.944266
275	328	626	2025-10-13 16:00:02.944267
276	328	334	2025-11-05 16:00:02.944268
277	328	342	2025-11-05 16:00:02.94427
278	163	426	2025-10-03 16:00:02.944274
279	163	292	2025-11-05 16:00:02.944275
280	163	308	2025-10-05 16:00:02.944276
281	163	176	2025-10-11 16:00:02.944278
282	397	72	2025-09-23 16:00:02.944282
283	397	428	2025-10-05 16:00:02.944283
284	397	204	2025-09-13 16:00:02.944285
285	397	91	2025-10-06 16:00:02.944286
286	397	426	2025-10-27 16:00:02.944288
287	223	293	2025-11-02 16:00:02.944291
288	223	478	2025-09-24 16:00:02.944293
289	223	84	2025-09-21 16:00:02.944294
290	347	375	2025-11-04 16:00:02.944299
291	347	139	2025-10-03 16:00:02.944301
292	347	2	2025-10-26 16:00:02.944302
293	347	329	2025-09-16 16:00:02.944303
294	347	576	2025-09-23 16:00:02.944304
295	347	468	2025-11-07 16:00:02.944306
296	313	253	2025-09-20 16:00:02.944311
297	313	178	2025-11-05 16:00:02.944312
298	313	460	2025-10-11 16:00:02.944313
299	313	495	2025-09-16 16:00:02.944315
300	313	81	2025-09-17 16:00:02.944316
307	507	1318	2025-12-01 22:18:22.716581
308	507	1411	2025-12-01 22:18:31.826148
\.


--
-- Data for Name: property; Type: TABLE DATA; Schema: public; Owner: drish
--

COPY public.property (propertyid, managerid, propertyname, streetaddress, city, state, zipcode, distancefromcampus, propertytype, availableunits, buildingamenities, petpolicy, description, propertyimageurl) FROM stdin;
1	1	Mill Avenue Lofts	234 E Mill Avenue	Tempe	AZ	85281	0.30	Student Housing	{"1b1b": 15, "2b2b": 20, "3b3b": 8, "studio": 5}	Pool, Fitness Center, Rooftop Lounge, Study Rooms, BBQ Area	Cats allowed with $300 deposit	Modern lofts in the heart of downtown Tempe. Walk to campus, restaurants, and nightlife.	\N
2	1	Apache Commons	567 S Apache Boulevard	Tempe	AZ	85281	0.50	Apartment Complex	{"1b1b": 18, "2b2b": 15, "3b3b": 10, "studio": 8}	Pool, Gym, Clubhouse, Business Center, Covered Parking	Small dogs under 25lbs allowed	Spacious apartments with walk-in closets. Free parking and internet included.	\N
3	1	University Heights	890 E University Drive	Tempe	AZ	85281	0.40	Student Housing	{"1b1b": 20, "2b2b": 22, "3b3b": 5, "studio": 3}	Resort-Style Pool, Hot Tub, Game Room, Coffee Bar, Bike Storage	No pets allowed	Steps from ASU campus. Fully furnished options available with all utilities included.	\N
4	1	Forest Avenue Apartments	123 N Forest Avenue	Tempe	AZ	85281	0.60	Apartment Complex	{"1b1b": 15, "2b2b": 25, "3b3b": 10}	Pool, Fitness Center, Laundry Facilities, Courtyard	Pets allowed with deposit	Quiet residential area close to campus. Great for students who prefer peaceful living.	\N
5	1	College Square	456 E College Avenue	Tempe	AZ	85281	0.40	Student Housing	{"1b1b": 20, "2b2b": 15, "3b3b": 5, "studio": 10}	Pool, Study Lounge, Free Printing, Yoga Studio, Sauna	Cats only, $250 deposit	All-inclusive living with utilities, WiFi, and cable included in rent.	\N
6	2	Sky Tower Residences	789 S Mill Avenue	Tempe	AZ	85281	0.50	Apartment Complex	{"1b1b": 25, "2b2b": 18, "3b3b": 8, "studio": 12}	Rooftop Pool, Sky Lounge, Concierge, Valet Parking, Theater Room	Pets allowed, $400 deposit	Luxury high-rise with panoramic views. 24/7 security and concierge services.	\N
7	2	Sunset View Apartments	234 W University Drive	Tempe	AZ	85281	0.70	Apartment Complex	{"1b1b": 20, "2b2b": 25, "3b3b": 12}	Pool, Fitness Center, BBQ Area, Playground, Dog Park	Pet-friendly, all sizes welcome	Stunning sunset views from every unit. Pet-friendly community with dog park.	\N
8	2	Broadway Heights	567 W Broadway Road	Tempe	AZ	85282	1.20	Apartment Complex	{"1b1b": 18, "2b2b": 20, "3b3b": 15, "studio": 5}	Pool, Clubhouse, Tennis Courts, Basketball Court	Small pets allowed	Affordable rates with spacious layouts. Close to shopping and dining.	\N
9	2	Terrace Gardens	890 S Rural Road	Tempe	AZ	85281	0.80	Apartment Complex	{"1b1b": 15, "2b2b": 30, "3b3b": 10}	Pool, Spa, Garden Courtyards, BBQ Area, Fitness Center	No pets allowed	Beautifully landscaped grounds with garden-style apartments.	\N
10	2	Rio Vista Lofts	123 E Rio Salado Parkway	Tempe	AZ	85281	1.50	Townhomes	{"2b2b": 20, "3b3b": 25}	Community Pool, Playground, Walking Trails, Two-Car Garages	Pets allowed with restrictions	Townhomes with private garages near Tempe Town Lake. Perfect for roommates.	\N
11	3	Stadium Village	456 E Veterans Way	Tempe	AZ	85287	0.20	Student Housing	{"1b1b": 25, "2b2b": 15, "3b3b": 5, "studio": 15}	Pool, Game Room, Study Center, Free Printing, Coffee Station	No pets allowed	Steps from Sun Devil Stadium. Perfect for sports fans and tailgating enthusiasts.	\N
12	3	Maple Terrace	789 S Maple Avenue	Tempe	AZ	85281	0.90	Apartment Complex	{"1b1b": 20, "2b2b": 22, "3b3b": 8}	Pool, Fitness Center, Clubhouse, Gated Community	Cats allowed only	Safe gated community with excellent security features.	\N
13	3	Palm Walk Apartments	234 N Palm Walk	Tempe	AZ	85281	0.30	Student Housing	{"1b1b": 22, "2b2b": 18, "3b3b": 2, "studio": 8}	Pool, Hot Tub, Fitness Center, Study Rooms, Bike Racks	No pets allowed	Named after ASU famous Palm Walk. Literally on campus doorstep.	\N
14	3	Ash Avenue Living	567 S Ash Avenue	Tempe	AZ	85281	0.70	Apartment Complex	{"1b1b": 18, "2b2b": 25, "3b3b": 10}	Pool, BBQ Area, Covered Parking, Laundry Facilities	Small dogs allowed	Affordable student living with flexible lease terms and roommate matching.	\N
15	3	Packard Drive Suites	890 N Packard Drive	Tempe	AZ	85281	1.00	Apartment Complex	{"1b1b": 15, "2b2b": 20, "3b3b": 15, "studio": 10}	Pool, Fitness Center, Computer Lab, Free WiFi	Pets allowed with deposit	All-inclusive utilities. Perfect for international and out-of-state students.	\N
16	4	Cactus Garden Villas	123 E Alameda Drive	Tempe	AZ	85282	1.80	Apartment Complex	{"1b1b": 25, "2b2b": 30, "3b3b": 15}	Resort Pool, Hot Tub, Tennis Courts, Sand Volleyball, Putting Green	Pet-friendly community	Resort-style living with desert landscaping. Quiet location away from campus bustle.	\N
17	4	Mirage Apartments	456 S McClintock Drive	Tempe	AZ	85281	1.50	Apartment Complex	{"1b1b": 20, "2b2b": 18, "3b3b": 10, "studio": 12}	Pool, Spa, Fitness Center, Business Center, Coffee Bar	Cats and small dogs allowed	Modern amenities with smart home features in select units.	\N
18	4	Saguaro Springs	789 E Southern Avenue	Tempe	AZ	85282	2.00	Apartment Complex	{"1b1b": 15, "2b2b": 28, "3b3b": 20}	Two Pools, Fitness Center, Clubhouse, Playground, BBQ Areas	All pets welcome	Spacious floor plans with updated kitchens and large balconies.	\N
19	4	Sonoran Place	234 N Scottsdale Road	Tempe	AZ	85281	2.50	Apartment Complex	{"1b1b": 18, "2b2b": 22, "3b3b": 12, "studio": 8}	Pool, Gym, Yoga Studio, Meditation Garden	Pets allowed with restrictions	Wellness-focused community with yoga classes and walking trails.	\N
20	4	Desert Breeze Lofts	567 W Baseline Road	Tempe	AZ	85283	2.20	Apartment Complex	{"1b1b": 20, "2b2b": 25, "3b3b": 5, "studio": 10}	Pool, Fitness Center, Dog Park, Car Wash Station	Pet-friendly, no weight limit	Loft-style apartments with high ceilings and modern finishes.	\N
21	5	Elm Street Studios	890 N Elm Street	Tempe	AZ	85281	0.50	Student Housing	{"1b1b": 15, "2b2b": 10, "studio": 25}	Study Lounge, Free Printing, Bike Storage, Coffee Bar	No pets allowed	Affordable studios perfect for solo students. Utilities included in rent.	\N
22	5	McAllister Commons	123 E McAllister Avenue	Tempe	AZ	85281	0.60	Apartment Complex	{"1b1b": 20, "2b2b": 25, "3b3b": 15}	Pool, Fitness Center, Clubhouse, Business Center	Cats allowed only	Family-managed property with personal touch. Responsive maintenance team.	\N
23	5	Farmer Avenue Flats	456 S Farmer Avenue	Tempe	AZ	85281	0.80	Apartment Complex	{"1b1b": 22, "2b2b": 18, "3b3b": 8, "studio": 12}	Pool, BBQ Area, Laundry Facilities, Parking	Small pets allowed	Updated units with modern appliances and granite countertops.	\N
24	5	Terrace Walk Apartments	789 E Terrace Road	Tempe	AZ	85281	1.00	Apartment Complex	{"1b1b": 18, "2b2b": 26, "3b3b": 12}	Pool, Hot Tub, Fitness Center, Tennis Courts	Pets allowed with deposit	Quiet residential location with easy access to campus and freeway.	\N
25	5	Price Place Residences	234 N Price Road	Tempe	AZ	85281	1.30	Apartment Complex	{"1b1b": 20, "2b2b": 24, "3b3b": 10, "studio": 8}	Pool, Clubhouse, Game Room, Study Center	No pets allowed	Budget-friendly option with flexible lease terms for students.	\N
26	6	Sun Devil Square	567 S College Avenue	Tempe	AZ	85281	0.40	Student Housing	{"1b1b": 25, "2b2b": 20, "3b3b": 10, "studio": 10}	Pool, Game Room, ASU Spirit Lounge, Study Rooms	No pets allowed	ASU-themed apartments with maroon and gold decor. Perfect for school spirit.	\N
27	6	Sparky Towers	890 E Apache Boulevard	Tempe	AZ	85281	0.60	Student Housing	{"1b1b": 20, "2b2b": 15, "3b3b": 5, "studio": 15}	Rooftop Pool, Fitness Center, Media Room, Study Lounge	Cats allowed with deposit	High-rise living with Sun Devil pride. Close to stadium and recreation center.	\N
28	6	Gold Rush Apartments	123 W University Drive	Tempe	AZ	85281	0.50	Student Housing	{"1b1b": 22, "2b2b": 25, "3b3b": 8}	Pool, Hot Tub, BBQ Area, Volleyball Court, Fitness Center	Small dogs allowed	Active community with regular resident events and game day parties.	\N
29	6	Maroon Manor	456 N Myrtle Avenue	Tempe	AZ	85281	0.90	Apartment Complex	{"1b1b": 18, "2b2b": 22, "3b3b": 12, "studio": 8}	Pool, Clubhouse, Study Center, Free Printing	No pets allowed	Quiet study environment with academic support resources.	\N
30	6	Pitchfork Place	789 S Forest Avenue	Tempe	AZ	85281	0.70	Student Housing	{"1b1b": 20, "2b2b": 18, "3b3b": 8, "studio": 12}	Pool, Game Room, Basketball Court, Fitness Center	Pets allowed with restrictions	Sports-oriented community with basketball and volleyball courts.	\N
31	7	Light Rail Lofts	234 E Apache Boulevard	Tempe	AZ	85281	0.80	Apartment Complex	{"1b1b": 25, "2b2b": 20, "3b3b": 5, "studio": 15}	Pool, Fitness Center, Bike Storage, EV Charging	Cats allowed only	Steps from light rail station. Easy commute to downtown Phoenix internships.	\N
32	7	Metro Heights	567 S Mill Avenue	Tempe	AZ	85281	0.60	Apartment Complex	{"1b1b": 22, "2b2b": 25, "3b3b": 10, "studio": 10}	Rooftop Deck, Fitness Center, Co-Working Space, Coffee Bar	Small pets allowed	Urban living with modern amenities. Great for business students and young professionals.	\N
33	7	Transit Station Apartments	890 E Southern Avenue	Tempe	AZ	85282	1.50	Apartment Complex	{"1b1b": 20, "2b2b": 28, "3b3b": 15}	Pool, Clubhouse, Business Center, Package Lockers	Pets allowed with deposit	Convenient location near public transportation and shopping centers.	\N
34	7	Urban Edge Suites	123 N Scottsdale Road	Tempe	AZ	85281	1.80	Apartment Complex	{"1b1b": 18, "2b2b": 22, "3b3b": 12, "studio": 12}	Pool, Gym, Yoga Studio, Study Lounge	No pets allowed	Contemporary design with smart home technology in all units.	\N
35	7	City Center Living	456 W Baseline Road	Tempe	AZ	85283	2.00	Apartment Complex	{"1b1b": 20, "2b2b": 26, "3b3b": 10, "studio": 8}	Pool, Fitness Center, Movie Theater, Game Room	Cats and small dogs allowed	Entertainment-focused community with regular social events.	\N
36	8	Old Town Flats	789 E 5th Street	Tempe	AZ	85281	0.90	Apartment Complex	{"1b1b": 20, "2b2b": 15, "3b3b": 5, "studio": 10}	Pool, Courtyard, Fitness Room, Covered Parking	Pets allowed with deposit	Charming apartments in historic Tempe neighborhood. Walk to downtown.	\N
37	8	McClintock Manor	234 N McClintock Drive	Tempe	AZ	85281	1.20	Apartment Complex	{"1b1b": 18, "2b2b": 25, "3b3b": 15}	Pool, BBQ Area, Laundry Facilities, Playground	All pets welcome	Family-friendly community with spacious layouts and private patios.	\N
38	8	Heritage Court	567 S Hardy Drive	Tempe	AZ	85281	1.00	Apartment Complex	{"1b1b": 22, "2b2b": 20, "3b3b": 10, "studio": 8}	Pool, Clubhouse, Tennis Courts, Fitness Center	Small pets allowed	Well-maintained property with classic Arizona architecture.	\N
39	8	Pueblo Village	890 E Guadalupe Road	Tempe	AZ	85283	2.50	Apartment Complex	{"1b1b": 15, "2b2b": 30, "3b3b": 20}	Two Pools, Fitness Center, Sand Volleyball, Dog Park	Pet-friendly, all sizes	Large community with excellent amenities and affordable rates.	\N
40	8	Cottonwood Commons	123 N 48th Street	Tempe	AZ	85281	1.50	Townhomes	{"2b2b": 25, "3b3b": 30}	Community Pool, Playground, BBQ Areas, Attached Garages	Pets allowed	Townhomes with private garages. Perfect for students with cars.	\N
41	9	Tech Hub Apartments	456 S Priest Drive	Tempe	AZ	85281	1.30	Student Housing	{"1b1b": 25, "2b2b": 18, "3b3b": 8, "studio": 15}	Pool, Co-Working Space, High-Speed Fiber Internet, 3D Printing Lab	No pets allowed	Tech-forward living for STEM students. Smart home features and maker space.	\N
42	9	Innovation Square	789 E Broadway Road	Tempe	AZ	85282	1.50	Apartment Complex	{"1b1b": 20, "2b2b": 22, "3b3b": 10, "studio": 12}	Pool, Fitness Center, VR Gaming Room, Study Pods	Cats allowed only	Future-focused community with cutting-edge technology and amenities.	\N
43	9	Digital Dorms	234 S Rural Road	Tempe	AZ	85281	1.00	Student Housing	{"1b1b": 18, "2b2b": 15, "3b3b": 5, "studio": 20}	Pool, Computer Lab, Free Printing, High-Speed WiFi, Tech Support	No pets allowed	Ultra-fast internet throughout. Perfect for computer science and engineering majors.	\N
44	9	Smart Living Suites	567 N Mill Avenue	Tempe	AZ	85281	0.80	Apartment Complex	{"1b1b": 22, "2b2b": 24, "3b3b": 12, "studio": 10}	Pool, Smart Home Hub, Fitness Center, Charging Stations	Small pets allowed	All units have smart thermostats, locks, and lighting. App-controlled amenities.	\N
45	9	Quantum Quarters	890 E University Drive	Tempe	AZ	85281	0.70	Student Housing	{"1b1b": 20, "2b2b": 20, "3b3b": 8, "studio": 8}	Pool, Innovation Lab, Study Rooms, Podcast Studio	Pets allowed with restrictions	Creative space for innovators and entrepreneurs. Regular tech workshops.	\N
46	10	Classic Court Apartments	123 E Lemon Street	Tempe	AZ	85281	1.10	Apartment Complex	{"1b1b": 25, "2b2b": 18, "3b3b": 8, "studio": 15}	Pool, Courtyard, Laundry Facilities, Covered Parking	Cats allowed with deposit	Established property with character. Utilities included in rent.	\N
47	10	Vintage Villa	456 S Rockford Drive	Tempe	AZ	85281	1.40	Apartment Complex	{"1b1b": 20, "2b2b": 28, "3b3b": 15}	Pool, BBQ Area, Clubhouse, Tennis Courts	All pets welcome	Charming vintage apartments with updated interiors and affordable pricing.	\N
48	10	Retro Ridge	789 N Evergreen Road	Tempe	AZ	85281	1.60	Apartment Complex	{"1b1b": 18, "2b2b": 25, "3b3b": 12, "studio": 10}	Pool, Fitness Room, Game Area, Bike Storage	Small dogs allowed	Retro-styled apartments with modern conveniences. Great value for students.	\N
49	10	Timeless Terrace	234 E Knox Road	Tempe	AZ	85284	2.30	Apartment Complex	{"1b1b": 22, "2b2b": 30, "3b3b": 20}	Two Pools, Fitness Center, Playground, Dog Park	Pet-friendly community	Spacious units in quiet location. Perfect for students who want peace and quiet.	\N
50	10	Legacy Lofts	567 S Kyrene Road	Tempe	AZ	85281	2.00	Apartment Complex	{"1b1b": 20, "2b2b": 22, "3b3b": 10, "studio": 12}	Pool, Clubhouse, Business Center, Coffee Station	Cats and small dogs allowed	Affordable living with all-inclusive utilities. No surprise bills.	\N
\.


--
-- Data for Name: propertymanager; Type: TABLE DATA; Schema: public; Owner: drish
--

COPY public.propertymanager (managerid, companyname, contactpersonname, email, phonenumber, password, website, officeaddress, licensenumber, description, registrationdate) FROM stdin;
1	Campus Living Properties	Sarah Johnson	sjohnson@campusliving.com	480-555-1001	hashed_manager_pass_1	www.campusliving.com	123 Mill Avenue, Suite 100, Tempe, AZ 85281	AZ-PM-2020-001	Specializing in student housing near ASU with over 15 years of experience. We offer modern amenities and flexible lease terms.	2025-11-08 16:00:02.191642
2	University Towers Management	Michael Chen	mchen@universitytowers.com	480-555-1002	hashed_manager_pass_2	www.universitytowers.com	456 Apache Boulevard, Tempe, AZ 85281	AZ-PM-2019-045	Premium high-rise apartments with stunning views. Pet-friendly community with resort-style amenities.	2025-11-08 16:00:02.191642
3	Sun Devil Housing LLC	Jennifer Martinez	jmartinez@sundevilhousing.com	480-555-1003	hashed_manager_pass_3	www.sundevilhousing.com	789 University Drive, Suite 200, Tempe, AZ 85281	AZ-PM-2018-123	Affordable student apartments within walking distance to ASU. We prioritize safety and community engagement.	2025-11-08 16:00:02.191642
4	Desert Oasis Apartments	Robert Williams	rwilliams@desertoasis.com	480-555-1004	hashed_manager_pass_4	www.desertoasisapts.com	234 Rural Road, Tempe, AZ 85282	AZ-PM-2021-067	Luxurious desert-themed apartments with pools, fitness centers, and study lounges. All-inclusive utilities available.	2025-11-08 16:00:02.191642
5	Valley Student Residences	Amanda Taylor	ataylor@valleystudent.com	480-555-1005	hashed_manager_pass_5	www.valleystudentresidences.com	567 College Avenue, Tempe, AZ 85281	AZ-PM-2017-089	Family-owned business managing quality student housing since 2010. Responsive maintenance and excellent customer service.	2025-11-08 16:00:02.191642
6	Maroon & Gold Properties	David Anderson	danderson@maroongold.com	480-555-1006	hashed_manager_pass_6	www.maroongoldproperties.com	890 Broadway Road, Tempe, AZ 85282	AZ-PM-2020-134	ASU-themed housing with school spirit. Close to stadium and campus recreation facilities.	2025-11-08 16:00:02.191642
7	Metro Student Living	Lisa Thompson	lthompson@metrostudent.com	480-555-1007	hashed_manager_pass_7	www.metrostudentliving.com	345 Southern Avenue, Tempe, AZ 85282	AZ-PM-2019-178	Modern apartments near light rail station. Perfect for students who commute to downtown Phoenix for internships.	2025-11-08 16:00:02.191642
8	Tempe Town Properties	Christopher Lee	clee@tempetown.com	480-555-1008	hashed_manager_pass_8	www.tempetownproperties.com	678 McClintock Drive, Tempe, AZ 85281	AZ-PM-2018-201	Boutique property management focusing on smaller communities. Individual attention to each resident.	2025-11-08 16:00:02.191642
9	Innovation Housing Group	Michelle Rodriguez	mrodriguez@innovationhousing.com	480-555-1009	hashed_manager_pass_9	www.innovationhousinggroup.com	901 Priest Drive, Suite 50, Tempe, AZ 85281	AZ-PM-2021-245	Tech-forward housing with smart home features, high-speed internet, and co-working spaces for STEM students.	2025-11-08 16:00:02.191642
10	Heritage Student Communities	Brian Davis	bdavis@heritagestudent.com	480-555-1010	hashed_manager_pass_10	www.heritagestudennt.com	123 Baseline Road, Tempe, AZ 85283	AZ-PM-2016-312	Established apartments with character and history. Affordable rates with utilities included in rent.	2025-11-08 16:00:02.191642
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: drish
--

COPY public.student (studentid, firstname, lastname, email, phonenumber, password, major, currentyear, preferredmoveindate, registrationdate) FROM stdin;
1	Jeffrey	Gibson	jeffreygibson246@asu.edu	480-555-1237	hashed_pass_1	Mechanical Engineering	Freshman	\N	2025-11-08 16:00:02.050528
2	Thomas	Collins	thomascollins435@asu.edu	480-555-5745	hashed_pass_2	Finance	Freshman	2025-08-12	2025-11-08 16:00:02.050528
3	Katherine	Adams	katherineadams97@asu.edu	480-555-9128	hashed_pass_3	Chemistry	Freshman	2025-08-09	2025-11-08 16:00:02.050528
4	David	Castro	davidcastro573@asu.edu	480-555-9703	hashed_pass_4	Biomedical Engineering	Freshman	2025-08-10	2025-11-08 16:00:02.050528
5	Patricia	Flores	patriciaflores381@asu.edu	480-555-9265	hashed_pass_5	Biomedical Engineering	Freshman	\N	2025-11-08 16:00:02.050528
6	Madison	Russell	madisonrussell706@asu.edu	480-555-8361	hashed_pass_6	Cybersecurity	Freshman	2025-08-11	2025-11-08 16:00:02.050528
7	Sean	Green	seangreen461@asu.edu	480-555-8136	hashed_pass_7	Business Analytics	Freshman	2025-08-18	2025-11-08 16:00:02.050528
8	Julie	Hughes	juliehughes325@asu.edu	480-555-3391	hashed_pass_8	Computer Information Systems	Freshman	2025-08-04	2025-11-08 16:00:02.050528
9	Janice	Herrera	janiceherrera303@asu.edu	480-555-7282	hashed_pass_9	Nursing	Freshman	\N	2025-11-08 16:00:02.050528
10	Roy	Harrison	royharrison835@asu.edu	480-555-6593	hashed_pass_10	Supply Chain Management	Freshman	\N	2025-11-08 16:00:02.050528
11	Stephen	Ross	stephenross433@asu.edu	480-555-7050	hashed_pass_11	Economics	Freshman	\N	2025-11-08 16:00:02.050528
12	Roger	Martinez	rogermartinez69@asu.edu	480-555-6678	hashed_pass_12	Supply Chain Management	Freshman	2025-08-20	2025-11-08 16:00:02.050528
13	Brandon	Henderson	brandonhenderson469@asu.edu	480-555-2864	hashed_pass_13	Software Engineering	Freshman	2025-08-02	2025-11-08 16:00:02.050528
14	Ronald	Brooks	ronaldbrooks747@asu.edu	480-555-2187	hashed_pass_14	Software Engineering	Freshman	2025-08-14	2025-11-08 16:00:02.050528
15	Alice	Bailey	alicebailey445@asu.edu	480-555-1401	hashed_pass_15	Finance	Freshman	2025-08-11	2025-11-08 16:00:02.050528
16	Grace	Jones	gracejones617@asu.edu	480-555-2922	hashed_pass_16	Business	Freshman	2025-08-05	2025-11-08 16:00:02.050528
17	Abigail	Torres	abigailtorres853@asu.edu	480-555-4480	hashed_pass_17	Political Science	Freshman	2025-08-05	2025-11-08 16:00:02.050528
18	Joshua	Martinez	joshuamartinez167@asu.edu	480-555-9391	hashed_pass_18	Environmental Science	Freshman	2025-08-14	2025-11-08 16:00:02.050528
19	Kenneth	Wallace	kennethwallace948@asu.edu	480-555-7762	hashed_pass_19	Artificial Intelligence	Freshman	2025-08-12	2025-11-08 16:00:02.050528
20	Hannah	Flores	hannahflores334@asu.edu	480-555-6759	hashed_pass_20	Management	Freshman	2025-08-18	2025-11-08 16:00:02.050528
21	Kathleen	Garcia	kathleengarcia913@asu.edu	480-555-2055	hashed_pass_21	Computer Information Systems	Freshman	2025-08-07	2025-11-08 16:00:02.050528
22	Nancy	Olson	nancyolson739@asu.edu	480-555-7727	hashed_pass_22	Cybersecurity	Freshman	2025-08-19	2025-11-08 16:00:02.050528
23	Gerald	Crawford	geraldcrawford784@asu.edu	480-555-1481	hashed_pass_23	Civil Engineering	Freshman	2025-08-15	2025-11-08 16:00:02.050528
24	Thomas	Hernandez	thomashernandez697@asu.edu	480-555-6308	hashed_pass_24	Environmental Science	Freshman	2025-08-02	2025-11-08 16:00:02.050528
25	Rebecca	Gray	rebeccagray201@asu.edu	480-555-1370	hashed_pass_25	Nursing	Freshman	2025-08-08	2025-11-08 16:00:02.050528
26	Scott	Kennedy	scottkennedy9@asu.edu	480-555-2610	hashed_pass_26	Cybersecurity	Freshman	2025-08-06	2025-11-08 16:00:02.050528
27	Sharon	Cole	sharoncole528@asu.edu	480-555-1875	hashed_pass_27	Biomedical Engineering	Freshman	2025-08-03	2025-11-08 16:00:02.050528
28	Jessica	Clark	jessicaclark724@asu.edu	480-555-4434	hashed_pass_28	Finance	Freshman	\N	2025-11-08 16:00:02.050528
29	Shirley	Morgan	shirleymorgan726@asu.edu	480-555-8527	hashed_pass_29	Business	Freshman	2025-08-04	2025-11-08 16:00:02.050528
30	Ronald	Gibson	ronaldgibson483@asu.edu	480-555-1768	hashed_pass_30	Management	Freshman	2025-08-12	2025-11-08 16:00:02.050528
31	Cheryl	Miller	cherylmiller365@asu.edu	480-555-5706	hashed_pass_31	Environmental Science	Freshman	\N	2025-11-08 16:00:02.050528
32	Patricia	Hernandez	patriciahernandez60@asu.edu	480-555-9509	hashed_pass_32	Supply Chain Management	Freshman	2025-08-04	2025-11-08 16:00:02.050528
33	Mia	Myers	miamyers590@asu.edu	480-555-8033	hashed_pass_33	Biochemistry	Freshman	2025-08-19	2025-11-08 16:00:02.050528
34	George	Burns	georgeburns322@asu.edu	480-555-2035	hashed_pass_34	Finance	Freshman	2025-08-02	2025-11-08 16:00:02.050528
35	Henry	Campbell	henrycampbell665@asu.edu	480-555-2143	hashed_pass_35	Mechanical Engineering	Freshman	\N	2025-11-08 16:00:02.050528
36	Katherine	Jimenez	katherinejimenez392@asu.edu	480-555-8109	hashed_pass_36	Artificial Intelligence	Freshman	\N	2025-11-08 16:00:02.050528
37	Barbara	Walker	barbarawalker313@asu.edu	480-555-6064	hashed_pass_37	Mechanical Engineering	Freshman	2025-08-05	2025-11-08 16:00:02.050528
38	Randy	Hayes	randyhayes97@asu.edu	480-555-6177	hashed_pass_38	Economics	Freshman	2025-08-13	2025-11-08 16:00:02.050528
39	Lawrence	Lopez	lawrencelopez861@asu.edu	480-555-8446	hashed_pass_39	Graphic Design	Freshman	2025-08-14	2025-11-08 16:00:02.050528
40	Russell	Patterson	russellpatterson463@asu.edu	480-555-3437	hashed_pass_40	International Business	Freshman	2025-08-03	2025-11-08 16:00:02.050528
41	Noah	Sanders	noahsanders166@asu.edu	480-555-3785	hashed_pass_41	Healthcare Administration	Freshman	2025-08-09	2025-11-08 16:00:02.050528
42	Noah	Kelly	noahkelly932@asu.edu	480-555-3830	hashed_pass_42	Management	Freshman	2025-08-05	2025-11-08 16:00:02.050528
43	Kelly	Cole	kellycole832@asu.edu	480-555-9457	hashed_pass_43	Civil Engineering	Freshman	2025-08-10	2025-11-08 16:00:02.050528
44	Juan	Medina	juanmedina603@asu.edu	480-555-9109	hashed_pass_44	Artificial Intelligence	Freshman	\N	2025-11-08 16:00:02.050528
45	Jesse	Wagner	jessewagner711@asu.edu	480-555-6142	hashed_pass_45	Marketing	Freshman	2025-08-16	2025-11-08 16:00:02.050528
46	Jennifer	Tucker	jennifertucker654@asu.edu	480-555-8592	hashed_pass_46	Psychology	Freshman	2025-08-20	2025-11-08 16:00:02.050528
47	Charles	West	charleswest747@asu.edu	480-555-7867	hashed_pass_47	Business Analytics	Freshman	2025-08-11	2025-11-08 16:00:02.050528
48	Barbara	Moreno	barbaramoreno187@asu.edu	480-555-4230	hashed_pass_48	Business	Freshman	2025-08-18	2025-11-08 16:00:02.050528
49	Kayla	Hunter	kaylahunter306@asu.edu	480-555-4214	hashed_pass_49	Industrial Engineering	Freshman	2025-08-05	2025-11-08 16:00:02.050528
50	Sean	Rose	seanrose361@asu.edu	480-555-9399	hashed_pass_50	Physics	Freshman	2025-08-04	2025-11-08 16:00:02.050528
51	Helen	Moore	helenmoore967@asu.edu	480-555-9814	hashed_pass_51	Management	Freshman	2025-08-18	2025-11-08 16:00:02.050528
52	Anthony	Webb	anthonywebb907@asu.edu	480-555-8115	hashed_pass_52	International Business	Freshman	2025-08-06	2025-11-08 16:00:02.050528
53	Kathryn	Ellis	kathrynellis955@asu.edu	480-555-7230	hashed_pass_53	Marketing	Freshman	2025-08-14	2025-11-08 16:00:02.050528
54	Carol	Black	carolblack570@asu.edu	480-555-4198	hashed_pass_54	Artificial Intelligence	Freshman	2025-08-03	2025-11-08 16:00:02.050528
55	Vincent	Tran	vincenttran912@asu.edu	480-555-5349	hashed_pass_55	Accounting	Freshman	\N	2025-11-08 16:00:02.050528
56	Jonathan	Ruiz	jonathanruiz703@asu.edu	480-555-5687	hashed_pass_56	Marketing	Freshman	2025-08-18	2025-11-08 16:00:02.050528
57	Steven	White	stevenwhite517@asu.edu	480-555-2338	hashed_pass_57	Computer Science	Freshman	2025-08-19	2025-11-08 16:00:02.050528
58	Julie	Graham	juliegraham574@asu.edu	480-555-6325	hashed_pass_58	Statistics	Freshman	2025-08-03	2025-11-08 16:00:02.050528
59	Helen	Burns	helenburns720@asu.edu	480-555-2985	hashed_pass_59	Mechanical Engineering	Freshman	\N	2025-11-08 16:00:02.050528
60	Sara	Freeman	sarafreeman662@asu.edu	480-555-4358	hashed_pass_60	Electrical Engineering	Freshman	\N	2025-11-08 16:00:02.050528
61	Eugene	Collins	eugenecollins44@asu.edu	480-555-5566	hashed_pass_61	Communications	Freshman	\N	2025-11-08 16:00:02.050528
62	Randy	Griffin	randygriffin59@asu.edu	480-555-6167	hashed_pass_62	Psychology	Freshman	2025-08-07	2025-11-08 16:00:02.050528
63	Andrew	Harrison	andrewharrison766@asu.edu	480-555-7951	hashed_pass_63	Chemistry	Freshman	2025-08-04	2025-11-08 16:00:02.050528
64	Donna	Washington	donnawashington441@asu.edu	480-555-1578	hashed_pass_64	Computer Information Systems	Freshman	\N	2025-11-08 16:00:02.050528
65	Sara	White	sarawhite505@asu.edu	480-555-7256	hashed_pass_65	Computer Science	Freshman	2025-08-15	2025-11-08 16:00:02.050528
66	Juan	Miller	juanmiller948@asu.edu	480-555-9439	hashed_pass_66	Computer Information Systems	Freshman	2025-08-01	2025-11-08 16:00:02.050528
67	Carl	Murphy	carlmurphy294@asu.edu	480-555-5088	hashed_pass_67	Business	Freshman	2025-08-11	2025-11-08 16:00:02.050528
68	Katherine	Chen	katherinechen420@asu.edu	480-555-4688	hashed_pass_68	Computer Science	Freshman	\N	2025-11-08 16:00:02.050528
69	Louis	Perry	louisperry743@asu.edu	480-555-6324	hashed_pass_69	Aerospace Engineering	Freshman	2025-08-07	2025-11-08 16:00:02.050528
70	Aaron	Hughes	aaronhughes617@asu.edu	480-555-2665	hashed_pass_70	Mathematics	Freshman	2025-08-01	2025-11-08 16:00:02.050528
71	Victoria	Parker	victoriaparker969@asu.edu	480-555-5581	hashed_pass_71	Communications	Freshman	2025-08-08	2025-11-08 16:00:02.050528
72	Joshua	Campbell	joshuacampbell559@asu.edu	480-555-6863	hashed_pass_72	Business	Freshman	2025-08-17	2025-11-08 16:00:02.050528
73	Frances	Ford	francesford123@asu.edu	480-555-1412	hashed_pass_73	Chemistry	Freshman	2025-08-14	2025-11-08 16:00:02.050528
74	Betty	Hunter	bettyhunter914@asu.edu	480-555-9071	hashed_pass_74	Public Health	Freshman	\N	2025-11-08 16:00:02.050528
75	Cheryl	Cole	cherylcole636@asu.edu	480-555-8089	hashed_pass_75	Supply Chain Management	Freshman	2025-08-17	2025-11-08 16:00:02.050528
76	Jesse	Taylor	jessetaylor858@asu.edu	480-555-9396	hashed_pass_76	Economics	Freshman	2025-08-15	2025-11-08 16:00:02.050528
77	Eugene	Foster	eugenefoster550@asu.edu	480-555-7574	hashed_pass_77	Computer Information Systems	Freshman	2025-08-03	2025-11-08 16:00:02.050528
78	Debra	Ortiz	debraortiz257@asu.edu	480-555-9611	hashed_pass_78	Psychology	Freshman	2025-08-05	2025-11-08 16:00:02.050528
79	Frances	Hayes	franceshayes876@asu.edu	480-555-9446	hashed_pass_79	Public Health	Freshman	2025-08-13	2025-11-08 16:00:02.050528
80	Isabella	Flores	isabellaflores474@asu.edu	480-555-6668	hashed_pass_80	Biomedical Engineering	Freshman	2025-08-07	2025-11-08 16:00:02.050528
81	Mark	Vasquez	markvasquez996@asu.edu	480-555-9335	hashed_pass_81	Industrial Engineering	Freshman	2025-08-19	2025-11-08 16:00:02.050528
82	Alice	Medina	alicemedina495@asu.edu	480-555-9957	hashed_pass_82	Management	Freshman	2025-08-12	2025-11-08 16:00:02.050528
83	Samantha	Sanchez	samanthasanchez569@asu.edu	480-555-7153	hashed_pass_83	Civil Engineering	Freshman	2025-08-03	2025-11-08 16:00:02.050528
84	Ruth	White	ruthwhite203@asu.edu	480-555-9826	hashed_pass_84	Computer Science	Freshman	2025-08-02	2025-11-08 16:00:02.050528
85	Daniel	Hamilton	danielhamilton940@asu.edu	480-555-1352	hashed_pass_85	Public Health	Freshman	2025-08-01	2025-11-08 16:00:02.050528
86	Robert	Ortiz	robertortiz823@asu.edu	480-555-9910	hashed_pass_86	Journalism	Freshman	2025-08-07	2025-11-08 16:00:02.050528
87	Jason	Brown	jasonbrown952@asu.edu	480-555-5998	hashed_pass_87	Journalism	Freshman	2025-08-15	2025-11-08 16:00:02.050528
88	Ashley	Robertson	ashleyrobertson193@asu.edu	480-555-5334	hashed_pass_88	Physics	Freshman	\N	2025-11-08 16:00:02.050528
89	Adam	Burns	adamburns173@asu.edu	480-555-6439	hashed_pass_89	Mathematics	Freshman	\N	2025-11-08 16:00:02.050528
90	Jordan	Wilson	jordanwilson292@asu.edu	480-555-2230	hashed_pass_90	Communications	Freshman	2025-08-12	2025-11-08 16:00:02.050528
91	Kyle	Davis	kyledavis859@asu.edu	480-555-1897	hashed_pass_91	Marketing	Freshman	2025-08-16	2025-11-08 16:00:02.050528
92	Aaron	Moreno	aaronmoreno305@asu.edu	480-555-7234	hashed_pass_92	Finance	Freshman	\N	2025-11-08 16:00:02.050528
93	Marie	Alexander	mariealexander317@asu.edu	480-555-1886	hashed_pass_93	Industrial Engineering	Freshman	2025-08-07	2025-11-08 16:00:02.050528
94	Donna	Hunt	donnahunt166@asu.edu	480-555-8506	hashed_pass_94	Nursing	Freshman	2025-08-11	2025-11-08 16:00:02.050528
95	Amanda	Silva	amandasilva278@asu.edu	480-555-6739	hashed_pass_95	International Business	Freshman	2025-08-16	2025-11-08 16:00:02.050528
96	Ryan	Wagner	ryanwagner128@asu.edu	480-555-5058	hashed_pass_96	International Business	Freshman	2025-08-19	2025-11-08 16:00:02.050528
97	Deborah	Owens	deborahowens127@asu.edu	480-555-2206	hashed_pass_97	Biomedical Engineering	Freshman	2025-08-04	2025-11-08 16:00:02.050528
98	Jean	Cruz	jeancruz104@asu.edu	480-555-7387	hashed_pass_98	Software Engineering	Freshman	2025-08-02	2025-11-08 16:00:02.050528
99	Carolyn	Dixon	carolyndixon205@asu.edu	480-555-3502	hashed_pass_99	Supply Chain Management	Freshman	2025-08-13	2025-11-08 16:00:02.050528
100	Jennifer	Washington	jenniferwashington744@asu.edu	480-555-5180	hashed_pass_100	Journalism	Freshman	2025-08-14	2025-11-08 16:00:02.050528
101	Olivia	Hunter	oliviahunter240@asu.edu	480-555-5965	hashed_pass_101	Marketing	Sophomore	\N	2025-11-08 16:00:02.050528
102	Christina	Butler	christinabutler383@asu.edu	480-555-4419	hashed_pass_102	International Business	Sophomore	2025-08-04	2025-11-08 16:00:02.050528
103	Sandra	Burns	sandraburns230@asu.edu	480-555-1372	hashed_pass_103	Aerospace Engineering	Sophomore	2025-08-03	2025-11-08 16:00:02.050528
104	Andrew	Robinson	andrewrobinson205@asu.edu	480-555-7286	hashed_pass_104	Healthcare Administration	Sophomore	2025-08-11	2025-11-08 16:00:02.050528
105	Tyler	Ford	tylerford448@asu.edu	480-555-1483	hashed_pass_105	Data Science	Sophomore	2025-08-07	2025-11-08 16:00:02.050528
106	Kevin	Silva	kevinsilva526@asu.edu	480-555-8888	hashed_pass_106	Artificial Intelligence	Sophomore	2025-08-12	2025-11-08 16:00:02.050528
107	Vincent	Hernandez	vincenthernandez722@asu.edu	480-555-8557	hashed_pass_107	Statistics	Sophomore	2025-08-01	2025-11-08 16:00:02.050528
108	Elijah	Gordon	elijahgordon954@asu.edu	480-555-5716	hashed_pass_108	Artificial Intelligence	Sophomore	2025-08-01	2025-11-08 16:00:02.050528
109	Austin	Ramos	austinramos368@asu.edu	480-555-7378	hashed_pass_109	Data Science	Sophomore	2025-08-04	2025-11-08 16:00:02.050528
110	Lawrence	Stevens	lawrencestevens835@asu.edu	480-555-1346	hashed_pass_110	Business	Sophomore	2025-08-17	2025-11-08 16:00:02.050528
111	Ruth	Johnson	ruthjohnson97@asu.edu	480-555-6725	hashed_pass_111	Mathematics	Sophomore	2025-08-13	2025-11-08 16:00:02.050528
112	Keith	Alexander	keithalexander743@asu.edu	480-555-4600	hashed_pass_112	Environmental Science	Sophomore	2025-08-01	2025-11-08 16:00:02.050528
113	Dylan	Sanders	dylansanders622@asu.edu	480-555-2531	hashed_pass_113	Electrical Engineering	Sophomore	\N	2025-11-08 16:00:02.050528
114	Carl	Jordan	carljordan621@asu.edu	480-555-5305	hashed_pass_114	Finance	Sophomore	2025-08-13	2025-11-08 16:00:02.050528
115	Jacob	Palmer	jacobpalmer173@asu.edu	480-555-3309	hashed_pass_115	Architecture	Sophomore	\N	2025-11-08 16:00:02.050528
116	Abigail	Mason	abigailmason570@asu.edu	480-555-5202	hashed_pass_116	Business	Sophomore	2025-08-09	2025-11-08 16:00:02.050528
117	Lori	Jones	lorijones259@asu.edu	480-555-9259	hashed_pass_117	Finance	Sophomore	2025-08-16	2025-11-08 16:00:02.050528
118	Helen	Alexander	helenalexander398@asu.edu	480-555-3026	hashed_pass_118	Architecture	Sophomore	2025-08-02	2025-11-08 16:00:02.050528
119	Gerald	Carter	geraldcarter171@asu.edu	480-555-9743	hashed_pass_119	Business	Sophomore	2025-08-19	2025-11-08 16:00:02.050528
120	Alexander	Murphy	alexandermurphy466@asu.edu	480-555-1862	hashed_pass_120	Mechanical Engineering	Sophomore	2025-08-08	2025-11-08 16:00:02.050528
121	Elijah	Sanchez	elijahsanchez579@asu.edu	480-555-6701	hashed_pass_121	Journalism	Sophomore	2025-08-06	2025-11-08 16:00:02.050528
122	Christopher	Baker	christopherbaker979@asu.edu	480-555-7800	hashed_pass_122	Electrical Engineering	Sophomore	2025-08-17	2025-11-08 16:00:02.050528
123	Catherine	Martin	catherinemartin87@asu.edu	480-555-7318	hashed_pass_123	Biomedical Engineering	Sophomore	2025-08-10	2025-11-08 16:00:02.050528
124	Louis	Brooks	louisbrooks812@asu.edu	480-555-9744	hashed_pass_124	Mathematics	Sophomore	2025-08-16	2025-11-08 16:00:02.050528
125	Jean	Harrison	jeanharrison703@asu.edu	480-555-9448	hashed_pass_125	Graphic Design	Sophomore	2025-08-11	2025-11-08 16:00:02.050528
126	Jason	Adams	jasonadams715@asu.edu	480-555-8608	hashed_pass_126	Aerospace Engineering	Sophomore	2025-08-04	2025-11-08 16:00:02.050528
127	Lori	Boyd	loriboyd286@asu.edu	480-555-4024	hashed_pass_127	Supply Chain Management	Sophomore	2025-08-14	2025-11-08 16:00:02.050528
128	Ryan	Kennedy	ryankennedy97@asu.edu	480-555-8912	hashed_pass_128	Graphic Design	Sophomore	2025-08-08	2025-11-08 16:00:02.050528
129	Tyler	Cook	tylercook938@asu.edu	480-555-9540	hashed_pass_129	Healthcare Administration	Sophomore	2025-08-11	2025-11-08 16:00:02.050528
130	Catherine	Gonzalez	catherinegonzalez476@asu.edu	480-555-8053	hashed_pass_130	Computer Information Systems	Sophomore	2025-08-09	2025-11-08 16:00:02.050528
131	Mark	Hicks	markhicks943@asu.edu	480-555-9777	hashed_pass_131	Software Engineering	Sophomore	\N	2025-11-08 16:00:02.050528
132	Daniel	Taylor	danieltaylor205@asu.edu	480-555-9421	hashed_pass_132	Mathematics	Sophomore	2025-08-08	2025-11-08 16:00:02.050528
133	Danielle	Patterson	daniellepatterson172@asu.edu	480-555-8179	hashed_pass_133	Marketing	Sophomore	2025-08-05	2025-11-08 16:00:02.050528
134	Carolyn	Munoz	carolynmunoz6@asu.edu	480-555-3196	hashed_pass_134	Chemistry	Sophomore	2025-08-12	2025-11-08 16:00:02.050528
135	Daniel	Rivera	danielrivera638@asu.edu	480-555-5715	hashed_pass_135	Graphic Design	Sophomore	2025-08-05	2025-11-08 16:00:02.050528
136	Elijah	Ramos	elijahramos197@asu.edu	480-555-5531	hashed_pass_136	Psychology	Sophomore	2025-08-13	2025-11-08 16:00:02.050528
137	Wayne	Green	waynegreen655@asu.edu	480-555-6653	hashed_pass_137	Industrial Engineering	Sophomore	2025-08-18	2025-11-08 16:00:02.050528
138	Christian	Vargas	christianvargas177@asu.edu	480-555-6950	hashed_pass_138	Biology	Sophomore	2025-08-09	2025-11-08 16:00:02.050528
139	Dylan	Black	dylanblack216@asu.edu	480-555-1661	hashed_pass_139	Graphic Design	Sophomore	2025-08-17	2025-11-08 16:00:02.050528
140	Daniel	Cruz	danielcruz167@asu.edu	480-555-3670	hashed_pass_140	Chemistry	Sophomore	2025-08-09	2025-11-08 16:00:02.050528
141	Deborah	Hayes	deborahhayes783@asu.edu	480-555-2505	hashed_pass_141	Aerospace Engineering	Sophomore	2025-08-08	2025-11-08 16:00:02.050528
142	Aaron	Morgan	aaronmorgan940@asu.edu	480-555-7425	hashed_pass_142	Healthcare Administration	Sophomore	2025-08-04	2025-11-08 16:00:02.050528
143	Eric	Rivera	ericrivera130@asu.edu	480-555-2319	hashed_pass_143	Journalism	Sophomore	2025-08-08	2025-11-08 16:00:02.050528
144	Margaret	Wood	margaretwood463@asu.edu	480-555-4108	hashed_pass_144	International Business	Sophomore	2025-08-04	2025-11-08 16:00:02.050528
145	Sophia	Tucker	sophiatucker169@asu.edu	480-555-1814	hashed_pass_145	Software Engineering	Sophomore	2025-08-11	2025-11-08 16:00:02.050528
146	Sean	Gonzales	seangonzales853@asu.edu	480-555-9928	hashed_pass_146	Psychology	Sophomore	2025-08-17	2025-11-08 16:00:02.050528
147	Gabriel	Turner	gabrielturner195@asu.edu	480-555-9293	hashed_pass_147	Healthcare Administration	Sophomore	2025-08-18	2025-11-08 16:00:02.050528
148	Kyle	Guzman	kyleguzman856@asu.edu	480-555-1886	hashed_pass_148	Electrical Engineering	Sophomore	2025-08-03	2025-11-08 16:00:02.050528
149	Abigail	Tucker	abigailtucker798@asu.edu	480-555-3769	hashed_pass_149	Communications	Sophomore	2025-08-09	2025-11-08 16:00:02.050528
150	Donna	Martinez	donnamartinez899@asu.edu	480-555-7732	hashed_pass_150	Journalism	Sophomore	2025-08-14	2025-11-08 16:00:02.050528
151	Barbara	Cruz	barbaracruz605@asu.edu	480-555-5672	hashed_pass_151	Chemistry	Sophomore	\N	2025-11-08 16:00:02.050528
152	Wayne	Reed	waynereed263@asu.edu	480-555-4086	hashed_pass_152	Journalism	Sophomore	2025-08-03	2025-11-08 16:00:02.050528
153	Douglas	Mason	douglasmason414@asu.edu	480-555-3427	hashed_pass_153	Communications	Sophomore	2025-08-02	2025-11-08 16:00:02.050528
154	Beverly	Gutierrez	beverlygutierrez214@asu.edu	480-555-7794	hashed_pass_154	Chemistry	Sophomore	2025-08-03	2025-11-08 16:00:02.050528
155	Albert	Morgan	albertmorgan781@asu.edu	480-555-6939	hashed_pass_155	Environmental Science	Sophomore	2025-08-02	2025-11-08 16:00:02.050528
156	Ava	Mitchell	avamitchell503@asu.edu	480-555-2131	hashed_pass_156	Political Science	Sophomore	2025-08-06	2025-11-08 16:00:02.050528
157	Mark	Moore	markmoore996@asu.edu	480-555-5366	hashed_pass_157	Biomedical Engineering	Sophomore	2025-08-08	2025-11-08 16:00:02.050528
158	Theresa	Turner	theresaturner402@asu.edu	480-555-2968	hashed_pass_158	Psychology	Sophomore	2025-08-13	2025-11-08 16:00:02.050528
159	Lori	Adams	loriadams160@asu.edu	480-555-3623	hashed_pass_159	Marketing	Sophomore	2025-08-15	2025-11-08 16:00:02.050528
160	Anna	Allen	annaallen624@asu.edu	480-555-3158	hashed_pass_160	Psychology	Sophomore	2025-08-17	2025-11-08 16:00:02.050528
161	Michelle	Webb	michellewebb175@asu.edu	480-555-9399	hashed_pass_161	Business Analytics	Sophomore	2025-08-15	2025-11-08 16:00:02.050528
162	Alice	James	alicejames160@asu.edu	480-555-8210	hashed_pass_162	Biochemistry	Sophomore	2025-08-20	2025-11-08 16:00:02.050528
163	Megan	Brooks	meganbrooks7@asu.edu	480-555-9990	hashed_pass_163	Cybersecurity	Sophomore	2025-08-08	2025-11-08 16:00:02.050528
164	Julie	Crawford	juliecrawford295@asu.edu	480-555-2670	hashed_pass_164	Mathematics	Sophomore	2025-08-17	2025-11-08 16:00:02.050528
165	Thomas	Woods	thomaswoods541@asu.edu	480-555-1326	hashed_pass_165	International Business	Sophomore	2025-08-18	2025-11-08 16:00:02.050528
166	Michael	Hayes	michaelhayes35@asu.edu	480-555-1064	hashed_pass_166	Chemistry	Sophomore	2025-08-09	2025-11-08 16:00:02.050528
167	Marilyn	Snyder	marilynsnyder516@asu.edu	480-555-3187	hashed_pass_167	Physics	Sophomore	2025-08-17	2025-11-08 16:00:02.050528
168	Lauren	Peterson	laurenpeterson454@asu.edu	480-555-9185	hashed_pass_168	Biology	Sophomore	2025-08-13	2025-11-08 16:00:02.050528
169	Megan	Morales	meganmorales819@asu.edu	480-555-1916	hashed_pass_169	Biochemistry	Sophomore	2025-08-17	2025-11-08 16:00:02.050528
170	Alice	Palmer	alicepalmer292@asu.edu	480-555-4784	hashed_pass_170	Computer Information Systems	Sophomore	2025-08-20	2025-11-08 16:00:02.050528
171	Gregory	Richardson	gregoryrichardson351@asu.edu	480-555-5989	hashed_pass_171	Healthcare Administration	Sophomore	2025-08-08	2025-11-08 16:00:02.050528
172	Brenda	Hamilton	brendahamilton97@asu.edu	480-555-4474	hashed_pass_172	Electrical Engineering	Sophomore	2025-08-02	2025-11-08 16:00:02.050528
173	Billy	Hicks	billyhicks889@asu.edu	480-555-6537	hashed_pass_173	Supply Chain Management	Sophomore	2025-08-06	2025-11-08 16:00:02.050528
174	Ethan	Gonzales	ethangonzales602@asu.edu	480-555-9654	hashed_pass_174	Psychology	Sophomore	\N	2025-11-08 16:00:02.050528
175	Philip	Silva	philipsilva367@asu.edu	480-555-2219	hashed_pass_175	Public Health	Sophomore	2025-08-01	2025-11-08 16:00:02.050528
176	Anthony	Burns	anthonyburns475@asu.edu	480-555-6953	hashed_pass_176	Civil Engineering	Sophomore	2025-08-16	2025-11-08 16:00:02.050528
177	Joyce	Henry	joycehenry555@asu.edu	480-555-5389	hashed_pass_177	Economics	Sophomore	2025-08-06	2025-11-08 16:00:02.050528
178	Ann	Jones	annjones371@asu.edu	480-555-2165	hashed_pass_178	Aerospace Engineering	Sophomore	2025-08-01	2025-11-08 16:00:02.050528
179	Stephen	Mitchell	stephenmitchell239@asu.edu	480-555-7619	hashed_pass_179	Management	Sophomore	\N	2025-11-08 16:00:02.050528
180	Willie	Hughes	williehughes919@asu.edu	480-555-2019	hashed_pass_180	Physics	Sophomore	2025-08-19	2025-11-08 16:00:02.050528
181	Beverly	Ford	beverlyford823@asu.edu	480-555-3158	hashed_pass_181	Industrial Engineering	Sophomore	2025-08-10	2025-11-08 16:00:02.050528
182	Abigail	Ross	abigailross830@asu.edu	480-555-1457	hashed_pass_182	Communications	Sophomore	2025-08-17	2025-11-08 16:00:02.050528
183	Dylan	Gonzales	dylangonzales486@asu.edu	480-555-7830	hashed_pass_183	Mechanical Engineering	Sophomore	2025-08-14	2025-11-08 16:00:02.050528
184	Evelyn	Fernandez	evelynfernandez589@asu.edu	480-555-7482	hashed_pass_184	Supply Chain Management	Sophomore	2025-08-11	2025-11-08 16:00:02.050528
185	Virginia	Butler	virginiabutler866@asu.edu	480-555-9278	hashed_pass_185	Economics	Sophomore	2025-08-10	2025-11-08 16:00:02.050528
186	Ryan	Chavez	ryanchavez835@asu.edu	480-555-3544	hashed_pass_186	Public Health	Sophomore	2025-08-15	2025-11-08 16:00:02.050528
187	Jeffrey	Sanders	jeffreysanders530@asu.edu	480-555-1613	hashed_pass_187	Mechanical Engineering	Sophomore	2025-08-03	2025-11-08 16:00:02.050528
188	Katherine	Ward	katherineward977@asu.edu	480-555-8799	hashed_pass_188	Biology	Sophomore	2025-08-02	2025-11-08 16:00:02.050528
189	Angela	Gonzalez	angelagonzalez533@asu.edu	480-555-9471	hashed_pass_189	Physics	Sophomore	2025-08-20	2025-11-08 16:00:02.050528
190	Jennifer	Hicks	jenniferhicks657@asu.edu	480-555-4055	hashed_pass_190	Aerospace Engineering	Sophomore	2025-08-08	2025-11-08 16:00:02.050528
191	Philip	Ross	philipross549@asu.edu	480-555-1393	hashed_pass_191	Chemistry	Sophomore	2025-08-14	2025-11-08 16:00:02.050528
192	Cheryl	Walker	cherylwalker970@asu.edu	480-555-7992	hashed_pass_192	Environmental Science	Sophomore	2025-08-18	2025-11-08 16:00:02.050528
193	Helen	Diaz	helendiaz939@asu.edu	480-555-2720	hashed_pass_193	Finance	Sophomore	2025-08-13	2025-11-08 16:00:02.050528
194	Larry	Ellis	larryellis303@asu.edu	480-555-8806	hashed_pass_194	Supply Chain Management	Sophomore	2025-08-12	2025-11-08 16:00:02.050528
195	Justin	Taylor	justintaylor261@asu.edu	480-555-8180	hashed_pass_195	Industrial Engineering	Sophomore	2025-08-10	2025-11-08 16:00:02.050528
196	Kelly	Vargas	kellyvargas764@asu.edu	480-555-8184	hashed_pass_196	Management	Sophomore	2025-08-07	2025-11-08 16:00:02.050528
197	Joshua	Moore	joshuamoore825@asu.edu	480-555-1229	hashed_pass_197	Graphic Design	Sophomore	2025-08-19	2025-11-08 16:00:02.050528
198	Amanda	Moore	amandamoore236@asu.edu	480-555-6604	hashed_pass_198	Business Analytics	Sophomore	2025-08-18	2025-11-08 16:00:02.050528
199	Gloria	Moreno	gloriamoreno673@asu.edu	480-555-8004	hashed_pass_199	Architecture	Sophomore	2025-08-19	2025-11-08 16:00:02.050528
200	Matthew	Hall	matthewhall954@asu.edu	480-555-2795	hashed_pass_200	Psychology	Sophomore	2025-08-09	2025-11-08 16:00:02.050528
201	Kayla	Kennedy	kaylakennedy292@asu.edu	480-555-5308	hashed_pass_201	Environmental Science	Sophomore	2025-08-16	2025-11-08 16:00:02.050528
202	Roger	Rose	rogerrose952@asu.edu	480-555-2549	hashed_pass_202	Cybersecurity	Sophomore	2025-08-04	2025-11-08 16:00:02.050528
203	Douglas	Butler	douglasbutler459@asu.edu	480-555-3831	hashed_pass_203	Biomedical Engineering	Sophomore	2025-08-20	2025-11-08 16:00:02.050528
204	Samuel	Stewart	samuelstewart433@asu.edu	480-555-6843	hashed_pass_204	Nursing	Sophomore	2025-08-18	2025-11-08 16:00:02.050528
205	Jesse	Tran	jessetran778@asu.edu	480-555-7556	hashed_pass_205	Economics	Sophomore	\N	2025-11-08 16:00:02.050528
206	Jordan	Thomas	jordanthomas639@asu.edu	480-555-2784	hashed_pass_206	Communications	Sophomore	\N	2025-11-08 16:00:02.050528
207	Gregory	Lewis	gregorylewis181@asu.edu	480-555-5642	hashed_pass_207	Accounting	Sophomore	2025-08-10	2025-11-08 16:00:02.050528
208	Susan	Allen	susanallen28@asu.edu	480-555-3649	hashed_pass_208	Mathematics	Sophomore	\N	2025-11-08 16:00:02.050528
209	Bobby	Romero	bobbyromero997@asu.edu	480-555-6482	hashed_pass_209	Journalism	Sophomore	2025-08-14	2025-11-08 16:00:02.050528
210	Alexis	Wilson	alexiswilson635@asu.edu	480-555-9666	hashed_pass_210	Artificial Intelligence	Sophomore	2025-08-18	2025-11-08 16:00:02.050528
211	Louis	Washington	louiswashington832@asu.edu	480-555-4456	hashed_pass_211	Biochemistry	Sophomore	2025-08-12	2025-11-08 16:00:02.050528
212	Jerry	Griffin	jerrygriffin82@asu.edu	480-555-3158	hashed_pass_212	Graphic Design	Sophomore	2025-08-13	2025-11-08 16:00:02.050528
213	Carl	Griffin	carlgriffin715@asu.edu	480-555-9811	hashed_pass_213	Marketing	Sophomore	2025-08-09	2025-11-08 16:00:02.050528
214	Philip	Sanders	philipsanders826@asu.edu	480-555-9488	hashed_pass_214	Management	Sophomore	2025-08-11	2025-11-08 16:00:02.050528
215	Elijah	Cole	elijahcole149@asu.edu	480-555-6123	hashed_pass_215	Chemistry	Sophomore	2025-08-14	2025-11-08 16:00:02.050528
216	Margaret	Burns	margaretburns684@asu.edu	480-555-1872	hashed_pass_216	International Business	Sophomore	2025-08-17	2025-11-08 16:00:02.050528
217	Jose	Ortiz	joseortiz580@asu.edu	480-555-6156	hashed_pass_217	Data Science	Sophomore	2025-08-05	2025-11-08 16:00:02.050528
218	Jesse	Jimenez	jessejimenez467@asu.edu	480-555-4433	hashed_pass_218	Economics	Sophomore	2025-08-20	2025-11-08 16:00:02.050528
219	Ashley	Torres	ashleytorres109@asu.edu	480-555-8728	hashed_pass_219	Software Engineering	Sophomore	2025-08-15	2025-11-08 16:00:02.050528
220	Hannah	Russell	hannahrussell776@asu.edu	480-555-8009	hashed_pass_220	Computer Science	Sophomore	\N	2025-11-08 16:00:02.050528
221	Sara	Barnes	sarabarnes487@asu.edu	480-555-7723	hashed_pass_221	Marketing	Sophomore	2025-08-19	2025-11-08 16:00:02.050528
222	Christina	Gomez	christinagomez717@asu.edu	480-555-2957	hashed_pass_222	Biomedical Engineering	Sophomore	2025-08-09	2025-11-08 16:00:02.050528
223	Larry	Hunt	larryhunt204@asu.edu	480-555-8963	hashed_pass_223	Public Health	Sophomore	2025-08-19	2025-11-08 16:00:02.050528
224	Juan	Perry	juanperry542@asu.edu	480-555-1858	hashed_pass_224	Artificial Intelligence	Sophomore	2025-08-20	2025-11-08 16:00:02.050528
225	Karen	Barnes	karenbarnes908@asu.edu	480-555-9059	hashed_pass_225	Cybersecurity	Sophomore	2025-08-05	2025-11-08 16:00:02.050528
226	Jennifer	Vargas	jennifervargas844@asu.edu	480-555-1514	hashed_pass_226	Architecture	Junior	2025-06-28	2025-11-08 16:00:02.050528
227	Abigail	Peterson	abigailpeterson147@asu.edu	480-555-5457	hashed_pass_227	Industrial Engineering	Junior	\N	2025-11-08 16:00:02.050528
228	Janice	Lewis	janicelewis275@asu.edu	480-555-2563	hashed_pass_228	Biology	Junior	2025-07-15	2025-11-08 16:00:02.050528
229	Marilyn	Hicks	marilynhicks69@asu.edu	480-555-9348	hashed_pass_229	Nursing	Junior	2025-08-08	2025-11-08 16:00:02.050528
230	Danielle	Chavez	daniellechavez177@asu.edu	480-555-6767	hashed_pass_230	Journalism	Junior	2025-07-27	2025-11-08 16:00:02.050528
231	Donna	Simmons	donnasimmons922@asu.edu	480-555-4131	hashed_pass_231	Software Engineering	Junior	2025-07-06	2025-11-08 16:00:02.050528
232	Nancy	Thomas	nancythomas57@asu.edu	480-555-6909	hashed_pass_232	Finance	Junior	2025-08-08	2025-11-08 16:00:02.050528
233	Vincent	Richardson	vincentrichardson443@asu.edu	480-555-2140	hashed_pass_233	Computer Science	Junior	2025-08-07	2025-11-08 16:00:02.050528
234	Janice	Owens	janiceowens988@asu.edu	480-555-7137	hashed_pass_234	Psychology	Junior	2025-08-17	2025-11-08 16:00:02.050528
235	Edward	Harrison	edwardharrison742@asu.edu	480-555-3694	hashed_pass_235	Biomedical Engineering	Junior	2025-06-14	2025-11-08 16:00:02.050528
236	Justin	Harrison	justinharrison435@asu.edu	480-555-8069	hashed_pass_236	Graphic Design	Junior	2025-08-20	2025-11-08 16:00:02.050528
237	Jerry	Nguyen	jerrynguyen838@asu.edu	480-555-8366	hashed_pass_237	Accounting	Junior	2025-08-18	2025-11-08 16:00:02.050528
238	Walter	White	walterwhite198@asu.edu	480-555-6604	hashed_pass_238	Artificial Intelligence	Junior	\N	2025-11-08 16:00:02.050528
239	Martha	Peterson	marthapeterson78@asu.edu	480-555-8118	hashed_pass_239	Journalism	Junior	\N	2025-11-08 16:00:02.050528
240	Melissa	Davis	melissadavis577@asu.edu	480-555-9955	hashed_pass_240	Aerospace Engineering	Junior	2025-08-04	2025-11-08 16:00:02.050528
241	Emily	Fisher	emilyfisher67@asu.edu	480-555-6811	hashed_pass_241	Cybersecurity	Junior	2025-07-04	2025-11-08 16:00:02.050528
242	Scott	Jackson	scottjackson278@asu.edu	480-555-5965	hashed_pass_242	Biomedical Engineering	Junior	2025-07-02	2025-11-08 16:00:02.050528
243	Randy	Ford	randyford253@asu.edu	480-555-7176	hashed_pass_243	Mathematics	Junior	2025-08-12	2025-11-08 16:00:02.050528
244	Gregory	Gonzalez	gregorygonzalez444@asu.edu	480-555-2771	hashed_pass_244	Civil Engineering	Junior	2025-07-13	2025-11-08 16:00:02.050528
245	Ann	Ross	annross434@asu.edu	480-555-7872	hashed_pass_245	Biomedical Engineering	Junior	\N	2025-11-08 16:00:02.050528
246	Nathan	Cook	nathancook112@asu.edu	480-555-2142	hashed_pass_246	Public Health	Junior	2025-07-11	2025-11-08 16:00:02.050528
247	Ronald	Nelson	ronaldnelson719@asu.edu	480-555-9532	hashed_pass_247	Graphic Design	Junior	2025-07-26	2025-11-08 16:00:02.050528
248	Scott	Rogers	scottrogers580@asu.edu	480-555-2519	hashed_pass_248	Finance	Junior	2025-07-29	2025-11-08 16:00:02.050528
249	Sharon	Jenkins	sharonjenkins814@asu.edu	480-555-3106	hashed_pass_249	Economics	Junior	2025-06-09	2025-11-08 16:00:02.050528
250	Alexander	Castro	alexandercastro658@asu.edu	480-555-2004	hashed_pass_250	Journalism	Junior	2025-06-12	2025-11-08 16:00:02.050528
251	Katherine	Perry	katherineperry68@asu.edu	480-555-2324	hashed_pass_251	Mathematics	Junior	2025-08-04	2025-11-08 16:00:02.050528
252	Bobby	Powell	bobbypowell763@asu.edu	480-555-9682	hashed_pass_252	Accounting	Junior	2025-07-20	2025-11-08 16:00:02.050528
253	Timothy	Davis	timothydavis969@asu.edu	480-555-9213	hashed_pass_253	International Business	Junior	2025-07-24	2025-11-08 16:00:02.050528
254	Ann	Cole	anncole705@asu.edu	480-555-7785	hashed_pass_254	Biology	Junior	2025-07-05	2025-11-08 16:00:02.050528
255	Joshua	Green	joshuagreen866@asu.edu	480-555-8567	hashed_pass_255	Computer Science	Junior	\N	2025-11-08 16:00:02.050528
256	Jacqueline	Moore	jacquelinemoore11@asu.edu	480-555-4559	hashed_pass_256	Biomedical Engineering	Junior	2025-06-16	2025-11-08 16:00:02.050528
257	Adam	Howard	adamhoward542@asu.edu	480-555-2200	hashed_pass_257	Statistics	Junior	2025-07-14	2025-11-08 16:00:02.050528
258	Michael	Kennedy	michaelkennedy407@asu.edu	480-555-9982	hashed_pass_258	Architecture	Junior	2025-08-06	2025-11-08 16:00:02.050528
259	Edward	Porter	edwardporter550@asu.edu	480-555-5862	hashed_pass_259	Artificial Intelligence	Junior	2025-06-06	2025-11-08 16:00:02.050528
260	Noah	Wagner	noahwagner532@asu.edu	480-555-6964	hashed_pass_260	Architecture	Junior	2025-08-13	2025-11-08 16:00:02.050528
261	Austin	Burns	austinburns585@asu.edu	480-555-4194	hashed_pass_261	Business	Junior	2025-08-06	2025-11-08 16:00:02.050528
262	Thomas	Smith	thomassmith666@asu.edu	480-555-2156	hashed_pass_262	Nursing	Junior	2025-08-10	2025-11-08 16:00:02.050528
263	Marie	Cooper	mariecooper338@asu.edu	480-555-3514	hashed_pass_263	Statistics	Junior	2025-08-19	2025-11-08 16:00:02.050528
264	Louis	Rogers	louisrogers67@asu.edu	480-555-7111	hashed_pass_264	Economics	Junior	2025-07-27	2025-11-08 16:00:02.050528
265	Victoria	Palmer	victoriapalmer756@asu.edu	480-555-4207	hashed_pass_265	Biomedical Engineering	Junior	2025-06-26	2025-11-08 16:00:02.050528
266	Ryan	Ellis	ryanellis758@asu.edu	480-555-4265	hashed_pass_266	Artificial Intelligence	Junior	2025-06-29	2025-11-08 16:00:02.050528
267	Emma	Butler	emmabutler48@asu.edu	480-555-8169	hashed_pass_267	Chemistry	Junior	2025-08-03	2025-11-08 16:00:02.050528
268	Stephen	Snyder	stephensnyder899@asu.edu	480-555-5009	hashed_pass_268	Psychology	Junior	2025-07-20	2025-11-08 16:00:02.050528
269	Steven	Jones	stevenjones672@asu.edu	480-555-2144	hashed_pass_269	Mechanical Engineering	Junior	2025-07-29	2025-11-08 16:00:02.050528
270	Diana	Cole	dianacole420@asu.edu	480-555-9375	hashed_pass_270	Business	Junior	2025-07-12	2025-11-08 16:00:02.050528
271	Billy	Phillips	billyphillips766@asu.edu	480-555-8982	hashed_pass_271	Architecture	Junior	2025-07-04	2025-11-08 16:00:02.050528
272	Christopher	Murray	christophermurray923@asu.edu	480-555-7492	hashed_pass_272	Biomedical Engineering	Junior	\N	2025-11-08 16:00:02.050528
273	Roger	Dixon	rogerdixon522@asu.edu	480-555-8025	hashed_pass_273	International Business	Junior	\N	2025-11-08 16:00:02.050528
274	Jacob	Turner	jacobturner564@asu.edu	480-555-6274	hashed_pass_274	Computer Information Systems	Junior	\N	2025-11-08 16:00:02.050528
275	Robert	McDonald	robertmcdonald157@asu.edu	480-555-5509	hashed_pass_275	Architecture	Junior	\N	2025-11-08 16:00:02.050528
276	Frank	Chen	frankchen614@asu.edu	480-555-3561	hashed_pass_276	Economics	Junior	2025-06-26	2025-11-08 16:00:02.050528
277	Matthew	Jimenez	matthewjimenez817@asu.edu	480-555-8111	hashed_pass_277	Communications	Junior	2025-07-21	2025-11-08 16:00:02.050528
278	Michelle	Johnson	michellejohnson674@asu.edu	480-555-5165	hashed_pass_278	Political Science	Junior	\N	2025-11-08 16:00:02.050528
279	Jesse	Howard	jessehoward192@asu.edu	480-555-2521	hashed_pass_279	Biomedical Engineering	Junior	2025-08-18	2025-11-08 16:00:02.050528
280	Pamela	Clark	pamelaclark254@asu.edu	480-555-8363	hashed_pass_280	Finance	Junior	2025-07-06	2025-11-08 16:00:02.050528
281	Diane	Cox	dianecox964@asu.edu	480-555-5722	hashed_pass_281	Mathematics	Junior	2025-06-21	2025-11-08 16:00:02.050528
282	Donald	Wilson	donaldwilson846@asu.edu	480-555-5729	hashed_pass_282	Industrial Engineering	Junior	2025-07-25	2025-11-08 16:00:02.050528
283	Michael	Lee	michaellee694@asu.edu	480-555-3649	hashed_pass_283	Statistics	Junior	2025-07-01	2025-11-08 16:00:02.050528
284	Deborah	Brown	deborahbrown835@asu.edu	480-555-5296	hashed_pass_284	Management	Junior	2025-07-13	2025-11-08 16:00:02.050528
285	Ronald	Edwards	ronaldedwards645@asu.edu	480-555-1936	hashed_pass_285	Nursing	Junior	2025-08-17	2025-11-08 16:00:02.050528
286	Melissa	West	melissawest936@asu.edu	480-555-4574	hashed_pass_286	Business Analytics	Junior	2025-07-26	2025-11-08 16:00:02.050528
287	Jacob	Black	jacobblack351@asu.edu	480-555-4716	hashed_pass_287	Finance	Junior	2025-06-24	2025-11-08 16:00:02.050528
288	Jonathan	Owens	jonathanowens618@asu.edu	480-555-6415	hashed_pass_288	Finance	Junior	2025-06-23	2025-11-08 16:00:02.050528
289	Olivia	Bennett	oliviabennett619@asu.edu	480-555-3033	hashed_pass_289	Communications	Junior	\N	2025-11-08 16:00:02.050528
290	Raymond	Martin	raymondmartin408@asu.edu	480-555-7504	hashed_pass_290	Industrial Engineering	Junior	2025-07-22	2025-11-08 16:00:02.050528
291	Doris	Hunt	dorishunt330@asu.edu	480-555-2390	hashed_pass_291	Electrical Engineering	Junior	2025-07-05	2025-11-08 16:00:02.050528
292	Anthony	Wagner	anthonywagner460@asu.edu	480-555-4243	hashed_pass_292	Political Science	Junior	2025-07-26	2025-11-08 16:00:02.050528
293	Evelyn	Turner	evelynturner642@asu.edu	480-555-5669	hashed_pass_293	Psychology	Junior	2025-06-14	2025-11-08 16:00:02.050528
294	Jack	Morris	jackmorris31@asu.edu	480-555-9192	hashed_pass_294	Software Engineering	Junior	2025-08-16	2025-11-08 16:00:02.050528
295	Katherine	Kim	katherinekim717@asu.edu	480-555-9100	hashed_pass_295	Accounting	Junior	2025-07-07	2025-11-08 16:00:02.050528
296	Daniel	Johnson	danieljohnson783@asu.edu	480-555-3824	hashed_pass_296	Statistics	Junior	2025-07-17	2025-11-08 16:00:02.050528
297	Sarah	Barnes	sarahbarnes912@asu.edu	480-555-3512	hashed_pass_297	Environmental Science	Junior	2025-06-03	2025-11-08 16:00:02.050528
298	Steven	Jordan	stevenjordan811@asu.edu	480-555-4564	hashed_pass_298	Mechanical Engineering	Junior	2025-07-03	2025-11-08 16:00:02.050528
299	Jerry	Patel	jerrypatel292@asu.edu	480-555-3195	hashed_pass_299	Accounting	Junior	2025-08-01	2025-11-08 16:00:02.050528
300	Patricia	Phillips	patriciaphillips39@asu.edu	480-555-8335	hashed_pass_300	Communications	Junior	2025-07-28	2025-11-08 16:00:02.050528
301	Cynthia	Torres	cynthiatorres766@asu.edu	480-555-6287	hashed_pass_301	Graphic Design	Junior	2025-06-01	2025-11-08 16:00:02.050528
302	Marie	Sanders	mariesanders281@asu.edu	480-555-5222	hashed_pass_302	Software Engineering	Junior	\N	2025-11-08 16:00:02.050528
303	Virginia	Johnson	virginiajohnson497@asu.edu	480-555-5267	hashed_pass_303	Computer Information Systems	Junior	\N	2025-11-08 16:00:02.050528
304	Kayla	Jones	kaylajones706@asu.edu	480-555-4483	hashed_pass_304	Mathematics	Junior	2025-08-05	2025-11-08 16:00:02.050528
305	Terry	Gibson	terrygibson713@asu.edu	480-555-3785	hashed_pass_305	Nursing	Junior	2025-07-19	2025-11-08 16:00:02.050528
306	Brandon	Phillips	brandonphillips723@asu.edu	480-555-7422	hashed_pass_306	Biomedical Engineering	Junior	\N	2025-11-08 16:00:02.050528
307	Ronald	Freeman	ronaldfreeman708@asu.edu	480-555-5194	hashed_pass_307	Environmental Science	Junior	\N	2025-11-08 16:00:02.050528
308	Joshua	Fernandez	joshuafernandez936@asu.edu	480-555-1124	hashed_pass_308	Chemistry	Junior	2025-06-01	2025-11-08 16:00:02.050528
309	Carolyn	Ortiz	carolynortiz492@asu.edu	480-555-4118	hashed_pass_309	Electrical Engineering	Junior	2025-08-19	2025-11-08 16:00:02.050528
310	Pamela	Diaz	pameladiaz995@asu.edu	480-555-8333	hashed_pass_310	Mathematics	Junior	2025-07-01	2025-11-08 16:00:02.050528
311	Michael	Green	michaelgreen219@asu.edu	480-555-5836	hashed_pass_311	Nursing	Junior	2025-06-14	2025-11-08 16:00:02.050528
312	Andrea	Brown	andreabrown232@asu.edu	480-555-4116	hashed_pass_312	Graphic Design	Junior	2025-07-24	2025-11-08 16:00:02.050528
313	Frances	McDonald	francesmcdonald631@asu.edu	480-555-9698	hashed_pass_313	Aerospace Engineering	Junior	2025-06-07	2025-11-08 16:00:02.050528
314	Christian	Martinez	christianmartinez754@asu.edu	480-555-6150	hashed_pass_314	Management	Junior	2025-07-13	2025-11-08 16:00:02.050528
315	Arthur	King	arthurking175@asu.edu	480-555-1664	hashed_pass_315	Biomedical Engineering	Junior	2025-08-04	2025-11-08 16:00:02.050528
316	Beverly	Guzman	beverlyguzman991@asu.edu	480-555-1197	hashed_pass_316	Artificial Intelligence	Junior	2025-07-04	2025-11-08 16:00:02.050528
317	Jerry	Barnes	jerrybarnes476@asu.edu	480-555-7162	hashed_pass_317	Statistics	Junior	2025-08-19	2025-11-08 16:00:02.050528
318	Beverly	Adams	beverlyadams947@asu.edu	480-555-3939	hashed_pass_318	International Business	Junior	2025-07-16	2025-11-08 16:00:02.050528
319	Deborah	Walker	deborahwalker905@asu.edu	480-555-3333	hashed_pass_319	Business	Junior	2025-06-17	2025-11-08 16:00:02.050528
320	Mia	Hayes	miahayes217@asu.edu	480-555-5635	hashed_pass_320	Computer Information Systems	Junior	\N	2025-11-08 16:00:02.050528
321	Ava	Ellis	avaellis825@asu.edu	480-555-1607	hashed_pass_321	Civil Engineering	Junior	2025-08-17	2025-11-08 16:00:02.050528
322	Amy	Kelly	amykelly836@asu.edu	480-555-1817	hashed_pass_322	Electrical Engineering	Junior	2025-07-19	2025-11-08 16:00:02.050528
323	Jeffrey	Simmons	jeffreysimmons132@asu.edu	480-555-7693	hashed_pass_323	Cybersecurity	Junior	2025-06-02	2025-11-08 16:00:02.050528
324	Helen	Miller	helenmiller924@asu.edu	480-555-5378	hashed_pass_324	Finance	Junior	2025-06-02	2025-11-08 16:00:02.050528
325	Joan	Taylor	joantaylor786@asu.edu	480-555-6715	hashed_pass_325	Software Engineering	Junior	2025-06-05	2025-11-08 16:00:02.050528
326	Frank	Jimenez	frankjimenez603@asu.edu	480-555-3441	hashed_pass_326	Architecture	Junior	2025-07-22	2025-11-08 16:00:02.050528
327	Brandon	Palmer	brandonpalmer862@asu.edu	480-555-9150	hashed_pass_327	Mathematics	Junior	2025-07-27	2025-11-08 16:00:02.050528
328	Katherine	Jordan	katherinejordan5@asu.edu	480-555-3718	hashed_pass_328	Physics	Junior	2025-07-30	2025-11-08 16:00:02.050528
329	Jeremy	Walker	jeremywalker899@asu.edu	480-555-3563	hashed_pass_329	Psychology	Junior	\N	2025-11-08 16:00:02.050528
330	Nancy	Reyes	nancyreyes539@asu.edu	480-555-3121	hashed_pass_330	Artificial Intelligence	Junior	\N	2025-11-08 16:00:02.050528
331	Mary	Murphy	marymurphy789@asu.edu	480-555-6874	hashed_pass_331	Computer Science	Junior	2025-06-22	2025-11-08 16:00:02.050528
332	Anna	Mitchell	annamitchell823@asu.edu	480-555-3125	hashed_pass_332	Communications	Junior	2025-08-09	2025-11-08 16:00:02.050528
333	David	Harris	davidharris438@asu.edu	480-555-5136	hashed_pass_333	Software Engineering	Junior	2025-06-18	2025-11-08 16:00:02.050528
334	Jason	Webb	jasonwebb101@asu.edu	480-555-6517	hashed_pass_334	Public Health	Junior	2025-07-20	2025-11-08 16:00:02.050528
335	Nancy	Rose	nancyrose904@asu.edu	480-555-2429	hashed_pass_335	Economics	Junior	2025-08-15	2025-11-08 16:00:02.050528
336	Mark	Wood	markwood332@asu.edu	480-555-3535	hashed_pass_336	Cybersecurity	Junior	2025-07-05	2025-11-08 16:00:02.050528
337	Noah	Miller	noahmiller346@asu.edu	480-555-3634	hashed_pass_337	Public Health	Junior	2025-08-12	2025-11-08 16:00:02.050528
338	Russell	Hamilton	russellhamilton520@asu.edu	480-555-3096	hashed_pass_338	Data Science	Junior	2025-07-12	2025-11-08 16:00:02.050528
339	Richard	Olson	richardolson132@asu.edu	480-555-9009	hashed_pass_339	Computer Information Systems	Junior	\N	2025-11-08 16:00:02.050528
340	Keith	Bell	keithbell656@asu.edu	480-555-2689	hashed_pass_340	Industrial Engineering	Junior	2025-07-15	2025-11-08 16:00:02.050528
341	Dylan	Myers	dylanmyers214@asu.edu	480-555-9784	hashed_pass_341	Biomedical Engineering	Junior	\N	2025-11-08 16:00:02.050528
342	Linda	Castillo	lindacastillo196@asu.edu	480-555-8328	hashed_pass_342	Architecture	Junior	2025-08-09	2025-11-08 16:00:02.050528
343	Tyler	Foster	tylerfoster217@asu.edu	480-555-8235	hashed_pass_343	Computer Information Systems	Junior	2025-08-18	2025-11-08 16:00:02.050528
344	Nancy	White	nancywhite367@asu.edu	480-555-2823	hashed_pass_344	Civil Engineering	Junior	\N	2025-11-08 16:00:02.050528
345	Carolyn	Castro	carolyncastro249@asu.edu	480-555-3813	hashed_pass_345	Computer Information Systems	Junior	2025-07-28	2025-11-08 16:00:02.050528
346	Nancy	Murphy	nancymurphy802@asu.edu	480-555-9021	hashed_pass_346	Industrial Engineering	Junior	\N	2025-11-08 16:00:02.050528
347	Martha	Ramirez	martharamirez246@asu.edu	480-555-5425	hashed_pass_347	Chemistry	Junior	2025-07-04	2025-11-08 16:00:02.050528
348	Joseph	Snyder	josephsnyder314@asu.edu	480-555-9723	hashed_pass_348	Healthcare Administration	Junior	2025-08-09	2025-11-08 16:00:02.050528
349	Brian	Robinson	brianrobinson601@asu.edu	480-555-7285	hashed_pass_349	Psychology	Junior	2025-08-16	2025-11-08 16:00:02.050528
350	Alan	Peterson	alanpeterson61@asu.edu	480-555-1727	hashed_pass_350	Graphic Design	Junior	\N	2025-11-08 16:00:02.050528
351	Andrea	Fernandez	andreafernandez890@asu.edu	480-555-8951	hashed_pass_351	Political Science	Junior	2025-06-23	2025-11-08 16:00:02.050528
352	Wayne	Fisher	waynefisher41@asu.edu	480-555-4862	hashed_pass_352	Graphic Design	Junior	2025-08-09	2025-11-08 16:00:02.050528
353	Vincent	Anderson	vincentanderson80@asu.edu	480-555-8262	hashed_pass_353	Graphic Design	Junior	2025-08-07	2025-11-08 16:00:02.050528
354	Teresa	Hernandez	teresahernandez432@asu.edu	480-555-7784	hashed_pass_354	Psychology	Junior	2025-08-01	2025-11-08 16:00:02.050528
355	Edward	Ramos	edwardramos589@asu.edu	480-555-2637	hashed_pass_355	Psychology	Junior	2025-06-30	2025-11-08 16:00:02.050528
356	Ann	Gordon	anngordon268@asu.edu	480-555-1193	hashed_pass_356	Public Health	Junior	\N	2025-11-08 16:00:02.050528
357	Olivia	Fisher	oliviafisher70@asu.edu	480-555-6863	hashed_pass_357	Data Science	Junior	2025-07-21	2025-11-08 16:00:02.050528
358	Deborah	Bryant	deborahbryant294@asu.edu	480-555-9377	hashed_pass_358	Biochemistry	Junior	2025-08-07	2025-11-08 16:00:02.050528
359	Theresa	Bennett	theresabennett746@asu.edu	480-555-5688	hashed_pass_359	Communications	Junior	2025-08-15	2025-11-08 16:00:02.050528
360	Amber	Alvarez	amberalvarez687@asu.edu	480-555-3136	hashed_pass_360	Business	Junior	\N	2025-11-08 16:00:02.050528
361	Shirley	Murray	shirleymurray619@asu.edu	480-555-3438	hashed_pass_361	Aerospace Engineering	Junior	2025-08-09	2025-11-08 16:00:02.050528
362	Vincent	Miller	vincentmiller864@asu.edu	480-555-7494	hashed_pass_362	Environmental Science	Junior	\N	2025-11-08 16:00:02.050528
363	Diane	Foster	dianefoster626@asu.edu	480-555-8895	hashed_pass_363	Computer Science	Junior	2025-06-15	2025-11-08 16:00:02.050528
364	Kenneth	Herrera	kennethherrera555@asu.edu	480-555-6718	hashed_pass_364	Industrial Engineering	Junior	2025-06-28	2025-11-08 16:00:02.050528
365	Marilyn	Hicks	marilynhicks238@asu.edu	480-555-2754	hashed_pass_365	Biomedical Engineering	Junior	2025-06-16	2025-11-08 16:00:02.050528
366	Jennifer	Alvarez	jenniferalvarez329@asu.edu	480-555-1794	hashed_pass_366	Marketing	Junior	2025-06-30	2025-11-08 16:00:02.050528
367	Sophia	Morales	sophiamorales960@asu.edu	480-555-8887	hashed_pass_367	Management	Junior	2025-06-13	2025-11-08 16:00:02.050528
368	Teresa	Phillips	teresaphillips127@asu.edu	480-555-5419	hashed_pass_368	Accounting	Junior	2025-07-23	2025-11-08 16:00:02.050528
369	Harold	Fernandez	haroldfernandez505@asu.edu	480-555-1421	hashed_pass_369	Biochemistry	Junior	2025-08-10	2025-11-08 16:00:02.050528
370	Jacob	Rogers	jacobrogers164@asu.edu	480-555-4514	hashed_pass_370	Mathematics	Junior	2025-06-12	2025-11-08 16:00:02.050528
371	Douglas	Washington	douglaswashington67@asu.edu	480-555-5436	hashed_pass_371	Business Analytics	Junior	2025-08-03	2025-11-08 16:00:02.050528
372	Anthony	Mason	anthonymason658@asu.edu	480-555-6878	hashed_pass_372	Business	Junior	2025-07-08	2025-11-08 16:00:02.050528
373	Laura	Scott	laurascott11@asu.edu	480-555-8870	hashed_pass_373	Computer Information Systems	Junior	2025-06-01	2025-11-08 16:00:02.050528
374	George	Wells	georgewells590@asu.edu	480-555-4718	hashed_pass_374	Statistics	Junior	2025-07-05	2025-11-08 16:00:02.050528
375	Barbara	Powell	barbarapowell792@asu.edu	480-555-6405	hashed_pass_375	Political Science	Junior	2025-06-16	2025-11-08 16:00:02.050528
376	Stephen	Robinson	stephenrobinson124@asu.edu	480-555-5730	hashed_pass_376	Mechanical Engineering	Senior	2025-07-21	2025-11-08 16:00:02.050528
377	Carolyn	Barnes	carolynbarnes389@asu.edu	480-555-3072	hashed_pass_377	Civil Engineering	Senior	2025-05-30	2025-11-08 16:00:02.050528
378	Ralph	Crawford	ralphcrawford693@asu.edu	480-555-3504	hashed_pass_378	Political Science	Senior	2025-07-23	2025-11-08 16:00:02.050528
379	Justin	Rodriguez	justinrodriguez188@asu.edu	480-555-3108	hashed_pass_379	Psychology	Senior	2025-08-12	2025-11-08 16:00:02.050528
380	Amy	Romero	amyromero369@asu.edu	480-555-2113	hashed_pass_380	Civil Engineering	Senior	2025-05-27	2025-11-08 16:00:02.050528
381	Hannah	Jones	hannahjones99@asu.edu	480-555-5317	hashed_pass_381	Supply Chain Management	Senior	2025-07-10	2025-11-08 16:00:02.050528
382	Nancy	Jenkins	nancyjenkins276@asu.edu	480-555-9591	hashed_pass_382	Artificial Intelligence	Senior	\N	2025-11-08 16:00:02.050528
383	Gloria	Robertson	gloriarobertson455@asu.edu	480-555-4457	hashed_pass_383	Biochemistry	Senior	2025-08-11	2025-11-08 16:00:02.050528
384	Denise	West	denisewest764@asu.edu	480-555-8789	hashed_pass_384	Economics	Senior	\N	2025-11-08 16:00:02.050528
385	Charles	Murphy	charlesmurphy564@asu.edu	480-555-7927	hashed_pass_385	Business	Senior	2025-08-12	2025-11-08 16:00:02.050528
386	Mia	Coleman	miacoleman601@asu.edu	480-555-3183	hashed_pass_386	Finance	Senior	2025-08-07	2025-11-08 16:00:02.050528
387	Sean	Silva	seansilva474@asu.edu	480-555-6249	hashed_pass_387	Chemistry	Senior	2025-05-19	2025-11-08 16:00:02.050528
388	Joseph	Collins	josephcollins970@asu.edu	480-555-9485	hashed_pass_388	Software Engineering	Senior	2025-06-30	2025-11-08 16:00:02.050528
389	Henry	Mendez	henrymendez59@asu.edu	480-555-3018	hashed_pass_389	Communications	Senior	\N	2025-11-08 16:00:02.050528
390	Alan	Wagner	alanwagner200@asu.edu	480-555-8736	hashed_pass_390	Biomedical Engineering	Senior	2025-05-15	2025-11-08 16:00:02.050528
391	William	Reynolds	williamreynolds512@asu.edu	480-555-2599	hashed_pass_391	Healthcare Administration	Senior	2025-06-29	2025-11-08 16:00:02.050528
392	Michael	Sullivan	michaelsullivan846@asu.edu	480-555-6516	hashed_pass_392	Nursing	Senior	\N	2025-11-08 16:00:02.050528
393	Melissa	Hall	melissahall883@asu.edu	480-555-6327	hashed_pass_393	Civil Engineering	Senior	2025-05-22	2025-11-08 16:00:02.050528
394	Janice	Jenkins	janicejenkins344@asu.edu	480-555-6865	hashed_pass_394	Graphic Design	Senior	\N	2025-11-08 16:00:02.050528
395	Carolyn	Freeman	carolynfreeman424@asu.edu	480-555-7447	hashed_pass_395	Physics	Senior	2025-08-06	2025-11-08 16:00:02.050528
396	Samantha	Peterson	samanthapeterson596@asu.edu	480-555-6087	hashed_pass_396	Aerospace Engineering	Senior	\N	2025-11-08 16:00:02.050528
397	Julie	Marshall	juliemarshall753@asu.edu	480-555-9047	hashed_pass_397	Biochemistry	Senior	2025-06-14	2025-11-08 16:00:02.050528
398	Abigail	White	abigailwhite95@asu.edu	480-555-7952	hashed_pass_398	Artificial Intelligence	Senior	2025-08-03	2025-11-08 16:00:02.050528
399	Alice	Tucker	alicetucker854@asu.edu	480-555-6538	hashed_pass_399	Physics	Senior	2025-06-05	2025-11-08 16:00:02.050528
400	Kathleen	Crawford	kathleencrawford815@asu.edu	480-555-2148	hashed_pass_400	Public Health	Senior	2025-05-15	2025-11-08 16:00:02.050528
401	Ronald	Moreno	ronaldmoreno72@asu.edu	480-555-1548	hashed_pass_401	Marketing	Senior	2025-06-23	2025-11-08 16:00:02.050528
402	Emily	Wagner	emilywagner738@asu.edu	480-555-4355	hashed_pass_402	Accounting	Senior	2025-06-29	2025-11-08 16:00:02.050528
403	Gabriel	Cook	gabrielcook636@asu.edu	480-555-3854	hashed_pass_403	Biomedical Engineering	Senior	\N	2025-11-08 16:00:02.050528
404	Janet	Murray	janetmurray83@asu.edu	480-555-9119	hashed_pass_404	Nursing	Senior	2025-06-12	2025-11-08 16:00:02.050528
405	Joshua	Chavez	joshuachavez872@asu.edu	480-555-4844	hashed_pass_405	Biology	Senior	2025-07-20	2025-11-08 16:00:02.050528
406	Timothy	Morales	timothymorales759@asu.edu	480-555-2317	hashed_pass_406	Marketing	Senior	2025-07-23	2025-11-08 16:00:02.050528
407	Martha	Castillo	marthacastillo725@asu.edu	480-555-9102	hashed_pass_407	Physics	Senior	\N	2025-11-08 16:00:02.050528
408	Sara	Dixon	saradixon664@asu.edu	480-555-6900	hashed_pass_408	Biomedical Engineering	Senior	2025-05-15	2025-11-08 16:00:02.050528
409	Marie	Tran	marietran76@asu.edu	480-555-1656	hashed_pass_409	Computer Science	Senior	2025-06-20	2025-11-08 16:00:02.050528
410	Paul	Clark	paulclark342@asu.edu	480-555-5226	hashed_pass_410	Biochemistry	Senior	\N	2025-11-08 16:00:02.050528
411	Vincent	Hamilton	vincenthamilton893@asu.edu	480-555-6156	hashed_pass_411	Finance	Senior	\N	2025-11-08 16:00:02.050528
412	Virginia	Mendez	virginiamendez501@asu.edu	480-555-5672	hashed_pass_412	Accounting	Senior	2025-06-18	2025-11-08 16:00:02.050528
413	John	Powell	johnpowell512@asu.edu	480-555-5333	hashed_pass_413	Biochemistry	Senior	2025-07-12	2025-11-08 16:00:02.050528
414	James	Russell	jamesrussell175@asu.edu	480-555-1610	hashed_pass_414	Architecture	Senior	2025-05-19	2025-11-08 16:00:02.050528
415	Olivia	Ward	oliviaward597@asu.edu	480-555-1271	hashed_pass_415	Computer Information Systems	Senior	2025-07-09	2025-11-08 16:00:02.050528
416	Samuel	Campbell	samuelcampbell119@asu.edu	480-555-4431	hashed_pass_416	Chemistry	Senior	2025-07-05	2025-11-08 16:00:02.050528
417	Ava	Torres	avatorres989@asu.edu	480-555-3086	hashed_pass_417	Marketing	Senior	2025-06-27	2025-11-08 16:00:02.050528
418	Jeffrey	Bailey	jeffreybailey616@asu.edu	480-555-2756	hashed_pass_418	International Business	Senior	\N	2025-11-08 16:00:02.050528
419	James	Wright	jameswright926@asu.edu	480-555-3277	hashed_pass_419	Chemistry	Senior	\N	2025-11-08 16:00:02.050528
420	Lisa	Phillips	lisaphillips159@asu.edu	480-555-1605	hashed_pass_420	Aerospace Engineering	Senior	2025-06-09	2025-11-08 16:00:02.050528
421	Lisa	Perez	lisaperez939@asu.edu	480-555-2608	hashed_pass_421	Business Analytics	Senior	2025-06-09	2025-11-08 16:00:02.050528
422	Donald	Torres	donaldtorres900@asu.edu	480-555-2318	hashed_pass_422	Architecture	Senior	2025-07-11	2025-11-08 16:00:02.050528
423	Patrick	Castillo	patrickcastillo71@asu.edu	480-555-1133	hashed_pass_423	Electrical Engineering	Senior	2025-06-26	2025-11-08 16:00:02.050528
424	Elizabeth	Diaz	elizabethdiaz520@asu.edu	480-555-1727	hashed_pass_424	Biomedical Engineering	Senior	2025-05-23	2025-11-08 16:00:02.050528
425	Arthur	Kennedy	arthurkennedy910@asu.edu	480-555-6249	hashed_pass_425	Computer Science	Senior	\N	2025-11-08 16:00:02.050528
426	Hannah	Roberts	hannahroberts388@asu.edu	480-555-4904	hashed_pass_426	Business	Senior	\N	2025-11-08 16:00:02.050528
427	Andrea	Hall	andreahall102@asu.edu	480-555-7949	hashed_pass_427	Computer Information Systems	Senior	2025-06-07	2025-11-08 16:00:02.050528
428	Danielle	Collins	daniellecollins411@asu.edu	480-555-8387	hashed_pass_428	Architecture	Senior	2025-07-26	2025-11-08 16:00:02.050528
429	Bobby	Chen	bobbychen87@asu.edu	480-555-3208	hashed_pass_429	Computer Information Systems	Senior	2025-07-31	2025-11-08 16:00:02.050528
430	Diane	Hamilton	dianehamilton714@asu.edu	480-555-4474	hashed_pass_430	Political Science	Senior	2025-05-15	2025-11-08 16:00:02.050528
431	Sarah	Myers	sarahmyers308@asu.edu	480-555-8927	hashed_pass_431	Political Science	Senior	\N	2025-11-08 16:00:02.050528
432	Alexander	Long	alexanderlong395@asu.edu	480-555-3268	hashed_pass_432	Data Science	Senior	\N	2025-11-08 16:00:02.050528
433	Ralph	Diaz	ralphdiaz170@asu.edu	480-555-5157	hashed_pass_433	Artificial Intelligence	Senior	2025-05-18	2025-11-08 16:00:02.050528
434	Donald	Barnes	donaldbarnes696@asu.edu	480-555-2468	hashed_pass_434	Architecture	Senior	\N	2025-11-08 16:00:02.050528
435	Patricia	Garcia	patriciagarcia959@asu.edu	480-555-9165	hashed_pass_435	Biomedical Engineering	Senior	2025-08-10	2025-11-08 16:00:02.050528
436	Kathleen	Jones	kathleenjones738@asu.edu	480-555-7951	hashed_pass_436	Data Science	Senior	2025-07-28	2025-11-08 16:00:02.050528
437	Nathan	Boyd	nathanboyd316@asu.edu	480-555-7230	hashed_pass_437	Environmental Science	Senior	\N	2025-11-08 16:00:02.050528
438	Eugene	Cole	eugenecole787@asu.edu	480-555-1462	hashed_pass_438	Journalism	Senior	\N	2025-11-08 16:00:02.050528
439	Nathan	Aguilar	nathanaguilar964@asu.edu	480-555-8012	hashed_pass_439	Biology	Senior	2025-07-01	2025-11-08 16:00:02.050528
440	Maria	Smith	mariasmith931@asu.edu	480-555-9562	hashed_pass_440	Statistics	Senior	\N	2025-11-08 16:00:02.050528
441	Justin	Kim	justinkim896@asu.edu	480-555-7075	hashed_pass_441	Economics	Senior	2025-06-13	2025-11-08 16:00:02.050528
442	Douglas	Kelly	douglaskelly454@asu.edu	480-555-4247	hashed_pass_442	Psychology	Senior	2025-07-31	2025-11-08 16:00:02.050528
443	William	Kennedy	williamkennedy244@asu.edu	480-555-5149	hashed_pass_443	Supply Chain Management	Senior	2025-05-28	2025-11-08 16:00:02.050528
444	Ashley	West	ashleywest806@asu.edu	480-555-7022	hashed_pass_444	Business Analytics	Senior	2025-06-19	2025-11-08 16:00:02.050528
445	Deborah	Simmons	deborahsimmons460@asu.edu	480-555-1420	hashed_pass_445	Software Engineering	Senior	2025-05-24	2025-11-08 16:00:02.050528
446	Angela	Jackson	angelajackson844@asu.edu	480-555-7749	hashed_pass_446	Accounting	Senior	2025-07-16	2025-11-08 16:00:02.050528
447	Cheryl	Reyes	cherylreyes400@asu.edu	480-555-5375	hashed_pass_447	Public Health	Senior	2025-08-14	2025-11-08 16:00:02.050528
448	Randy	Morales	randymorales345@asu.edu	480-555-4323	hashed_pass_448	Software Engineering	Senior	2025-05-30	2025-11-08 16:00:02.050528
449	Harold	Phillips	haroldphillips505@asu.edu	480-555-3266	hashed_pass_449	Journalism	Senior	2025-05-25	2025-11-08 16:00:02.050528
450	Ava	Scott	avascott730@asu.edu	480-555-9120	hashed_pass_450	Industrial Engineering	Senior	2025-07-06	2025-11-08 16:00:02.050528
451	Susan	Davis	susandavis787@asu.edu	480-555-4714	hashed_pass_451	Aerospace Engineering	Graduate	2025-05-02	2025-11-08 16:00:02.050528
452	Sandra	Jackson	sandrajackson397@asu.edu	480-555-4879	hashed_pass_452	Industrial Engineering	Graduate	2025-08-08	2025-11-08 16:00:02.050528
453	Jacqueline	Mason	jacquelinemason149@asu.edu	480-555-8715	hashed_pass_453	Marketing	Graduate	2025-05-16	2025-11-08 16:00:02.050528
454	Christopher	Washington	christopherwashington421@asu.edu	480-555-3053	hashed_pass_454	Computer Science	Graduate	2025-06-27	2025-11-08 16:00:02.050528
455	Roger	Cook	rogercook394@asu.edu	480-555-8432	hashed_pass_455	Physics	Graduate	2025-07-29	2025-11-08 16:00:02.050528
456	Walter	Gibson	waltergibson668@asu.edu	480-555-6291	hashed_pass_456	Data Science	Graduate	2025-06-16	2025-11-08 16:00:02.050528
457	Jennifer	Bryant	jenniferbryant958@asu.edu	480-555-8729	hashed_pass_457	Psychology	Graduate	2025-08-22	2025-11-08 16:00:02.050528
458	Ruth	Garcia	ruthgarcia363@asu.edu	480-555-2575	hashed_pass_458	Finance	Graduate	2025-07-29	2025-11-08 16:00:02.050528
459	Peter	Allen	peterallen455@asu.edu	480-555-2559	hashed_pass_459	Marketing	Graduate	2025-05-20	2025-11-08 16:00:02.050528
460	Roger	Gutierrez	rogergutierrez845@asu.edu	480-555-8207	hashed_pass_460	Economics	Graduate	2025-06-17	2025-11-08 16:00:02.050528
461	Barbara	Tran	barbaratran193@asu.edu	480-555-2591	hashed_pass_461	Chemistry	Graduate	2025-06-29	2025-11-08 16:00:02.050528
462	Beverly	Hall	beverlyhall504@asu.edu	480-555-7668	hashed_pass_462	Marketing	Graduate	2025-08-21	2025-11-08 16:00:02.050528
463	Helen	Evans	helenevans357@asu.edu	480-555-2863	hashed_pass_463	Management	Graduate	2025-06-19	2025-11-08 16:00:02.050528
464	Madison	Coleman	madisoncoleman41@asu.edu	480-555-1210	hashed_pass_464	Business	Graduate	2025-05-24	2025-11-08 16:00:02.050528
465	Pamela	Reed	pamelareed732@asu.edu	480-555-9883	hashed_pass_465	Public Health	Graduate	2025-06-20	2025-11-08 16:00:02.050528
466	Joan	Hernandez	joanhernandez458@asu.edu	480-555-5070	hashed_pass_466	Nursing	Graduate	2025-07-08	2025-11-08 16:00:02.050528
467	Kelly	Aguilar	kellyaguilar493@asu.edu	480-555-4530	hashed_pass_467	Economics	Graduate	\N	2025-11-08 16:00:02.050528
468	Harold	Peterson	haroldpeterson172@asu.edu	480-555-4236	hashed_pass_468	Aerospace Engineering	Graduate	2025-06-17	2025-11-08 16:00:02.050528
469	Walter	Castillo	waltercastillo913@asu.edu	480-555-6497	hashed_pass_469	Management	Graduate	2025-08-24	2025-11-08 16:00:02.050528
470	Nathan	Vargas	nathanvargas11@asu.edu	480-555-1342	hashed_pass_470	Supply Chain Management	Graduate	\N	2025-11-08 16:00:02.050528
471	Paul	Moreno	paulmoreno632@asu.edu	480-555-1495	hashed_pass_471	Industrial Engineering	Graduate	2025-08-05	2025-11-08 16:00:02.050528
472	Gregory	Myers	gregorymyers436@asu.edu	480-555-6004	hashed_pass_472	Chemistry	Graduate	2025-06-04	2025-11-08 16:00:02.050528
473	Johnny	Baker	johnnybaker785@asu.edu	480-555-1916	hashed_pass_473	Accounting	Graduate	2025-06-21	2025-11-08 16:00:02.050528
474	Ralph	Mitchell	ralphmitchell378@asu.edu	480-555-3990	hashed_pass_474	Industrial Engineering	Graduate	2025-08-30	2025-11-08 16:00:02.050528
475	Julie	Carter	juliecarter477@asu.edu	480-555-8498	hashed_pass_475	Healthcare Administration	Graduate	2025-06-30	2025-11-08 16:00:02.050528
476	Justin	Hayes	justinhayes280@asu.edu	480-555-4402	hashed_pass_476	Civil Engineering	Graduate	2025-05-21	2025-11-08 16:00:02.050528
477	Jeremy	Webb	jeremywebb31@asu.edu	480-555-4453	hashed_pass_477	Management	Graduate	2025-09-01	2025-11-08 16:00:02.050528
478	Benjamin	Garcia	benjamingarcia991@asu.edu	480-555-3445	hashed_pass_478	Statistics	Graduate	2025-08-25	2025-11-08 16:00:02.050528
479	Ryan	Rodriguez	ryanrodriguez315@asu.edu	480-555-1460	hashed_pass_479	Computer Science	Graduate	2025-05-12	2025-11-08 16:00:02.050528
480	Gary	Lewis	garylewis249@asu.edu	480-555-3603	hashed_pass_480	Management	Graduate	\N	2025-11-08 16:00:02.050528
481	Jeffrey	Sanders	jeffreysanders151@asu.edu	480-555-3906	hashed_pass_481	Business Analytics	Graduate	2025-07-28	2025-11-08 16:00:02.050528
482	Bryan	Stevens	bryanstevens125@asu.edu	480-555-1937	hashed_pass_482	Psychology	Graduate	2025-05-29	2025-11-08 16:00:02.050528
483	Christine	Alvarez	christinealvarez607@asu.edu	480-555-8639	hashed_pass_483	Political Science	Graduate	2025-07-20	2025-11-08 16:00:02.050528
484	Katherine	Kennedy	katherinekennedy49@asu.edu	480-555-3514	hashed_pass_484	Marketing	Graduate	\N	2025-11-08 16:00:02.050528
485	Denise	Hunter	denisehunter976@asu.edu	480-555-4057	hashed_pass_485	Artificial Intelligence	Graduate	2025-08-30	2025-11-08 16:00:02.050528
486	Diana	Mitchell	dianamitchell531@asu.edu	480-555-3903	hashed_pass_486	International Business	Graduate	2025-07-15	2025-11-08 16:00:02.050528
487	Andrew	Aguilar	andrewaguilar306@asu.edu	480-555-5781	hashed_pass_487	Computer Information Systems	Graduate	\N	2025-11-08 16:00:02.050528
488	Ethan	Kim	ethankim63@asu.edu	480-555-9670	hashed_pass_488	Artificial Intelligence	Graduate	\N	2025-11-08 16:00:02.050528
489	Billy	Cole	billycole483@asu.edu	480-555-6352	hashed_pass_489	Public Health	Graduate	2025-06-28	2025-11-08 16:00:02.050528
490	Gregory	Murray	gregorymurray585@asu.edu	480-555-9406	hashed_pass_490	Healthcare Administration	Graduate	2025-08-28	2025-11-08 16:00:02.050528
491	Charles	Murray	charlesmurray111@asu.edu	480-555-2235	hashed_pass_491	Biochemistry	Graduate	2025-07-15	2025-11-08 16:00:02.050528
492	Susan	Aguilar	susanaguilar370@asu.edu	480-555-4756	hashed_pass_492	Management	Graduate	\N	2025-11-08 16:00:02.050528
493	Justin	Webb	justinwebb967@asu.edu	480-555-6067	hashed_pass_493	Healthcare Administration	Graduate	2025-06-22	2025-11-08 16:00:02.050528
494	Emily	Sanchez	emilysanchez870@asu.edu	480-555-2736	hashed_pass_494	Software Engineering	Graduate	2025-08-06	2025-11-08 16:00:02.050528
495	Gloria	Carter	gloriacarter320@asu.edu	480-555-9798	hashed_pass_495	Electrical Engineering	Graduate	2025-07-18	2025-11-08 16:00:02.050528
496	Elijah	Adams	elijahadams794@asu.edu	480-555-9382	hashed_pass_496	Civil Engineering	Graduate	2025-06-06	2025-11-08 16:00:02.050528
497	Zachary	Johnson	zacharyjohnson488@asu.edu	480-555-2005	hashed_pass_497	Statistics	Graduate	2025-05-25	2025-11-08 16:00:02.050528
498	Jack	Moore	jackmoore278@asu.edu	480-555-9899	hashed_pass_498	Healthcare Administration	Graduate	2025-08-18	2025-11-08 16:00:02.050528
499	Victoria	Rose	victoriarose222@asu.edu	480-555-4432	hashed_pass_499	Supply Chain Management	Graduate	2025-05-17	2025-11-08 16:00:02.050528
500	Janet	Diaz	janetdiaz471@asu.edu	480-555-9449	hashed_pass_500	Mathematics	Graduate	\N	2025-11-08 16:00:02.050528
507	John	Smith	jsmith123@asu.edu	1234567891	$2b$10$gGc1tRj0e71iRYMIlUwHs.lXqaqEi52fXr1ukFWVmZMdkhsJ.9Cpa	Computer Science	Junior	\N	2025-12-01 22:17:34.014161
\.


--
-- Name: apartmentunit_unitid_seq; Type: SEQUENCE SET; Schema: public; Owner: drish
--

SELECT pg_catalog.setval('public.apartmentunit_unitid_seq', 2501, true);


--
-- Name: favorite_favoriteid_seq; Type: SEQUENCE SET; Schema: public; Owner: drish
--

SELECT pg_catalog.setval('public.favorite_favoriteid_seq', 308, true);


--
-- Name: property_propertyid_seq; Type: SEQUENCE SET; Schema: public; Owner: drish
--

SELECT pg_catalog.setval('public.property_propertyid_seq', 50, true);


--
-- Name: propertymanager_managerid_seq; Type: SEQUENCE SET; Schema: public; Owner: drish
--

SELECT pg_catalog.setval('public.propertymanager_managerid_seq', 10, true);


--
-- Name: student_studentid_seq; Type: SEQUENCE SET; Schema: public; Owner: drish
--

SELECT pg_catalog.setval('public.student_studentid_seq', 507, true);


--
-- Name: apartmentunit apartmentunit_pkey; Type: CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.apartmentunit
    ADD CONSTRAINT apartmentunit_pkey PRIMARY KEY (unitid);


--
-- Name: apartmentunit apartmentunit_propertyid_unitnumber_key; Type: CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.apartmentunit
    ADD CONSTRAINT apartmentunit_propertyid_unitnumber_key UNIQUE (propertyid, unitnumber);


--
-- Name: favorite favorite_pkey; Type: CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT favorite_pkey PRIMARY KEY (favoriteid);


--
-- Name: favorite favorite_studentid_unitid_key; Type: CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT favorite_studentid_unitid_key UNIQUE (studentid, unitid);


--
-- Name: property property_pkey; Type: CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_pkey PRIMARY KEY (propertyid);


--
-- Name: propertymanager propertymanager_email_key; Type: CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.propertymanager
    ADD CONSTRAINT propertymanager_email_key UNIQUE (email);


--
-- Name: propertymanager propertymanager_licensenumber_key; Type: CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.propertymanager
    ADD CONSTRAINT propertymanager_licensenumber_key UNIQUE (licensenumber);


--
-- Name: propertymanager propertymanager_pkey; Type: CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.propertymanager
    ADD CONSTRAINT propertymanager_pkey PRIMARY KEY (managerid);


--
-- Name: student student_email_key; Type: CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_email_key UNIQUE (email);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (studentid);


--
-- Name: idx_favorite_date; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_favorite_date ON public.favorite USING btree (datesaved);


--
-- Name: idx_favorite_student; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_favorite_student ON public.favorite USING btree (studentid);


--
-- Name: idx_favorite_unit; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_favorite_unit ON public.favorite USING btree (unitid);


--
-- Name: idx_manager_email; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_manager_email ON public.propertymanager USING btree (email);


--
-- Name: idx_property_city; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_property_city ON public.property USING btree (city);


--
-- Name: idx_property_distance; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_property_distance ON public.property USING btree (distancefromcampus);


--
-- Name: idx_property_manager; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_property_manager ON public.property USING btree (managerid);


--
-- Name: idx_student_email; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_student_email ON public.student USING btree (email);


--
-- Name: idx_unit_available; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_unit_available ON public.apartmentunit USING btree (isavailable);


--
-- Name: idx_unit_available_date; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_unit_available_date ON public.apartmentunit USING btree (availabledate);


--
-- Name: idx_unit_bedrooms; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_unit_bedrooms ON public.apartmentunit USING btree (bedrooms);


--
-- Name: idx_unit_property; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_unit_property ON public.apartmentunit USING btree (propertyid);


--
-- Name: idx_unit_rent; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_unit_rent ON public.apartmentunit USING btree (monthlyrent);


--
-- Name: idx_unit_search; Type: INDEX; Schema: public; Owner: drish
--

CREATE INDEX idx_unit_search ON public.apartmentunit USING btree (bedrooms, monthlyrent, isavailable);


--
-- Name: apartmentunit apartmentunit_propertyid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.apartmentunit
    ADD CONSTRAINT apartmentunit_propertyid_fkey FOREIGN KEY (propertyid) REFERENCES public.property(propertyid) ON DELETE CASCADE;


--
-- Name: favorite favorite_studentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT favorite_studentid_fkey FOREIGN KEY (studentid) REFERENCES public.student(studentid) ON DELETE CASCADE;


--
-- Name: favorite favorite_unitid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT favorite_unitid_fkey FOREIGN KEY (unitid) REFERENCES public.apartmentunit(unitid) ON DELETE CASCADE;


--
-- Name: property property_managerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: drish
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_managerid_fkey FOREIGN KEY (managerid) REFERENCES public.propertymanager(managerid) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 6mmFNLmPp3ls7QD61dgn7MjjuDMkr1Y6xAJLncSAvTgK3eDJXEgLiYZNilh3Ta9

