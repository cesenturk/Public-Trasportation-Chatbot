def questionfunction():
    questionfile = open("questionList.txt", encoding='utf8')
    questionList = []
    for line in questionfile:
        stripped_line = line.strip()
        line_list = stripped_line.split()
        questionList.append(line_list)
    questionfile.close()
    return questionList
