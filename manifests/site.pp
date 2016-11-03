
node 'banco.localdomain' {
  include role::banco
}

node 'web.localdomain' {
  include role::web
}

node 'solr.localdomain' {
  include role::solr
}
