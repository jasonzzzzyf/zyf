#!/bin/sh

if [ $# -eq 0 ]
#if the number of arguments  equal to zero
then
    printf "Please enter one path name\n"
    printf "Use: $0 path\n"
    exit
else
    file=`find $1 -perm -u=r -name "*.rec" | wc -l`
    #find readable file
    if [ $file -eq 0 ]
    #if readable file equal to zero
    then
        printf "There is not readable *.rec file exists in the specifiedpath or its subdirectories\nlab3.sh path"
                   #When the script cannot find any readable “*.rec” file
        exit
    fi

    printf "command:"
    read command
    #get command
    while [ $command != "q" -a $command != "quit" ]
    do
        set `find $1 -name "*.rec" -perm -u=r`
            if [ $command = "l" -o $command = "list" ]
            then
                printf "here is the list of found class files"
                find $1 -type f -name "*.rec" -perm -444
                        #The script shows the list of found readable "*.rec". Ifthe user enters l “lower case el”, accept as the "list" command and show list.
            elif [ $command = "ci" ]
            then
                echo "Found courses are:"
                for i in $@
                do
                    name=$(grep "COURSE NAME:" $i | cut -b 14-)
                    credit=$(grep -i "credits" $i | cut -b 9-)
                    echo $name 'has' $credit 'credits'
                    done
            elif [ $command = "sl" ]
			then
				printf "Here is the unique list of student numbers in all courses:\n"
				grep ^[0-9] *.rec | cut -d : -f2 | cut -c1-6 | sort | uniq > studentNumbers.txt
				cat studentNumbers.txt
				rm studentNumbers.txt
            elif [ $command = "sc" ] #problem
            then
                for i in $@
                do
                    `grep -o "[0-9]\{6\}" $i >> output`
                done
                student_n=`sort < output | uniq | wc -l`
                echo "There are $student_n registered students in all courses"
            elif [ $command = "cc" ]
            then
                echo  "There are" "$(find .. -name '*.rec' | wc -l)" "course files."
            elif [ $command = "h" -o $command = "help" ]
            then
                echo 'Here are defined commands: '
                echo 'l or list: lists found courses'
                echo 'ci: gives the name of all courses plus number of credits'
                echo 'sl: gives a unique list of all students registered in all courses'
                echo 'sc: gives the total number of unique students registered in all courses'
                echo 'cc: gives the total numbers of found course files.'
                echo 'h or help: prints the current message.'
                echo 'q or quit: exits from the script'
            else
                printf "Unrecognized command!\n"
                        #when read other command
            fi
    printf "command:"
    read command
    done
fi
