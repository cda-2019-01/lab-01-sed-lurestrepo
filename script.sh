sed 's#/#-#g' data.csv > out.1 # convierte /  en  -

sed 's/-\([0-9][0-9]\);/-20\1;/' out.1 >out.2 # convierte el año YY en YYYY

sed 's/\([0-9][0-9]\)-\([0-9][0-9]\)-\([0-9]*\);/\3-\2-\1;/' out.2>out.3 #invertir año por por día


sed 's/\([0-9]\),/\1./' out.3 >out.4 # Use el . para indicar decimales.

sed 's/;/,/g' out.4>out.5 #Reemplace los ; por ,v.
sed 's/,/./4' out.5 > out.6 #remplaza la ,  los decimales de la ultima columna.
#Transforme el archivo para que todos los campos nulos 
#aparezcan como \N
sed 's/,N/\,\\N/g' out.6 > out.7 #cambia las N por \N
sed 's/,,/\,\\N,/g' out.7>out.8 #cambia las ,, por ,\N,
sed 's/,$/,\\N/g' out.8>out.9 #los nulos al final de la cadena cambiar por ,\N
tr '[:lower:]'  '[:upper:]' < out.9 > out.10 # convierte mayusculas en minusculas del out.9 al out.10
grep -v \\N out.10 > out.11 #Extraiga los registros que no tienen campos nulos.
cat out.11 #muestre el archivo final   
rm out.* #elimina los archivos temporales