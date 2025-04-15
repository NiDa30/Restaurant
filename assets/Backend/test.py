import numpy as np # linear algebra
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import plotly.express as px
from plotly.offline import init_notebook_mode, iplot
init_notebook_mode(connected=True)
recipe = pd.read_json('/kaggle/input/recipe-ingredients-dataset/train.json')
recipe.head()
print('Shape:',recipe.shape) 
print('Columns:',recipe.columns)

print('Whether Null exists:\n',recipe.isnull().sum())
recipe['cuisine'].nunique()
recipe['cuisine'].unique()
recipe['ingredients'][0]
recipe['ingredients'][6]
recipe['cuisine'].value_counts()
# bar plot for count of entries for each cuisine
x = recipe['cuisine'].value_counts().index
y = recipe['cuisine'].value_counts().values

df = pd.DataFrame({
    'Cuisine':x,
    'These many entries':y
})
#fig = sns.countplot(recipe['cuisine'])
fig = px.bar(df,
             x='Cuisine',
             y='These many entries',
             color='Cuisine')
fig.show()
from wordcloud import WordCloud
x= recipe['cuisine'].values

plt.subplots(figsize = (8,8))

wordcloud = WordCloud (
                    background_color = 'white',
                    width = 712,
                    height = 384,
                    colormap = 'prism'    ).generate(' '.join(x))
plt.imshow(wordcloud) # image show
plt.axis('off') # to off the axis of x and y
plt.savefig('cuisines.png')
plt.show()
all_ingredients = [] # list to store all ingredients
for indiv_ingredient_list in recipe['ingredients'].values:
    for ingredient in indiv_ingredient_list:
        all_ingredients.append(ingredient)
len(all_ingredients) # 4 lacs ingredients 
# Convert that list in a Pandas DataFrame so that we can apply value_counts
ingredients_together = pd.DataFrame(all_ingredients)
ingredients_together
ingredients_together.value_counts()[0:30] # for first 30
# bar plot for count of entries for each cuisine
x = ingredients_together.value_counts()[0:30].index.tolist()
y = ingredients_together.value_counts()[0:30].values

df = pd.DataFrame({
    'Ingredient':x,
    'These many entries':y
})
#fig = sns.countplot(recipe['cuisine'])
fig = px.pie(df,
             names='Ingredient',
             values='These many entries',
             color='Ingredient')
fig.show()
recipe['cuisine'].value_counts()
recipe['cuisine'] = recipe['cuisine'].map({'italian':1,
                       'mexican':2,
                       'southern_us':3,
                       'indian':4,
                       'chinese':5,
                       'french':6,
                       'cajun_creole':7,
                       'thai':8,
                       'japanese':9,
                       'greek':10,
                       'spanish':11,
                       'korean':12,
                       'vietnamese':13,
                       'moroccan':14,
                       'british':15,
                       'filipino':16,
                       'irish':17,
                       'jamaican':18,
                       'russian':19,
                       'brazilian':20
})
X = recipe.iloc[:,-1]
y = recipe['cuisine']
X
y
from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test = train_test_split(X,y,test_size=0.2,random_state=1)
X_train = pd.DataFrame(X_train)
X_test = pd.DataFrame(X_test)
X_train
X_train['ingredients'] = X_train['ingredients'].apply(lambda x:  ' '.join(x))
X_test['ingredients'] = X_test['ingredients'].apply(lambda x:  ' '.join(x))
X_train
X_test
# Applying BoW
from sklearn.feature_extraction.text import CountVectorizer
cv = CountVectorizer()
X_train_bow = cv.fit_transform(X_train['ingredients']).toarray()
X_test_bow = cv.transform(X_test['ingredients']).toarray()
X_train_bow.shape
from sklearn.naive_bayes import GaussianNB
gnb = GaussianNB()

gnb.fit(X_train_bow,y_train)

y_pred = gnb.predict(X_test_bow)

from sklearn.metrics import accuracy_score,confusion_matrix
accuracy_score(y_test,y_pred)