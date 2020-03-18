SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: dimensions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dimensions (
    id bigint NOT NULL,
    width numeric DEFAULT 0 NOT NULL,
    length numeric DEFAULT 0 NOT NULL,
    film_id integer NOT NULL
);


--
-- Name: dimensions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dimensions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dimensions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dimensions_id_seq OWNED BY public.dimensions.id;


--
-- Name: film_movements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_movements (
    id bigint NOT NULL,
    from_phase character varying NOT NULL,
    to_phase character varying NOT NULL,
    width numeric DEFAULT 0 NOT NULL,
    length numeric DEFAULT 0 NOT NULL,
    actor character varying NOT NULL,
    film_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tenant_code character varying NOT NULL
);


--
-- Name: film_movements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.film_movements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: film_movements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.film_movements_id_seq OWNED BY public.film_movements.id;


--
-- Name: films; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.films (
    id bigint NOT NULL,
    master_film_id integer NOT NULL,
    note text,
    shelf character varying,
    deleted boolean DEFAULT false,
    sales_order_id integer,
    order_fill_count integer DEFAULT 1 NOT NULL,
    tenant_code character varying NOT NULL,
    serial character varying NOT NULL,
    area numeric DEFAULT 0 NOT NULL,
    phase integer DEFAULT 0 NOT NULL
);


--
-- Name: films_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.films_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: films_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.films_id_seq OWNED BY public.films.id;


--
-- Name: job_dates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_dates (
    id bigint NOT NULL,
    job_order_id bigint NOT NULL,
    step character varying NOT NULL,
    value date NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    completed boolean DEFAULT false NOT NULL
);


--
-- Name: job_dates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.job_dates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_dates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.job_dates_id_seq OWNED BY public.job_dates.id;


--
-- Name: job_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_orders (
    id bigint NOT NULL,
    serial character varying DEFAULT ''::character varying NOT NULL,
    quantity character varying DEFAULT ''::character varying NOT NULL,
    part_number character varying DEFAULT ''::character varying NOT NULL,
    run_number character varying DEFAULT ''::character varying NOT NULL,
    note character varying DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    priority character varying DEFAULT ''::character varying NOT NULL
);


--
-- Name: job_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.job_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.job_orders_id_seq OWNED BY public.job_orders.id;


--
-- Name: line_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.line_items (
    id bigint NOT NULL,
    sales_order_id integer NOT NULL,
    custom_width numeric NOT NULL,
    custom_length numeric NOT NULL,
    quantity integer NOT NULL,
    wire_length character varying,
    busbar_type character varying,
    note text,
    product_type character varying NOT NULL
);


--
-- Name: line_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.line_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: line_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.line_items_id_seq OWNED BY public.line_items.id;


--
-- Name: machines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.machines (
    id bigint NOT NULL,
    code character varying NOT NULL,
    yield_constant numeric NOT NULL,
    tenant_code character varying NOT NULL
);


--
-- Name: machines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.machines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: machines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.machines_id_seq OWNED BY public.machines.id;


--
-- Name: master_films; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_films (
    id bigint NOT NULL,
    serial character varying NOT NULL,
    formula character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    mix_mass numeric,
    film_code_top character varying,
    thinky_code character varying,
    machine_id integer,
    effective_width numeric DEFAULT 0 NOT NULL,
    effective_length numeric DEFAULT 0 NOT NULL,
    operator character varying,
    chemist character varying,
    note text,
    defects public.hstore DEFAULT ''::public.hstore NOT NULL,
    tenant_code character varying NOT NULL,
    micrometer_left numeric,
    micrometer_right numeric,
    run_speed numeric,
    inspector character varying,
    serial_date date DEFAULT '2018-08-02'::date NOT NULL,
    function integer DEFAULT 0 NOT NULL,
    yield numeric,
    temperature numeric,
    humidity numeric,
    b_value numeric,
    wep_uv_on numeric,
    wep_visible_on numeric,
    wep_ir_on numeric,
    wep_uv_off numeric,
    wep_visible_off numeric,
    wep_ir_off numeric,
    haze numeric,
    "Supplier_ID" character varying,
    string character varying
);


--
-- Name: master_films_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.master_films_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_films_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.master_films_id_seq OWNED BY public.master_films.id;


--
-- Name: sales_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_orders (
    id bigint NOT NULL,
    code character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    customer character varying,
    due_date date NOT NULL,
    release_date date NOT NULL,
    ship_to character varying,
    ship_date date,
    note text,
    tenant_code character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL
);


