# Docconv

The docconv container will run docd as a service by default. A Debian & alpine
version are available (the default is Debian).

More info on docd can be found on https://github.com/sajari/docconv.

## Usage

To run with the default settings :

    docker run -p 8888:8888 nascom/docconv-alpine

You can also specify custom parameters :

    docker run -p 7777:7777 nascom/docconv-alpine -log-level 1 -addr :7777

## Testing

To test the container, you can use the following curl call :

    curl -v -F input=@yourfile.pdf http://localhost:8888/convert

Make sure you specify the correct port number :p.
