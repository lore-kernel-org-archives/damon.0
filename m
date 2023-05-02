Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770C622
	for <damon@lists.linux.dev>; Tue,  2 May 2023 01:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E46CC433EF;
	Tue,  2 May 2023 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682990862;
	bh=1lfG7N0xynxHpyMOtx9RCUa6Rg91lUAThOYSp1xJdn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLwYUw0f8f1zyNqSL5lulev64XYpTHOR9/JQI+siM/T6nUYe6MOfRNSTWBqGpOlDI
	 rOT2BHzlBsCROFgxx+egKjosrx3pSmxqLtChLwj4t6+REVPcUsAAG3wbq4IbDRMw8L
	 EgU7AUG9OXp/Sw7rEAmywqtI0adLCyvWu93o+RnU6w4Iea9iV1XOi2FYfSXLboTUbG
	 ByPoMg719ORIR79PtK2TQUL9v+mfjPcfbswJbN4r5hsBT8g3tBCyS0d8i4KpYJqsYB
	 vMsZ5fx4kXN7GKgNtw1SylFLlKyPThjuf9lvnBMqImhEgviZwesNnMQGcVRT0REp+8
	 7FnvkEvhj5bcA==
From: SeongJae Park <sj@kernel.org>
To: Grzegorz Uriasz <gorbak25@gmail.com>
Cc: damon@lists.linux.dev,
	dutkahugo@gmail.com
Subject: Re: What kind of memory is DAMON RECLAIM able to free?
Date: Tue,  2 May 2023 01:27:40 +0000
Message-Id: <20230502012740.150413-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c3086fc3-f33c-4eb5-db1e-9dec731aeede@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Grzegorz,

On Fri, 28 Apr 2023 16:15:12 +0200 Grzegorz Uriasz <gorbak25@gmail.com> wrote:

> Hi!
> 
> I'm running some experiments using DAMON RECLAIM on the 6.2 kernel. I've 
> set up an VM with free page reporting enabled with 16 vcores and 16GB of 
> ram with very aggressive memory reclamation settings, my kernel boot 
> line includes:
> - transparent_hugepage=never
> - page_reporting.page_reporting_order=0
> - damon_reclaim.enabled=Y
> - damon_reclaim.min_age=10000000
> - damon_reclaim.wmarks_low=0
> - damon_reclaim.wmarks_mid=999
> - damon_reclaim.wmarks_high=1000
> - damon_reclaim.quota_sz=1073741824
> - damon_reclaim.quota_reset_interval_ms=1000
> 
> The memory usage of the VM starts at 800 MB, after running some 
> workloads and ballooning the VM to 16 GB DAMON RECLAIM was able to 
> quickly bring the memory usage back down to 3GB, after which it just 
> stopped doing anything. What concerns me is that 20%(3.2GB for that VM) 
> is the default low watermark in the DAMON RECLAIM module. I've verified 
> that the watermarks were properly set in sysfs to my custom values, but 
> it doesn't seem to affect anything as free -mh shows 400Mb for apps but 
> 2.6GB for caches/buffers. The VM besides idling for a very long time 
> isn't able to free the buffers. When dropping the caches manually using 
> /proc/sys/vm/drop_caches the memory usage returns back to the starting 
> one. The cache/buffers don't increase at all after dropping them 
> indicating that this memory was indeed idling.

Thank you for sharing your great experience and questions!

> 
> My questions:
> 1. Are there types of freeable memory which DAMON is not allowed to touch?

Basically there is no such limitation.  We implemented page type of cgroups
based DAMOS filtering feature in v6.3, but as you're using v6.2, it shouldn't
be related with your use case.

One possible limitation for this case might be the monitoring region.  You can
specify the region to monitor and reclaim using `monitor_region_{start,end}`
parameters.  By default, it's set to biggest System RAM.  If your system is
having non-countinuous System RAMs and the biggest one is not covering the 3GiB
region, the 3GiB regions will not be moitored and therefore not reclaimed.

Can you check if it is excluding the 3GiB region?  You may be able to get it
using `proc/iomem` like files.  You could also refer to DAMON user-space tool
to show its usage of the file[1].

Also, you could get DAMON_RECLAIM internal statistics[2].  Checking those could
also provide some hints, or help excluding unnecessary suspects.

> 2. What prevents DAMON from getting back the memory?

Other than quotas, watermarks and access pattern, there should be nothing
preventing DAMON_RECLAIM reclaiming memory on v6.2 kernel.  DAMOS filters could
also make some effect, but as mentioned-above, it's available from v6.3.

> 2. /sys/kernel/debug/damon/* seems separate from DAMON RECLAIM, 
> /sys/module/damon_reclaim/parameters/kdamond_pid shows DAMON RECLAIM is 
> running but the DAMON debugfs doesn't show it nor exposes any registered 
> reclamation schemes.

You're correct.  DAMON provides two main user interfaces, via debugfs
(/sys/kernel/debug/damon/) and sysfs (/sys/kernel/mm/damon/).  Those are for
fine-controlled use of all DAMON capabilities.  Btw, the debugfs interface is
deprecated now, so please use the sysfs interface.

DAMON modules like DAMON_RECLAIM and DAMON_LRU_SORT are for simpler control of
DAMON for only special purpose system-wide utilization, like proactive reclaim
and LRU lists manipulation.  Those hence provide simpler module parameters
interface.


[1] https://github.com/awslabs/damo/blob/next/_damo_paddr_layout.py
[2] https://docs.kernel.org/admin-guide/mm/damon/reclaim.html#nr-reclaim-tried-regions


Thanks,
SJ

> 
> Best Regards,
> Grzegorz Uriasz
