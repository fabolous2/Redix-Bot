PGDMP  )    0            
    |            redix    15.8    16.3 	    f           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            g           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            h           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            i           1262    16384    redix    DATABASE     p   CREATE DATABASE redix WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE redix;
                postgres    false            �            1259    24663    product    TABLE     �  CREATE TABLE public.product (
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
       public         heap    postgres    false            c          0    24663    product 
   TABLE DATA             COPY public.product (id, game_id, category_id, name, description, price, instruction, purchase_count, game_name, image_url, purchase_limit, is_auto_purchase, auto_purchase_text, is_manual, instruction_image_url, is_visible, auto_purchase_image_url, is_gift_purchase) FROM stdin;
    public          postgres    false    222   (       �           2606    24669    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    222            �           2606    24794     product product_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.product DROP CONSTRAINT product_category_id_fkey;
       public          postgres    false    222            �           2606    24789    product product_game_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.product DROP CONSTRAINT product_game_id_fkey;
       public          postgres    false    222            c      x��}ks#���g�Wе�U�:�Ӎ��֤(�"%�o�T���n�ĻX����lv��u�=����r���{*�g'c�ό����_�8�' ͛�c[�P����h$�@����x_X��f������1`�P���C�#���[���뚦E�oO?�~:��z=2�W�ϫ���Ǒ����2�ٌ��������-2�=�ꓫ_L\��~(�x����ë�������z���͟F�o���OMF��+�^��<�\��/���u�l/GxI���y{�\���<����_FD1��yݯ���������E��?dU�y���巏x�~.��%DxA�~v���g���O�~9����'�6=ۢHO�|�7���iE~��z0�#/�u��xn����=Ѥ��^6��uY�Î�yS6��➗�f�zs�1/�S�1���9�o#���O�X��Oy)�����E��D���:�c��g���!E�Bt�;��D��������������o�~����?yk����#�__�!ޡ�K������?~,�@�;�+�ͧ��?�>��1���;����ޜ�˿�OY�����M��������E��/�������M�?��2���~�2Q鬻D7|&�5���^��3x<�w����]��BS���D^��˗��;Dm�L��e�_�C�Q�$|u��_]� ���pd<=%`p_�3{3Tb�<��?m~���L��������C\�>��ɋ��6�S���/Y ��p���"����ed�9�O�碤�7�ÆX�~�J�g������U�������=>���:V_t\�{���S<]-�?9o���i�k{+��W5��D7< �W`>�͛�d՞pl������~�����(|�+�y~C�������쵯����{�c�?do�?ͽ�� ���?����-��w�×����w����$>��0ʿ��O�}���b�L&R,eq�����}w����}��;�H����Y|�VX	�|p�[#��#W��WJ��᯦�ƿxK�����)Ǿ���/��Ҷ���E��^���������O����_��m��fg����?�����:g?qN�i�g|u�T�h1\=#�Vӎ��#�gvL�>{�m�I�q)�V''���qϦ������w�y9�>�w���䬱���� ����I0\n���lwY�����У �'�����C���V�0[NW�N�qF���8�z\��/��#���3
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
Y#��0@�x y�\� ��`� Xw%Y�})�Lŕ�;RqG�FV01�/�D�#)��@�LS2Mɴ[�i��eZ]7�Q�Pu�1g0��t\�s�f/d�A6��-��f�����W~������5     