import speech_recognition as sr
from gtts import gTTS
import os
import Tokenizer
import questionfile
import answerfile


r = sr.Recognizer()
result = ""
sentence = ""
keyList = []
tempList = []
quest = []
questionList = questionfile.questionfunction()
answerList = answerfile.answerfunction()


def takeQuestion():

        with sr.Microphone() as source:
            r.adjust_for_ambient_noise(source)

            print("Sizi dinliyorum...")
            data = r.record(source, duration=10)

            print("Sesiniz Metine Dönüştürülüyor…")
            global sentence
            sentence = r.recognize_google(data, language='tr')
        print("\nSorunuz: " + sentence)


def analyzeQuestion():
    # analyze the sentence
    wordList = Tokenizer.analyze(sentence)
    # Show word list
    print("\nTokenized Sentence")
    print(wordList)
    for i in range(len(questionList)):
        quest = questionList[i]
        for word in (wordList):
            if len(keyList) < 3:
                for item in quest:
                    if(word in item) or (item in word):
                        print("\nquest:")
                        print(quest)
                        keyList.append(item)
                        print("keyword bulundu:")
                        print(item)
                        break
            else:
                break

    print("\nKeyList: ")
    print(keyList)

def analyzeAnswer():
    for i in range(len(answerList)):
        sentence = answerList[i]
        wordList = Tokenizer.analyze(sentence)
        for word in (wordList):
            if len(tempList) < 3:
                for item in keyList:
                    if (word in item) or (item in word):
                        tempList.append(item)
                        break

            else:
                break

        if sorted(keyList) == sorted(tempList):
            print("\nCevap:")
            print(sentence)
            tts = gTTS(text=sentence, lang='tr')
            tts.save("answer.mp3")
            os.system("answer.mp3")
            break
        else:
            tempList.clear()


def main():

    takeQuestion()
    analyzeQuestion()
    analyzeAnswer()

if __name__ == '__main__':
    main()