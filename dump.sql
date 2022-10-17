--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Ubuntu 14.5-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.5 (Ubuntu 14.5-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    token text NOT NULL,
    "userId" integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now()
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: shortUrls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."shortUrls" (
    id integer NOT NULL,
    "shortUrl" text NOT NULL,
    "urlId" integer,
    "visitCount" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now()
);


--
-- Name: shortUrls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."shortUrls_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shortUrls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."shortUrls_id_seq" OWNED BY public."shortUrls".id;


--
-- Name: urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.urls (
    id integer NOT NULL,
    url text,
    "userId" integer,
    "createdAt" timestamp without time zone DEFAULT now()
);


--
-- Name: urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.urls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.urls_id_seq OWNED BY public.urls.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    "confirmPassword" text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now()
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: shortUrls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."shortUrls" ALTER COLUMN id SET DEFAULT nextval('public."shortUrls_id_seq"'::regclass);


--
-- Name: urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls ALTER COLUMN id SET DEFAULT nextval('public.urls_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sessions VALUES (1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiaGFtdGFyb0BnbWFpbC5jb20iLCJpYXQiOjE2NjU5ODA3MTksImV4cCI6MTY2ODU3MjcxOX0.z6mpknCpCRtQn42NuvI4sRWP5VMKmrGNoOG1p9q4ll8', 1, '2022-10-17 01:25:19.649748');
INSERT INTO public.sessions VALUES (2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiY2lzcXVpbmhvY2hpcXVlQGdtYWlsLmNvbSIsImlhdCI6MTY2NTk4MTI1OSwiZXhwIjoxNjY4NTczMjU5fQ.dKPWCWfCY6y-zSccrhoe0ljpv3eSFrq1yDsqxY0RNng', 2, '2022-10-17 01:34:20.033054');
INSERT INTO public.sessions VALUES (4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoidHJhYWFhYXBAZ21haWwuY29tIiwiaWF0IjoxNjY2MDE3OTI4LCJleHAiOjE2Njg2MDk5Mjh9.L3kP9aDWM49Jp4fElCgdR60vzK4kIi2MTC4upxbFfp4', 5, '2022-10-17 11:45:28.3798');


--
-- Data for Name: shortUrls; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."shortUrls" VALUES (1, 'GYrSlSNM', 1, 3, '2022-10-17 01:26:20.989788');
INSERT INTO public."shortUrls" VALUES (2, 'z62yWwYO', 2, 1, '2022-10-17 01:35:35.968443');
INSERT INTO public."shortUrls" VALUES (3, 'mhFxYpKN', 2, 0, '2022-10-17 01:37:27.626443');
INSERT INTO public."shortUrls" VALUES (4, 'yrqfl4GP', 4, 0, '2022-10-17 11:52:58.947483');
INSERT INTO public."shortUrls" VALUES (5, '_AHgtsK4', 4, 0, '2022-10-17 13:23:31.060248');
INSERT INTO public."shortUrls" VALUES (6, '8z2lBNQS', 4, 0, '2022-10-17 13:24:19.455337');
INSERT INTO public."shortUrls" VALUES (7, 'uLYKShsH', 4, 0, '2022-10-17 13:25:04.555815');
INSERT INTO public."shortUrls" VALUES (8, 'W5LnoUoo', 4, 0, '2022-10-17 13:28:35.790481');
INSERT INTO public."shortUrls" VALUES (9, 'iapAuh46', 4, 0, '2022-10-17 13:29:15.017581');


--
-- Data for Name: urls; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.urls VALUES (1, 'https://www.google.com.br', 1, '2022-10-17 01:24:49.799874');
INSERT INTO public.urls VALUES (2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnr9BSyqGko5U7ElYjr6AfpuUa4fFmLjHe3w&usqp=CAU', 2, '2022-10-17 01:34:07.212605');
INSERT INTO public.urls VALUES (3, NULL, 3, '2022-10-17 01:38:02.064764');
INSERT INTO public.urls VALUES (4, 'batata1211', 5, '2022-10-17 11:45:16.621122');
INSERT INTO public.urls VALUES (5, NULL, 6, '2022-10-17 13:32:40.468801');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (1, 'hamtaro', 'hamtaro@gmail.com', '$2b$10$quaMCGXddQxnHv.8Ji/.vuL3M39H80caFQHWK16g9tPfnuooVjcIW', '$2b$10$AlyAIgVHXkVcQuYLeHJKE.mMLKxFM/I7RV/7rYedzsVEHZ2.8/OWq', '2022-10-17 01:24:49.759565');
INSERT INTO public.users VALUES (2, 'Bartolomeu Francisco', 'cisquinhochique@gmail.com', '$2b$10$Q/T4bM4XtRb0VeSZujJPq.peSdTCarSF7XunNcvT.O1FLq7sP.tDu', '$2b$10$ZcH2.Qj8fz97SU0PaeiMpuEC8G.8pBBDjGdDxXdlGnWN24uBtqBPy', '2022-10-17 01:34:07.161065');
INSERT INTO public.users VALUES (3, 'Moacir Barbosa', 'moacirB@gmail.com', '$2b$10$H12PstDRHjBOnLTtXBfxjO1b0ijKn9QYpS3gC6LvYp2wWIBgLXXGu', '$2b$10$cYXuzficxDnf8PEXwc/EseRIbB5fo.G0T6/07Zqc5qnnBoFc7VTsC', '2022-10-17 01:38:01.960461');
INSERT INTO public.users VALUES (5, 'Travis Bernadete', 'traaaaap@gmail.com', '$2b$10$5uwReGjeX9q93DTfdFqu.OFaUPpdtQOCgYsfVCQi3CGQ43.G034Yq', '$2b$10$rRd/ANLLwbQ7OdJw4Wmdhe1atIugiVONtLEjRVLmjcyddqe8.Bh.e', '2022-10-17 11:45:16.509224');
INSERT INTO public.users VALUES (6, 'Otis Consuelo', 'consu@gmail.com', '$2b$10$GORtkZ0DkAl/0kC9wyZ3fe8jMjJlvaNEbkhGOW6pYsBiIb.Z/YTvy', '$2b$10$i5r8FBhwjzRjBXSTW5BrB.3dN0PXdV.8enitPe1HD/X5W6B9IuWRO', '2022-10-17 13:32:40.366015');


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sessions_id_seq', 4, true);


--
-- Name: shortUrls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."shortUrls_id_seq"', 9, true);


--
-- Name: urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.urls_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_token_key UNIQUE (token);


--
-- Name: shortUrls shortUrls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."shortUrls"
    ADD CONSTRAINT "shortUrls_pkey" PRIMARY KEY (id);


--
-- Name: urls urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls
    ADD CONSTRAINT urls_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: shortUrls shortUrls_urlId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."shortUrls"
    ADD CONSTRAINT "shortUrls_urlId_fkey" FOREIGN KEY ("urlId") REFERENCES public.urls(id);


--
-- Name: urls urls_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls
    ADD CONSTRAINT "urls_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

