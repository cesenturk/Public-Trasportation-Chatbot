:- include('C:/Users/asus/Desktop/4. Sýnýf/Lisans Tezi/TurkishMorphophonologicalAnalyzer/Morphophonologic Analyzer for Nouns/weak_vowel_harmonizer.pl').

initial(q0).
final(q1).
final(q2).
final(q3).
final(q4a).
final(q4b).

t(q0, noun, q1).
t(q1, plur, q2).
t(q1, poss, q3).
t(q1, plur, q2).
t(q1, loc, q4a).
t(q1, gen, q4a).
t(q1, acc, q4b).
t(q1, dat, q4b).
t(q1, abl, q4b).
t(q4a, rel, q1).
t(q2, poss, q3).
t(q2, loc, q4a).
t(q2, gen, q4a).
t(q2, acc, q4b).
t(q2, dat, q4b).
t(q2, abl, q4b).
t(q3, loc, q4a).
t(q3, gen, q4a).
t(q3, acc, q4b).
t(q3, dat, q4b).

allomorph(germencik,noun).
allomorph(kuyucak,noun).
allomorph(kuyucað,noun).
allomorph(sultanhisar,noun).
allomorph(karpuzlu,noun).
allomorph(kusadasi,noun).
allomorph(adu,noun).
allomorph(incirliova,noun).
allomorph(soke,noun).
allomorph(cine,noun).
allomorph(tavþan,noun).
allomorph(okul,noun).
allomorph(park,noun).
allomorph(aðaç,noun).
allomorph(aðac,noun).
allomorph(kask,noun).
allomorph(köþk,noun).
allomorph(kayýp,noun).
allomorph(kayb,noun).

allomorph(ler,plur).
allomorph(lar,plur).

allomorph(i,poss).
allomorph(im,poss).
allomorph(in,poss).
allomorph(imiz,poss).
allomorph(iniz,poss).
allomorph(ý,poss).
allomorph(ým,poss).
allomorph(ýn,poss).
allomorph(ýmýz,poss).
allomorph(ýnýz,poss).
allomorph(u,poss).
allomorph(um,poss).
allomorph(un,poss).
allomorph(umuz,poss).
allomorph(unuz,poss).
allomorph(ü,poss).
allomorph(üm,poss).
allomorph(ün,poss).
allomorph(ümüz,poss).
allomorph(ünüz,poss).

allomorph(i,acc).
allomorph(ý,acc).
allomorph(u,acc).
allomorph(ü,acc).

allomorph(den,abl).
allomorph(dan,abl).
allomorph(ten,abl).
allomorph(tan,abl).

allomorph(e,dat).
allomorph(a,dat).

allomorph(de,loc).
allomorph(da,loc).
allomorph(te,loc).
allomorph(ta,loc).
allomorph(nde,loc).
allomorph(nda,loc).

allomorph(in,gen).
allomorph(ýn,gen).
allomorph(un,gen).
allomorph(ün,gen).

allomorph(ki,rel).

analyze(String, Morphemes):-
   initial(State),
   analyze(String, State, Morphemes, []).
   
analyze('', State, [], _):- final(State).

analyze(String, CurrentState, [Prefix|Morphemes], Ex_Allomorph):-
   concat(Prefix, Suffix, String),
   allomorph(Prefix, Allomorph),
   t(CurrentState, Allomorph, NextState),
   append(Ex_Allomorph, [Prefix], Morpheme),
   harmonize(Morpheme),
   analyze(Suffix, NextState, Morphemes, [Prefix]).

harmonize([_]).

harmonize([Allomorph1, Allomorph2]):-
   string_to_list(Allomorph1, LCodes),
   string_to_list(Allomorph2, RCodes),
   vowel_vowel_harmony(LCodes, RCodes),
   consonant_consonant_harmony(LCodes, RCodes),
   vowel_consonant_harmony(LCodes, RCodes),
   consonant_vowel_harmony(LCodes, RCodes).

vowel_vowel_harmony(LCodes, [RCode1, RCode2|_]):-
   reverse(LCodes, [LCode1, LCode2|_]),
   char_code(LChar1, LCode1),
   char_code(LChar2, LCode2),
   char_code(RChar1, RCode1),
   char_code(RChar2, RCode2),
   vowel(LChar1),
   consonant(LChar2),
   consonant(RChar1),
   vowel(RChar2),
   (vowel(LChar1), (RChar1 = k, RChar2 = i)
   ).

