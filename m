Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C414F9D9
	for <damon@lists.linux.dev>; Tue, 21 Jan 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453713; cv=none; b=ictZlE0AymUZEba+jl+YGGCXDrvlKKd0aVcm20DoAdiQ+3EgzvKeQuKW29ZV4h//KURXjtffm9nF4UZQQyI5gWAU1CE97fNjXY49tBZjmKqPWTQZlp4bRP51BC0/NSNOWE288LRiA+6o5jFRhKINw/MO0oxEY5gIt5fGiZGrDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453713; c=relaxed/simple;
	bh=SMilkJiGkUm4HMs0C3Vut1IC375QxPDLsGftaGW9mtE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msYFp1qaoCrx1fNMeNaet35A90SmKR6BUWUx9ZbgJOOhFIR8/2bvK0Jcs4hCK8Fyc7pF5+3JkRrKu+jxdfy9JfWct6X7BZHIy0P01kTUT0EVqncUl2WksJrrobfengiA/h55klQWKuU6STxSXvaQb4jvTPLFTvQpTsgByi5BVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YcjR227rDz6K9Ds;
	Tue, 21 Jan 2025 18:01:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F1F23140B30;
	Tue, 21 Jan 2025 18:01:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 11:01:46 +0100
Date: Tue, 21 Jan 2025 10:01:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: SeongJae Park <sj@kernel.org>
CC: <lsf-pc@lists.linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Updates and Plans: Monitoring
 Parameters Auot-tuning and Memory Tiering
Message-ID: <20250121100145.0000398a@huawei.com>
In-Reply-To: <20250102222317.48760-1-sj@kernel.org>
References: <20250102222317.48760-1-sj@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  2 Jan 2025 14:23:17 -0800
SeongJae Park <sj@kernel.org> wrote:

> Hi all,
> 
> 
> We started sharing and discussing DAMON's current status and future plans from
> LSF/MM/BPF 2023.  Thanks to the constructive feedbacks from the discussions, I
> believe DAMON is continuing the evolution in right or at least not
> controversial directions.  To continue getting the benefit and avoid it becomes
> an unexpected "demon" in early stage, I'd like to share and discuss followup
> updates and new plans for DAMON once again on LSF/MM/BPF 2025.
> 
> Major topics and currently expected materials to share on the session include
> below.  Of course, some changes could happen.
> 
> First, followups on work items that we discussed on last LSF/MM/BPF.
> 
> DAMOS auto-tuning based tiered memory manamgent.  No many progress has made so
> far.  But I recently gained an access to a tiered memory system, and setting up
> test environment.  Hopefully I will be able to share early RFC implementation
> and evaluation results by the session.
> 
> Access/Contiguity-aware Memory Auto-scalging.  No progress has made so far,
> too.  I'm pivoting this into reliable huge contig memory occupation
> mechanism, though, since it is smaller scope that we can make faster.  It can
> also be used for not only memory hotplugging based auto-scaling but also
> contiguous memory allocation.  Hopefully early evaluation of a part of the
> work, probably access-aware partial compaction, will be shared by the session.

Hi SJ,

I couldn't immediately identify the huge contig memory occupation mechanism proposal
in last year's slides. Perhaps a brief summary here?

> 
> Please refer to last year LSF/MM/BPF slides[1] for details of the above two
> projects.
> 
> And new projects that currently in their early stages.
> 
> Page level properties-based access monitoring.  We are extending DAMOS filters
> that works in page level properties to further be useful for monitoring
> purpose.  RFC patch series for the essential part[1] is already available, and
[1] seems to be last year's slides?  Was that your intent?
> user-space tool support[2] is made.  By the session, hopefully the patch series
> will be merged in mm tree, and I will be able to share followup plans for
> making it more lightweight and useful.
> 
> Extending DAMON for memory bandwidth monitoring.  We aim to extend DAMON to
> support not only access pattern snapshot generation, but more general access
> pattern information, like memory bandwidth usage.  I expect only rough idea
> will be shared on the session, to make early alignemnt of the future shape, or
> abortion.


Where does this fit alongside hardware aided solutions (resctl  - MPAM on ARM,
similar stuff on x86?)  Idea to do it at sub process granularity?
What are the use cases for that?

One other topic, can we differentiate read access from write accesses?
The promotion costs for the two may be somewhat different if we can keep the
old translation live until the copy is in place for read only. Taking that
into account in promotion decisions may be useful.

Being able to track separately is one thing the hardware tracking units
do well subject to tracking resource constraints.

Thanks,

Jonathan

> 
> Please let me know if you have interest in status of other projects that I
> shared on last LSF/MM/BPF session or somewhere else.  Depending on that, the
> topics and time portions can be changed.
> 
> Note that I proposed[3] yet another LSF/MM/BPF topic for DAMON.  If both are
> accepted, please schedule this one before the other one.  I believe this
> session can make the other session deduplicated and faster.
> 
> [1] https://github.com/damonitor/talks/blob/master/2024/lsfmmbpf/damon_lsfmmbpf_2024.pdf
> [2] https://damonitor.github.io/posts/damon_sz_filter_passed/
> [3] https://lore.kernel.org/20250101222039.74565-1-sj@kernel.org
> 
> 
> Thanks,
> SJ
> 

