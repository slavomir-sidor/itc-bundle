ITC Bundle
==========

    CODE Reflection,UML Modelingm & Manipulations Library with generators.


Reflections
-----------

    Code reflections console tools. Console Tools for code.


**Code Reflections commands**:

    reflection:bundles             ITCloud Reflection Bundles
    reflection:classes             ITCloud Reflection Classes
    reflection:classes:attr        ITCloud Reflection Classes Attributes
    reflection:files               ITCloud Reflection Files
    reflection:namespaces          ITCloud Reflection Namespaces
    reflection:operations          ITCloud Reflection Classes Operations
    reflection:operations:attr     ITCloud Reflection Classes Operations Attributes

    Usage:
    <command> [options] [--] [<src>]...
            
            Arguments:
              src                                                     PHP Source directory [default: ["src/","app/","tests/"]]
            Options:
              -h, --help                                              Display this help message
              -q, --quiet                                             Do not output any message
              -V, --version                                           Display this application version
                  --ansi                                              Force ANSI output
                  --no-ansi                                           Disable ANSI output
              -n, --no-interaction                                    Do not ask any interactive question
              -e, --env=ENV                                           The Environment name. [default: "dev"]
                  --no-debug                                          Switches off debug mode.
              -bs, --bootstrap[=BOOTSTRAP]                            PHP Boostrap File.
              -an, --attributeName[=ATTRIBUTENAME]                    Attributes name, e.g. '^myPrefix|mySuffix$', regular expression allowed.
              -df, --ignoreDotFiles[=IGNOREDOTFILES]                  Ignore DOT files. [default: true]
              -on, --operationName[=OPERATIONNAME]                    Operations name, e.g. '^myPrefix|mySuffix$', regular expression allowed.
              -oa, --operationAttributeName[=OPERATIONATTRIBUTENAME]  Operations Attributes name, e.g. '^myPrefix|mySuffix$', regular expression allowed.
              -ac, --accessibility[=ACCESSIBILITY]                    Operations and attributes accessibility: protected, public, private.
              -pc, --parentClass=PARENTCLASS                          Parent Class Name, e.g 'My\Class' (multiple values allowed)
              -fs, --fileSuffix[=FILESUFFIX]                          File suffixes for given src, default all and not dot files. [default: "*.php"]
              -fl, --followLinks[=FOLLOWLINKS]                        Follows links. [default: false]
              -ii, --is-interface=IS-INTERFACE                        Reflect Interfaces Objects Only, possible values are (true|false).
              -it, --is-trait=IS-TRAIT                                Reflect Traits Objects Only, possible values are (true|false).
              -ib, --is-abstract-class=IS-ABSTRACT-CLASS              Reflect Abstract Classes Only, possible values are (true|false).
              -if, --is-final=IS-FINAL                                Reflect Final Classes Only, possible values are (true|false).
              -ia, --is-abstract=IS-ABSTRACT                          Reflect Abstract Classes Only, possible values are (true|false).
              -ip, --is-private=IS-PRIVATE                            Reflect Private Operations or Attributes, possible values are (true|false).
              -id, --is-protected=IS-PROTECTED                        Reflect Protected Operations or Attributes, possible values are (true|false).
              -ic, --is-public=IS-PUBLIC                              Reflect Public Operations or Attributes, possible values are (true|false).
              -is, --is-static=IS-STATIC                              Reflect Static Operations or Attributes, possible values are (true|false).
              -imi, --implements-interface=IMPLEMENTS-INTERFACE       Reflect Abstract Classes Only. (multiple values allowed)
              -ed, --exclude=EXCLUDE                                  Exclude Directory from source (multiple values allowed)
              -v|vv|vvv, --verbose                                    Increase the verbosity of messages: 1 for normal output, 2 for more verbose output and 3 for debug


UML Code Modeling
-----------------

    Internal UML Models structure. Import, export to XMI from given reflection.

Code Manipulation
-----------------

    From Internal UML Models gives ability to manipulate with given code.
    Features:

**Formating**

https://github.com/phpfmt/fmt

**Annotations**

Fixes Annotations.



Referencies
-----------

   * http://www.uml-diagrams.org/uml-25-diagrams.html