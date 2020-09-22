# directory-to-markdown

directory contents convert to markdown 

# how to use

```
$ git clone <this-repo>
$ cd <this-repo>
$ perl conv.pl <target-dir>
```

# example

## directory contents

```
targetDirectory
|--AAA
|  |--aaa.txt
|--BBB
|  |--aaa.txt
|  |--bbb.txt
|--CCC
|  |--aaa.txt
|  |--XXX
|  |  |--xxx.txt
|  |  |--yyy.txt
|--DDD
|  |--XXX
|  |  |--xxx.txt
|  |--YYY
|  |  |--yyy.txt
```

## converted markdown text

>***
># AAA
>
>aaa.txt's text
>
>***
># BBB
>
>aaa.txt's text
>
>bbb.txt's text
>
>***
># CCC
>
>aaa.txt's text
>
>## XXX
>
>xxx.txt's text
>yyy.txt's text
>
>***
># DDD
>
>## XXX
>
>xxx.txt's text
>
>## YYY
>
>yyy.txt's text


