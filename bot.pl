#!/usr/bin/perl
#
# [!] NECESSÁRIO RODAR COMO ROOT [!]
#        sudo perl bot.pl
#
# USE, EDITE, COMPILE. MAS SEMPRE DISTRIBUA O CÓDIGO FONTE!
# CONHECIMENTO DEVE SER LIVRE E DE TODOS!
#
# CODED BY: HackerOrientado
#
# Me sigam no twitter -> @HackerOrientado
# Facebook -> facebook.com/CalsEvolution
# Página Ciência Hacker -> facebook.com/CienciaHacker
# Grupo Ciência Hacker -> facebook.com/groups/cienciahacker/
# 
# Obrigado ao @7mm5l pelo força e com o conhecimento que me deu usando regex, tanto nesse quanto no BypassCF
# Link do BypassCF -> github.com/HackerOrientado/BypassCF
#
# GPG Pública: 2465B5D3
#

############################ MÓDULOS 
use warnings;
use strict;
use Net::Twitter;
use Time::localtime;
use Scalar::Util 'blessed';
use utf8;
use WWW::Mechanize;

############################ CODIFICAÇÃO utf8 NA ENTRADA E SAÍDA DO SCRIPT
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

############################ CRIAÇÃO DE VARIÁVEIS
my ( $baner, $SO, $limpar_tela, $tuitar );
my ( $mech, $url_tempo, $url_bitcoin, $celcius, $C, $bitcoin );
$url_tempo = "http://www.previsaodotempo.org/api.php?city=Rio+de+Janeiro";
$url_bitcoin = "https://www.mercadobitcoin.net/api/ticker/";
$mech = WWW::Mechanize->new();

$baner = "
      :::::::::  ::::::::::::::::::   ::::::::: ::::::::: :::::::::::::::::::::::::    :::::::::::::::::    :::::::::  :::::::: 
     :+:    :+::+:    :+:   :+:      :+:    :+::+:    :+:    :+:    :+:       :+:+:   :+:    :+:  :+: :+:  :+:    :+::+:    :+: 
    +:+    +:++:+    +:+   +:+      +:+    +:++:+    +:+    +:+    +:+       :+:+:+  +:+    +:+ +:+   +:+ +:+    +:++:+    +:+  
   +#++:++#+ +#+    +:+   +#+      +#+    +:++#++:++#:     +#+    +#++:++#  +#+ +:+ +#+    +#++#++:++#++:+#+    +:++#+    +:+   
  +#+    +#++#+    +#+   +#+      +#+    +#++#+    +#+    +#+    +#+       +#+  +#+#+#    +#++#+     +#++#+    +#++#+    +#+    
 #+#    #+##+#    #+#   #+#      #+#    #+##+#    #+#    #+#    #+#       #+#   #+#+#    #+##+#     #+##+#    #+##+#    #+#     
#########  ########    ###       ######## ###    ###########################    ####    ######     ############  ########       

															0.9b\n\n";

############################ VERIFICAÇÃO DO SISTEMA OPERACIONAL PARA LIMPEZA DE TELA
$SO = $^O;
if ( $SO eq "MSWin32" ) {
	system "cls";
	print "Desculpe mas rode este bot somente no Linux\n";
	print "Recomendo Linux Debian/Ubuntu\n\n";
	exit (0);
} else {
	$limpar_tela = "clear";
}

system ("$limpar_tela");

############################ MINHAS KEYS DE DESENVOLVEDOR :D
my $consumer_key = 'ENTRE COM SUA CHAVE DE DESENVOLVEDOR AQUI';
my $consumer_secret = 'ENTRE COM SUA CHAVE DE DESENVOLVEDOR AQUI';
my $access_token = 'ENTRE COM SUA CHAVE DE DESENVOLVEDOR AQUI';
my $access_token_secret = 'ENTRE COM SUA CHAVE DE DESENVOLVEDOR AQUI';

############################ INICIANDO AUTENTICAÇÃO COM O Net::Twitter
my $nt = Net::Twitter->new (
	traits              => ['API::RESTv1_1', 'OAuth'],
	consumer_key        => $consumer_key,
	consumer_secret     => $consumer_secret,
	access_token        => $access_token,
	access_token_secret => $access_token_secret,
);

