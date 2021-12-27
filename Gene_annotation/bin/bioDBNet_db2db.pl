#!/usr/bin/perl -w

my $usage=<<END;
--------------------------------------------------------
db2db, a tool from bioDBNet for converting gene ID through all kinds of different bioinformatics database.
Usage: perl $0 input_type output_type list_file (-n 30) >list_file.cor
        # type is small letter with gap removed. Example: perl $0 genesymbol geneid list_file
        # -n sets the thread number, by default is 30
                                                Du Kang 2017-3-24, 2017-8-28
--------------------------------------------------------
END

open LIST, $ARGV[2] or die $usage;
while (<LIST>){
        chomp;
        $i=int($./100);
        $list{$i} .= "$_,";
        $max=$.;
}

$top=int($max/100);
foreach $n (0..$top){
        chop $list{$n};
        $result = db2db($ARGV[0],$ARGV[1],$list{$n});
        @result =split /\n/, $result;
        foreach $line (@result) {
#                $line=~s/\s//g;
                print $1 if  $line=~/<InputValue>(.*)<\/InputValue>/;
                print "\t$1\n" if $line=~/<$ARGV[1]>(.*)<\/$ARGV[1]>/i;
        }
}

# perl funtion talking to bioDBNet API --------------------------------
sub db2db{
        use REST::Client;
        $input=$_[0];
        $output=$_[1];
        $list=$_[2];
        my $client=REST::Client -> new();
        $url = 'https://biodbnet-abcc.ncifcrf.gov/webServices/rest.php/biodbnetRestApi.xml?method=db2db&format=row&input='.$input.'&inputValues='.$list.'&outputs='.$output.',affyid';
        $client -> GET($url);
        $response=$client -> responseContent();
        return $response;
}

# Python funtion talking to bioDBNet API -------------------------------- abandon
#use Inline Python => <<EOF;

#def db2db(input,output,list):
#       import urllib

#       url = 'https://biodbnet-abcc.ncifcrf.gov/webServices/rest.php/biodbnetRestApi.xml?method=db2db&format=row&input='+input+'&inputValues='+list+'&outputs='+output+',affyid'

#       u = urllib.urlopen(url)

#       response = u.read()

#       return response

#EOF
