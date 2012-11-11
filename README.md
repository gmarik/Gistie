# Gitsy

`Gitsy` is an open source [Git]-based pastebin implementation that enables sharing snippets(aka Gist) using simple web UI.
Every Gist is a *Git repository* thus **versioned** and **cloneable**.

![gitsy](https://lh6.googleusercontent.com/-0uLEFS1ZVK8/UJ_g9D96qqI/AAAAAAAAHpE/L7rAklsb9Fw/s819/gitsy.png)

## Features

as of `v0.1`

- Create, Edit, Delete Gists
- Revision browsing
- Cloneable (served by git-daemon)
- public by default
- Raw view

- syntax highlight with pygments (filename based detection)

## TODO

- Fork
- Markup(markdown) rendering
- Search
- Binary support
- Inline image

- Accounts
- Private gists
- Commenting
- "Code Review"

## Installation

[Gitsy] is based on Ruby on Rails, Sqlite, Libgit2 and Pygments(requires Python installed).


1. `git clone https://github.com/gmarik/gitsy` 
2. `cd gitsy && bundle install`
3. `rake db:create db:migrate`
4. `rails server`

## Making repos cloneable

run

    git-daemon --user=nobody --export-all --base-path=/path/to/gitsy/repos_production


## Development

### Cloneable repos with `git-daemon`

on OSX, it may look like:

    /usr/local/Cellar/git/1.7.7/libexec/git-core/git-daemon --export-all --base-path=./repos_development


## Testing

1. `cd gitsy`
2. `rake db:test:clone_structure`
3. `rspec spec`
