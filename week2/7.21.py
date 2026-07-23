import re

text = '상품 번호는 A-102, 가격은 25000원, 할인율은 15%입니다.'

# numbers = re,findall(r'[0-9]+',text)
numbers = re.findall(r'\d+',text)
print(numbers)

email = "nick123@gmail.com"
# \. 텍스트로 . 의미 \. 나타내고 싶으면 \\.
pattern = r"^[\w.-] + @[\w.-] + \.[A-Za-z]{2,}$ "

if re.fullmatch(pattern,email):
    print('올바른 형식')

else:
    print('이메일 형식이 아님')


import re

phone = """
문의: 010-1234-5678
관리자: 010 9876 5432
대표번호: 02-123-4567
"""
phones = re.findall(r"010[- ]?\d{4}[- ]?\d{4}", phone)
print(phones)
web_text = " python 정규표현식 연습. "
result = re.findall(f"[]{2,}","",web_text)
print(result)


