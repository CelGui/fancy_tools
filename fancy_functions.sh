function gco
{
    #In Project git repository
    in_git="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

    if [[ $in_git == "true" ]]
    then

        if [[ $# < 1 ]]
        then
            echo "Error! Commit message missing"
            echo "Add Commit message after gco "
        else
            echo "In a git repository"
            echo " "

            #Verifying current branch
            branch="$(git rev-parse --abbrev-ref HEAD)"
            echo "On branch $current_branch"
            echo " "
            git commit -m "[$branch] $*"
            echo "Commit msg = [$branch] $*"
        fi

    else
        echo "Error! This is not a git repository"
    fi
}
