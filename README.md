[![Build Status](https://travis-ci.org/jonkerz/kingscourt.svg?branch=master)](https://travis-ci.org/jonkerz/kingscourt)
[![Gemnasium](https://img.shields.io/gemnasium/jonkerz/kingscourt.svg?maxAge=2592000)](https://gemnasium.com/github.com/jonkerz/kingscourt)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
[![Website](https://img.shields.io/website-up-down/http/kingscourt.io.svg?maxAge=2592000)](http://kingscourt.io)
[![GitHub release](https://img.shields.io/github/release/jonkerz/kingscourt.svg?maxAge=2592000)](https://github.com/jonkerz/kingscourt/releases)

```
 ____  __..__               /\        _________                           __   
|    |/ _||__|  ____    ____)/ ______ \_   ___ \   ____   __ __ _______ _/  |_ 
|      <  |  | /    \  / ___\ /  ___/ /    \  \/  /  _ \ |  |  \\_  __ \\   __\
|    |  \ |  ||   |  \/ /_/  >\___ \  \     \____(  <_> )|  |  / |  | \/ |  |  
|____|__ \|__||___|  /\___  //____  >  \______  / \____/ |____/  |__|    |__|  
        \/         \//_____/      \/          \/                               
```

### King's Court
Generate, build, and browse kingdoms of the card game [Dominion](https://en.wikipedia.org/wiki/Dominion_(card_game)). Live at [kingscourt.io](http://kingscourt.io/).

### Stack
**Front-end**: AngularJS 1.5 (in CoffeeScript), Bootstrap 3 (Sass), Bower-Rails, some jQuery-UI, Lodash. **Backend**: Rails 5, ActiveModelSerializers (API), Sunspot/Solr (API), DeviseTokenAuth (API), ActiveAdmin (manage database), Capistrano 3 (deployment). **Backup**: Backup (gem) + Whenever (for uploading db dumps to Dropbox), PaperTrail. **Server** (on DigitalOcean): nginx, Puma, MySQL. **Testing**: Cucumber (with Capybara Webkit), RSpec, Teaspoon + Jasmine (JavaScript unit-ish tests), Travis CI (for continuous integration), RuboCop (style/linting).

### Installation
See [INSTALL.md](INSTALL.md).

### Contributing
Contributions welcome!
