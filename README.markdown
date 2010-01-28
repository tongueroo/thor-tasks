Thor tasks
==========

Getting started: install [Thor](http://github.com/wycats/thor/tree/master) if you haven't.

    gem install wycats-thor

You can install these tasks directly from the web:

    thor install http://github.com/tongueroo/thor-tasks/tree/master/github.thor?raw=true

If you want to inspect and try out the tasks **without** installing, you should clone the repo:

    git clone git://github.com/tongueroo/thor-tasks.git
    cd thor-tasks
    thor list

That command will get you a list of tasks together with their usage information. So, if you like them:

    thor install github.thor --as Tongueroo

Later you'll wish to update:

    git pull
    thor update Tongueroo

On update, Thor will try to fetch the tasks from the same source you specified during install.

That's it. And now for a bit of fun.    


Tongueroo tasks
------------

