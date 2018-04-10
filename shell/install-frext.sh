# This script is intended to checkout latest version of "reach-frext" and deploy it to
# local maven by calling "gradle clean publishToMavenLocal". However, it does not perform 
# as expected (at least on my computer). When "publishToMavenLocal" is called it builds successfully 
# but does not deploy to local maven repository. The script is useless until the problem is solved. 


# First shell parameter determines whether the dependencies should be created inside or outside of 
# project. They are created outside by default.
if [ $1 == "IN" ]; then
  echo "Dependencies folder will be created inside the project"
  DEPENDENCIES_PATH="../dependencies"
else
  echo "Dependencies folder will be created outside of the project"
  DEPENDENCIES_PATH="$PWD/../../FriesToFrextDependencies"
fi

FREXT_SUBPATH="reach-frext"
FREXT_URL="https://github.com/metincansiper/reach-frext.git"
FREXT_PATH="$DEPENDENCIES_PATH/$FREXT_SUBPATH"
if [ ! -d $DEPENDENCIES_PATH ]; then
  mkdir -p $DEPENDENCIES_PATH
fi

if [ -d $FREXT_PATH ]; then
  cd $FREXT_PATH && git pull
else
  cd $DEPENDENCIES_PATH && git clone $FREXT_URL && cd $FREXT_SUBPATH
fi

git checkout maven-publish

sudo gradle clean publishToMavenLocal