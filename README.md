# Generate ObjC Class Tree

* via shell scripts and command line application.
* Download the OtherScripts Folder, include shell script and pre-build command line application.
* Export OtherScripts path.
* Then type command like below。`-p` is your objc class path, `-o` is output file name.

~~~
cd yourPath/
classTree.sh -p TSCommon/ -o classTree.txt  
~~~


* you will create a class tree like this 

~~~
UIViewController
	└──AViewController
		├──A1ViewController
		└──A2ViewController
~~~



