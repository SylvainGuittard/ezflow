{set-block scope=global variable=title}{'Poll %pollname'|i18n('design/ezwebin/collectedinfo/poll',,hash('%pollname',$node.name|wash))}{/set-block}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-poll">
        <div class="poll-result">

    <div class="attribute-header">
        <a class="blackbuttonleft button" href={$node.url_alias|ezurl}>Poll</a>
        <h1>{'Results'|i18n( 'design/ezwebin/collectedinfo/poll' )}</h1>
    </div>

        {section show=$error}

        {section show=$error_anonymous_user}
        <div class="warning">
            <h2>{'Please log in to vote on this poll.'|i18n('design/ezwebin/collectedinfo/poll')}</h2>
        </div>
        {/section}

        {section show=$error_existing_data}
        <div class="warning">
            <h2>{'You have already voted for this poll.'|i18n('design/ezwebin/collectedinfo/poll')}</h2>
        </div>
        {/section}

        {/section}

        {section loop=$object.contentobject_attributes}
            {section show=$:item.contentclass_attribute.is_information_collector}
        	{let  attribute=$:item
        	      contentobject_attribute_id=cond( $attribute|get_class|eq( 'ezinformationcollectionattribute' ),$attribute.contentobject_attribute_id,
                                                   $attribute|get_class|eq( 'ezcontentobjectattribute' ),$attribute.id )
                  contentobject_attribute=cond( $attribute|get_class|eq( 'ezinformationcollectionattribute' ),$attribute.contentobject_attribute,
                                                $attribute|get_class|eq( 'ezcontentobjectattribute' ),$attribute )
                  total_count=fetch( 'content', 'collected_info_count', hash( 'object_attribute_id', $contentobject_attribute_id ) )
                  item_counts=fetch( 'content', 'collected_info_count_list', hash( 'object_attribute_id', $contentobject_attribute_id  ) ) }

                <h3>{$contentobject_attribute.content.name}</h3>

                <table class="poll-resultlist">
                <tr>

                {section name=Option loop=$contentobject_attribute.content.option_list}
                    {let item_count=0}
                    {section show=is_set($item_counts[$:item.id])}
                        {set item_count=$item_counts[$:item.id]}
                    {/section}
                    <td class="poll-resultname">
                        <p>
                            {$:item.value}
                        </p>
                    </td>

                    {let percentage = cond( $total_count|gt( 0 ), round( div( mul( $:item_count, 100 ), $total_count ) ), 0 )
                         tenth      = cond( $total_count|gt( 0 ), round( div( mul( $:item_count, 10 ), $total_count ) ), 0 )}
                    <td class="poll-resultbar">
                        <table class="poll-resultbar">
                        <tr>
                            <td class="poll-percentage">
                                <i>{$:percentage}%</i>
                            </td>
                            <td class="poll-votecount">
                                {'Votes'|i18n('design/ezwebin/collectedinfo/poll')}: {$:item_count}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            <div class="chart-bar-edge-start">
                                <div class="chart-bar-edge-end">
                                    <div class="chart-bar-resultbox">
                                        <div class="chart-bar-resultbar chart-bar-{$:percentage}-of-100 chart-bar-{$:tenth}-of-10" style="width: {$:percentage}%;">
                                            <div class="chart-bar-result-divider"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </td>
                        </tr>
                        </table>
                    </td>
                    {/let}
                    {/let}

                    {delimiter}
                </tr>
                <tr>
                    {/delimiter}

                {/section}
                </tr>
                </table>
            {/let}
            {section-else}
                {section show=$attribute_hide_list|contains($:item.contentclass_attribute.identifier)|not}
                    <div class="attribute-short">{attribute_view_gui attribute=$:item}</div>
                {/section}
            {/section}
        {/section}

        <br/>

        {"%count total votes"|i18n( 'design/ezwebin/collectedinfo/poll' ,,
                                     hash( '%count', fetch( content, collected_info_count, hash( object_id, $object.id ) ) ) )}

        </div>
    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>