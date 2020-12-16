# Projeto Redes Neurais - Arquitetura de Computadores

**Alunos:** Erika Marcia e Italo Lelis

**Professor:** Luis Fabricio W. Goes

:link: Link do vídeo: [https://www.youtube.com/watch?v=HXRTaTP4UTI](https://www.youtube.com/watch?v=HXRTaTP4UTI)

## Sobre o projeto

O perceptron implementado tem como objetivo receber a nota (0-10) de duas provas aplicadas
durante um semestre (uma com peso correto 60 e a outra com peso correto 40). A partir dessas notas,
uma função de ativação irá retornar 0 se o aluno for reprovado e 1 se o aluno for aprovado.
Além disso, caso tenha sido aplicada alguma pontuacao extra, essa será
acresentada no viés do perceptron.

Para isso, o perceptron receberá duas entradas e retornará o somatório, considerando-se os pesos calculados em uma etapa de treinamento.
Esse somatório irá para uma função de ativação que analisa se o valor resultate é maior do que 60.

Os pesos das entradas são calculados em uma etapa de treinamento que utiliza **5 épocas**.
