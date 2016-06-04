# PhantomJS (Teaspoons default driver) doesn't have support for Function.prototype.bind, which has caused confusion.
# Use this polyfill to avoid the confusion.
#= require support/phantomjs-shims

#= require kings_angular
#= require angular-mocks/angular-mocks
