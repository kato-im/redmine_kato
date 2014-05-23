Kato Plugin for Redmine
==========================

Redmine plugin for Kato notifications


Installation
------------

###### 1 .Install kato-rb gem:

add `gem kato-rb` to your Gemfile and run

    bundle install

###### 2. Install Kato plugin:

copy plugin to redmine plugins directory:

    git clone git@github.com:kato-im/redmine_kato.git #{redmine_root/plugins}

then run

    rake redmine:plugins:migrate RAILS_ENV=production

(change environment if needed - more info at Redmine [plugin installation guide](http://www.redmine.org/wiki/redmine/Plugins))

###### 3. Configure plugin

In Redmine go to the Plugin page in the Adminstration area and configure Kato plugin using webhook URL - you can find it at [Kato](https://kato.im) (go to your room's integration panel and click on Redmine icon).

Copyright
------------

Copyright © LeChat, Inc. See LICENSE for details.

Based on [redmine_hipchat](https://github.com/hipchat/redmine_hipchat)
