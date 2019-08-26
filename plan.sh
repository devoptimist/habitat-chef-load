pkg_name=chef-load
pkg_origin=devoptimist
pkg_version="4.0.0"
pkg_maintainer="Steve Brown <sbrown@chef.io>"
pkg_license=("Apache-2.0")
pkg_filename=${pkg_name}-${pkg_version}.tar.bz2
pkg_deps=(
  chef/chef-load
  core/git
  core/cacerts
)

pkg_binds_optional=(
  [automate]="port"
  [chef-server]="port"
)

do_download() {
  export GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  git clone -q https://github.com/chef/chef-load

  # pushd chef-load
  # git checkout $pkg_version
  # popd

  mkdir ${pkg_name}-${pkg_version}
  mv chef-load/sample-data ${pkg_name}-${pkg_version}/
  rm -rf chef-load

  curl -s -o ${pkg_name}-${pkg_version}/sample-data/1mb_ohai.json https://tcate-large-nodes.s3.eu-west-2.amazonaws.com/1mb_ohai.json
  curl -s -o ${pkg_name}-${pkg_version}/sample-data/2mb_ohai.json https://tcate-large-nodes.s3.eu-west-2.amazonaws.com/2mb_ohai.json
  curl -s -o ${pkg_name}-${pkg_version}/sample-data/3mb_ohai.json https://tcate-large-nodes.s3.eu-west-2.amazonaws.com/3mb_ohai.json
  curl -s -o ${pkg_name}-${pkg_version}/sample-data/4mb_ohai.json https://tcate-large-nodes.s3.eu-west-2.amazonaws.com/4mb_ohai.json
  curl -s -o ${pkg_name}-${pkg_version}/sample-data/5mb_ohai.json https://tcate-large-nodes.s3.eu-west-2.amazonaws.com/5mb_ohai.json


  tar -cjf $HAB_CACHE_SRC_PATH/${pkg_filename} ./${pkg_name}-${pkg_version}
  rm -rf ./${pkg_name}-${pkg_version} 

  pkg_shasum=$(trim $(sha256sum $HAB_CACHE_SRC_PATH/${pkg_filename} | cut -d " " -f 1))
}



do_build() {
  return 0
}

do_install() {
  ls $HAB_CACHE_SRC_PATH/*
  echo "PKG_FILE_NAME ${pkg_filename}"
  mv ${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}/sample-data ${pkg_prefix}/sample-data
}
