@echo off

git --version
if  ERRORLEVEL 1 goto git-error

echo "Create folder %cd%/bundle"
md "%cd%/bundle"

echo "Clone Vundle.vim...."
git clone https://github.com/gmarik/Vundle.vim.git %cd%/bundle/Vundle.vim

goto ok

:git-error
echo "Please install git first."
goto end

:ok
echo "OK, open you vim, and take :PluginInstall"

:end
