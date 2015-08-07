Register 'udf.py' using jython as myfuncs;
A = LOAD '$input' as (str:CHARARRAY);
B = FOREACH A generate myfuncs.handle(str) as uri:chararray ,myfuncs.url(str) as url:chararray;
C = FILTER B BY url != '';
H = FOREACH C generate uri as uri:chararray,FLATTEN(url) as url:chararray;

H_2 = FOREACH H generate uri ,url;
H_3 = FOREACH H generate uri ,url;

I_2 = JOIN H BY url,H_2 BY url;
I_3 = JOIN H BY url,H_2 BY url,H_3 BY url;

J_2 = FOREACH I_2 GENERATE H::uri as uri1, H_2::uri as uri2, H::url as url;
J_3 = FOREACH I_3 GENERATE H::uri as uri1, H_2::uri as uri2, H_3::uri as uri3,  H::url as url;

J_2 = FILTER J_2 BY uri1 > uri2;
J_3 = FILTER J_3 BY uri1 > uri2 AND uri2 > uri3;

J_2 = FOREACH J_2 GENERATE TOTUPLE(uri1,uri2) as uri, url;
J_3 = FOREACH J_3 GENERATE TOTUPLE(uri1,uri2,uri3) as uri, url;

K_2 = GROUP J_2 BY uri;
K_3 = GROUP J_3 BY uri;

L_2 = FOREACH K_2 GENERATE $0 as url, COUNT(J_2) as count_2;
L_3 = FOREACH K_3 GENERATE $0 as url, COUNT(J_3) as count_3;

OUT_2 = FIlTER L_2 BY count_2 >= $minSup;
OUT_3 = FIlTER L_3 BY count_3 >= $minSup;

UN_2 = FOREACH OUT_2 GENERATE FLATTEN($0) , FLATTEN($1);
UN_3 = FOREACH OUT_3 GENERATE FLATTEN($0) , FLATTEN($1);

FORM_2 = FOREACH UN_2 GENERATE myfuncs.getForm1($0, $1, $2);
FORM_3 = FOREACH UN_3 GENERATE myfuncs.getForm2($0, $1, $2, $3);

OUT = UNION FORM_2, FORM_3;

STORE OUT INTO 'Project-Team-13';

