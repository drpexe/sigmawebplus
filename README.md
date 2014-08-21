SigmaWeb+
============
App para Android que monitora o sistema acadêmico de diversas universidades e avisa o usuário quando novos resultados de avaliações estão disponíveis.

Features
--------------
* **Fácil de utilizar:** Os menus são simples e intuitivos
* **Multi-plataforma:** Funciona em Android, Windows e Linux
* **Seguro:** Utiliza criptografia de chave pública para dados sensíveis
* **Baixo trafego de dados:** Utiliza um servidor intermediário para otimizar o trafego de dados na rede (muito importante em conexões 3g)
* **Customizável:** Desenvolvido em python e publicado com o código aberto

Instalação (somente Linux)
-------------
Este são os passos necessários para rodar o aplicativo no Linux ou criar um APK para Android e instalar no celular.

###1. Download e instalacão do Android SDK e NDK
Primeiramente é necessário fazer o download e instalar o [Android SDK](http://developer.android.com/sdk/index.html) e [Android NDK](http://developer.android.com/tools/sdk/ndk/index.html)

Após a instalação do SDK, você precisa realizar o download da **API 8**. Isso pode ser feito seguindo [essas instruções](https://developer.android.com/sdk/installing/adding-packages.html). Caso tenha dúvida de qual dos itens é a API 8, veja esse [outro tutorial](https://stackoverflow.com/questions/8241571/how-to-get-android-google-api-for-2-2-version).

###2. Download do código fonte do SigmaWeb+
Copie o código fonte do SigmaWeb+ para o seu computador
```
$ git clone https://github.com/drpexe/sigmawebplus.git sigmaweb
$ cd sigmaweb
```

###3. Configurações do Make
Configure o arquivo android-sdk.sh dentro da pasta com o código fonte do SigmaWeb+ para apontar para os locais de instalação do Android SDK e NDK
```
export ANDROIDSDK=CAMINHO-DO-SDK
export ANDROIDNDK=CAMINHO-DO-NDK
export ANDROIDAPI=8
export ANDROIDNDKVER=VERSAO-DO-NDK
export PATH=$ANDROIDNDK:$ANDROIDSDK/platform-tools:$ANDROIDSDK/tools:$PATH
```
Onde os valores a serem preenchidos sao:
* **CAMINHO-DO-SDK:** Caminho (absoluto) até a pasta "sdk" do Android SDK
* **CAMINHO-DO-SDK:** Caminho (absoluto) até a pasta raiz do Android NDK
* **VERSAO-DO-NDK:** Versao do NDK utilizado (você pode conferi-la no nome do arquivo que baixou. Exemplo: r9)

###4. Instalação das dependências
Escolha um dos comandos abaixo dependendo da distro que você estiver utilizando.

####4.1. Sistema 32bit
```
$ make install-deps-x86
```

####4.2. Sistema 64bit
Alem das dependências normais, instala também as [dependências 64bit do python-for-android](http://python-for-android.readthedocs.org/en/latest/prerequisites/)
```
$ make install-deps
```

###5. 'Compilando' os arquivos para Android
O comando abaixo vai compilar uma *dist* do python-for-android com as configurações setadas no Makefile. Sempre que alterar alguma configuração do Makefile, é necessario rodar esse comando novamente
```
$ make install
```

###6. Iniciando o aplicativo
Você pode rodar o applicativo no proprio Linux ou compilar um APK e instalar no celular pelo USB

####1. No Linux
```
$ make
```

####2. No Android (debug)
Este comando vai criar o APK com um chave padrão e instalar no celular que estiver conectado na porta USB
```
$ make build
```

####3. No Android (release)
Este comando vai criar o APK e assinar com a chave especificada no arquivo Makefile. O APK será criado na pasta 'release', mas não será instalado automaticamente no celular.
```
$ make build-release
```
Você pode alterar o local da chave privada modificando o valor da variavel **APK_KEYSTORE** no Makefile

Dependências
-----------
* [Android SDK](http://developer.android.com/sdk/index.html) [(Licença)](http://creativecommons.org/licenses/by/2.5/)
* [Android NDK](http://developer.android.com/tools/sdk/ndk/index.html) [(Licença)](http://creativecommons.org/licenses/by/2.5/)
* [kivy](https://github.com/kivy/kivy) [(Licença)](https://github.com/kivy/kivy/blob/master/LICENSE)
* [python-for-android](https://github.com/kivy/python-for-android) [(Licença)](https://github.com/kivy/python-for-android/blob/master/LICENSE) (utiliza um [fork](https://github.com/drpexe/sigmawebplus-py4a))

Licença
-----------
[MIT License](https://github.com/drpexe/sigmawebplus/blob/master/LICENSE.md)
