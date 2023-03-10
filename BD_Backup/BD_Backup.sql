PGDMP                         {            Lagar    15.2    15.2 S    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16398    Lagar    DATABASE     ~   CREATE DATABASE "Lagar" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "Lagar";
                postgres    false            ?            1255    16589    atualizar_stock()    FUNCTION     ?  CREATE FUNCTION public.atualizar_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    id_tipofatura INTEGER;
BEGIN
    SELECT id_tipofatura INTO id_tipofatura FROM "Fatura" WHERE Id_Fatura = NEW.ID_FATURA;
    IF (id_tipofatura = 1) THEN
        UPDATE "Produto" SET Quantidade = Quantidade + NEW.Quantidade WHERE Id_Produto = NEW.ID_PRODUTO;
    END IF;
    RETURN NEW;
END;
$$;
 (   DROP FUNCTION public.atualizar_stock();
       public          postgres    false            ?            1255    16591    atualizar_stock_recibo()    FUNCTION     ?  CREATE FUNCTION public.atualizar_stock_recibo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    id_tipofatura INTEGER;
BEGIN
    SELECT id_tipofatura INTO id_tipofatura FROM "Fatura" WHERE Id_Fatura = NEW.ID_FATURA;
    IF (id_tipofatura = 2) THEN
        UPDATE "Produto" SET Quantidade = Quantidade - NEW.Quantidade WHERE Id_Produto = NEW.ID_PRODUTO;
    END IF;
    RETURN NEW;
END;
$$;
 /   DROP FUNCTION public.atualizar_stock_recibo();
       public          postgres    false            ?            1255    16594    prodmp_update_stock()    FUNCTION     ?   CREATE FUNCTION public.prodmp_update_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "Produto"
    SET Quantidade = Quantidade - NEW.quantidade
    WHERE Id_Produto = NEW.id_produto;
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.prodmp_update_stock();
       public          postgres    false            ?            1255    16596    producao_update_stock()    FUNCTION     ?   CREATE FUNCTION public.producao_update_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "Produto"
    SET Quantidade = Quantidade + NEW.quantidade
    WHERE Id_Produto = NEW.id_produto;
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.producao_update_stock();
       public          postgres    false            ?            1259    16399    Codigo_Postal    TABLE     ?   CREATE TABLE public."Codigo_Postal" (
    "Cod_Postal" numeric(10,3) NOT NULL,
    "Localidade" character varying(50) NOT NULL
);
 #   DROP TABLE public."Codigo_Postal";
       public         heap    postgres    false            ?            1259    16529    Embalamento    TABLE     ?   CREATE TABLE public."Embalamento" (
    "Id_Embalamento" integer NOT NULL,
    "Data" date NOT NULL,
    "Id_Produto" integer NOT NULL,
    "Qtd_Embalada" integer NOT NULL
);
 !   DROP TABLE public."Embalamento";
       public         heap    postgres    false            ?            1259    16409    Entidade    TABLE     w  CREATE TABLE public."Entidade" (
    "Id_Entidade" integer NOT NULL,
    "Nome" character varying(80) NOT NULL,
    "NIF" integer NOT NULL,
    "Email" character varying(80) NOT NULL,
    "Telemovel" integer NOT NULL,
    "Rua" character varying(50) NOT NULL,
    "N_Porta" integer NOT NULL,
    "Cod_Postal" numeric(10,3) NOT NULL,
    "Id_TipoEntidade" integer NOT NULL
);
    DROP TABLE public."Entidade";
       public         heap    postgres    false            ?            1259    16429    Fatura    TABLE       CREATE TABLE public."Fatura" (
    "Id_Fatura" integer NOT NULL,
    "Data_Emissao" date NOT NULL,
    valor numeric(10,2) NOT NULL,
    "Total_c_IVA" numeric(10,2) NOT NULL,
    "Id_TipoPagamento" integer NOT NULL,
    "Id_Entidade" integer NOT NULL,
    id_utilizador integer
);
    DROP TABLE public."Fatura";
       public         heap    postgres    false            ?            1259    16459    Linha_Fatura    TABLE     ?   CREATE TABLE public."Linha_Fatura" (
    "Id_Produto" integer NOT NULL,
    "Id_Fatura" integer NOT NULL,
    "Quantidade" integer NOT NULL,
    "Valor" numeric(10,2) NOT NULL
);
 "   DROP TABLE public."Linha_Fatura";
       public         heap    postgres    false            ?            1259    16489    Linha_Recibo    TABLE     ?   CREATE TABLE public."Linha_Recibo" (
    "Id_Produto" integer NOT NULL,
    "Id_Recibo" integer NOT NULL,
    "Quantidade" integer NOT NULL,
    "Valor" numeric(10,2) NOT NULL
);
 "   DROP TABLE public."Linha_Recibo";
       public         heap    postgres    false            ?            1259    16504    Producao    TABLE     ?   CREATE TABLE public."Producao" (
    "Id_Producao" integer NOT NULL,
    "Data" date NOT NULL,
    "Id_Produto" integer NOT NULL,
    "Qtd_Produzida" integer NOT NULL,
    "Acidez" numeric(5,2) NOT NULL
);
    DROP TABLE public."Producao";
       public         heap    postgres    false            ?            1259    16449    Produto    TABLE     ?   CREATE TABLE public."Produto" (
    "Id_Produto" integer NOT NULL,
    "Nome" character varying(80) NOT NULL,
    "Valor_Unitario" numeric(10,2) NOT NULL,
    "Quantidade" integer NOT NULL,
    "Id_TipoProduto" integer NOT NULL
);
    DROP TABLE public."Produto";
       public         heap    postgres    false            ?            1259    16539 
   ProdutoEMB    TABLE     ?   CREATE TABLE public."ProdutoEMB" (
    "Id_Produto" integer NOT NULL,
    "Id_Embalamento" integer NOT NULL,
    "Quantidade" integer NOT NULL
);
     DROP TABLE public."ProdutoEMB";
       public         heap    postgres    false            ?            1259    16514 	   ProdutoMP    TABLE     ?   CREATE TABLE public."ProdutoMP" (
    "Id_Produto" integer NOT NULL,
    "Id_Producao" integer NOT NULL,
    "Quantidade" integer NOT NULL
);
    DROP TABLE public."ProdutoMP";
       public         heap    postgres    false            ?            1259    16474    Recibo    TABLE        CREATE TABLE public."Recibo" (
    "Id_Recibo" integer NOT NULL,
    "Data_Emissao" date NOT NULL,
    "Valor" numeric(10,2) NOT NULL,
    "Total_c_IVA" numeric(10,2) NOT NULL,
    "Id_TipoPagamento" integer NOT NULL,
    "Id_Entidade" integer NOT NULL
);
    DROP TABLE public."Recibo";
       public         heap    postgres    false            ?            1259    16404    Tipo_Entidade    TABLE     ?   CREATE TABLE public."Tipo_Entidade" (
    "Id_TipoEntidade" integer NOT NULL,
    "Descricao" character varying(15) NOT NULL
);
 #   DROP TABLE public."Tipo_Entidade";
       public         heap    postgres    false            ?            1259    16424    Tipo_Pagamento    TABLE     ?   CREATE TABLE public."Tipo_Pagamento" (
    "Id_TipoPagamento" integer NOT NULL,
    "Descricao" character varying(30) NOT NULL
);
 $   DROP TABLE public."Tipo_Pagamento";
       public         heap    postgres    false            ?            1259    16444    Tipo_Produto    TABLE     ~   CREATE TABLE public."Tipo_Produto" (
    "Id_TipoProduto" integer NOT NULL,
    "Descricao" character varying(50) NOT NULL
);
 "   DROP TABLE public."Tipo_Produto";
       public         heap    postgres    false            ?            1259    16554    Tipo_Utilizador    TABLE     ?   CREATE TABLE public."Tipo_Utilizador" (
    "Id_TipoUtilizador" integer NOT NULL,
    "Cargo" character varying(50) NOT NULL
);
 %   DROP TABLE public."Tipo_Utilizador";
       public         heap    postgres    false            ?            1259    16559 
   Utilizador    TABLE     ?   CREATE TABLE public."Utilizador" (
    "Id_Utilizador" integer NOT NULL,
    "Nome" character varying(80) NOT NULL,
    "Telemovel" integer NOT NULL,
    "Id_TipoUtilizador" integer NOT NULL
);
     DROP TABLE public."Utilizador";
       public         heap    postgres    false            ?            1259    16614    balanco    VIEW     a  CREATE VIEW public.balanco AS
 SELECT COALESCE(sum("Recibo"."Total_c_IVA"), (0)::numeric) AS total_vendas,
    COALESCE(sum("Fatura"."Total_c_IVA"), (0)::numeric) AS total_compras,
    (COALESCE(sum("Recibo"."Total_c_IVA"), (0)::numeric) - COALESCE(sum("Fatura"."Total_c_IVA"), (0)::numeric)) AS "balanço"
   FROM public."Recibo",
    public."Fatura";
    DROP VIEW public.balanco;
       public          postgres    false    222    218            ?            1259    16610    compras    VIEW     ?   CREATE VIEW public.compras AS
 SELECT "Fatura"."Id_Fatura",
    "Fatura"."Data_Emissao",
    "Fatura"."Total_c_IVA"
   FROM public."Fatura";
    DROP VIEW public.compras;
       public          postgres    false    218    218    218            ?            1259    16598    produtosembalados    VIEW     ?   CREATE VIEW public.produtosembalados AS
 SELECT "Produto"."Id_Produto",
    "Produto"."Nome",
    "Produto"."Valor_Unitario",
    "Produto"."Quantidade"
   FROM public."Produto"
  WHERE ("Produto"."Id_TipoProduto" = 5);
 $   DROP VIEW public.produtosembalados;
       public          postgres    false    220    220    220    220    220            ?            1259    16606    vendas    VIEW     ?   CREATE VIEW public.vendas AS
 SELECT "Recibo"."Id_Recibo",
    "Recibo"."Data_Emissao",
    "Recibo"."Total_c_IVA"
   FROM public."Recibo";
    DROP VIEW public.vendas;
       public          postgres    false    222    222    222            }          0    16399    Codigo_Postal 
   TABLE DATA           E   COPY public."Codigo_Postal" ("Cod_Postal", "Localidade") FROM stdin;
    public          postgres    false    214   ?q       ?          0    16529    Embalamento 
   TABLE DATA           _   COPY public."Embalamento" ("Id_Embalamento", "Data", "Id_Produto", "Qtd_Embalada") FROM stdin;
    public          postgres    false    226   hr                 0    16409    Entidade 
   TABLE DATA           ?   COPY public."Entidade" ("Id_Entidade", "Nome", "NIF", "Email", "Telemovel", "Rua", "N_Porta", "Cod_Postal", "Id_TipoEntidade") FROM stdin;
    public          postgres    false    216   ?r       ?          0    16429    Fatura 
   TABLE DATA           ?   COPY public."Fatura" ("Id_Fatura", "Data_Emissao", valor, "Total_c_IVA", "Id_TipoPagamento", "Id_Entidade", id_utilizador) FROM stdin;
    public          postgres    false    218   ?s       ?          0    16459    Linha_Fatura 
   TABLE DATA           Z   COPY public."Linha_Fatura" ("Id_Produto", "Id_Fatura", "Quantidade", "Valor") FROM stdin;
    public          postgres    false    221   ?s       ?          0    16489    Linha_Recibo 
   TABLE DATA           Z   COPY public."Linha_Recibo" ("Id_Produto", "Id_Recibo", "Quantidade", "Valor") FROM stdin;
    public          postgres    false    223   5t       ?          0    16504    Producao 
   TABLE DATA           d   COPY public."Producao" ("Id_Producao", "Data", "Id_Produto", "Qtd_Produzida", "Acidez") FROM stdin;
    public          postgres    false    224   ~t       ?          0    16449    Produto 
   TABLE DATA           k   COPY public."Produto" ("Id_Produto", "Nome", "Valor_Unitario", "Quantidade", "Id_TipoProduto") FROM stdin;
    public          postgres    false    220   ?t       ?          0    16539 
   ProdutoEMB 
   TABLE DATA           T   COPY public."ProdutoEMB" ("Id_Produto", "Id_Embalamento", "Quantidade") FROM stdin;
    public          postgres    false    227   ?u       ?          0    16514 	   ProdutoMP 
   TABLE DATA           P   COPY public."ProdutoMP" ("Id_Produto", "Id_Producao", "Quantidade") FROM stdin;
    public          postgres    false    225   ?u       ?          0    16474    Recibo 
   TABLE DATA           z   COPY public."Recibo" ("Id_Recibo", "Data_Emissao", "Valor", "Total_c_IVA", "Id_TipoPagamento", "Id_Entidade") FROM stdin;
    public          postgres    false    222   )v       ~          0    16404    Tipo_Entidade 
   TABLE DATA           I   COPY public."Tipo_Entidade" ("Id_TipoEntidade", "Descricao") FROM stdin;
    public          postgres    false    215   ?v       ?          0    16424    Tipo_Pagamento 
   TABLE DATA           K   COPY public."Tipo_Pagamento" ("Id_TipoPagamento", "Descricao") FROM stdin;
    public          postgres    false    217   ?v       ?          0    16444    Tipo_Produto 
   TABLE DATA           G   COPY public."Tipo_Produto" ("Id_TipoProduto", "Descricao") FROM stdin;
    public          postgres    false    219   w       ?          0    16554    Tipo_Utilizador 
   TABLE DATA           I   COPY public."Tipo_Utilizador" ("Id_TipoUtilizador", "Cargo") FROM stdin;
    public          postgres    false    228   Rw       ?          0    16559 
   Utilizador 
   TABLE DATA           a   COPY public."Utilizador" ("Id_Utilizador", "Nome", "Telemovel", "Id_TipoUtilizador") FROM stdin;
    public          postgres    false    229   ?w       ?           2606    16570     Codigo_Postal Codigo_Postal_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public."Codigo_Postal"
    ADD CONSTRAINT "Codigo_Postal_pkey" PRIMARY KEY ("Cod_Postal");
 N   ALTER TABLE ONLY public."Codigo_Postal" DROP CONSTRAINT "Codigo_Postal_pkey";
       public            postgres    false    214            ?           2606    16533    Embalamento Embalamento_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public."Embalamento"
    ADD CONSTRAINT "Embalamento_pkey" PRIMARY KEY ("Id_Embalamento");
 J   ALTER TABLE ONLY public."Embalamento" DROP CONSTRAINT "Embalamento_pkey";
       public            postgres    false    226            ?           2606    16413    Entidade Entidade_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public."Entidade"
    ADD CONSTRAINT "Entidade_pkey" PRIMARY KEY ("Id_Entidade");
 D   ALTER TABLE ONLY public."Entidade" DROP CONSTRAINT "Entidade_pkey";
       public            postgres    false    216            ?           2606    16433    Fatura Fatura_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "Fatura_pkey" PRIMARY KEY ("Id_Fatura");
 @   ALTER TABLE ONLY public."Fatura" DROP CONSTRAINT "Fatura_pkey";
       public            postgres    false    218            ?           2606    16463    Linha_Fatura Linha_Fatura_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public."Linha_Fatura"
    ADD CONSTRAINT "Linha_Fatura_pkey" PRIMARY KEY ("Id_Produto", "Id_Fatura");
 L   ALTER TABLE ONLY public."Linha_Fatura" DROP CONSTRAINT "Linha_Fatura_pkey";
       public            postgres    false    221    221            ?           2606    16493    Linha_Recibo Linha_Recibo_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public."Linha_Recibo"
    ADD CONSTRAINT "Linha_Recibo_pkey" PRIMARY KEY ("Id_Produto", "Id_Recibo");
 L   ALTER TABLE ONLY public."Linha_Recibo" DROP CONSTRAINT "Linha_Recibo_pkey";
       public            postgres    false    223    223            ?           2606    16508    Producao Producao_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public."Producao"
    ADD CONSTRAINT "Producao_pkey" PRIMARY KEY ("Id_Producao");
 D   ALTER TABLE ONLY public."Producao" DROP CONSTRAINT "Producao_pkey";
       public            postgres    false    224            ?           2606    16543    ProdutoEMB ProdutoEMB_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public."ProdutoEMB"
    ADD CONSTRAINT "ProdutoEMB_pkey" PRIMARY KEY ("Id_Produto", "Id_Embalamento");
 H   ALTER TABLE ONLY public."ProdutoEMB" DROP CONSTRAINT "ProdutoEMB_pkey";
       public            postgres    false    227    227            ?           2606    16518    ProdutoMP ProdutoMP_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public."ProdutoMP"
    ADD CONSTRAINT "ProdutoMP_pkey" PRIMARY KEY ("Id_Produto", "Id_Producao");
 F   ALTER TABLE ONLY public."ProdutoMP" DROP CONSTRAINT "ProdutoMP_pkey";
       public            postgres    false    225    225            ?           2606    16453    Produto Produto_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Produto"
    ADD CONSTRAINT "Produto_pkey" PRIMARY KEY ("Id_Produto");
 B   ALTER TABLE ONLY public."Produto" DROP CONSTRAINT "Produto_pkey";
       public            postgres    false    220            ?           2606    16478    Recibo Recibo_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public."Recibo"
    ADD CONSTRAINT "Recibo_pkey" PRIMARY KEY ("Id_Recibo");
 @   ALTER TABLE ONLY public."Recibo" DROP CONSTRAINT "Recibo_pkey";
       public            postgres    false    222            ?           2606    16408     Tipo_Entidade Tipo_Entidade_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public."Tipo_Entidade"
    ADD CONSTRAINT "Tipo_Entidade_pkey" PRIMARY KEY ("Id_TipoEntidade");
 N   ALTER TABLE ONLY public."Tipo_Entidade" DROP CONSTRAINT "Tipo_Entidade_pkey";
       public            postgres    false    215            ?           2606    16428 "   Tipo_Pagamento Tipo_Pagamento_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public."Tipo_Pagamento"
    ADD CONSTRAINT "Tipo_Pagamento_pkey" PRIMARY KEY ("Id_TipoPagamento");
 P   ALTER TABLE ONLY public."Tipo_Pagamento" DROP CONSTRAINT "Tipo_Pagamento_pkey";
       public            postgres    false    217            ?           2606    16448    Tipo_Produto Tipo_Produto_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public."Tipo_Produto"
    ADD CONSTRAINT "Tipo_Produto_pkey" PRIMARY KEY ("Id_TipoProduto");
 L   ALTER TABLE ONLY public."Tipo_Produto" DROP CONSTRAINT "Tipo_Produto_pkey";
       public            postgres    false    219            ?           2606    16558 $   Tipo_Utilizador Tipo_Utilizador_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public."Tipo_Utilizador"
    ADD CONSTRAINT "Tipo_Utilizador_pkey" PRIMARY KEY ("Id_TipoUtilizador");
 R   ALTER TABLE ONLY public."Tipo_Utilizador" DROP CONSTRAINT "Tipo_Utilizador_pkey";
       public            postgres    false    228            ?           2606    16563    Utilizador Utilizador_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public."Utilizador"
    ADD CONSTRAINT "Utilizador_pkey" PRIMARY KEY ("Id_Utilizador");
 H   ALTER TABLE ONLY public."Utilizador" DROP CONSTRAINT "Utilizador_pkey";
       public            postgres    false    229            ?           2620    16590    Linha_Fatura atualizar_stock    TRIGGER     ?   CREATE TRIGGER atualizar_stock AFTER INSERT OR UPDATE ON public."Linha_Fatura" FOR EACH ROW EXECUTE FUNCTION public.atualizar_stock();
 7   DROP TRIGGER atualizar_stock ON public."Linha_Fatura";
       public          postgres    false    234    221            ?           2620    16592 #   Linha_Fatura atualizar_stock_recibo    TRIGGER     ?   CREATE TRIGGER atualizar_stock_recibo AFTER INSERT OR UPDATE ON public."Linha_Fatura" FOR EACH ROW EXECUTE FUNCTION public.atualizar_stock_recibo();
 >   DROP TRIGGER atualizar_stock_recibo ON public."Linha_Fatura";
       public          postgres    false    221    235            ?           2620    16595    ProdutoMP prodmp_update_stock    TRIGGER     ?   CREATE TRIGGER prodmp_update_stock BEFORE INSERT OR UPDATE ON public."ProdutoMP" FOR EACH ROW EXECUTE FUNCTION public.prodmp_update_stock();
 8   DROP TRIGGER prodmp_update_stock ON public."ProdutoMP";
       public          postgres    false    225    236            ?           2620    16597    Producao producao_update_stock    TRIGGER     ?   CREATE TRIGGER producao_update_stock BEFORE INSERT OR UPDATE ON public."Producao" FOR EACH ROW EXECUTE FUNCTION public.producao_update_stock();
 9   DROP TRIGGER producao_update_stock ON public."Producao";
       public          postgres    false    237    224            ?           2606    16534 '   Embalamento Embalamento_Id_Produto_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Embalamento"
    ADD CONSTRAINT "Embalamento_Id_Produto_fkey" FOREIGN KEY ("Id_Produto") REFERENCES public."Produto"("Id_Produto");
 U   ALTER TABLE ONLY public."Embalamento" DROP CONSTRAINT "Embalamento_Id_Produto_fkey";
       public          postgres    false    226    3265    220            ?           2606    16580 !   Entidade Entidade_Cod_Postal_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Entidade"
    ADD CONSTRAINT "Entidade_Cod_Postal_fkey" FOREIGN KEY ("Cod_Postal") REFERENCES public."Codigo_Postal"("Cod_Postal");
 O   ALTER TABLE ONLY public."Entidade" DROP CONSTRAINT "Entidade_Cod_Postal_fkey";
       public          postgres    false    216    3253    214            ?           2606    16419 &   Entidade Entidade_Id_TipoEntidade_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Entidade"
    ADD CONSTRAINT "Entidade_Id_TipoEntidade_fkey" FOREIGN KEY ("Id_TipoEntidade") REFERENCES public."Tipo_Entidade"("Id_TipoEntidade");
 T   ALTER TABLE ONLY public."Entidade" DROP CONSTRAINT "Entidade_Id_TipoEntidade_fkey";
       public          postgres    false    215    3255    216            ?           2606    16439    Fatura Fatura_Id_Entidade_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "Fatura_Id_Entidade_fkey" FOREIGN KEY ("Id_Entidade") REFERENCES public."Entidade"("Id_Entidade");
 L   ALTER TABLE ONLY public."Fatura" DROP CONSTRAINT "Fatura_Id_Entidade_fkey";
       public          postgres    false    3257    218    216            ?           2606    16434 #   Fatura Fatura_Id_TipoPagamento_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "Fatura_Id_TipoPagamento_fkey" FOREIGN KEY ("Id_TipoPagamento") REFERENCES public."Tipo_Pagamento"("Id_TipoPagamento");
 Q   ALTER TABLE ONLY public."Fatura" DROP CONSTRAINT "Fatura_Id_TipoPagamento_fkey";
       public          postgres    false    218    217    3259            ?           2606    16469 (   Linha_Fatura Linha_Fatura_Id_Fatura_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Linha_Fatura"
    ADD CONSTRAINT "Linha_Fatura_Id_Fatura_fkey" FOREIGN KEY ("Id_Fatura") REFERENCES public."Fatura"("Id_Fatura");
 V   ALTER TABLE ONLY public."Linha_Fatura" DROP CONSTRAINT "Linha_Fatura_Id_Fatura_fkey";
       public          postgres    false    218    221    3261            ?           2606    16464 )   Linha_Fatura Linha_Fatura_Id_Produto_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Linha_Fatura"
    ADD CONSTRAINT "Linha_Fatura_Id_Produto_fkey" FOREIGN KEY ("Id_Produto") REFERENCES public."Produto"("Id_Produto");
 W   ALTER TABLE ONLY public."Linha_Fatura" DROP CONSTRAINT "Linha_Fatura_Id_Produto_fkey";
       public          postgres    false    221    3265    220            ?           2606    16494 )   Linha_Recibo Linha_Recibo_Id_Produto_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Linha_Recibo"
    ADD CONSTRAINT "Linha_Recibo_Id_Produto_fkey" FOREIGN KEY ("Id_Produto") REFERENCES public."Produto"("Id_Produto");
 W   ALTER TABLE ONLY public."Linha_Recibo" DROP CONSTRAINT "Linha_Recibo_Id_Produto_fkey";
       public          postgres    false    223    220    3265            ?           2606    16499 (   Linha_Recibo Linha_Recibo_Id_Recibo_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Linha_Recibo"
    ADD CONSTRAINT "Linha_Recibo_Id_Recibo_fkey" FOREIGN KEY ("Id_Recibo") REFERENCES public."Recibo"("Id_Recibo");
 V   ALTER TABLE ONLY public."Linha_Recibo" DROP CONSTRAINT "Linha_Recibo_Id_Recibo_fkey";
       public          postgres    false    223    222    3269            ?           2606    16509 !   Producao Producao_Id_Produto_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Producao"
    ADD CONSTRAINT "Producao_Id_Produto_fkey" FOREIGN KEY ("Id_Produto") REFERENCES public."Produto"("Id_Produto");
 O   ALTER TABLE ONLY public."Producao" DROP CONSTRAINT "Producao_Id_Produto_fkey";
       public          postgres    false    224    3265    220            ?           2606    16549 )   ProdutoEMB ProdutoEMB_Id_Embalamento_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."ProdutoEMB"
    ADD CONSTRAINT "ProdutoEMB_Id_Embalamento_fkey" FOREIGN KEY ("Id_Embalamento") REFERENCES public."Embalamento"("Id_Embalamento");
 W   ALTER TABLE ONLY public."ProdutoEMB" DROP CONSTRAINT "ProdutoEMB_Id_Embalamento_fkey";
       public          postgres    false    227    226    3277            ?           2606    16544 %   ProdutoEMB ProdutoEMB_Id_Produto_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."ProdutoEMB"
    ADD CONSTRAINT "ProdutoEMB_Id_Produto_fkey" FOREIGN KEY ("Id_Produto") REFERENCES public."Produto"("Id_Produto");
 S   ALTER TABLE ONLY public."ProdutoEMB" DROP CONSTRAINT "ProdutoEMB_Id_Produto_fkey";
       public          postgres    false    3265    227    220            ?           2606    16524 $   ProdutoMP ProdutoMP_Id_Producao_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."ProdutoMP"
    ADD CONSTRAINT "ProdutoMP_Id_Producao_fkey" FOREIGN KEY ("Id_Producao") REFERENCES public."Producao"("Id_Producao");
 R   ALTER TABLE ONLY public."ProdutoMP" DROP CONSTRAINT "ProdutoMP_Id_Producao_fkey";
       public          postgres    false    3273    224    225            ?           2606    16519 #   ProdutoMP ProdutoMP_Id_Produto_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."ProdutoMP"
    ADD CONSTRAINT "ProdutoMP_Id_Produto_fkey" FOREIGN KEY ("Id_Produto") REFERENCES public."Produto"("Id_Produto");
 Q   ALTER TABLE ONLY public."ProdutoMP" DROP CONSTRAINT "ProdutoMP_Id_Produto_fkey";
       public          postgres    false    3265    220    225            ?           2606    16454 #   Produto Produto_Id_TipoProduto_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Produto"
    ADD CONSTRAINT "Produto_Id_TipoProduto_fkey" FOREIGN KEY ("Id_TipoProduto") REFERENCES public."Tipo_Produto"("Id_TipoProduto");
 Q   ALTER TABLE ONLY public."Produto" DROP CONSTRAINT "Produto_Id_TipoProduto_fkey";
       public          postgres    false    219    220    3263            ?           2606    16484    Recibo Recibo_Id_Entidade_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Recibo"
    ADD CONSTRAINT "Recibo_Id_Entidade_fkey" FOREIGN KEY ("Id_Entidade") REFERENCES public."Entidade"("Id_Entidade");
 L   ALTER TABLE ONLY public."Recibo" DROP CONSTRAINT "Recibo_Id_Entidade_fkey";
       public          postgres    false    3257    216    222            ?           2606    16479 #   Recibo Recibo_Id_TipoPagamento_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Recibo"
    ADD CONSTRAINT "Recibo_Id_TipoPagamento_fkey" FOREIGN KEY ("Id_TipoPagamento") REFERENCES public."Tipo_Pagamento"("Id_TipoPagamento");
 Q   ALTER TABLE ONLY public."Recibo" DROP CONSTRAINT "Recibo_Id_TipoPagamento_fkey";
       public          postgres    false    222    3259    217            ?           2606    16564 ,   Utilizador Utilizador_Id_TipoUtilizador_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Utilizador"
    ADD CONSTRAINT "Utilizador_Id_TipoUtilizador_fkey" FOREIGN KEY ("Id_TipoUtilizador") REFERENCES public."Tipo_Utilizador"("Id_TipoUtilizador");
 Z   ALTER TABLE ONLY public."Utilizador" DROP CONSTRAINT "Utilizador_Id_TipoUtilizador_fkey";
       public          postgres    false    228    3281    229            ?           2606    16618    Fatura fk_fatura_utilizador    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT fk_fatura_utilizador FOREIGN KEY (id_utilizador) REFERENCES public."Utilizador"("Id_Utilizador");
 G   ALTER TABLE ONLY public."Fatura" DROP CONSTRAINT fk_fatura_utilizador;
       public          postgres    false    218    229    3283            }   i   x?3170?300?t,9?8?X7,3'Q!,?(%?????,?_T??ebU鞘??eb	??e&?%*??+8'??? ?YZ@?啤*??*?d?5??4?m????? k"?      ?   1   x?3?4202?5"SNNC#.#??	?)????1????W? 1}	?         ?   x?U?Kn?0???)|d??B?E?M???q??X5LdL.ԣ?b
