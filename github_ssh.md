# How to set up SSH for GitHub

## [Checking for existing SSH keys](https://help.github.com/articles/checking-for-existing-ssh-keys/#platform-linux)

* Check `~/.ssh` folder to see if there are already public and private keys to
use.

  ```
  ls -al ~/.ssh
  ```

* If there's no existing public and private
key pair to use, then [generate a new SSH
key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#platform-linux).

  * Generate a new ssh key.

    ```
    ssh-keygen -t rsa -b 4096 -C "<github email>"
    ```
  * Start the ssh-agent in the background.

    ```
    eval "$(ssh-agent -s)"
    ```

  * Add SSH private key to the ssh-agent.

    ```
    ssh-add ~/.ssh/<private key name, usually id_rsa>
    ```

* [Add the SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/#platform-linux)

  * Copy the SSH key to your clipboard.

    ```
    xclip -sel clip < ~/.ssh/<public key name, usually id_rsa.pub>
    ```

  * **Add SSH key** in Github Settings.
