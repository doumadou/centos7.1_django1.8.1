#!/bin/bash
set -e
yum install -y mysql-devel mysql
yum install -y MySQL-python
yum install -y gcc python-devel
[ -f get-pip.py ] || (yum install -y wget ;wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py)
python get-pip.py
if [ $? ! -eq 0 ];then
	pip_url=https://pypi.python.org/packages/source/p/pip/pip-7.0.1.tar.gz
	pip_pkg=`basename $pip_url`
	if [ ! -f $pip_pkg ];then
		yum install -y wget
		wget $pip_url
	fi
	
	tar vxf $pip_pkg && cd ${pip_pkg%%.tar.gz} && python setup.py install
fi

pip install -r ./requirements.txt

yum install -y unixODBC postgresql-libs #unixODBC-devel

if [ ! -f sphinx-2.2.9-1.rhel7.x86_64.rpm ]; then
wget http://sphinxsearch.com/files/sphinx-2.2.9-1.rhel7.x86_64.rpm
fi
rpm -ivh sphinx-2.2.9-1.rhel7.x86_64.rpm
