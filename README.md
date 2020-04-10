# Processamento Sísmico no Seismic Unix (proSU)
>Fluxo de processamento sísmico no SU, scripts e relatório de processamento

 [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![Build Status](https://travis-ci.org/Dirack/proSU.svg?branch=master)](https://travis-ci.org/Dirack/proSU)

<img src="https://user-images.githubusercontent.com/30205197/78612633-31627e80-7840-11ea-8813-785ef1ed92bf.jpg" width="450">

Este repositório é uma biblioteca de scripts para o pacote de processamento sísmico Seismic Unix (SU) em 
linguagem Shell Script. Funciona como uma interface de linha de comandos para a utilização dos programas do pacote
de processamento, chamados dentro dos scripts.
Este repositório possui, além da documentação, testes e exemplos de uso
detalhando as etapas do processamento sísmico desenvolvidas nos scripts e referência teórica.

[Para mais informações visite o nosso wiki!](https://github.com/Dirack/proSU/wiki)

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

Também pode ser feita a partir do script de [script de instalação do SU (suinstall)](https://github.com/Dirack/Shellinclude/releases/tag/v1.2.2-beta.1) disponível na bilbioteca Shellinclude

## Histórico de lançamentos

* [v1.0](https://github.com/Dirack/proSU/issues?q=is%3Aopen+is%3Aissue+milestone%3A%22proSU+v1.0-beta.1%22) (Beta)
    * Versão Beta em desenvolvimento

[Visualize o histórico de modificações detalhado](https://github.com/Dirack/proSU/wiki/Hist%C3%B3rico-de-vers%C3%B5es)

## Sobre

Murilo Santiago - [@sanmurilo](https://github.com/sanmurilo) - murilovj@gmail.com

Rodolfo Dirack – [@dirack](https://github.com/Dirack) – rodolfo_profissional@hotmail.com

Distribuído sob a licença GPL3. Veja `LICENSE` para mais informações.

[main page](https://github.com/Dirack/proSU)

## Contribuição

1. Faça o _fork_ do projeto (<https://github.com/Dirack/proSU/fork>)
2. Crie uma _branch_ para sua modificação (`git checkout -b feature/suaFeature`)
3. Faça o _commit_ (`git commit -am 'Add some fooBar'`)
4. _Push_ (`git push origin feature/fooBar`)
5. Crie um novo _Pull Request_

[Para uma explicação detalhada, visite a página Contribua do nosso wiki](https://github.com/Dirack/proSU/wiki/Contribua)

#### Importante: O histórico de suas modificações deve ser claro, com mensagens de commit de um a dois parágrafos descrevendo cada modificação. _Pull Requests_ com histórico de commits insuficiente serão rejeitados.
