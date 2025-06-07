# Chat de Perguntas e Respostas com Gemini e Flutter

Este é um aplicativo web simples de chat de perguntas e respostas construído com Flutter e Dart, utilizando a API Gemini do Google para fornecer respostas inteligentes.

## Visão Geral

O aplicativo oferece uma interface de chat onde os usuários podem digitar suas perguntas e receber respostas geradas pelo modelo de linguagem Gemini. A interface é responsiva e projetada para ser intuitiva.

## Funcionalidades

* **Interface de Chat:** Uma tela de chat clara e centralizada para interação.
* **Envio de Perguntas:** Campo de texto para o usuário digitar e enviar suas perguntas.
* **Recebimento de Respostas:** Exibição das respostas geradas pela API Gemini na tela do chat.
* **Indicação de Carregamento:** Um indicador visual mostra quando a aplicação está aguardando uma resposta da API.
* **Tratamento de Erros:** Mensagens de erro informativas são exibidas caso ocorram problemas na comunicação com a API.
* **Design Inspirado no Google/Gemini:** Utilização de cores e elementos visuais que remetem à identidade do Google e do Gemini.

## Tecnologias Utilizadas

* **Flutter:** Framework de UI do Google para construir aplicativos nativamente compilados para web, mobile e desktop a partir de uma única base de código.
* **Dart:** A linguagem de programação usada pelo Flutter.
* **`http` package:** Pacote Flutter para fazer requisições HTTP à API Gemini.

## Pré-requisitos

* **Flutter SDK:** Certifique-se de ter o Flutter SDK instalado e configurado em sua máquina. Você pode seguir as instruções de instalação no [site oficial do Flutter](https://flutter.dev/docs/get-started/install).
* **Chave de API da Google AI (Gemini):** Você precisará obter uma chave de API válida para acessar a API Gemini.

## Configuração

1.  **Obtenha uma Chave de API:**
    * Acesse a plataforma da Google AI e siga as instruções para criar um projeto e obter uma chave de API para a API Gemini.

2.  **Configure a Chave de API no Código:**
    * No arquivo `chat_screen.dart`, localize a linha que define a constante `geminiApiKey`:
        ```dart
        const String geminiApiKey = 'SUA_CHAVE_DE_API';
        ```
    * Substitua `'SUA_CHAVE_DE_API'` pela sua chave de API real. **Importante:** Em um ambiente de produção, considere usar variáveis de ambiente ou um método mais seguro para gerenciar sua chave de API.

3.  **Execute o Aplicativo:**
    * Abra o terminal na raiz do seu projeto Flutter.
    * Execute o comando: `flutter run -d chrome` (para executar no navegador Chrome) ou outro dispositivo/emulador de sua preferência.

## Estrutura de Arquivos

gemini_chat_app/
├── lib/
│   ├── chat_screen.dart
│   └── main.dart
├── web/
├── .gitignore
├── pubspec.yaml
└── README.md             # Documentação do projeto

## Prompt de Exemplo

Você é um dos melhores palestrantes do mundo. Você cria apresentações envolventes e atraentes para palestras e webinars. Seu trabalho é me ajudar a criar uma apresentação para um evento.
Tópico: IA Generativa
Subtópicos: O que é IA Generativa, Blocos de Construção da IA ​​Generativa, Limitações da IA ​​Generativa, Ameaças da IA ​​Generativa.
Prepare uma apresentação para uma palestra sobre o tema.
Certifique-se de seguir as regras abaixo para gerar slides:
 o primeiro slide deve ser a pauta
 o número total de slides não deve exceder 5
 se houver subtópicos, use-os para enquadrar a pauta
Responda no seguinte formato:
Para cada slide:
Número:
Título:
Conteúdo:
Ideias de Imagem:
Roteiro para a palestra:
