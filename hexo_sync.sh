MESSAGE=$1

hexo clean

#Generate public files
hexo g
#Deploy to wangding.github.io
hexo d

#Clean Public files
hexo clean

#Push to github
git ca -m $1
git push origin master
