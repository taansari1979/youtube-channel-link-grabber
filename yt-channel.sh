
i=1;
echo "page#$i"
wget -q "$1/videos?shelf_id=0&sort=dd" --no-check-certificate -O temp1.html
cat temp1.html|tr '"' '\n'|grep -i "watch?v="|sort|uniq|tr -d '\\'>"url.list"

while true; do
	k=$(cat "temp$i.html"|tr '"' '\n'|grep -i "browse_ajax?action_continuation="|tr -d '\\')
	k="${k/u0026amp;/&}"
	if [ -z "$k" ] ; then
		break;
	else
		let "i++"
		echo "page#$i"
		wget -q "https://www.youtube.com$k" --no-check-certificate -O "temp$i.html"
		cat temp1.html|tr '"' '\n'|grep -i "watch?v="|sort|uniq|tr -d '\\'>>"url.list"
	fi

done

sed -i -e "s/^/http:\/\/www.youtube.com/" url.list
cat url.list
for(( j=1; j<=i; j++ ))do rm -f "temp$j.html";done;


