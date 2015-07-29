# LazyDev

LazyDev is a iOS application generator for Rusic spaces. You provide LazyDev
with your Rusic API key and the bucket ID of the space which you want to create
an iOS application for. LazyDev then goes and generates a native application
which allows users to view the ideas in that space, number of comments, number
of likes and also allows them to add new ideas to the space.

Lazy was created for the Simpleweb hacknight sponsored by
[Rusic](http://rusic.com). (That means don't shout at me aboout the
code)

## How?

LazyDev works by having a template Rusic iOS application that
communicates with the Rusic API. This application contains a
Credentials class that stores the API key and bucket ID. First the
LazyDev Rusic template iOS application is copied by a python script,
this will become the new application. The python script then replaces
the Credentials class within the new application with the provided
information.

## Running

Retrieve your Bucket ID from [here](http://rusic.com/spaces) and your
API key from [here](http://rusic.com/accounts/api).

Run LazyDev using `./lazydev.py` ensuring the LazyDev template
application is in the same directory.
