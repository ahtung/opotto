#!/bin/bash
set -x
set -e

rake quality
rake spec
git push staging master
rake smoke:staging
git push production master
rake smoke:production
