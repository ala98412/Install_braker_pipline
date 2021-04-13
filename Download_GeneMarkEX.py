from re import S
import requests
from bs4 import BeautifulSoup

url = 'http://exon.gatech.edu/GeneMark/license_download.cgi'
myobj = {'program': 'gmet', 'os': 'linux64', 'name':'Jui-Hung, Tai', 'institution':'National Taiwan University',\
    'address':'', 'city':'', 'state':'', 'country': 'Taiwan', 'email':'ala98412@gmail.com', 'submit':'I agree to the terms of this license agreement'}

x = requests.post(url, data = myobj)

soup = BeautifulSoup(x.content, 'html.parser')
a_tags = soup.find_all('a')
for tag in a_tags:
    s = str(tag.get('href'))
    if s.find('gm_key_64.gz') != -1:
        key_url = s
    if s.find('gmes_linux_64.tar.gz') != -1:
        program_url = s

with open("gmes_urls.txt", 'w') as FILE:
    FILE.write(key_url+"\n")
    FILE.write(program_url+"\n")