vowel_vowel_harmony(LCodes, [RCode1, RCode2|_]):-
   reverse(LCodes, [LCode1|_]),
   char_code(LChar1, LCode1),
   char_code(RChar1, RCode1),
   char_code(RChar2, RCode2),
   vowel(LChar1),
   consonant(RChar1),
   vowel(RChar2),
  (((LChar1 = a; LChar1 = ý), (RChar2 = a; RChar2 = ý));
   ((LChar1 = o; LChar1 = u), (RChar2 = a; RChar2 = u));
   ((LChar1 = e; LChar1 = i), (RChar2 = e; RChar2 = i));
   ((LChar1 = ö; LChar1 = ü), (RChar2 = e; RChar2 = ü))
   ).

vowel_vowel_harmony(LCodes, [RCode1, RCode2|_]):-
   reverse(LCodes, [LCode1, LCode2|_]),
   char_code(LChar1, LCode1),
   char_code(LChar2, LCode2),
   char_code(RChar1, RCode1),
   char_code(RChar2, RCode2),
   consonant(LChar1),
   vowel(LChar2),
   consonant(RChar1),
   vowel(RChar2),
  (((LChar2 = a; LChar2 = ý), (RChar2 = a; RChar2 = ý));
   ((LChar2 = o; LChar2 = u), (RChar2 = a; RChar2 = u));
   ((LChar2 = e; LChar2 = i), (RChar2 = e; RChar2 = i));
   ((LChar2 = ö; LChar2 = ü), (RChar2 = e; RChar2 = ü))
   ).

vowel_vowel_harmony(LCodes, [RCode1|_]):-
   reverse(LCodes, [LCode1, LCode2, LCode3|_]),
   char_code(LChar1, LCode1),
   char_code(LChar2, LCode2),
   char_code(RChar1, RCode1),
   char_code(LChar3, LCode3),
   consonant(LChar1),
   consonant(LChar2),
   vowel(LChar3),
   vowel(RChar1),
  (((LChar3 = a; LChar3 = ý), (RChar1 = a; RChar1 = ý));
   ((LChar3 = o; LChar3 = u), (RChar1 = a; RChar1 = u));
   ((LChar3 = e; LChar3 = i), (RChar1 = e; RChar1 = i));
   ((LChar3 = ö; LChar3 = ü), (RChar1 = e; RChar1 = ü))
   ).

vowel_vowel_harmony(LCodes, [RCode1, RCode2|_]):-
   reverse(LCodes, [LCode1, LCode2, LCode3|_]),
   char_code(LChar1, LCode1),
   char_code(LChar2, LCode2),
   char_code(LChar3, LCode3),
   char_code(RChar1, RCode1),
   char_code(RChar2, RCode2),
   consonant(LChar1),
   consonant(LChar2),
   vowel(LChar3),
   consonant(RChar1),
   vowel(RChar2),
  (((LChar3 = a; LChar3 = ý), (RChar2 = a; RChar2 = ý));
   ((LChar3 = o; LChar3 = u), (RChar2 = a; RChar2 = u));
   ((LChar3 = e; LChar3 = i), (RChar2 = e; RChar2 = i));
   ((LChar3 = ö; LChar3 = ü), (RChar2 = e; RChar2 = ü))
   ).

vowel_vowel_harmony(LCodes, [RCode1, RCode2|_]):-
   reverse(LCodes, [LCode1, LCode2, LCode3|_]),
   char_code(LChar1, LCode1),
   char_code(LChar2, LCode2),
   char_code(LChar3, LCode3),
   char_code(RChar1, RCode1),
   char_code(RChar2, RCode2),
   consonant(LChar1),
   consonant(LChar2),
   vowel(LChar3),
   vowel(RChar1),
   consonant(RChar2),
  (((LChar3 = a; LChar3 = ý), (RChar1 = a; RChar1 = ý));
   ((LChar3 = o; LChar3 = u), (RChar1 = a; RChar1 = u));
   ((LChar3 = e; LChar3 = i), (RChar1 = e; RChar1 = i));
   ((LChar3 = ö; LChar3 = ü), (RChar1 = e; RChar1 = ü))
   ).

vowel_vowel_harmony(LCodes, [RCode1|_]):-
   reverse(LCodes, [LCode1, LCode2|_]),
   char_code(LChar1, LCode1),
   char_code(LChar2, LCode2),
   char_code(RChar1, RCode1),
   consonant(LChar1),
   vowel(LChar2),
   vowel(RChar1),
  (((LChar2 = a; LChar2 = ý), (RChar1 = a; RChar1 = ý));
   ((LChar2 = o; LChar2 = u), (RChar1 = a; RChar1 = u));
   ((LChar2 = e; LChar2 = i), (RChar1 = e; RChar1 = i));
   ((LChar2 = ö; LChar2 = ü), (RChar1 = e; RChar1 = ü))
   ).

