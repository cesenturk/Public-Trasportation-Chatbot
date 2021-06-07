def answerfunction():
    answerfile = open("answerList.txt", encoding='utf8')
    answerList = []
    for line in answerfile:
        stripped_line = line.strip()
        answerList.append(stripped_line)
    answerfile.close()
    return answerList