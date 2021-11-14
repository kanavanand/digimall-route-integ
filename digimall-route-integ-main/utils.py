def getPossibleSearches(text):
    smallWord=[]
    string=""
    for char in text:
        if char.isalpha():
            string= string+char
            if len(string)>2:
                smallWord.append(string)
    return smallWord
def longWordGenerator(st):
    word_list =[]
    for name in st.split( ):
        if (len(name)>2)&(name.isalpha()):
            word_list.append(name.lower())

    possible_big_name=[]
    for index,word in enumerate(word_list):
        for word2 in word_list[index:]:
            if word2!=word:
                possible_big_name.append(word+" "+word2)
    return possible_big_name
            
def nameKeywordsGenerator(NAME):
    possibleCombinations=[]
    for word in NAME.split(' '):
        possibleCombinations=possibleCombinations+getPossibleSearches(word.lower())
    return possibleCombinations+longWordGenerator(NAME)