consonant_consonant_harmony(LCodes, [RCode1|_]):-
   reverse(LCodes, [LCode1|_]),
   char_code(LChar1, LCode1),
   char_code(RChar1, RCode1),
   ((not(consonant(LChar1)),!); not(consonant(RChar1))).

consonant_consonant_harmony(LCodes, [RCode1|_]):-
   reverse(LCodes, [LCode1|_]),
   char_code(LChar1, LCode1),
   char_code(RChar1, RCode1),
   consonant(LChar1),
   consonant(RChar1),
  ((consonant_type1(LChar1), consonant_type1(RChar1));
   (consonant_type1(LChar1), consonant_type2(RChar1));
   (consonant_type2(LChar1), consonant_type3(RChar1));
   (consonant_type2(LChar1), consonant_type2(RChar1));
   (consonant_type3(LChar1), consonant_type2(RChar1));
   (consonant_type3(LChar1), consonant_type3(RChar1))
   ).
   
consonant_consonant_harmony(LCodes, [RCode1, RCode2|_]):-
   reverse(LCodes, [LCode1, LCode2, LCode3|_]),
   char_code(LChar1, LCode1),
   char_code(LChar2, LCode2),
   char_code(LChar3, LCode3),
   char_code(RChar1, RCode1),
   char_code(RChar2, RCode2),
   consonant(LChar1),
   consonant(LChar2),
   vowel(LChar3),
   consonant(RChar1),
   vowel(RChar2),
  ((tenuis_type(LChar1), continuant_type(LChar2), (RChar1 = t; RChar1 = l))
  ).

vowel_consonant_harmony(LCodes, [RCode1|_]):-
   reverse(LCodes, [LCode1|_]),
   char_code(LChar1, LCode1),
   char_code(RChar1, RCode1),
   ((not(vowel(LChar1)),!); not(consonant(RChar1))).

vowel_consonant_harmony(LCodes, [RCode1|_]):-
   reverse(LCodes, [LCode1|_]),
   char_code(LChar1, LCode1),
   char_code(RChar1, RCode1),
   vowel(LChar1),
   consonant(RChar1),
   not(RChar1 = t).

consonant_vowel_harmony(LCodes, [RCode1|_]):-
   reverse(LCodes, [LCode1|_]),
   char_code(LChar1, LCode1),
   char_code(RChar1, RCode1),
   ((not(consonant(LChar1)),!); not(vowel(RChar1))).

consonant_vowel_harmony(LCodes, [RCode1|_]):-
   reverse(LCodes, [LCode1|_]),
   char_code(LChar1, LCode1),
   char_code(RChar1, RCode1),
   consonant(LChar1),
   vowel(RChar1),
   not(LChar1 = p),
   not(LChar1 = ç),
   not(LChar1 = t),
   not(LChar1 = k).
   
consonant_vowel_harmony(LCodes, [RCode1|_]):-
   reverse(LCodes, [LCode1, LCode2|_]),
   char_code(LChar1, LCode1),
   char_code(LChar2, LCode2),
   char_code(RChar1, RCode1),
   consonant(LChar1),
   consonant(LChar2),
   vowel(RChar1),
  (tenuis_type(LChar1), continuant_type(LChar2), vowel(RChar1)
   ).

consonant_type1(ç).
consonant_type1(f).
consonant_type1(h).
consonant_type1(k).
consonant_type1(p).
consonant_type1(s).
consonant_type1(þ).
consonant_type1(t).

consonant_type2(l).
consonant_type2(m).
consonant_type2(n).
consonant_type2(r).
consonant_type2(y).

consonant_type3(b).
consonant_type3(c).
consonant_type3(d).
consonant_type3(g).
consonant_type3(ð).
consonant_type3(j).
consonant_type3(v).
consonant_type3(z).

tenuis_type(b).
tenuis_type(c).
tenuis_type(ç).
tenuis_type(d).
tenuis_type(g).
tenuis_type(k).
tenuis_type(p).
tenuis_type(t).

continuant_type(f).
continuant_type(ð).
continuant_type(h).
continuant_type(j).
continuant_type(l).
continuant_type(m).
continuant_type(n).
continuant_type(r).
continuant_type(s).
continuant_type(þ).
continuant_type(v).
continuant_type(y).
continuant_type(z).