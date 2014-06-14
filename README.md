JSObjCBridge
============

Bridge to call Objective C code from JavaScript. Please see below a simple example in JS


```
        function myFunction(event)
        {
            document.location = "libtest://" + "methodName?{\"api\":{\"methodName\":\"performTestMethod1WithParameter\",\"parameters\":{\"param1\":{\"name\":\"param1\",\"value\":\"test\"},\"param2\":{\"name\":\"parameter2\",\"value\":\"test1\"},\"param3\":{\"name\":\"withCompletion\",\"value\":\"\"}}}}";
        }
```
