To make an ISO image suitable for installing on the basestation please follow the steps below.

1. Get all of the recent packages from the release repository:

    sudo ./fetch

2. Check that the release list for the basestation is correct:

    sudo ./repocheck release basestation-release.yaml --path install_dev1/pr2-packages --gen 0.8.6

3. Confirm everything works

    sudo ./verifyinstaller

4. Make the installer into an ISO. Release num of the currently deployed basestation ISO is 8 and the build number is whatever build we're currently at on the Jenkins farm. If you're making your own custom basestation, put in whatever you want.

    sudo ./createiso.sh basestation-${RELEASE_NUM}.${BUILD_NUMBER}.iso


