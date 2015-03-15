#!/bin/bash
set -x
set -e

rake spec
rake quality
git push staging master
rake smoke:staging
git push production master
rake smoke:production
