#!/bin/sh

################################################################
#  Multi Certificates in one file checker                      #
#  Version:2.0                                                 #
#          1.0: the first version                              #
#          2.0: fix to read if certificate file modified in    #
#               in windows.                                    #
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

sub_ca_file="/tmp/sub_ca_tmpxxxxx.crt"  #temporary ca file for each certificate fetched from the input
ca_number=1     #used to counte the certificate number
if [ -f  $sub_ca_file ];then            #check if the temporary ca file existed or not,
    rm -rf $sub_ca_file                 #exist, then remove
fi

if [ -z $1 ];then        #the input file is required
    echo "ERROR: missing the file name";exit
fi

#if the input file existed or not, yes, continue; no, exit.
if [ -f $1 ];then
    ca_total_number=`cat $1 | grep -w "\-----BEGIN\ CERTIFICATE-----" -c`   #check if the input file has certificate or not, and how many certificates are there
    if [ $ca_total_number != "0" ];then   #if there is certificate, going on
        echo "Total Certificate found: $ca_total_number";echo         #printout the totle certificates number
        
        #this is used for the ca file modifyed in windows
        tmp_ca_file="/tmp/"$1"tmp.crt"     #temporary file of the input
        sed 's/\r//g' $1 > $tmp_ca_file    #replace the line break of windows and write into the temporary file, the input file is not changed.
        
        while read line || [ -n "$line" ]  #read the certificate in the temporary file 
        do
            #if it is end of certificate, then perform the openssl to printout the x509 format
            #if not, continue to write the certificate to temporary ca file
            if [[ $line == "-----END CERTIFICATE-----" ]];then
                echo $line >> $sub_ca_file 2>&1
                echo "########Certificate $ca_number#######"
                openssl x509 -in $sub_ca_file -text -noout
                rm -rf $sub_ca_file 2>&1
                echo;echo;ca_number=$(($ca_number+1))
            else
                echo $line >> $sub_ca_file 2>&1
            fi 
        done < $tmp_ca_file
        rm -rf $tmp_ca_file 2>&1
    else 
        echo;echo "An incorrecte certificate file.";echo;echo
    fi 
else
    echo "File \"$1\" is not existed!"
fi
