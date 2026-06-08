Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E54329396
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921798; cv=none; b=J/mNrWq0TDr0YIwPtr8SfpCw+EBs73LdxeyOj9lkf1LRqZmFBDeTaXI7SggfbWKxygukQ87HrpLGBxJbF0/RQ+2g5oG2CuhpK4hKE0S99a2UofSHc28iMJLGoXAVJ1UWA5QPhyHEW6/4Wt2+faYA+iXAIETSGFPzxec8Jnv8tXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921798; c=relaxed/simple;
	bh=ANGn6rs0yhDXw2n+hTfHlll77cRn3Gb04giF2Uy06iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCUiixL9Yq5UBYUe64AZW6LBGRAhDa1Mbx8wh6BDVSL0G+rweqRnwunOtF4ng6Evypr1KJbmhoinm1UDOA3TAtvGV8B2h24TKMWSz5LyrtqrVGdzr/KVz0u8Cumt4ek6ZYMGcd838dMADPG0thVP8RaZJ5X7cYZAbr13n6SXwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrACXdwyntSZq4WgYAA--.18145S2;
	Mon, 08 Jun 2026 20:29:27 +0800 (CST)
Received: from [10.12.169.28] (unknown [10.12.169.28])
	by gateway (Coremail) with SMTP id _____wDXD+qltSZqI1wCAA--.3812S2;
	Mon, 08 Jun 2026 20:29:26 +0800 (CST)
Message-ID: <deeb7c45-3353-4696-9d86-b2f23763fd9e@hust.edu.cn>
Date: Mon, 8 Jun 2026 20:29:26 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] docs/zh_CN: update DAMON usage Chinese translation
To: Doehyun Baek <doehyunbaek@gmail.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 SeongJae Park <sj@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, damon@lists.linux.dev
References: <20260523094420.741003-1-doehyunbaek@gmail.com>
 <20260608065745.1587885-1-doehyunbaek@gmail.com>
 <20260608065745.1587885-2-doehyunbaek@gmail.com>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20260608065745.1587885-2-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrACXdwyntSZq4WgYAA--.18145S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvAXoW3urW7tr1UWr1xZFyUGr48WFg_yoW8Cr4xuo
	WUurW3Aw1DJr1fJry8tr47Jr4kJrnrCr4jy3y3Xr1DGr47XFn5WF4UtwsxJw13tr43Jr4U
	tr15tw15Awn7J3WUn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOy7k0a2IF6w4kM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
	0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
	IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04
	k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUvYsjDUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 6/8/26 2:57 PM, Doehyun Baek wrote:
> Update the translation of .../admin-guide/mm/damon/usage.rst into Chinese.
>
> Update the translation through commit d9cfe515d36e
> ("Docs/admin-guide/mm/damon/usage: document goal_tuner sysfs file")
>
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>

 From my experience, you need to double check your patched translation 
with the original English documentation. This will make sure your 
translation matches the latest documenation.

Dongliang Mu

> ---
>   .../zh_CN/admin-guide/mm/damon/usage.rst      | 92 +++++++++++++------
>   1 file changed, 65 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
> index 9d7cb51be493..4a31210b948e 100644
> --- a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
> @@ -15,6 +15,10 @@
>   
>   DAMON 为不同的用户提供了下面这些接口。
>   
> +- *专用DAMON模块。*
> +  :ref:`这 <damon_modules_special_purpose>` 是为构建、发布或管理带有专用DAMON用法的内
Please change to the reference in the Chinese translation. And double 
check all the references.
> +  核的用户准备的。使用它，用户可以在构建、启动或运行时以简单的方式为给定目的使用DAMON的主要
> +  功能。
>   - *DAMON用户空间工具。*
>     `这 <https://github.com/damonitor/damo>`_ 为有这特权的人， 如系统管理员，希望有一个刚好
>     可以工作的人性化界面。
> @@ -55,30 +59,37 @@ DAMON sysfs接口的文件层次结构如下图所示。在下图中，父子关
>   

