PGDMP      0            
    |            redix    15.8    16.3 A    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16384    redix    DATABASE     p   CREATE DATABASE redix WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE redix;
                postgres    false            {           1247    24751 	   adminrole    TYPE     C   CREATE TYPE public.adminrole AS ENUM (
    'OWNER',
    'ADMIN'
);
    DROP TYPE public.adminrole;
       public          postgres    false            o           1247    24681    orderstatus    TYPE     f   CREATE TYPE public.orderstatus AS ENUM (
    'PAID',
    'CLOSED',
    'COMPLETED',
    'PROGRESS'
);
    DROP TYPE public.orderstatus;
       public          postgres    false            W           1247    24591    promostatus    TYPE     I   CREATE TYPE public.promostatus AS ENUM (
    'ACTIVE',
    'INACTIVE'
);
    DROP TYPE public.promostatus;
       public          postgres    false            f           1247    24636    transactioncause    TYPE     �   CREATE TYPE public.transactioncause AS ENUM (
    'DONATE',
    'ADMIN_DEPOSIT',
    'ADMIN_DEBIT',
    'COUPON',
    'REFUND',
    'PAYMENT',
    'REFERRAL'
);
 #   DROP TYPE public.transactioncause;
       public          postgres    false            c           1247    24630    transactiontype    TYPE     K   CREATE TYPE public.transactiontype AS ENUM (
    'DEBIT',
    'DEPOSIT'
);
 "   DROP TYPE public.transactiontype;
       public          postgres    false            �            1259    24735    admin    TABLE     �   CREATE TABLE public.admin (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    role public.adminrole NOT NULL,
    permissions json NOT NULL
);
    DROP TABLE public.admin;
       public         heap    postgres    false    891            �            1259    24734    admin_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.admin_id_seq;
       public          postgres    false    226            �           0    0    admin_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.admin_id_seq OWNED BY public.admin.id;
          public          postgres    false    225            �            1259    24576    alembic_version    TABLE     X   CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
 #   DROP TABLE public.alembic_version;
       public         heap    postgres    false            �            1259    24616    category    TABLE       CREATE TABLE public.category (
    id integer NOT NULL,
    game_id integer NOT NULL,
    name character varying(255) NOT NULL,
    image character varying(255),
    is_visible boolean NOT NULL,
    thread_id integer,
    web_app_place integer,
    required_fields json
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    24615    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          postgres    false    220            �           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    219            �            1259    24706    feedback    TABLE     ;  CREATE TABLE public.feedback (
    id uuid NOT NULL,
    product_id uuid,
    order_id uuid,
    user_id bigint NOT NULL,
    text character varying(500) NOT NULL,
    stars integer,
    "time" timestamp with time zone NOT NULL,
    is_active boolean NOT NULL,
    images json,
    message_url character varying
);
    DROP TABLE public.feedback;
       public         heap    postgres    false            �            1259    24582    game    TABLE     �   CREATE TABLE public.game (
    id integer NOT NULL,
    name character varying NOT NULL,
    image_url character varying NOT NULL,
    web_app_place integer,
    supergroup_id bigint
);
    DROP TABLE public.game;
       public         heap    postgres    false            �            1259    24581    game_id_seq    SEQUENCE     �   CREATE SEQUENCE public.game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.game_id_seq;
       public          postgres    false    216            �           0    0    game_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;
          public          postgres    false    215            �            1259    24689    order    TABLE     S  CREATE TABLE public."order" (
    id uuid NOT NULL,
    user_id bigint NOT NULL,
    product_id uuid,
    name character varying NOT NULL,
    status public.orderstatus NOT NULL,
    price numeric NOT NULL,
    "time" timestamp with time zone NOT NULL,
    additional_data json,
    cancel_reason character varying,
    admin_id bigint
);
    DROP TABLE public."order";
       public         heap    postgres    false    879            �            1259    24663    product    TABLE     �  CREATE TABLE public.product (
    id uuid NOT NULL,
    game_id integer,
    category_id integer,
    name character varying NOT NULL,
    description character varying NOT NULL,
    price numeric NOT NULL,
    instruction character varying,
    purchase_count integer NOT NULL,
    game_name character varying,
    image_url character varying,
    purchase_limit integer,
    is_auto_purchase boolean NOT NULL,
    auto_purchase_text character varying,
    is_manual boolean NOT NULL,
    instruction_image_url character varying,
    is_visible boolean DEFAULT true NOT NULL,
    auto_purchase_image_url character varying,
    is_gift_purchase boolean
);
    DROP TABLE public.product;
       public         heap    postgres    false            �            1259    24595    promo    TABLE     �   CREATE TABLE public.promo (
    id uuid NOT NULL,
    name character varying NOT NULL,
    bonus_amount numeric NOT NULL,
    uses integer NOT NULL,
    status public.promostatus NOT NULL
);
    DROP TABLE public.promo;
       public         heap    postgres    false    855            �            1259    24651    transaction    TABLE     *  CREATE TABLE public.transaction (
    id uuid NOT NULL,
    user_id bigint NOT NULL,
    type public.transactiontype NOT NULL,
    cause public.transactioncause NOT NULL,
    "time" timestamp with time zone NOT NULL,
    amount numeric NOT NULL,
    payment_data json,
    is_successful boolean
);
    DROP TABLE public.transaction;
       public         heap    postgres    false    867    870            �            1259    24604    user    TABLE     6  CREATE TABLE public."user" (
    user_id bigint NOT NULL,
    referral_id integer,
    balance numeric,
    used_coupons json,
    referral_code character varying NOT NULL,
    nickname character varying,
    profile_photo character varying,
    joined_at timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public."user";
       public         heap    postgres    false            �           2604    24738    admin id    DEFAULT     d   ALTER TABLE ONLY public.admin ALTER COLUMN id SET DEFAULT nextval('public.admin_id_seq'::regclass);
 7   ALTER TABLE public.admin ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    226    226            �           2604    24619    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    24585    game id    DEFAULT     b   ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);
 6   ALTER TABLE public.game ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            �          0    24735    admin 
   TABLE DATA           ?   COPY public.admin (id, user_id, role, permissions) FROM stdin;
    public          postgres    false    226   (P       �          0    24576    alembic_version 
   TABLE DATA           6   COPY public.alembic_version (version_num) FROM stdin;
    public          postgres    false    214   �P       �          0    24616    category 
   TABLE DATA           s   COPY public.category (id, game_id, name, image, is_visible, thread_id, web_app_place, required_fields) FROM stdin;
    public          postgres    false    220   �P       �          0    24706    feedback 
   TABLE DATA           z   COPY public.feedback (id, product_id, order_id, user_id, text, stars, "time", is_active, images, message_url) FROM stdin;
    public          postgres    false    224   �T       �          0    24582    game 
   TABLE DATA           Q   COPY public.game (id, name, image_url, web_app_place, supergroup_id) FROM stdin;
    public          postgres    false    216   �V       �          0    24689    order 
   TABLE DATA           �   COPY public."order" (id, user_id, product_id, name, status, price, "time", additional_data, cancel_reason, admin_id) FROM stdin;
    public          postgres    false    223   �W       �          0    24663    product 
   TABLE DATA             COPY public.product (id, game_id, category_id, name, description, price, instruction, purchase_count, game_name, image_url, purchase_limit, is_auto_purchase, auto_purchase_text, is_manual, instruction_image_url, is_visible, auto_purchase_image_url, is_gift_purchase) FROM stdin;
    public          postgres    false    222   �\       �          0    24595    promo 
   TABLE DATA           E   COPY public.promo (id, name, bonus_amount, uses, status) FROM stdin;
    public          postgres    false    217   ��       �          0    24651    transaction 
   TABLE DATA           l   COPY public.transaction (id, user_id, type, cause, "time", amount, payment_data, is_successful) FROM stdin;
    public          postgres    false    221   �       �          0    24604    user 
   TABLE DATA           �   COPY public."user" (user_id, referral_id, balance, used_coupons, referral_code, nickname, profile_photo, joined_at) FROM stdin;
    public          postgres    false    218   ̒       �           0    0    admin_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.admin_id_seq', 9, true);
          public          postgres    false    225            �           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 18, true);
          public          postgres    false    219            �           0    0    game_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.game_id_seq', 1, false);
          public          postgres    false    215            �           2606    24742    admin admin_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
       public            postgres    false    226            �           2606    24744    admin admin_user_id_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_user_id_key UNIQUE (user_id);
 A   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_user_id_key;
       public            postgres    false    226            �           2606    24580 #   alembic_version alembic_version_pkc 
   CONSTRAINT     j   ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
 M   ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
       public            postgres    false    214            �           2606    24623    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    220            �           2606    24712    feedback feedback_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_pkey;
       public            postgres    false    224            �           2606    24589    game game_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.game DROP CONSTRAINT game_pkey;
       public            postgres    false    216            �           2606    24695    order order_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_pkey;
       public            postgres    false    223            �           2606    24669    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    222            �           2606    24603    promo promo_name_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.promo
    ADD CONSTRAINT promo_name_key UNIQUE (name);
 >   ALTER TABLE ONLY public.promo DROP CONSTRAINT promo_name_key;
       public            postgres    false    217            �           2606    24601    promo promo_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.promo
    ADD CONSTRAINT promo_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.promo DROP CONSTRAINT promo_pkey;
       public            postgres    false    217            �           2606    24657    transaction transaction_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.transaction DROP CONSTRAINT transaction_pkey;
       public            postgres    false    221            �           2606    24610    user user_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public            postgres    false    218            �           2606    24612    user user_referral_code_key 
   CONSTRAINT     a   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_referral_code_key UNIQUE (referral_code);
 G   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_referral_code_key;
       public            postgres    false    218            �           2606    24614    user user_referral_id_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_referral_id_key UNIQUE (referral_id);
 E   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_referral_id_key;
       public            postgres    false    218            	           2606    24745    admin admin_user_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);
 B   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_user_id_fkey;
       public          postgres    false    226    3309    218                        2606    24764    category category_game_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.category DROP CONSTRAINT category_game_id_fkey;
       public          postgres    false    216    3303    220                       2606    24774    feedback feedback_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_order_id_fkey FOREIGN KEY (order_id) REFERENCES public."order"(id) ON DELETE SET NULL;
 I   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_order_id_fkey;
       public          postgres    false    224    3321    223                       2606    24769 !   feedback feedback_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE SET NULL;
 K   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_product_id_fkey;
       public          postgres    false    224    3319    222                       2606    24723    feedback feedback_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_user_id_fkey;
       public          postgres    false    218    224    3309                       2606    24779    order order_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE SET NULL;
 G   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_product_id_fkey;
       public          postgres    false    3319    222    223                       2606    24784    order order_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_user_id_fkey;
       public          postgres    false    223    3309    218                       2606    24794     product product_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.product DROP CONSTRAINT product_category_id_fkey;
       public          postgres    false    220    3315    222                       2606    24789    product product_game_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.product DROP CONSTRAINT product_game_id_fkey;
       public          postgres    false    3303    222    216                       2606    24658 $   transaction transaction_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.transaction DROP CONSTRAINT transaction_user_id_fkey;
       public          postgres    false    3309    218    221            �   �   x�3�43�0�43�02�tt����V�M����KW�R()*M�QP*(���/F᧔&� ���!qSr3��ũ%%@�EJK2�K2�ab�\F��F&�����~�A�KNs#33Kccc"�%-1��c`*஁	`�<F��� `S��      �      x�K4464�HK264L����� )��      �   �  x�ՖKo�V���+��Z�$����0ױ��	M��m��o����DU��u3��Y�jU5���$fHR)3��O��z���^"��������^�~I�қ��ަ�Hz��׫��v�!7	C/xsr��/���BvT-Q,7R�-<�5�H
���N�J@��L� Ԧ���v��������bH#R��m��Iq�Qi����g*q� "��s8 ���Ǧ�����.ڹ��.."�����
Ig�.�G?!�m��myt�'!u'�4_�,�@"�|v���?/L<�z�i�#(́b�K]�Γ��Z眏�.疲��x1�P��>�u��2��Jo��#�����������+4p��B5šo�l�3=�O�f��������@�ER�����O$�״TV$���o��Y���e���{on׳�Ex��ɲ��0�a% Z�3�T���\��SN]�  �@�A� ,��krf'��@��5�T!�l�2H�d،#HȞ�w�p����D�ʟYh25�47���/ ֆ����O���v���;1�"q���<���q�W]KE9���Oo����w�??�B���W�N���.���mT+�nJC��i���r6K葊�[t��f����(C�'��(�ܨ�>�I���@їc+N�����P�&6��K�H{�MǓ�h�?��TZ��G�7t��X��!ۮ���s#8���#��k�J�3h\�MpS��H7�ߞ�(#^Z���C��p��*���d4	�w��~�HW	���),Íψ9��bL2_����#���ٷ�0)>w/�8���Z�F8x���
l�(md�um�^iE�,|���0&��޾���'��עʄ��6�Fg<`�i~夜�fRh�}�������M��q>���@      �   1  x����jA��=O1d�w�V�{�g���*���*��̐�]e����� JE��P�FV�B0�⢡�v���wN�Jt�� �`���|*�x�Iq$���t�9@�1T"�b�����:N�ؔ$A�@JFJU�y�쐚f�P?���N�!(�N/�[h����b7t7��au�����~�ʳ�a�χ���Y?���|?�;�p��\�W��a��,)'dQ�3�'�����_�a����������ϛ��s+D%K((z�ڂO���2��+�}i0b&�����wo!kQY��b�b����d3+׷M��:=���J��qhɣ����~�_�W����~����~j��lZ�Փz:��Y�wVLǗmyԞ��lZ�EcYO���Bg=��BV�,�&uK�B����u�N�
H�[��ұ��JB�nֲd���G�����آ�B��2���Z�Y(�`�y������/�P��lS�Uh��D���9E1�f�w�S�����p�J�{�|��|��WM��vE�#{�$�5�^$yw�?T��i&�f���7̮f      �   �   x���Mn� ��5����O�2ɢ�f[)�G��X�o���w�y}�N~GrM"R��G���<]�a��ݏ~���R�}�q�s{/Y,U3OO�ЁQ�?2-�a���q _>����}�n�v��M��������L�v����RV������6X�������ܾ���׮�rũTBI�9�2�@���-�
�T+��7�?$=�"      �   �  x���nU7��7Oq�m;��{�w�R6t������PQ�E��.Z���*^��AM)�W8��:7)��(�6�Jr��>�u�߱��ܒ�M�(�J�؃Vs��"byİ�FF���x(�t�LN�G�f9d���Ō��'ó�Ű9�b<<�ޛ�O�����N�������o����a{V�nx:}��ۣ3?�t��g?Y�#k,"`c�8;!��q�>0f�����-C��m� �-�n����篭����.�YG��/�Ik�}��~k���S��S8��\��wGKFQ�C�s<�1E� ` �Q���ĩU����2�[KPL+@&uH�{�.v��w}��!/�����WZߚ>�9����At��}��qwG~x��{X���1BØ�b&HE�=`-��Т9n�._<w��+�Gc����]K�|+IjϠS�UOL]7E��!��������kG����x�4/�uH��C�T�A�7H]bK�g�y�~��v[�Hk7Wn�C����ٵ��($��k)�kI��`O�~4]]�FQ��-�(���ި�㎢��e �#�xv�ol�W!򭛄ܛbk:�1$�stI��5t[�ǠmT}�n�PF�=n<�qڸ���|=��.������/n�4�R8���C��� ��E*�Y':v&���2������ ��˄hA�3�w�7�6����j[�v#`8��s����5��J��+�H^^#�+�`���#M'^?�wdߍ���.�Ĕ��ү����')讄������m�G� ����j����rq3?`�k�H�N6�k�D�D���[���u�1�?Y�A�*�5�Wȳ G"R�B��IV������9/ܿ�N�3���+�fZ]Y�	{oI�,��J
B�iKS������&���/��m�؛z}�	�Nó�7����v~����D[����ݴis��N�����T;��=��/3I�·�\7Y�+ks/X�I�oũozo�AU�����V�Ś<M��T�H���SI����d�:�����(�SB5V4^Ϙ�i�JC�� �ip��5-8 �F�8W�h��@�1��z�>D�˩ 7
1�cg��g�)��L���""���c����U[�%�-�k��@p]���3EMգ�����m˧�-Q��Í5FT�8kWA϶z��q*@,-����*�j�      �      x��}ks#���g�Wе�U�:�Ӎ��֤(�"%�o�T���n�ĻX����lv��u�=����r���{*�g'c�ό����_�8�' ͛�c[�P����h$�@����x_X��f������1`�P���C�#���[���뚦E�oO?�~:��z=2�W�ϫ���Ǒ����2�ٌ��������-2�=�ꓫ_L\��~(�x����ë�������z���͟F�o���OMF��+�^��<�\��/���u�l/GxI���y{�\���<����_FD1��yݯ���������E��?dU�y���巏x�~.��%DxA�~v���g���O�~9����'�6=ۢHO�|�7���iE~��z0�#/�u��xn����=Ѥ��^6��uY�Î�yS6��➗�f�zs�1/�S�1���9�o#���O�X��Oy)�����E��D���:�c��g���!E�Bt�;��D��������������o�~����?yk����#�__�!ޡ�K������?~,�@�;�+�ͧ��?�>��1���;����ޜ�˿�OY�����M��������E��/�������M�?��2���~�2Q鬻D7|&�5���^��3x<�w����]��BS���D^��˗��;Dm�L��e�_�C�Q�$|u��_]� ���pd<=%`p_�3{3Tb�<��?m~���L��������C\�>��ɋ��6�S���/Y ��p���"����ed�9�O�碤�7�ÆX�~�J�g������U�������=>���:V_t\�{���S<]-�?9o���i�k{+��W5��D7< �W`>�͛�d՞pl������~�����(|�+�y~C�������쵯����{�c�?do�?ͽ�� ���?����-��w�×����w����$>��0ʿ��O�}���b�L&R,eq�����}w����}��;�H����Y|�VX	�|p�[#��#W��WJ��᯦�ƿxK�����)Ǿ���/��Ҷ���E��^���������O����_��m��fg����?�����:g?qN�i�g|u�T�h1\=#�Vӎ��#�gvL�>{�m�I�q)�V''���qϦ������w�y9�>�w���䬱���� ����I0\n���lwY�����У �'�����C���V�0[NW�N�qF���8�z\��/��#���3
l$���:��O�k��|��-�E���i���"9��q�,�P �齭U�̭ÌD��g�dF@�����dh���{�����?���3B��WĻ�n��<Y���кΈ��7� 9�y�~Y�'��]��<i����NH�`٠Ga�O�w�Y���7׉�{�i�I��\\'����Ê����������]v��g��?�Ϳ/��?���B�.��?����n�du��l<o�#Y铫��&*��������{M�^�Ξ�����B=��4p��K~��iF(�&K:��+4��#װ%�H�Q�[��v>�[f͸��� �C��jϕټ�������}(�!iT��R��.D��q��#+�x�8D�R�:g���I5|0�[�.>B��O���٭J�M}�.���C>
�3���W����֢���Dt��e�V&���Z��l0����^_�g��j˦���[>�v�����K��� �=���8�CiU��q)T}��*}U��N
�L���7t���B�K��ih+B��:��o�5/	��[^����W��\�}V�#���.���!$���{ �+�~�9�u.aʟ��|�����Z{t�l�$�{R�	:_���?a(G$��S]���#D�������'���";�	Z��c=3f�{]��3Cj��y��zUڭO��bԿ/���\sO��զ-GR�DRf~����;��y�_��݋HK$[�����y���9f�G�Yf�����(�} m+֤��H'��_�/���:U�s�?�s�t?ynD!�.��Y2�x��[Z���n݋�T��oK'����$O�m���ǭL|owrju��7��hL>]�����hi�k�L&V �!����mJl��г���11�en	M�fՎ\�N|p�>�k��5�ݽ�p�&t��8">\�	=��n~��i�ώ}�D�D����/�����)k�"_���|���?^�qǛN'�l6ZO�k����E�u������I�qv���qgᲝ.]����?f�dv-�e�R�s�-��l@�Q�E���M=�>3{�<`
����l0��~[�0�&����x�rt�o����0K1cx��s�Y����(@.$�@@�@��� �����l B��:�ZX�: T� j@��u�[Y�]Bڽ�����=����b̓R,���`A���C���}vp�1� ����R@� Ab �xx� �>wp�-}��2LN�� gL���{�"�v>�u_��o(ub}7�1ڥ#a:��^;�̃�m:��n�2�V�bl�Ϣ���d2�vܭu�|��ͧOS�}�n�-�r	� (  a��NH�1�$
	V(\+
�,v����q];n&���(�/��h��������e���cd/�o�B��l-�|fDPl�@�(1=h`��D!�;��C{Ì�9�0�7�Aaw�qv�M�D�h3����m~��s8�I-~zQ+��^%ùS���1|a�\��E� 8�q����t���a�{�9�)n�\Κ`��<h���h��������<�����j���^o���M��o��� h��Qhp<� ���T�>2�I�D��l�FNt�	�}��#'��+'r㾡�ONF���b��;1x87��fj��R�ZstCSH�Fu��f �qŵM�i��Z���)������ȷ�K�{>�^3��T�{�9�Ս,��u2��'ѵ:1���ޜ�#����N�G�k��©�y��{a��7jz�Ҳ�_~�e��j6�)�_y����/Ђ\��L.F�b޲����|ie-V��o0J������.��%V�f����@���a���/�Zl�:؇�>�Y����a�X=Jj�.��fnJ�8p�O��S�sm@��������Sj��Z.ŝ/:*M{���Bp�vaO���F
�cٜ�;�fN��^�7�i��ɓB�c��:�8G�:0L�8 ����@'�%�@6�4	@�R��ى8kq�X�q�[ս��Q�v\k�:C���n�_#3����
r#gy���1 @$���t0Ĉ���jҋ�g�C�5���D�Vp\�D�w�O�;�
���_d�Hl��!�b�(�f�F�~voo/Ǽ���.�.聗�&V�ܻ�Sk��YH2}����@7 c��f�Ԥ!�� ��� y9 IO��=�I�3%0Ҋm@������ٚ[�,v��b?{��>Ft��:�T7�Q \���Q۴L�h�煈ԡ��S�� �s�O�aK�؉ģG�Y~?��不��-\�	2r��x�=o��Eu@K��خ܀Z YȰt�E.sCHBe%7}x]�4��̧���h��XdS��*.�V8&�&�J�r��#xc�fܕ���4�ͭ$�m��PX3���4$7�x]�4��̙�\�0<8� tNi'�Ss�!��d��oj,Z�)$=|MG�P��aM�õCRCLM�_X�SA�*�v�A���*���@���PQ�w/�N׿�kPQ�*��;1�|�6`m�������?�)f��5�<��7��d*b-��܃"=!��&�|���.��1��{Q��B�6�e��(�)�F.������BkP9��a��Q�����DXbk9��C�[��-��f]u�)�m�7Y��}�ŌB��8�hO� IS�q�a�wN��w��%� ���&���"��$6��H;�\�&f�b��̶��u=��Ok}�h��#�A���~�b-~�Ե]r�[U�s���a�,`�:0�V��0z�=���t
}�}]��A~@%��M���g��1�i*�k�ȗ������P�c����v3��4k�V    ��Q�������R�'�x�sn{h��hئ ��#���ЁkۦA��KC�������0����Ζj�$�'�uvQ����\v��cǉ��|Y�u�땉S��������l�{�3��� �O@�,ˣ�.��2��s�Hș5���تmw�L�e�NS�{xn�z��쬼mo��w��`+qR�����֑i�i ly��DNҮ����#��S�60=�Te��i����d
�/������9�<���=��Oϒ�}dT��d�t���sT6��K�Ri�x{tpSTB"7008KsՈu`�H�t�i3��^�8��p
HvB��ĳ����Zvͯ���`������F7j��PD/^Բg�`r�}����]wp@����9Zn;�
��Nrۻ�CC|�O�|�F��4\���!��0��P��׊A�4ׅ���u<ޙ��v��D�J�$����hT�N�."h30�@��f�����:2��z�0	����ލ��q熊-�_�U��@�p�ge��[F�pd�cə��r�\X�l5vc1�"��*(�(��-�C 
�V_�L�'����V?ˏ��Av�ݞ�d�6�!�o��ײ���q��1m�����z�9On�-m�ЊLş�����J�'O�ɻ���D0�J���}��P���,�%�Ed�^�HV�}N����~*K;F����v�p��Ω8*'�<*'ڇ��@O�7&E^��6�� ؾؽ`j�Զ����mC?��Z7Ez2�֊����)�Vl��Z����:/���L�Ӳ���^d�kp~L'�	m�B��7���s�ȸ�lm��&����di�Ū��3b#/0-��l����Z���΢�lE׊�]+�^3]�sm��MG%Mߣ�����~=��8�6g���Lt�<���O�>��ꕲ;�ך�i��)�kܻ� p��".�t*7��_�!��9[1�]bHuJ��Gŏ�W�q]˵�����wq�Z������t��so�g���i��N~���3ܾ-���V�֜�g�N�
N�5l�Z'Zs����!g5����zg�狇P�8�Q�1��M�R�Z�m l�R��>Q��mő�#G*����pG�x����x�WhT�J۷�G�\2����d�������ꀝ�C��f�����@�5u؈�w%��tLh� 浍�j�Wq��M��Z��"�5����#p���b����t|�=-��{��v�+Bt&���L�z��|MR��C��c&���K<NՔ�!��t����ݐT-C*�A�zȺӕ|Q��Fޫ"P��]�E������u�ן��dX�8�e�|�m�+Y䔲�3�BF�(a���JX�WXtJ��3�d<H����8�t��<h��\X�ZˉrX�$j��y"�<.����uM״��2&� i.!�U�y�FL��sa!�"ӷ���Qhd��b�p~8�n|�_���"u�,�浜�.x�YJ��s9��1����7�"���/�ى�g�ER���[!x�7p���2�#Q����-�$�����<�g]}0��Q�.e�,���>��S�d�郵�|��"���Z2��w�#�3Z�ZQ7ő���[;G'�ty7��5�ߩBn�~<г��P7o��#�<��8,o�E��d�F��W�|�@�L- 6� �d��=0�Z���HX&�Q?�0~ZC&��Dd�+�'���p�v���`��a6��{sG�-�XɎ�b�MS�:e6b6�4���4��|;�a�	Hu����u &8"�;1w�j;�����ۃt��`���.�����F)������h��"�K��t<]wA�1�v�nc������O?���ցI$�d]����S(����Y ;ȟ�����4��o6�ͯ��\= /�<���ap	�-@��o1�ƞaKH���~0G?������v9��Jn7߈&�}����/J�e�ܔՍ���-��'�B��a`r�	�nڀ�l�3���0�:��s��:0I����p�v�A��J�X��D�b���� �|�*;�܍�BZ(p}�j��- O#���l��G}�{򾂻զ����S���x5����|��w�e���f��&f����c��v��u��m/��O�+���vnosV�� a�bހ��@���\ƅ,��bɍ`I�N��bIŒ�Òy�w�c��A,e2�?,�w���,Β�������q�׷7�%���ek�"`3*R���7Mu��,��%7�%�J�XR��b�[aɒ�%�ۓ���D�����=�+U>�s��.X��7G�V�q��W+�Mz��\�(0mjqga���,S�L��i�)ׯ8�L��F�J���R�"�["ʊp'{�x!S��"�m�Qr���Qĉ�� JWϛM���7ŝ\]#�ԁ�Hd�B�� �X��.{�us��%��mi�$��:����(���z}��v!w�\4V̄�k�w�*�G:��A��'�8t�ti1��I��$�~;��D�BE��Er��� Z��kz�g���k�OT�m#dV�M�6%ڔh���B.�0��;��G�a�e��2��h>�E�pAT���>��Mm8𱯣 "0�����@�Cԇ�a<����X�c�zaz�����E4����(2�}b�=YR ��|�ݟ~|���]��+�_��Q�,�^JhYg�+b�>��b���\}�.�a��N!iㄕ)x���=
�¿{UH��7�I�{�D�KQ��Ê�q-���Ȑ���U��t��t{�x��9�Z�WD�.�<�
��:��FHV����ƇQ��ajOg������}{M�^�ϟ����L]� lǇҸ�z.g��I$�\�3�Y9
��<�O���l��ۇ��y��k} �O>QH��\�͛.��>�!u�W	ɟ����z?��ʑI0}�q)~^��a��l�M��/jY������Q���M@�Q���ɺ�{��K�o-�0JOd>�OW�h�2�L2�����]�~,�ë-�~�r(l�PXP���������<�0��ėb͘If��9z?����m�fbU��
��L���5n��"��Uo�H�T�!5JNH�����Q�'��A������<�����TUO�����s��~Ε>���.���}_��ǋ�~]�=�n0gB�=)��/���0!�⩮^۲�$J�k�}�"��'�/�۞2���3+v��gQ��B�~iW%�^��S����K�}4ğ�R��z��b�t���X`w�?�0%����"��|�L��}�U��������N���=��������q�k�R�5�Q�����T?y2��ʓC.�'���B+������ޖ0>DcE[V���+	���q�3^&�8C��`�ӯ�#7��SL0� b���4���E�8���z��{j6s#�_�1��]7����a�(�/2��N���wh92�T�щ�m��ӘTwMh@���,���6ฦ�Eh #�n(nl��P��oP�H/wOʦa�?&j��8
���m7��vv�3�x2�M!@v ���-��kP3D!��B����}�Q8:�2��:K�@ˬD�kw�U�Bk�Bf�Z�x,��|�L�

��5\�,, �l�����!Ŕ��ܲ�y=�����Qk9j-G��<g-g��g������og��F�'�TeN�N��s��r� �q1�	vF������iC# ����D�#��i���[A 5*9R�sl8I�{I*�T$yK$��y)[�/�;;��l=���ЩUO�e��d|�`;��mCH�0�>�:�`P�b��I-���I�*�Φ��ʠ�hRѤ��ۢɬ�%�%���A/�u��Ğ�ɴ���,h�J���a�LLЦ�$u}�Z�|_���a�����X�h�I�T)t6�&U
E��&M�M�7�zp{�����af7V��'�8�&�e�B0)�����M�ɀ1˅Z �R��a� �-�\f�.�4�r�l:M�:�&M*��-�,	o�C���1�jV�Gx��߅�X��djA��r&Sݱ���4<b0�2 �kqo�2 �m��q�   �����R;77;�6���V����X���i�$��$}6��`y�He�I7^�qp�Md$�Wk.��.NsЀKl�3���o�6�J��p�^���Blf����I��r�̹>4s��ϓ
�!Y�����Z��>���n���a`�&7��G��A�\C7]q�S8\/���6�ay��G;��7���
�=��d�8igi�Zɍ�G_w$�J���Ae��fD�l����[X��p�v[�(]��=�fs��a������r�+,��C���W�w9���
�U$M�t������8
Q�M ����\�¾o�&�)U¨=Xim	����(h�;��=옭A�����3�9�+1.1pތ&.�7�b����V 
m��=��أ����.��㵁q$���Mꙋ��v|�t�h�E,�XY���VEf4Y���s����0hqV�pM胀��X�}��J*��O*���jVY�*�Y�[�U����Frt�KGI��+L��c��ӿ����.��t27H������*��� p�O�t_��j �n���j�}E[c�����&��%!�MӇ�Q�Ð�[f*���#Q���޸n
���u,R�L�yOB���_.�f��\-XR��!n��Tm+�V��J�/>��Mpǲ��K"�h����~��H�K��w,��j*�����n���;�1��Y?��.���=?z�����R~~��{�"��
f��jڙ��X�2�f!�������a. ��!�
� aB���ud�.{<PL��Z��*�VL����0uJ���R��Y%�6K~�'�c}r�ۜ��A�e���T6��Mȝg��ցa���H�$VE<��p 5�h�Ԇ��Z1���UT��ZQ�ݤ�`ǡ�/0X%��=��\�7r�S�2P�/vN{'������P��!�|W6���O�m3� `�f1�S/�j9z~^�������b���_8����җK�y�_�������pR����z���r�J����<�-Q���E���y3ޙ^;B�p�%�~$�^I	>���4#�h�qh�f�����ux��RwGJ!����RJJ))�^)U�0wA#v�������h��h�d�f�K��Jj���f�b�#���]�#���eX��c0�i�F��E2�9^���CSǡ��8�a��C����|�W�8�g�󽟈��$G���C��ѯ��=��"�Y��b�;��L1���o����Q��Eqn)�����[��5Q,6�V�CF'p<�r�X3S=�'N�t��]�K6�I�m��*�yRyj���a`�B��l�R )��lͧ�,4JF�=q�wt���N�{8���'E�c��]$rȆ-��/�	�S6�fK�h�qQ&���L��xC� ���5�(�Y��R*$n�ahkCbKD�i,�v{b��L���N&z�#��]����X?����� "�&>�<,"�4�g����Ԣ��C�u]��5#��!�6$�#"+F٬�Ial��ǥ��/��3���2�xt\��hyW�)������Lj���]j �h�>�Ȣ���,|�j��Z\R;j�ڒZ[RkK/���6�$�.���Q�0=n�����E�I���ӥ���NV���	�{���\a2uj؁ˀ�!� �bD vu�u�t�B�����"lE�jc�bl�؊��c�g����K{�E�b|�r�kM�w3�S쌜X;[�����"��$y�$�;I�#Sw� h�b���Ѹ�m	�ZP6Ć�lE��PEي�e�eʎq'�������p��<��1��>�N���nݺ��xtt�5s�w��1�	!��ˈ^�q}�#��#a6Ok�4��f�[1���W�)�V���v[�dm�(͌��N�v�w��J~pB�g���`����k���mcS� ˣ���Y�&w���3�Y:4��غaaEي�U�e�ي�g�i�N
/;漣UX�T�6���y�V�8g˭�}t�Yz`���ن�.��=M�^6 �&�p�05ݷ� ϖ���,�0�EI<C�a����I�w�����W2zh��}&�d%o���X]X��C�dJ��X�UѺ�Y傎V�&>S�28�91*Ɗ��^`�f��7����T���N�C�N%:�輝��:�y���6�aTM�����^��(�,D��-�Oƌ�I���gݍ��Ħ�3@�碓����a�P�繶-���>��Nۻa�3��~��: �"S�LeKS�L)2��n��:d8�>���,f�Z��S��ўA���$��9:�����Ʀ��b`�y�si ���"݂�%��!�[wz����cJ����
�Sbl�0hCi1�ŔSZ�Z�й�M���y=�pQK��:��.���i}��h���Jl��;g��7�6E�Y�����B&��� �E.4��� �A���~�J�n��UJ��(1��)�SJL)�5�!P����i2y���$[�z<�<��ْHͷ��w<>M����n�
%�]߰���vd ��r5ݲ�
Ӷt1#fk�..��y��9ɇC���ns9�8��}���_��է����9E�
�O��1d�Us1��g���z=3���`^�l��ȸ�F��l�˻��C�W���r0�t��+T53��zie��ʘ�2&Bt����$�v��9ڥ#A��n���!��S��qЯ&���w�T������9���Jm��z���0Zh9즙"��SL4�"�c�@\������.�O��cn����;|��X��wP���V|���dOK0�s��a�0�
4�7��P�2�ɜ��q��	��R���X����L�2�cTG>0��]����x�'�N��%egLҴm�z��Q�dΊ�Q+��;D!'겗���[��󻹝�q�Hb{eN��Q��� ^�2x 6��=Q[�܁v1'/P@l�{֔6ufyH�n[��S��AEՊ�U�Q�F§�d�Ӭ�'�
b���鑡j��s�	�Lj����锟v����y�\mSY@M�"��� Ԁ �lx���0�ZCX��"k�R��"kE�w���'�jwNs��N�ĕq�Ѩ�zo��~5\��t�&��q4����$��)r�.�~5��Qv���mS钫!�4�Պ�UHE֊�Y�U��Yׂ=�O֛�n�{d�K�j��N�xA�,c��ž�;Jl
Y#��0@�x y�\� ��`� Xw%Y�})�Lŕ�;RqG�FV01�/�D�#)��@�LS2Mɴ[�i��eZ]7�Q�Pu�1g0��t\�s�f/d�A6��-��f�����W~������5      �   j   x�-ˡ�0@Q,�ȑs���\Q�d+�t�L��j��䑿�t�x��Nk��4-U���G{?��-n���Ȳ�)MH鴑bTa��4k���YB?d��      �   �  x���nG����0t�ۣ��>�N��]#������ �1Vb"��� ��Y���/��F�4��Ow}]�&�������
��^Un� [�k<^�Ƀ�Ϟ>t<y������D�&����!O1L;� ��`"7���Z���������|���O#�����ԫ��w���r�I<����d\��2_���^_�^�ː[8����4�G��<�>Y���l�pgu��,�����t�������k�g����e�����r�T~?(ߌ%΢����\_���\����v=���u?�������<�z}}2�Z�s��������^����X��qV�rl��#��S���}ً�/�H���i{�^{��lvy==8����m?�N�� ^�\�wg�|v�W?-Dֿ#]:}]kw5? ����{�l��I�3Q)
�T0(���h��f�'A�҃1nzv�f�mg��i���g�V��<��|������1��MG�Ǡ�=5��>�����;b�%����Y̞�F�JR>rRZP!�$���P�;|�����W�,�r+�	�`�M�?���J*1���EI�Te-R�UN�}K�-�`��ͼ���NH5�P{;��+����=�"�"�Xҡsf(�v����z�yj��(���,w��7�x���2�4(K���U$����� D6i�N�>�.x+�9�q��1�C�9���.���#NL�:�z{�;b/��Y9<��Ⴝ�Jr��x������J��R,�e���(m��j�#<�X�t��H�h�]�����f�#��}��7�?<{�Ղ=p	�A� (�U@�T�ֲE'��f!h�v�Sn�en����J*�&�M�l�j���/1ہR�s���|_G��9��H>��ТQ�!i�]�kZ����_<yx4������&`�@����Gk1J:��Bsh]�H�,�3acS��R	�ʞ�;�g����J����T�"S�lޱY�h�ƗG�~z��b��G��<��+A�$^;nJ�&�����K��V"���p��s��G�����{wxy��Ǚ}�,�3똀T-}g��S��UL-7g����T+ޛ��,(X��1 �@/��zJ�*@��j�fL�7�q���T�W��;��g����'G�#M����l�;B[J�������=�sN�ʁT��*�H�ƖL�Z�b���z��
~x�?�!���.���n�3v��1��]X#OdƢ��[<��i��K�??|Z:��(X���a�rG�}7����m�rV���ܟ�D_�b�Ї� ������:��"�Zi�$n�✼")�%�1Io��hK�4*x��>x#��Kp�f�T)֨�"�ƴ���v
��J�z�2TE����Uea��MdxKL�j�R�X's(�W0�p����-�yI/�� Sg;P��**Gk)�\�$uZ���*YK�C�+_�U��
M��QiZ��lG(Q�Vti-:��QЕ���k��&^��~<^Bp_��K��,R^$�RnziQ���i�9ɽ6�>wOJ_+��qX1�J>�i�g��U<n�3�`�
gK�V. ���$K�oӒ2)��l�Gl�M
%��M���!�-�K��%�d�l�JA�~d�w�Jm��3�U.�3��u����ΚO��a���L�DXɌct�2c b�w��-i���L5�v25`���N��.W��/ڍP�[���J��.e��7Sq1����ϭȏ�O[�w���;������x�<|��i�|�iC#��l%/�")Z��B�9S���_
��.t��'�xw�2<��u����g?��/��\�g��ӳ��GG-�g�R�䄪&&:�\�K���3�1���q���;�Ƃ�;�|�1`�#�.��p�Փ�/�G��x�W	:�)_cP�B4:i�J�R୾��; �`6����a���hno�rWG���������ˣ���Z$��D�Z���(P���d\�������Y�a,$�(a匙J5[JI�,��L���'CAE����耠�c��5����%�D�E%̬�,�o�f� ��((�hIE5K�=[d�tPN������l;2�?�Q����b	$�&������BUװ��e��z�49JC��$�5�m�]������N��H��dło���Y~U�J��[w'�����`�a�Y@h��Lʄ&���o����.V'wN[J|������<l       �   F  x��X�NW^�O1�d���?�A�4�U	�."Ev='.C=J��ЖE����&P#�J�P��P��Y]?���z�+�!D��\Y����s����3Ɗ0�	E4s���/�B����,���V��/d�d1Ώ�˹$��s��繨:7�Y���DH�4Ú������'_\���쬨ҙH\�y�|��ޕ�t�05��xtq>J������܍ŹA��`<�e�Y�<W9�9�,���I�em���X1�*KI\�f�+s`4Bhp����,�"�Q��X2��	�Ah=�7�g���䘳�'?�k,�
s{r�����o9�D����ZjAt*�,t����� �D3�(��LAfӼh��C�,�Ӎ�q�5F̺�BW�0&�ax���d��,�H�VC�)��[I��r◤@.��#���ȒLA�&TP�웗��^	�?��.��2��C�
̞i�W�w�~�� 
���g]d.]�\!�	���lSa���l�4>/~���1,'Y��P�#rx�E&˥���|2Y�J�R�s��x�B
�^[�2?B4��_�OP˼���îg��Y��W�!��V��&
�J���=IEA�4�b�E
��T�>��Oy>*uF�1Ρ��dAd����������N���K�&��/hݐ�y&r�+AiV))���nn��'�x��o��y��&4�t�A�,v���_?�7:���:�pyϳxsg~"������þ����]�����u��R�9���
e�4��2���Tp�`(C85KZ�S;��v{�v�:���wp�3vr� Fd�TV�Tx0����75���S��B#��	�@�S�5��(K�m��a����Ԑk��K������;g�y�S�`X�����̳����)�(���>�����<?��~羕��wk[�ﻵ�n�g�:�6q?3&�a3�zS�l��,Eq�٣�9	!=Q(�N�!d���5��}U�̕:�N)�Fm�Ha���׽��;``����Z�ɽ��;'k���y�>���5$I�>7�{�YH`��K���?'6�S�d!Y���Q89"M�Қ��,-��p�3G��x-��f��o~Z     