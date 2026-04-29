mdp='Krokmou'

read -s -p 'Saisissez votre mot de passe : ' tentative

if [ $mdp = $tentative ]; then
	echo "Mot de passe Accepté!"
else
	echo "Mot de passe Refusé!"
fi