|.. parsed-literal:: :ref:`/sys/kernel/mm/damon <sysfs_root>`/admin │ 
:ref:`kdamonds <sysfs_kdamonds>`/nr_kdamonds │ │ :ref:`0 
<sysfs_kdamond>`/state,pid,refresh_ms │ │ │ :ref:`contexts 
<sysfs_contexts>`/nr_contexts │ │ │ │ :ref:`0 
<sysfs_context>`/avail_operations,operations,addr_unit │ │ │ │ │ 
:ref:`monitoring_attrs <sysfs_monitoring_attrs>`/ │ │ │ │ │ │ 
intervals/sample_us,aggr_us,update_us │ │ │ │ │ │ │ 
intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us │ │ │ │ │ │ 
nr_regions/min,max │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets │ 
│ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target,obsolete_target │ │ │ │ │ │ 
│ :ref:`regions <sysfs_regions>`/nr_regions │ │ │ │ │ │ │ │ :ref:`0 
<sysfs_region>`/start,end │ │ │ │ │ │ │ │ ... │ │ │ │ │ │ ... │ │ │ │ │ 
:ref:`schemes <sysfs_schemes>`/nr_schemes │ │ │ │ │ │ :ref:`0 
<sysfs_scheme>`/action,target_nid,apply_interval_us │ │ │ │ │ │ │ 
:ref:`access_pattern <sysfs_access_pattern>`/ │ │ │ │ │ │ │ │ sz/min,max 
│ │ │ │ │ │ │ │ nr_accesses/min,max │ │ │ │ │ │ │ │ age/min,max │ │ │ │ 
│ │ │ :ref:`quotas 
<sysfs_quotas>`/ms,bytes,reset_interval_ms,effective_bytes,goal_tuner │ 
│ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil │ │ │ │ │ 
│ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals │ │ │ │ │ │ │ │ 
│ 0/target_metric,target_value,current_value,nid,path │ │ │ │ │ │ │ 
:ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low │ │ 
│ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters │ │ │ │ 
│ │ │ │ 
0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max 
│ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests │ │ │ │ │ │ │ │ 
0/id,weight │ │ │ │ │ │ │ :ref:`stats 
<sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots 
│ │ │ │ │ │ │ :ref:`tried_regions 
<sysfs_schemes_tried_regions>`/total_bytes │ │ │ │ │ │ │ │ 
0/start,end,nr_accesses,age,sz_filter_passed │ │ │ │ │ │ │ │ ... │ │ │ │ 
│ │ ... │ │ │ │ ... │ │ ... |



This part changes a lot. Please take a look the original English 
documentation.


>       /sys/kernel/mm/damon/admin
>       │ kdamonds/nr_kdamonds
> -    │ │ 0/state,pid
> +    │ │ 0/state,pid,refresh_ms
>       │ │ │ contexts/nr_contexts
> -    │ │ │ │ 0/operations
> +    │ │ │ │ 0/avail_operations,operations,addr_unit
>       │ │ │ │ │ monitoring_attrs/
>       │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
> +    │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
>       │ │ │ │ │ │ nr_regions/min,max
>       │ │ │ │ │ targets/nr_targets
> -    │ │ │ │ │ │ 0/pid_target
> +    │ │ │ │ │ │ 0/pid_target,obsolete_target
>       │ │ │ │ │ │ │ regions/nr_regions
>       │ │ │ │ │ │ │ │ 0/start,end
>       │ │ │ │ │ │ │ │ ...
>       │ │ │ │ │ │ ...
>       │ │ │ │ │ schemes/nr_schemes
> -    │ │ │ │ │ │ 0/action
> +    │ │ │ │ │ │ 0/action,target_nid,apply_interval_us
>       │ │ │ │ │ │ │ access_pattern/
>       │ │ │ │ │ │ │ │ sz/min,max
>       │ │ │ │ │ │ │ │ nr_accesses/min,max
>       │ │ │ │ │ │ │ │ age/min,max
> -    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
> +    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms,effective_bytes,goal_tuner
>       │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
> +    │ │ │ │ │ │ │ │ goals/nr_goals
> +    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid,path
>       │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
> -    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
> -    │ │ │ │ │ │ │ tried_regions/
> -    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
> +    │ │ │ │ │ │ │ {core_,ops_,}filters/nr_filters
> +    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
> +    │ │ │ │ │ │ │ dests/nr_dests
> +    │ │ │ │ │ │ │ │ 0/id,weight
> +    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
> +    │ │ │ │ │ │ │ tried_regions/total_bytes
> +    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
>       │ │ │ │ │ │ │ │ ...
>       │ │ │ │ │ │ ...
>       │ │ │ │ ...
> @@ -104,7 +115,8 @@ kdamonds/
>   kdamonds/<N>/
>   -------------
>   
> -在每个kdamond目录中，存在两个文件（``state`` 和 ``pid`` ）和一个目录( ``contexts`` )。
> +在每个kdamond目录中，存在三个文件（``state``、``pid`` 和 ``refresh_ms``）和一个目录
> +(``contexts``)。
>   
>   读取 ``state`` 时，如果kdamond当前正在运行，则返回 ``on`` ，如果没有运行则返回 ``off`` 。
>   写入 ``on`` 或 ``off`` 使kdamond处于状态。向 ``state`` 文件写 ``update_schemes_stats`` ，
> @@ -117,6 +129,10 @@ kdamonds/<N>/
>   
>   如果状态为 ``on``，读取 ``pid`` 显示kdamond线程的pid。
>   
> +用户可以要求内核通过 ``refresh_ms`` 文件周期性地更新显示自动调优参数和DAMOS统计信息的文件。
> +向该文件写入希望的更新时间间隔（毫秒）。如果间隔为零，则禁用周期性更新。读取该文件会显示当前
> +设置的时间间隔。
> +
>   ``contexts`` 目录包含控制这个kdamond要执行的监测上下文的文件。
>   
>   kdamonds/<N>/contexts/
> @@ -129,15 +145,19 @@ kdamonds/<N>/contexts/
>   contexts/<N>/
>   -------------
>   
> -在每个上下文目录中，存在一个文件(``operations``)和三个目录(``monitoring_attrs``,
> -``targets``, 和 ``schemes``)。
> +在每个上下文目录中，存在三个文件（``avail_operations``、``operations`` 和
> +``addr_unit``）和三个目录（``monitoring_attrs``、``targets`` 和 ``schemes``）。
>   
> -DAMON支持多种类型的监测操作，包括对虚拟地址空间和物理地址空间的监测。你可以通过向文件
> -中写入以下关键词之一，并从文件中读取，来设置和获取DAMON将为上下文使用何种类型的监测操作。
> +DAMON支持多种类型的监测操作，包括对虚拟地址空间和物理地址空间的监测。你可以通过读取
> +``avail_operations`` 文件获取可用的监测操作集列表。你可以通过向 ``operations`` 文件中写入
> +``avail_operations`` 文件列出的关键词之一，并从文件中读取，来设置和获取DAMON将为上下文使用
> +何种类型的监测操作。
>   
>    - vaddr: 监测特定进程的虚拟地址空间
>    - paddr: 监视系统的物理地址空间
>   
> +``addr_unit`` 文件用于设置和获取操作集的 :ref:`地址单位 <damon_design_addr_unit>` 参数。
> +
>   contexts/<N>/monitoring_attrs/
>   ------------------------------
>   
> @@ -161,11 +181,15 @@ contexts/<N>/targets/
>   targets/<N>/
>   ------------
>   
> -在每个目标目录中，存在一个文件(``pid_target``)和一个目录(``regions``)。
> +在每个目标目录中，存在两个文件（``pid_target`` 和 ``obsolete_target``）和一个目录
> +（``regions``）。
>   
>   如果你把 ``vaddr`` 写到 ``contexts/<N>/operations`` 中，每个目标应该是一个进程。你
>   可以通过将进程的pid写到 ``pid_target`` 文件中来指定DAMON的进程。
>   
> +用户可以向 ``obsolete_target`` 文件写入非零值并提交它（向 ``state`` 文件写入 ``commit``），
> +从目标数组中间选择性地删除目标。

This is the original English text.

Users can selectively remove targets in the middle of the targets array by
writing non-zero value to ``obsolete_target``file and committing it (writing
``commit``to ``state``file). DAMON will remove the matching targets from its
internal targets array. Users are responsible to construct target 
directories
again, so that those correctly represent the changed internal targets array.

You missed many translations.

> +
>   targets/<N>/regions
>   -------------------
>   
> @@ -203,8 +227,9 @@ contexts/<N>/schemes/
>   schemes/<N>/
>   ------------
>   
> -在每个方案目录中，存在五个目录(``access_pattern``、``quotas``、``watermarks``、
> -``stats`` 和 ``tried_regions``)和一个文件(``action``)。
> +在每个方案目录中，存在九个目录（``access_pattern``、``quotas``、``watermarks``、
> +``core_filters``、``ops_filters``、``filters``、``dests``、``stats`` 和
> +``tried_regions``）和三个文件（``action``、``target_nid`` 和 ``apply_interval_us``）。

Here I found a typo in the English documenation. The directory should be 
nine other than 8.

The correct order is to first submit a patch to fix this typo. Then this 
translation is correct. And this patch should be merged after the typo 
fix. @Jon, am I right?

>   
>   ``action`` 文件用于设置和获取你想应用于具有特定访问模式的内存区域的动作。可以写入文件
>   和从文件中读取的关键词及其含义如下。
> @@ -218,6 +243,9 @@ schemes/<N>/
>    - ``lru_deprio``: 对区域的LRU列表进行降低优先处理。
>    - ``stat``: 什么都不做，只计算统计数据
>   
> +``target_nid`` 文件用于设置迁移目标节点，仅当 ``action`` 为 ``migrate_hot`` 或
> +``migrate_cold`` 时有意义。``apply_interval_us`` 文件用于以微秒为单位设置和获取方案的应用间隔。
> +

"``apply_interval_us`` 文件用于以微秒为单位设置和获取方案的应用间隔。" is in a separate paragraph.

>   schemes/<N>/access_pattern/
>   ---------------------------
>   
> @@ -239,14 +267,20 @@ schemes/<N>/quotas/
>   当预计超过配额限制时，DAMON会根据 ``目标访问模式`` 的大小、访问频率和年龄，对找到的内存区域
>   进行优先排序。为了进行个性化的优先排序，用户可以为这三个属性设置权重。
>   
> -在 ``quotas`` 目录下，存在三个文件（``ms``, ``bytes``, ``reset_interval_ms``）和一个
> -目录(``weights``)，其中有三个文件(``sz_permil``, ``nr_accesses_permil``, 和
> -``age_permil``)。
> +在 ``quotas`` 目录下，存在五个文件（``ms``、``bytes``、``reset_interval_ms``、
> +``effective_bytes`` 和 ``goal_tuner``）和两个目录（``weights`` 和 ``goals``）。
>   
>   你可以设置以毫秒为单位的 ``时间配额`` ，以字节为单位的 ``大小配额`` ，以及以毫秒为单位的 ``重
>   置间隔`` ，分别向这三个文件写入数值。你还可以通过向 ``weights`` 目录下的三个文件写入数值来设
>   置大小、访问频率和年龄的优先权，单位为千分之一。
>   
> +你可以通过向 ``goal_tuner`` 文件写入算法名称，设置要使用的基于目标的有效配额自动调优算法。
> +读取该文件会返回当前选定的调优器算法。读取 ``effective_bytes`` 会返回当前有效大小配额。
> +
> +``goals`` 目录用于设置自动配额调优目标。每个目标目录包含 ``target_metric``、
> +``target_value``、``current_value``、``nid`` 和 ``path`` 文件。用户可以读写这些文件来设置
> +和获取配额自动调优目标的参数。

You can set the goal-based effective quota auto-tuning algorithm to use, by
writing the algorithm name to ``goal_tuner`` file.  Reading the file returns
the currently selected tuner algorithm.  Refer to the design documentation of
:ref:`automatic quota tuning goals <damon_design_damos_quotas_auto_tuning>` for
the background design of the feature and the name of the selectable algorithms.
Refer to :ref:`goals directory <sysfs_schemes_quota_goals>` for the goals
setup.

The above is the original English text. It seems your translation does 
not match it.

> +
>   schemes/<N>/watermarks/
>   -----------------------
>   
> @@ -271,16 +305,21 @@ schemes/<N>/stats/
>   DAMON统计每个方案被尝试应用的区域的总数量和字节数，每个方案被成功应用的区域的两个数字，以及
>   超过配额限制的总数量。这些统计数据可用于在线分析或调整方案。
>   
> -可以通过读取 ``stats`` 目录下的文件(``nr_tried``, ``sz_tried``, ``nr_applied``,
> -``sz_applied``, 和 ``qt_exceeds``)）分别检索这些统计数据。这些文件不是实时更新的，所以
> -你应该要求DAMON sysfs接口通过在相关的 ``kdamonds/<N>/state`` 文件中写入一个特殊的关键字
> -``update_schemes_stats`` 来更新统计信息的文件内容。
> +可以通过读取 ``stats`` 目录下的文件（``nr_tried``、``sz_tried``、``nr_applied``、
> +``sz_applied``、``sz_ops_filter_passed``、``qt_exceeds``、``nr_snapshots`` 和
> +``max_nr_snapshots``）分别检索这些
> +统计数据。这些文件默认不是实时更新的。你应该要求DAMON sysfs接口通过 ``refresh_ms`` 周期性地
> +更新这些文件，或者通过在相关的 ``kdamonds/<N>/state`` 文件中写入一个特殊的关键字
> +``update_schemes_stats`` 来执行一次性更新。
>   
>   schemes/<N>/tried_regions/
>   --------------------------
>   
> +该目录开始时有一个文件 ``total_bytes``。
> +
>   当一个特殊的关键字 ``update_schemes_tried_regions`` 被写入相关的 ``kdamonds/<N>/state``
> -文件时，DAMON会在这个目录下创建从 ``0`` 开始命名的整数目录。每个目录包含的文件暴露了关于每个
> +文件时，DAMON会更新 ``total_bytes`` 文件，使读取该文件返回方案尝试区域的总大小，并在这个目录下
> +创建从 ``0`` 开始命名的整数目录。每个目录包含的文件暴露了关于每个
>   内存区域的详细信息，在下一个 :ref:`聚集区间 <sysfs_monitoring_attrs>`，相应的方案的 ``动作``
>   已经尝试在这个目录下应用。这些信息包括地址范围、``nr_accesses`` 以及区域的 ``年龄`` 。
>   
> @@ -290,9 +329,8 @@ schemes/<N>/tried_regions/
>   tried_regions/<N>/
>   ------------------
>   
> -在每个区域目录中，你会发现四个文件(``start``, ``end``, ``nr_accesses``, and ``age``)。
> -读取这些文件将显示相应的基于DAMON的操作方案 ``动作`` 试图应用的区域的开始和结束地址、``nr_accesses``
> -和 ``年龄`` 。
> +在每个区域目录中，你会发现五个文件（``start``、``end``、``nr_accesses``、``age`` 和
> +``sz_filter_passed``）。读取这些文件将显示相应的基于DAMON的操作方案 ``动作`` 试图应用的区域属性。
>   
>   用例
>   ~~~~

