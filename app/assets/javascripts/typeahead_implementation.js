jQuery(document).ready(function($) {
  var discussionsEngine = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 10,
    prefetch: {
      url: '/api/prefetch/discussions.json'
    }
  });

  var articlesEngine = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 10,
    prefetch: {
      url: '/api/prefetch/articles.json'
    }
  });

  discussionsEngine.clearPrefetchCache();
  articlesEngine.clearPrefetchCache();

  // kicks off the loading/processing of `local` and `prefetch`
  // discussionsEngine.initialize();
  // articlesEngine.initialize();

  if ( window.operamini ) {
    $('.home-search--input').unbind('focus');
  } else {
    discussionsEngine.initialize();
    articlesEngine.initialize();
  }

  $('.home-search--input').typeahead({
    highlight: true
  },
  {
    name: 'discussions',
    displayKey: 'title',
    source: discussionsEngine.ttAdapter(),
    templates: {
      header: '<h3 class="typeahead-results-header">Discussions</h3>',
      suggestion: Handlebars.compile('<a href="/discussions/{{slug}}">{{title}}</a>')
    },
    engine: Handlebars
  },
  {
    name: 'articles',
    displayKey: 'title',
    source: articlesEngine.ttAdapter(),
    templates: {
      header: '<h3 class="typeahead-results-header">Articles</h3>',
      suggestion: Handlebars.compile('<a href="/articles/{{id}}">{{title}}</a>')
    },
    engine: Handlebars
  }).on('typeahead:selected', function(e, object) {
    if (object.class_name == 'discussion') {
      window.location = '/discussions/' + object.id;
    } else {
      window.location = '/articles/' + object.id;
    }
  });
});