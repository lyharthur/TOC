import re

@outputSchema("handle")
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
			if(u_list[c+2] != '' and u_list[c+2] not in url):
				url.append(u_list[c+2])
			u_list = u_list[c+2:]
			cnt-=1
		return url
	return None


@outputSchema("space2")
def getForm1(word1, word2, word3):
	w1 = str(word1)
	w2 = str(word2)
	w3 = str(word3)
	result = w1+' '+w2+'	'+w3
	return result

@outputSchema("space3")
def getForm2(word1, word2, word3, word4):
	w1 = str(word1)
	w2 = str(word2)
	w3 = str(word3)
	w4 = str(word4)
	result = w1+' '+w2+ ' '+w3+'	'+w4
	return result



