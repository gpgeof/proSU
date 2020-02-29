# Processamento Sísmico no Seismic Unix (SU)
>Fluxo de processamento sísmico no SU, scripts e relatório de processamento

[Programas e relatório desenvolvidos originalmente por Murilo Santiago](https://github.com/sanmurilo)

![Campo de velocidades suavizado](https://github.com/Dirack/ProcessamentoSismicoSU/blob/master/relatorio_original/figuras/cap2/campovel_suavizado.png)

Este repositório é uma biblioteca de scripts para o pacote de processamento sísmico Seismic Unix (SU) em 
linguagem Shell Script. Funciona como uma interface de linha de comandos para a utilização dos programas do pacote
 de processamento, chamados dentro dos scripts.

Este repositório possui, além da documentação, um [relatório](https://github.com/Dirack/proSU/blob/master/relatorio_original/relatorio_PS.pdf) detalhando as etapas do processamento sísmico desenvolvidas nos scripts, serrvindo de referência teórica. Ambos, scripts e relatório, podem ser utilizados como guias para um minicurso de introdução ao processamento sísmico.

[Para mais informações visite o nosso wiki!](https://github.com/Dirack/ProcessamentoSismicoSU/wiki)

## Instalação

Para instalar a proSU basta fornecer permissão de execução aos scripts com _chmod_, assim:

```shell
~$ chmod u+x script.sh
```

E você poderá chamar os scripts como qualquer outro Shell Script, fornecendo o caminho para o script ao
terminal do bash. Exemplo, executando um script do shell em um diretório qualquer:

```śhell
~$ /diretorio/script.sh # Se o script estiver na pasta diretório
~$ ./script # Se o script estiver na pasta atual em que foi aberto o terminal do bash
```

Você também pode chamar os scripts da proSU como se fosse um comando nativo do _bash_. Basta adicionar os scripts
a um diretório listado na sua variável de ambiente $PATH ou adicionar a seguinte linha ao final do seu arquivo _.bashrc_:

```shell
PATH="$PATH:/caminhoParaPastaProSU/proSU"
```

## Dependências: 

Depende do pacote de processamento sísmico [Seismic Unix](https://github.com/Dirack/SeisUnix) instalado.

## Instalação das dependências

A instalação do pacote SU pode ser feita seguindo os passos deste tutorial no [Youtube](https://www.youtube.com/watch?v=DzGCBesq8Ng).

Também pode ser feita a partir deste [script de instalação do SU](https://github.com/Dirack/Shellinclude/issues/26#issuecomment-592551654)

## Histórico de lançamentos

* [v1.0](https://github.com/Dirack/ProcessamentoSismicoSU/issues?q=is%3Aopen+is%3Aissue+milestone%3A%22proSU+v1.0-beta.1%22) (Beta)
    * Versão Beta em desenvolvimento

[Visualize o histórico de modificações detalhado](https://github.com/Dirack/ProcessamentoSismicoSU/wiki/Hist%C3%B3rico-de-vers%C3%B5es)

## Sobre

Murilo Santiago - [@sanmurilo](https://github.com/sanmurilo) - murilovj@gmail.com

Rodolfo Dirack – [@dirack](https://github.com/Dirack) – rodolfo_profissional@hotmail.com

Distribuído sob a licença GPL3. Veja `LICENSE` para mais informações.

[main page](https://github.com/Dirack/ProcessamentoSismicoSU)

## Contribuição

1. Faça o _fork_ do projeto (<https://github.com/Dirack/ProcessamentoSismicoSU/fork>)
2. Crie uma _branch_ para sua modificação (`git checkout -b feature/suaFeature`)
3. Faça o _commit_ (`git commit -am 'Add some fooBar'`)
4. _Push_ (`git push origin feature/fooBar`)
5. Crie um novo _Pull Request_

#### Importante: O histórico de suas modificações deve ser claro, com mensagens de commit de um a dois parágrafos descrevendo cada modificação. _Pull Requests_ com histórico de commits insuficiente serão rejeitados.
