# @summary Manages gpg key information and repository, if necessary
#
# @example
#   include kapacitor::repo
class kapacitor::repo (
  String $key_resource = $kapacitor::key_resource,
  String $resource = $kapacitor::resource,
  Boolean $manage_repo = $kapacitor::manage_repo,
){
  if $manage_repo {

    $keys = lookup('kapacitor::gpg_keys', Hash, 'deep', {})
    $repositories = lookup('kapacitor::repositories', Hash, 'deep', {})

    if $keys != {} {
      create_resources($key_resource, $keys)
    }
    if $repositories != {} {
      create_resources($resource, $repositories)
    }
  }
}
