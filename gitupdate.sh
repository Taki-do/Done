echo "Your git project will be updated in a few seconds"
read -p "Give your folder name that need to be updated: " name
read -p "Name your commit : " commit
cd $name/
git add *
git commit -m "$commit"
git push