
# coding: utf-8

# 1 задание

# In[ ]:

long_phrase = 'Насколько проще было бы писать программы, если бы не заказчики'
short_phrase = '640Кб должно хватить для любых задач. Билл Гейтс (по легенде)'


# In[8]:

if len(long_phrase) > len(short_phrase):
    print(True)


# 2 задание

# In[26]:

text = 'Если программист в 9-00 утра на работе, значит, он там и ночевал'


# In[46]:

print(text.replace ('и', '**')) #но replace можно использовать если глазами реально все увидеть


# In[47]:

print(text.replace ('а', '**'))


# In[44]:

text.count('и') #я бы использовала count


# In[45]:

text.count('а')


# 3 задание

# In[69]:

bytes = 224059719.68


# In[70]:

megabytes = bytes/1024**2
print("Объем файла равен", float(megabytes),"mb")


# 4 задание

# In[71]:

import math


# In[77]:

math.sin(math.radians(30))


# 5 задание - в питоне просто сделать

# In[84]:

a = 32
b = 16


# In[85]:

a,b = b,a


# In[86]:

a


# In[87]:

b


# 6 задание

# In[107]:

num = 10011


# In[118]:

num


# In[124]:

num10 = 0
for i in str(num):
    num10 = num10*2
    num10 = num10+int(i)
print(num10)
    


# In[ ]:



