# Hello!

This repository stores the code and configuration that I use to run the website at [stevthedev.com](https://stevthedev.com).

## This will be deployed as a set of services:
- **aboutme-djano:** a django web application
- **aboutme-data:** a postgresql database
- **aboutme-proxy:** a front end proxy server

I'm using Django to serve text posts and code snippets, as well as running a [Contact Page](https://stevthedev.com/contact). 

I've been using the Typora Markdown editor when writing articles. I love it's simplicity and sharp appearance. After exporting to HTML, I convert the file into a django template to be displayed in the articles section. Similarly, I use the python package [pygments](http://pygments.org/) to generate stylized HTML from code. Check out the results [here](https://stevthedev.com/articles/)!

Thanks for stopping by!
- Steven