????|??1<<#??4????ZH?Mc??]??N?5?J?J[???s?????_?YY?p^rΡ.jx????A?6F+)?jE?8???Y???k?pe?O??#?c?!??<??Q?N???D?I/o?????B?P????9?8??/?e?;d?
?Hai?N?p?_?;?.?5?ђ?$65?u??1?,??{???(?ӹr      ?   <   x?-??? Cѳ???U݅?? ????KX?H%j*$t)??S????^??B?\Ar??*      ?   (   x?3?4?47??4?0?30?2?4?440?442qc???? `?A      ?   9   x?ɱ?0??????,(?%????cm????I?I????R??ٌ^???VD?P?
      ?   <   x?E??	?0Cѳ?K?,??2??????????+dX??\%FpH??<聢?/Hn???      ?   ?   x?m??j?0D?W_?/zز??t[?Ȫ??XM~PY?ү??F???=3?M?_?2su?y?????IK??6??0w?+????Q?n????????5??w??S?W???&?h
??3?<,?????????ms???????#?\9~????6-Y???y??F^S?,?d?Q?B?B}
ؚx?[Z????͞?AB???Ke?Q?Q󴳓????C
!? ?0a*      ?   )   x?3?4?442಄??F?? >???4?? q?T? ???      ?   -   x?3?4?440?2?4?43?2?4?465?2? ac?0?????? ?F?      ?   U   x?=???0D?3?b4&1???:?%???፾A6?<?H????PF-n?
? ???!??????kп?h??q?Y?O?1U}??O      ~   $   x?3?t??L?+I?2?t?/?KMNM?/?????? {)?      ?   2   x?3?t???H?,??2?)J?+NK-:?*/93?˘?9#??4?+F??? /MR      ?   >   x?3?t?J?,??K?2?0S??9]s?s?S???L8]K2KSK??L?* ?)?\1z\\\ ???      ?   4   x?3?tL????,.)JL?/?2?tO-.2?9?J??3??/,???????? \??      ?   h   x?%??
1?/#$i??]??x?P??څu?^g?a\???j??G?I?kGHu+*!ͬ}?<?l?I?$E?}l?~??-?ua(n???????k?煈~@?	     