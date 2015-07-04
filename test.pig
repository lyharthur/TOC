Register 'test.py' using jython as myfuncs;
A = LOAD '$input' as (str:CHARARRAY);
B = FOREACH A generate myfuncs.handle(str) as uri ,myfuncs.url(str) as url;
D = FOREACH B generate uri,myfuncs.tuple_ct(url) as count ;
F = JOIN B by uri ,D by uri;
G = FOREACH F generate B::uri,B::url,D::count;
DESCRIBE G;
store G into '$output';
