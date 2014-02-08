(function(){
  var path;
  path = require('path');
  module.exports = function(done){
    this.express(function(app, express){
      app.set('views', __dirname + '/views');
      app.set('view engine', 'jade');
      app.use(express.favicon());
      app.use(express.logger('dev'));
      app.use(express.bodyParser());
      app.use(express.methodOverride());
      app.use(app.router);
    });
    this.routes();
    done();
  };
}).call(this);
