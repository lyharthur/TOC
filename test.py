import re
import sys
@outputSchema("uri:chararray")
def handle(word):
	a = word.find("WARC-Target-URI")  
	word = word[a+17:]
	#word = word.replace('"',' ')
	#uri = re.match('\s\S*\s', word)
	pos = re.match('"[^"]*"', word)
	uri = pos.group()
	uri = uri.replace('"', '')
	return uri

@outputSchema("url")
def url(word):
    a = word.find('"Link":[')
    if a > -1:
        word = word[a+8:]
        b = word.find(']')
        word = word[:b]
        u_list = word.split('"')
        url = []
        cnt = u_list.count('url')
                #url.append(cnt)
        while cnt:
            c = u_list.index('url')
            url.append(u_list[c+2])
            u_list = u_list[c+2:]
            cnt-=1
            return url
        return 0

@outputSchema("tuple_ct")
def tuple_ct(word):
    a = word
        if a != 0:
            b = len(a)
            return b
        return 0

