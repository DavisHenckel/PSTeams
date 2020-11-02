﻿function New-AdaptiveAction {
    [cmdletBinding()]
    param(
        [scriptblock] $Body,
        [scriptblock] $Actions,
        [ValidateSet('Action.ShowCard', 'Action.Submit', 'Action.OpenUrl', 'Action.ToggleVisibility')][string] $Type = 'Action.ShowCard',
        [string] $ActionUrl,
        [string] $Title
    )
    $TeamObject = [ordered] @{
        type  = $Type
        title = $Title
        url   = $ActionUrl
        card  = [ordered]@{}
    }
    if ($Body -or $Actions) {
        $TeamObject['card']['type'] = 'AdaptiveCard'
        if ($Body) {
            $TeamObject['card']['body'] = & $Body
        }
        if ($Actions) {
            $TeamObject['card']['actions'] = & $Actions
        }
    }
    Remove-EmptyValue -Hashtable $TeamObject
    $TeamObject
}