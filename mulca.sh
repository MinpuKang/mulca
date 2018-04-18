#!/bin/sh

################################################################
#  Multi Certificates in one file checker                      #
#  Version:1.0                                                 #
#  Owner: Minpu Kang                                           #
#  Introduction: This is used to check multiple certificates   #
#                in one file based on openssl.                 #
#                Parameters of -in|-text|-noout for x509       #
#                is used, and if printout different format     #
#                below line can be changed:                    #
#                   openssl x509 -in $sub_ca_file -text -noout #
#                                                              #
#  An example for setup:                                       #
#     $ vi mulca.sh                                            #
#     $ chmod u+x mulca.sh                                     #
#     $ ln -s mulca.sh ~/bin/mulca                             #
#     $ echo "PATH=~/bin:\${PATH}" >> ~/.profile               #
#                                                              #
#  Link: https://github.com/MinpuKang/mulca                    #
#                                                              #
################################################################

sub_ca_file="certificatexx.crt"
ca_number=1
if [ -f  $sub_ca_file ];then
    rm -rf $sub_ca_file
fi

if [ -z $1 ];then
    echo "ERROR: missing the file name";exit
fi

if [ -f $1 ];then
    ca_total_number=`cat $1 | grep -w "\-----BEGIN\ CERTIFICATE-----" -c`
    if [ $ca_total_number != "0" ];then 
        echo "Total Certificate found: $ca_total_number";echo
        while read line || [ -n "$line" ]
        do
            if [[ $line == "-----END CERTIFICATE-----" ]];then
                echo $line >> $sub_ca_file 2>&1
                echo "########Certificate $ca_number#######"
                openssl x509 -in $sub_ca_file -text -noout
                rm -rf $sub_ca_file 2>&1
                echo;echo;ca_number=$(($ca_number+1))
            else
                echo $line >> $sub_ca_file 2>&1
            fi 
        done < $1 
    else 
        echo;echo "An incorrecte certificate file.";echo;echo
    fi 
else
    echo "File \"$1\" is not existed!"
fi 
