# Learn Git by Building an SQL 

Git is a version control system that keeps track of all the changes you make to your codebase.

In this 240-lesson course, you will learn how Git keeps track of your code by creating an object containing commonly used SQL commands.

git init

git status

You can create and go to a new branch with `git checkout -b new_branch`. The `-b` stands for "branch". Use that command to switch to a new branch named `main`.

git checkout -b main

-b stands for branch

git add file_name

Commit messages often start with `fix:` or `feat:`    `-m` stands for messsage

git commit -m “Initial commit” 

git log 

to see commit history logs

git log  —oneline

 You can see the changes you made with `git diff`

git diff

# BRANCHING

You only have the `main` branch still. You can create a branch with `git branch branch_name`. Branches often start with `fix/` or `feat/`, among others, like commit messages, but they use a forward slash and can't contain spaces. Create a new branch named `feat/add-create-table-reference`.

git branch feat/add-create-table-reference

# Merging

git merge branch_you_want_to_merge_from

# Delete branch

You can delete a branch with `git branch -d branch_name`. `-d` stands for "delete". Since your changes were added, you can safely delete your feature branch. Do that now.

# Rebase branch

 You need to `rebase` this branch against `main` to do that. Enter `git rebase main` to rebase this branch.

git rebase main

Another commit was added to `main`, you should update this branch again. To be more specific, a rebase will "rewind" this branch to where it last matched `main`, then, add the commits from `main` that aren't here. After that, it adds the commits you made to this branch on top. `rebase` this branch against `main` so it's up to date. You should see a conflict...

The conflict arose because the first commit you added to this branch changed the same lines as the commit from `main`. So it tried to add the commit, but couldn't because something was already there. There are sections, separated by characters (`<`, `>`, and `=`), that represent the commit you are on (`HEAD`) and the commit that is trying to be added (`feat: add column reference`). Fix the conflict by removing those `<`, `>`, and `=` characters. Then making the JSON object valid again.

There's been a mistake. This branch was for the insert

command, not the update command. You can put your changes aside with `git stash` . Stash your changes so you can add them to a different branch.

View the things you have stashed with `git stash list.`

`git stash list.`

git stash pop

git stash show

condensed form

View the full changes of the latest stash with `git stash show -p`. `-p` stands for "patch".

Now you can see the actual changes that are stored in the stash. Before, you used the pop command to remove the latest stash and add it to your working tree. 

You can add the latest stash while keeping it in the list with `git stash apply`. Apply your stash with this method.

Now there's two things stashed. You can use the name at the front of each stash (`stash@{#}`) with many of the stash commands to select one other than the latest one. The most recent stash is the one at the top, `stash@{0}`. View the condensed changes of the **oldest** stash with the `git stash show` command by putting the name of the stash after it.

stash@{0}: WIP on feat/add-insert-row-reference: 88989a2 feat: add insert row reference

 git stash show stash@{1} 

Next, using a similar method, **show** the full changes of the **oldest** stash with the "patch" flag you used earlier.

 git stash show stash@{1} -p

There's two identical items in your stash. Drop one of them with `git stash drop` or `git stash drop <stash_name>`.

Continue your rebase with the suggested command.

git rebase --continue

I'm going to show you a few ways to remove or undo a commit. The first is to simply "travel back in time". You can use the `git reset` command to travel to any point in your commit history. Your current `HEAD` is a reference to the last commit you just made. Use `git reset HEAD~1` to go back one before `HEAD`.

git reset HEAD~1

And the changes from the reset are back in the working tree. So when your `reset` to one commit before `HEAD`, it removed the most recent commit, and put all the changes in the working tree. If you used the `--hard` flag with the reset, the changes would have not been added to the working tree and if you used the `--soft` flag, the changes would have been added to the working tree and to staging. Add the changes back to staging so you can commit them again.

Reverting is a good way to undo a commit because you don't lose the commit from the history. You can revert the most recent commit (`HEAD`) with `git revert HEAD`. Do that now.

git revert head

Using revert to undo that commit added another commit that is the exact opposite of it. Enter

`git show` into the terminal to see the last commit added (now `HEAD`) and its details.

  git show HEAD~1

If you look at the bottom of those two messages, it shows the diff. The diff of the revert commit is the exact opposite of the one before it. Effectively, undoing the changes. You've used rebase to update this branch, but you can enter an "interactive" mode to manipulate commits. Type

`git rebase --interactive HEAD~2` into the terminal to enter this mode. The `HEAD~2` means you will have a chance to change the last two commits.

At the top of Nano, you can see the two commits with `pick` next to them. Below them, there's a list of options for working with them. `pick` means that it will use the commits as they were. At the bottom, it says, `d, drop = remove commit`. Replace the word `pick` preceeding your two commits with a `d` to drop them both. When you are done, save the file and exit Nano.

Both, the commit to add the unique command and the one to revert it, were dropped. Enter another`--interactive` rebase that goes back to the `--root` instead of `HEAD~2`. I am going to show you how to change a commit message. `--root` means that the rebase will go back to your very first commit

You can see that the latest commit is at the bottom here. Be careful not to change the wrong commits. One of the options is `r, reword = use commit, but edit the commit message`. Replace `pick` with an `r` next to the commit with the message `feat: add column reference` to reword the message, it's the very first commit you added to this branch. When you are done, save the file and exit Nano. Git will put you in another Nano instance to reword the commit message. Don't change anything in it yet.

The message was reworded, but there's a problem. Look at the commit hash for your Initial commit from the last two times you viewed the log, it's that string left of the log. They aren't the same anymore since you rebased back to the root. Same goes for the rest of the commits. When you rebase interactively it changes all those hashes, so git sees them as different commits. If you were to try and merge this into `main`, it wouldn't work because they don't share the same history anymore. For this reason, you don't want to do an interactive rebase where you go back passed commits unique to the branch you are on. Fortunately, you can fix this. Enter `git rebase main` to realign the history of the two branches

Now the hashes are the same as they were before you rebased back to `—root` , which is what they are on `main`. Enter another interactive rebase. Go back to the first commit you added to this branch, it's `HEAD~5`.

Squashing commits means that you will take a bunch of commits and turn them into one. This is helpful to keep your commit history clean and something you want try to do.

Replace `pick` with an `s` next to all your commits except the one with the message `feat: add column references`. When you are done, save and exit the file. You will find yourself in another instance of Nano. Don't change anything in it yet.

git log -1

You viewed the most recent log with a -1 flag. You can viewthe last `x` number of commits with any number instead of `1`. View the last five commits with the oneline flag.