############################ DECLARA A SUB ROTINA DO BOT
sub bot () {
	init_bot:
	my $hora = localtime->hour(); # PEGA A HORA LOCAL DO SEU COMPUTADOR

	print "São $hora hora(s)\n\n";

	$mech->get ( $url_tempo ); # ENTRA NA URL QUE FOI COLOCA NA VARIÁVEL ACIMA
	my $celsius = $mech->content(format => 'text'); # PEGA TUDO QUE FOR TEXTO 

	if ( $celsius =~ /("temperature":"\d*")/ ) { # FILTRO PARA RETIRAR APENAS O NÚMERO DA TEMPERATURA DA API E CONVERSÃO PARA CELSIUS
		$celsius = $1;
		$celsius =~ s/[^0-9]//g;
		$C = ($celsius-32) / 1.8000;
		$C = sprintf ( "%.1f", $C ); # DELIMITANDO MOSTRAR APENAS UMA CASA DECIMAL APÓS A VÍRGULA ( como em C )
	}

	$mech->get ( $url_bitcoin );
	my $ticker = $mech->content(format => 'text');
	if ( $ticker =~ /("buy":\d*)/ ) {
		$ticker = $1;
		$ticker =~ s/[^0-9]//g;
	}

	if ( $hora == 7 ) { # CASO A HORA SEJA 07:00 ELE FAZ TAL AÇÃO
		eval { $nt -> update ({ status => "Bom dia, seus lindos. A temperatura hoje é de $C°C. O preço da BitCoin é de R\$ $ticker - #bicoin #hoje #perl #clima #tempo" }) };
		
		if ( $@ ) {
			print "[\!] AVISO [\!] => $@\n\n"; # CASO OCORRA ALGUM ERRO NO eval ELE RETORNA O ERRO E O MOSTRA NA TELA
		}

	} elsif ( $hora == 14 ) { # CASO A HORA SEJA 14:00 ELE FAZ TAL AÇÃO
		eval { $nt -> update ({ status => "Boa tarde, seus lindos. A temperatura de agora é de $C°C. O preço da BitCoin é de  R\$ $ticker - #bicoin #hoje #perl #clima #tempo" }) };

		if ( $@ ) {
			print "[\!] AVISO [\!] => $@\n\n"; # CASO OCORRA ALGUM ERRO NO eval ELE RETORNA O ERRO E O MOSTRA NA TELA
		}
	} elsif ( $hora == 21 ) { # CASO A HORA SEJA 21:00 ELE FAZ TAL AÇÃO
		eval { $nt -> update ({ status => "Boa noite, seus lindos. A temperatura de agora é de $C°C. O preço da BitCoin é de R\$  $ticker - #bicoin #hoje #perl #clima #tempo" }) };

		if ( $@ ) {
			print "[\!] AVISO [\!] => $@\n\n"; # CASO OCORRA ALGUM ERRO NO eval ELE RETORNA O ERRO E O MOSTRA NA TELA
		}
	}


	my $espera = int rand 3601; # ESPERA EM SEGUNDOS PARA POSTAR A PUBLICAÇÃO ( de 0 á 3600 segundo = 1 hora )
    
	print "publicação aleatória daqui a $espera segundo(s)\n";
	sleep $espera;

 
	my $rand;
       	$rand = int rand 42; # GERA UM NÚMERO ALEATÓRIO DE 0 A 43 QUE SERÁ O NÚMERO DE FRASES NO BANCO DE DADOS
	print "\n";
       	print "Índice $rand do banco de dados\n";
    
       	open FILE, "<dados.txt" or die $!; # ABRE O ARQUIVO dados.txt PARA PEGAR TUDO DO E GUARDA NA VARIÁVEL
       	my $dados = <FILE>; # VARIÁVEL PARA ARMAZENAR O CONTEÚDO DO dados.txt
       	close FILE;
    
	if ( $dados =~ /($rand\.\w*\.|$rand\.\w* \w*\.|$rand\.\w* \w* \w*\.|$rand\.\w* \w* \w* \w*\.|$rand\.\w* \w* \w* \w* \w*\.|$rand\.\w* \w* \w* \w* \w* \w*\.|$rand\.\w* \w* \w* \w* \w* \w* \w*\.|$rand\.\w* \w* \w* \w* \w* \w* \w* \w*\.|$rand\.\w* \w* \w* \w* \w* \w* \w* \w* \w*\.|$rand\.\w* \w* \w* \w* \w* \w* \w* \w* \w* \w*\. )/ ) { # REGEX PARA PEGAR O TEXTO COM O NÚMERO GERADO ALEATÓRIAMENTE
		
            	$tuitar = $1; # GUARDA O CONTEÚDO DA REGEX NA VARIÁVEL
		$tuitar =~ s/(\d*\.)//g;
            	print "Aqui esta -> $tuitar \n";
	}
	
        eval { $nt -> update ({ status => "$tuitar\." }) };
	if ( $@ ) {
		warn "Falha ao realizar o Update: $@\n\n";
        }
	
	print "\n";
	system ("echo 3 > /proc/sys/vm/drop_caches"); # NECESSÁRIO PERMISSÃO DO ROOT PARA LIMPAR A MEMÓRIA CACHE
	system ("sysctl -w vm.drop_caches=3"); # NECESSÁRIO PERMISSÃO DO ROOT PARA LIMPAR A MEMÓRIA CACHE
	print "Memória limpa\n";
	print "--------------------------------------------";

	print "\n\n\n";
	
	goto init_bot; # RETORNA PARA O INÍCIO DO BOT, FAZENDO UM LOOP INFINITO

}

print $baner; # PRINTA O BANER NA TELA E MOSTRA A LICENÇA
print "\n\n\t\t\t\t\t\t\t\t[\!] ATENÇÃO [\!]\n\n";
print "Este script contém direitos autorais e está sob a licença Artistic License 2.0 .\n";
print "Está licença proíbe o uso de marcas registradas ( nomes, logos ou marcas de contribuidores ) e assegura o desenvolvedor/licença de não se responsabilizar por perdas e danos.\n";
print "Está licença exige que você avise sobre direitos autorais, indique mudanças significativas no código e distribua o código fonte junto com o software\n";
print "Está licença também permite que o software possa ter fins comerciais, que possa ser modificado, que você possa distribuir o código fonte, possa incluir sublicenças para modificar e distribuir software de terceiros que não estejam incluídos na licença e que você possa modificar o software sem precisar distribui-lo.\n";
print "Para saber mais entrem em: http://escolhaumalicenca.com.br/licencas/\n\n\n\n";
return bot(); # RETORNA A SUB ROTINA DO BOT

# EoF
