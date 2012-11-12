Gistie
================

[Gistie] is an open source [Git]-based pastebin implementation that enables sharing snippets(aka Gist) using simple web UI.
Every Gist is a *Git repository* thus **versioned** and **cloneable**. Heavily inspired by gist.github.com

![Gistie](https://lh6.googleusercontent.com/-0uLEFS1ZVK8/UJ_g9D96qqI/AAAAAAAAHpE/L7rAklsb9Fw/s819/gitsy.png)

Features
---------------

as of `v0.1`:

- Create, Edit, Delete Gists
- Revision browsing
- Cloneable (served by git-daemon)
- public by default
- Raw view
- syntax highlight with pygments (filename based detection)



TODO
---------------

- Fork
- Markup(markdown) rendering
- Search
- Binary support
- Inline image
- Accounts
- Private gists
- Commenting
- "Code Review"


Installation
---------------

[Gistie] is based on Ruby on Rails, Sqlite, Libgit2 and Pygments(requires Python installed).


1. `git clone https://github.com/gmarik/Gistie` 
2. `cd Gistie && bundle install`
3. `rake db:create db:migrate`
4. `rails server`


Making repos cloneable
--------------


run

    git-daemon --user=nobody --export-all --base-path=/path/to/Gistie/repos_production



Testing
---------------

1. `cd Gistie`
2. `rake db:test:clone_structure`
3. `rspec spec`


License
---------------

Please see LICENSE for licensing details.


Author
---------------

Maryan Hratson aka [@gmarik](http://github.com/gmarik)

- contact: [@gmarik](http://twitter.com/gmarik)

[Gistie]:http://github.com/gmarik/Gistie

