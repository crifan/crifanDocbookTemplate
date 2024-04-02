#!/bin/bash
#remove *.bak in subfolder files
echo "*********************************************************************";
echo "Version   : 2012-06-14"
echo "Author    : admin at crifan.com"
echo "Function  : remove *.bak under current folder and its sub folders";
echo "Note      : 1. current folder level is 0";
echo "            2. current can not handle space in file/foder properly";
echo "Usage     : ./remove_bak.sh [subfolder_depth]";
echo "*********************************************************************";

# inpu should be full path of a folder
function remove_subfolder_bak() 
{
    if [ $subfolder_depth ]; then
        #echo "check folder level";
        if [ $cur_subfolder_depth -gt $subfolder_depth ]; then
            #echo "cur_subfolder_depth=$cur_subfolder_depth > subfolder_depth=$subfolder_depth, not process it";
            return;
        fi
    fi
    
    local input_folder=$1;
    echo "processing folder: $input_folder";
    if [ -d $input_folder ]; then
        #echo "111 input $input_folder is a foler.";

        #local sub_items=`ls $input_folder`;
        #avoid space in filename
        local sub_items=`ls $input_folder | tr " " '\?'`;
        #echo '444 sub_items='$sub_items;
        #echo 'sub_items='$sub_items;
        local sub_item_len=`ls $input_folder | wc -w`;
        #echo "sub_item_len=$sub_item_len";
        if [ $sub_item_len -gt 0 ]; then
            for each_item in $sub_items; do
                each_item=`echo $each_item | tr '\?' " "`;
                #echo "666 each_item=" $each_item;
                local item_full_path=$input_folder/$each_item
                #echo "777 item_full_path=" $item_full_path
                if [ -d $item_full_path ]; then
                    #echo $each_item
                    #echo "888 before call, input_folder=$input_folder";
                    #cur_prefix=$input_folder;
                    
                    #echo "in: cur_subfolder_depth=$cur_subfolder_depth";
                    cur_subfolder_depth=`expr $cur_subfolder_depth + 1`;
                    #echo "in: cur_subfolder_depth=$cur_subfolder_depth";
    
                    remove_subfolder_bak $item_full_path;
                    
                    #echo "out: cur_subfolder_depth=$cur_subfolder_depth";
                    cur_subfolder_depth=`expr $cur_subfolder_depth - 1`;
                    #echo "out: cur_subfolder_depth=$cur_subfolder_depth";
                    
                    #input_folder=$cur_prefix;
                    #echo "999 exit from remove_subfolder_bak, input_folder=$input_folder";
                else
                    if [ -f $item_full_path ]; then
                        #echo "101010 ------ file: $each_item"
                        #echo "file: $each_item"
                    
                        #if [ $each_item == *.bak ] ; then
                        if [ `echo $each_item | sed -nr '/.+\.bak/p' ` ] ; then
                            #echo "111111 !!!!! found bak file="$input_folder"/"$each_item;
                            echo "!!!!!! now to remove bak file: $item_full_path";
                            rm -rf $item_full_path;
                        fi
                    else
                        echo "??????????found non-file non-folder strange one: $each_item";
                    fi
                fi
            done
        fi
    fi

} 

#echo "input the 0 para="$0;
echo "input the 1 para="$1;
subfolder_depth=$1;
echo "subfolder_depth="$subfolder_depth;
if [ $subfolder_depth ]; then
    echo "input subfolder_depth="$subfolder_depth;
    if [ $subfolder_depth -gt 0 ]; then
        echo "valid setting: subfolder_depth=$subfolder_depth";
    else
        echo "input invalid subfolder_depth=$subfolder_depth"
    fi
else
    echo "no input subfolder_depth";
fi

cur_full_path=`pwd`;
#cur_subfolder_depth=-1;
cur_subfolder_depth=0;
remove_subfolder_bak $cur_full_path;
echo "+++++++++++++++++++++++++++++++++++++++++++++++end of this script";

exit 0