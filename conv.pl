#
#  指定ディレクトリ配下の内容をMarkdownに変換する
#

use File::Spec;

my $abs = File::Spec->rel2abs('.');
print "current director is " . $abs . "\n";

#my $licensesDir = $abs . '/licenses';
my $targetDir = $ARGV[0];
my $output = $abs . '/output.md';

open(OUT, ">$output");
opendir(DIR, $targetDir);

foreach(readdir(DIR)){
  next if /^\.{1,2}$/;    # '.'や'..'をスキップ
  my $dName =  "$_";
  my $path = $targetDir . '/' . $dName;  
  print OUT ("***\n");  # マークダウンの<hr>
  conv($dName, $path, 1);
}

print "\n";
print("Finish!!\n");
print("(Please view output.md)\n\n");

closedir(DIR);
close OUT;

sub conv {
  
  my $name = $_[0];
  my $dirFullpath = $_[1];
  my $level = $_[2];
  
  print("converting $name level=$level\n");
  my $a = '#'x $level;
  print OUT $a . " $name\n\n"; # ディレクトリ名で章を作る
  
  opendir(SUBDIR, $dirFullpath) or die "$!";
  my @dirList = readdir(SUBDIR);
  closedir(SUBDIR);

  # ファイルの処理
  foreach(@dirList){
    next if /^\.{1,2}$/;
    my $file = $dirFullpath . '/' . $_;
#    print("    check file : $file\n");
    if(-f $file){
      outputText($file);
    }
  }

  # フォルダの処理
  foreach(@dirList){
    next if /^\.{1,2}$/;
    my $subCompo = $_;
    my $dir = $dirFullpath . '/' . $subCompo;
#    print("    check dir : $dir\n");
    if(-d $dir){
      my $lev = $level + 1;
      conv($subCompo, $dir, $lev);
    }
  }
  
}

sub outputText {
  my $filepath = $_[0];
  open(IN, $filepath) or die "$!";

#  # マークダウンの場合は行頭に\を付けてテキスト化する
#  my $mdFlg = undef;
#  if($filepath =~ /\.md$/){
#    #print("$filepath is end by md");
#    $mdFlg = 1;
#  }

  foreach(<IN>){
    my $t = $_;
    #print('$_' . "=" . length($_));
#    if($mdFlg and !noStr($t)){
#    #if($mdFlg){
#      print OUT ("\\" . $t);
#    } else {
      print OUT ($t);
#    }
  }
  
  print OUT ("\n\n");
  close(IN); 
}

#sub noStr {
#  my $str = $_[0];
#  if($str){
#    return undef;
#  } else {
#    return 1;
#  }

#  if(($str eq " ") or ($str eq "　") or ()){
#    return true;
#  } else {
#    return false;
#  }
#}
