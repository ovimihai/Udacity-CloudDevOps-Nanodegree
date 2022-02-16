
#sudo yum install python3

# this diddn't run ok directly from here
python3 -m venv venv

source venv/bin/activate

pip install --upgrade pip
pip install pylint
pip install black


pip install pytestpip install ipython