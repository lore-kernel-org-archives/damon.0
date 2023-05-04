Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDB79D2
	for <damon@lists.linux.dev>; Thu,  4 May 2023 17:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4ECC433EF;
	Thu,  4 May 2023 17:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683220670;
	bh=BZ/lcFLTr8T1mBORx/2RawOxVXKIdTpB2+V5RzClqj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u42Tt+5F77pDITN7MEHPV27pjSxiI+Uk06TQdNHgYaL48BCXoLZk3YqPr5LyPlm3f
	 SeDEAky5MlK/noAb2j8/suiWHGDB412xoHdnm0HtqbtGuPU7M2h49qpbwbQgCGqUME
	 BiOwt1bjQo7gFjRUg8wOph3eHOhB20e8Q0kiVbx8JkZixRFksPFUhZeFjBtaYJ79EL
	 pdIqOUUKt1xsB3pKLYXmOGyFoqR9eEAAJlwy7rL+G8VCMMtmzP2OLNzUZybHzZ9v/T
	 K6lHUADXV5E2POd2Er6Kz2S+JTJ0zbcvBKxsvmDQHau8kEbV0Uz+ssEJUryn1XIQJa
	 rsK5QgzuAIGHg==
From: SeongJae Park <sj@kernel.org>
To: Grzegorz Uriasz <gorbak25@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	dutkahugo@gmail.com
Subject: Re: What kind of memory is DAMON RECLAIM able to free?
Date: Thu,  4 May 2023 17:17:49 +0000
Message-Id: <20230504171749.89225-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <29e96910-a068-3201-fa77-fb715ffca36f@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Grzegorz,

On Thu, 4 May 2023 15:47:25 +0200 Grzegorz Uriasz <gorbak25@gmail.com> wrote:

> Hi SeongJae,
> 
> /* I apologize for the duplicate email but damon@lists.linux.dev 
> rejected my previous message due to embedded pictures, moved the 
> screenshots to imgur ;) */

No problem, thank you for patiently posting again :)

Seems the screenshots are showing only text outputs.  Maybe you could simply
copy-paste those into the mail body later if you want to avoid uploading it to
imgur separately.

> 
> Thank you for your help and providing us a link to the DAMON user space 
> tools, they are very helpful.
> I've checked the memory regions and indeed there was a 3GB RAM region 
> besides the largest system ram(https://imgur.com/a/q8gdV8b).
> 
> After setting the start of the monitoring region to 0 DAMOS RECLAIM 
> suddenly became more responsive and ram reclamation became more 
> immediate and useful. Unfortunately there is still something which holds 
> DAMOS RECLAIM back.
> 
> I've changed the memory region to start from 0 and ran the same workload 
> as before, Damon was able to reclaim 1GB more ram compared to my 
> previous tests, unfortunately this still leaves 2GB's of unused RAM in 
> the caches :( Like before after dropping the caches the cache usage 
> never grows indicating the ram was idling. I've also checked that after 
> rising the amount of monitoring regions in DAMON_RECLAIM from 10 to 100 
> the reclamation became more effective, DAMON_RECLAIM was able to reclaim 
> 0.4GB more than in the last test, but this still left 1.6GB of 
> reclaimable ram overall(https://imgur.com/a/FHww4XA).

Thank you for sharing your great experiments results!

> 
> My questions:
> 1) What is holding DAMOS RECLAIM back?

Currently, DAMON utilizes its own monitoring accuracy-overhead tradeoff
mechanism, namely Region Based Sampling[1] and Adaptive Regions Adjustment[2].
I guess DAMON is not showing the remaining 1.6GB as cold enough to be
reclaimed, due to the traded accuracy.

You can increase the accuracy as a cost of increased monitoring overhead by
increasing the {min,max}_nr_accesses.  I think this explains why you shown
DAMON_RECLAIM reclaiming 0.4GB more memory after you increased min_nr_regions
from 10 to 100.  This also explains why dropping cache reclaimed 1.6GB more
memory.  Cache dropping and page fault-driven memory population works in page
granularity, so could be more accurate than DAMON in general.

In detail, no entire page would be idle on the system.  Based on the second
screenshot, we can assume at least the 97MB of buff/cache memory could be
assumed to be still accesses.  My hopotheses is that the pages for the 97MB
memory are quite evenly spread in the DAMON_RECLAIM unreclaiming 2GB memory.
In the case, because DAMON works in region-based sampling[1], it will
occasionally pick one of the 97MB pages as the page to sample access, and
conclude the 2GB region is accessed.

For more detail, let's assume the pages are really evenly distributed, and the
pages are accessed at least once per the DAMON's sampling interval, which is
5ms by default.  Then, for about 1/20 (97MB / 2GB) times of sampling, one of
the pages are picked as sample page.  DAMON aggregates the sampling results for
its aggregation interval, which is 100ms, so do 20 repeated sampling.  So for
every aggregation interval, DAMON shows the region is having at least one
sample saying it was accessed.  So it conclude the 2GB regions is accessed at
least once per the 20 samples, and doesn't reclaim the entire 2GB region.

You may further increase the {min,max}_nr_regions to increase DAMON accuracy
and hence reclaim more memory.  Note that it will also increase the monitoring
overhead.  IF you even increase the numbers to 'your system memory / page
size', DAMON will do the monitoring in page granularity[3], so may provide the
best accuracy same to that of cache dropping.

One possible way for reclaiming more memory while keeping the overhead lower
would be finding memory regions that DAMON is still thinking hot, and setting
the monitoring region to only the region, and continuously
dividing-and-conquering.

> 2) Is it possible to explicitly specify multiple monitoring regions in 
> DAMOS RECLAIM or do i need to configure DAMOS manually from userspace 
> for that?

At the moment, DAMON_RECLAIM does not provide a way for such fine control.  So
you should use DAMOS manually.  Using the DAMON user space tool, damo, you may
use '--regions' option.

> 3) How to find the number of monitoring regions where DAMOS is most 
> effective?

You may simply try different numbers and show the progress.  Visualizing
monitored access pattern could also be helpful.  For DAMOS-specific case,
checking DAMOS stats and tried_regions could also be useful.

Note that these limitations are only in current implementation.  There are TODO
items for improving DAMON accuracy and automating tuning.  Hopefully future
version of DAMON will provide better accuracy and easier tuning.  Nevertheless,
this is where we are at the moment.

Sending questions, sharing experience/usages, and participating discussions
like this helps DAMON community knowing unexpected requirements, getting new
ideas, and prioritizing specific items.  Thank you for inspiring me with this.
Please feel free to ask anything if you need.

[1] https://docs.kernel.org/mm/damon/design.html#region-based-sampling
[2] https://docs.kernel.org/mm/damon/design.html#adaptive-regions-adjustment
[3] https://docs.kernel.org/mm/damon/faq.html#can-i-simply-monitor-page-granularity


Thanks,
SJ

> 
> Best Regards,
> Grzegorz Uriasz
> 