--
-- Name: sales_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sales_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sales_orders_id_seq OWNED BY public.sales_orders.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: solder_measurements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solder_measurements (
    id bigint NOT NULL,
    height1 numeric DEFAULT 0.0 NOT NULL,
    height2 numeric DEFAULT 0.0 NOT NULL,
    film_id bigint NOT NULL
);


--
-- Name: solder_measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solder_measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solder_measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solder_measurements_id_seq OWNED BY public.solder_measurements.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    full_name character varying NOT NULL,
    chemist boolean DEFAULT false,
    operator boolean DEFAULT false,
    password_digest character varying NOT NULL,
    role_level integer DEFAULT 0 NOT NULL,
    tenant_code character varying NOT NULL,
    inspector boolean DEFAULT false NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
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
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimensions ALTER COLUMN id SET DEFAULT nextval('public.dimensions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_movements ALTER COLUMN id SET DEFAULT nextval('public.film_movements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.films ALTER COLUMN id SET DEFAULT nextval('public.films_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_dates ALTER COLUMN id SET DEFAULT nextval('public.job_dates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_orders ALTER COLUMN id SET DEFAULT nextval('public.job_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.line_items ALTER COLUMN id SET DEFAULT nextval('public.line_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machines ALTER COLUMN id SET DEFAULT nextval('public.machines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_films ALTER COLUMN id SET DEFAULT nextval('public.master_films_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_orders ALTER COLUMN id SET DEFAULT nextval('public.sales_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solder_measurements ALTER COLUMN id SET DEFAULT nextval('public.solder_measurements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: dimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimensions
    ADD CONSTRAINT dimensions_pkey PRIMARY KEY (id);


--
-- Name: film_movements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_movements
    ADD CONSTRAINT film_movements_pkey PRIMARY KEY (id);


--
-- Name: films_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.films
    ADD CONSTRAINT films_pkey PRIMARY KEY (id);


--
-- Name: job_dates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_dates
    ADD CONSTRAINT job_dates_pkey PRIMARY KEY (id);


--
-- Name: job_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_orders
    ADD CONSTRAINT job_orders_pkey PRIMARY KEY (id);


--
-- Name: line_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.line_items
    ADD CONSTRAINT line_items_pkey PRIMARY KEY (id);


--
-- Name: machines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_pkey PRIMARY KEY (id);


--
-- Name: master_films_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_films
    ADD CONSTRAINT master_films_pkey PRIMARY KEY (id);


--
-- Name: sales_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_orders
    ADD CONSTRAINT sales_orders_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: solder_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solder_measurements
    ADD CONSTRAINT solder_measurements_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_dimensions_on_film_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dimensions_on_film_id ON public.dimensions USING btree (film_id);


--
-- Name: index_film_movements_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_film_movements_on_created_at ON public.film_movements USING btree (created_at);


--
-- Name: index_film_movements_on_film_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_film_movements_on_film_id ON public.film_movements USING btree (film_id);


--
-- Name: index_film_movements_on_from_phase; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_film_movements_on_from_phase ON public.film_movements USING btree (from_phase);


--
-- Name: index_film_movements_on_tenant_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_film_movements_on_tenant_code ON public.film_movements USING btree (tenant_code);


--
-- Name: index_film_movements_on_to_phase; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_film_movements_on_to_phase ON public.film_movements USING btree (to_phase);


--
-- Name: index_films_on_area; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_films_on_area ON public.films USING btree (area);


--
-- Name: index_films_on_deleted; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_films_on_deleted ON public.films USING btree (deleted);


--
-- Name: index_films_on_master_film_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_films_on_master_film_id ON public.films USING btree (master_film_id);


--
-- Name: index_films_on_phase; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_films_on_phase ON public.films USING btree (phase);


--
-- Name: index_films_on_sales_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_films_on_sales_order_id ON public.films USING btree (sales_order_id);


--
-- Name: index_films_on_serial; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_films_on_serial ON public.films USING btree (serial);


--
-- Name: index_films_on_tenant_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_films_on_tenant_code ON public.films USING btree (tenant_code);


--
-- Name: index_job_dates_on_job_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_dates_on_job_order_id ON public.job_dates USING btree (job_order_id);


--
-- Name: index_job_dates_on_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_dates_on_value ON public.job_dates USING btree (value);


--
-- Name: index_job_orders_on_serial; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_job_orders_on_serial ON public.job_orders USING btree (serial);


--
-- Name: index_line_items_on_sales_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_line_items_on_sales_order_id ON public.line_items USING btree (sales_order_id);


--
-- Name: index_machines_on_tenant_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_machines_on_tenant_code ON public.machines USING btree (tenant_code);


--
-- Name: index_master_films_on_machine_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_master_films_on_machine_id ON public.master_films USING btree (machine_id);


--
-- Name: index_master_films_on_serial; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_master_films_on_serial ON public.master_films USING btree (serial);


--
-- Name: index_master_films_on_tenant_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_master_films_on_tenant_code ON public.master_films USING btree (tenant_code);


--
-- Name: index_sales_orders_on_due_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sales_orders_on_due_date ON public.sales_orders USING btree (due_date);


--
-- Name: index_sales_orders_on_release_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sales_orders_on_release_date ON public.sales_orders USING btree (release_date);


--
-- Name: index_sales_orders_on_ship_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sales_orders_on_ship_date ON public.sales_orders USING btree (ship_date);


--
-- Name: index_sales_orders_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sales_orders_on_status ON public.sales_orders USING btree (status);


--
-- Name: index_sales_orders_on_tenant_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sales_orders_on_tenant_code ON public.sales_orders USING btree (tenant_code);


--
-- Name: index_solder_measurements_on_film_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solder_measurements_on_film_id ON public.solder_measurements USING btree (film_id);


--
-- Name: index_users_on_tenant_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_tenant_code ON public.users USING btree (tenant_code);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_username ON public.users USING btree (username);


--
-- Name: master_films_defects; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX master_films_defects ON public.master_films USING gin (defects);


--
-- Name: fk_rails_af8cc6e8cb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_dates
    ADD CONSTRAINT fk_rails_af8cc6e8cb FOREIGN KEY (job_order_id) REFERENCES public.job_orders(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20130417223847'),
('20130418022546'),
('20130418031955'),
('20130418061551'),
('20130428211109'),
('20130428211135'),
('20130430224137'),
('20130430224247'),
('20130430230747'),
('20130430230755'),
('20130501173114'),
('20130502231350'),
('20130502231905'),
('20130503001410'),
('20130503002812'),
('20130511191840'),
('20130511191856'),
('20130526061242'),
('20130705013815'),
('20130913015232'),
('20130920162233'),
('20130926170108'),
('20130926182736'),
('20130930181734'),
('20131011222114'),
('20131011222115'),
('20131014164214'),
('20131015172632'),
('20131015203008'),
('20131015203301'),
('20131016152456'),
('20131016181031'),
('20131018213700'),
('20131024195542'),
('20131029182509'),
('20131030180530'),
('20131031192648'),
('20131101012216'),
('20131105153333'),
('20131107145209'),
('20131107220819'),
('20131110204952'),
('20131112180415'),
('20131112234801'),
('20131113160732'),
('20131113163816'),
('20131114154759'),
('20131114164348'),
('20131119190331'),
('20131119201022'),
('20131119221151'),
('20131120191843'),
('20131203014500'),
('20131203015228'),
('20131203072215'),
('20131204073627'),
('20131205032911'),
('20131205034528'),
('20131205035610'),
('20140101025515'),
('20140101215407'),
('20140101215624'),
('20140121064715'),
('20140212204905'),
('20140213210613'),
('20140217195523'),
('20140217200733'),
('20140217202446'),
('20140218020141'),
('20140218192615'),
('20140219055852'),
('20140219061410'),
('20140219225140'),
('20140219225241'),
('20140219225351'),
('20140219231540'),
('20140220005924'),
('20140321195010'),
('20140321195221'),
('20140430234916'),
('20140515191006'),
('20140515200239'),
('20140528033947'),
('20140605210258'),
('20140622223450'),
('20140624151838'),
('20140624192223'),
('20140626002150'),
('20140626002836'),
('20140626004020'),
('20140626005821'),
('20140626012253'),
('20140626012626'),
('20140626013350'),
('20141223062841'),
('20141223233616'),
('20150130224042'),
('20150515223559'),
('20150806195532'),
('20150807004114'),
('20150811195951'),
('20151012210724'),
('20151101005058'),
('20151101005814'),
('20160131003721'),
('20160131032713'),
('20160131042206'),
('20170413162227'),
('20170413162721');


