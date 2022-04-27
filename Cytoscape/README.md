# change the uniprot entry to the human entry
```bash
# kangjingliang@kangjingliangdeMacBook-Pro 三  4 27 16:31:07 ~/Documents/2022/Ldim_genome/Interaction
less Ldim_ano_swissprot_detail.txt|perl -alne 'next if /^yourlist/;($nm)=$F[2]=~/(.*?)_/;$nm.="_HUMAN";print "$F[0]\t$F[2]\t$nm"' >Ldim_ano_swissprot_detail.2.txt
# Ldim_ano_swissprot_detail.2.human.string.tab: human string id
perl temp1.pl > Ldim_ano_swissprot_human_stringid.txt
```
