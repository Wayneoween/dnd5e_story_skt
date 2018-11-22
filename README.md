## A D&D Blog from some people from Augsburg

The purpose of this Blog is to keep track on the adventures me and my players life and die through.
This useses [Jekyll](https://jekyllrb.com/) and the fact that GitHub can render this to html out of
the box.

The Theme we use is [this](https://github.com/iwiedenm/jekyll-theme-massively-src/) but has quite a
few modifications. We removed the `Formspring.io` integrations since it [seems not to be alive
anymore](https://techcrunch.com/2013/03/15/formspring-the-pioneering-anonymous-qa-platform-is-shutting-down/)
and we didn't want forms anyway. [Disqus](https://disqus.com) also was removed, since we don't want
comments on that page and you can mail me or join our Slack!


## Development

* Install rbenv + ruby 2.5.1
* Run `bundle`
* Open a terminal and run
  * `b jekyll server --watch --livereload`
* Open the local version in your Browser: http://127.0.0.1:4000/
* Whenever you make a content change, it will automatically be builti, served locally and reload
  your tab.
* Please note that you must restart the server when making changes to "_config.yml" (i.e. when
  adding a new icon).
