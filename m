Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31F3C944E;
	Wed, 11 Mar 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239962; cv=none; b=dGQkSIfRWr9FxdwX1WmqodFbGhzQJV5kzqGJpcKoR6WJ0QwMnFnIcGM7JBDTTcT2QA5sIw0o+QTkCJBoxRD+mo3ipZm6H9n2PFJGU5Pkf8qG+XFUuKK+Ee3AsBBEFqerD1ZDo7dEPCXpaq8yXDX/YsqIHkePN8PCJo2xeJRnH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239962; c=relaxed/simple;
	bh=NJ10AZXdscg+DvMqnyYzr0It1WL0JuhQV8FD7xqijPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9u76iEQ1TUHdrvbfpuQSplVdxqm7iUR/JSMszae1GXTHeSnIfMLEkKL7AFDbwjfh/8kLrVGdoZG4g+7MGOi3CDe7ju+VilMlfrwc+l2Lvqq+8Hd9ryriP30EmEG1D4brktm67rhUEGmYHKnaFSiOk4xm8ITso0Bs4HiHlDVrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT2IU5HN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT2IU5HN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26ABC4CEF7;
	Wed, 11 Mar 2026 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773239962;
	bh=NJ10AZXdscg+DvMqnyYzr0It1WL0JuhQV8FD7xqijPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LT2IU5HNWxB0iJ9LuNGYfyn0SEQ15nR4YpdC9Swgnko7sYltMJyqQ00h5IO0OnX3w
	 httHIieCaSHUABplizTeBVYaHellks5Rqr0UrYpFiMAgvWA5sQUIovsx1bEsKUuCFc
	 zepKlIOgdIPkU+S0gO64kMVMzNLTavCytAnoqpeye8ANKiclih2r8wIF7XHvb/pE5L
	 20Z1s0unzplcxO5ABRZH5WyjR93reDTgeIpd9l6kHQXZQSvNgFQw0teErwsKaTHSep
	 0i0mZKTHeRpoTka4EQQ8pNUdofPmuInPebfnmcd02gmrKku+fCdzsTCjfD4YsnNJFX
	 v4ZzV6uQrObLQ==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] mm/damon: Support hot application detections
Date: Wed, 11 Mar 2026 07:39:12 -0700
Message-ID: <20260311143912.96834-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <577a2b92-3507-400c-acbd-32c914d374b7@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Mar 2026 16:08:56 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SeongJae,
> 
> On 3/11/2026 8:07 AM, SeongJae Park wrote:
> > Hello Asier,
> > 
> > 
> > Thank you for continuing this work!
> > 
> > On Tue, 10 Mar 2026 16:24:16 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> Overview
> >> ----------
> > 
> > Let's make the legnth of the subject and the length of the underline same.
> > 
> >>
> >> This patch set introduces a new dynamic mechanism for detecting hot applications
> >> and hot regions in those applications.
> > 
> > Seems now you offload the hot applications detection to the user space.  If I'm
> > not wrong, you should remove "hot applications and" on the above sentence.
> 
> You're right. I was not sure whether changing the RFC subject was right or not.
> I will change it for the next RFC version.

It's fine to change the subject.  Please feel free to do so in the next version
:)

> 
> >>
> >> Motivation
> >> -----------
> >>
> >> Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
> >> hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
> >> fragmentation and memory waste. For this reason, most application guides and
> >> system administrators suggest to disable THP.
> >>
> >>
> >> Solution
> >> -----------
> >>
> >> A new Linux kernel module that uses DAMON to detect hot regions and collapse
> >> those regions into huge pages. The user supplies a set of PIDs using a module
> >> parameter,
> > 
> > This sounds reasonable to me.
> > 
> >> and then, the module launches a new kdamond thread to monitor each
> >> of the tasks.
> >>
> >> In each kdamond, we start with a high min_access value. Our goal is to find the
> >> "maximum" min_access value at which point the DAMON action is applied. In each
> >> cycle, if no action is applied, we lower the min_access.
> > 
> > So, this patch series introduces a sort of auto-tuning of the hugepages
> > collapse hotness threshold, that implemented in the new module.
> > 
> > We already have a sort of DAMOS auto-tuning feature, namely goal-based DAMOS
> > quota auto-tuning [1].  Have you considered using that?  Of course, it might
> > not be able to be used as is.  Some extensions, e.g., introduction of new goal
> > metric, may be needed.
> > 
> > Yet another approach would be implementing the auto-tuning in the user-space.
> > Because DAMON parameters can be updated online, updating the min_access from
> > the user space should be doable?  Given the fact the module anyway require
> > user-space control for feeding the list of applications to apply access-aware
> > huge pages collapsing, I find no problem at user space driven auto-tuning.
> > 
> > If the goal-based DAMOS quota auto-tuning or the user-space based auto-tuning
> > are feasible, all the controls can be done using DAMON sysfs interface.
> > Introduction of the new kernel module might not really be needed in the case.
> > 
> > We have DAMON modules in addition to DAMON sysfs interface for users who want
> > to use DAMON for a given specific use case with only minimum or near-zero
> > user-space control.  In this case, because it is already aimed to ask the
> > user-space to feed the list of applications to apply DAMOS-based hugepages
> > collapsing, it seems a new module is not really needed, to me.
> > 
> > But I guess your use case might have some special restrictions that really
> > require use of the module instead of offloading the auto-tuning to the
> > user-space or DAMON core.  Is that the case?  If so, can you share more details
> > about it?
> 
> I haven't figured out how I can use goal autotune to change the min_access.

Indeed, it is not a very straightforward feature.

> Your suggestion about moving this to the user space sound good.

If it works for you, maybe that is best for you :)

> 
> The idea was to stop lowering the min_access as soon as collapses occur,
> since we don't want to lower so much that we start collapsing regions that
> are not very hot.
> 
> Maybe you can suggest a better way to do it. Maybe with autotuning.

I will add more detailed suggestion soon, by tomorrow or a day after.

> 
> > 
> >>
> >> Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
> >> collapse synchronously and avoid polluting khugepaged and other parts of the MM
> >> subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
> >> which needs the correct vm_flags_t set.
> > 
> > This makes sense to me.  I expect DAMOS_COLLAPSE to have some advantages over
> > DAMOS_HUGEPAGE for some use cases, similar to MADV_COLLAPSE vs MADV_HUGEPAGE.
> > 
> > From my perspective, this patch series is introducing three things.
> > 1) hugepage collapsing hotness threshold auto-tuning, 2) the module for running
> > the auto-tuning, and 3) DAMOS_COLLAPSE.  To me, it is unclear if the first two
> > changes are really needed.  I will wait your answer.

Please answer the above questions when you get a chance.

> > 
> > Meanwhile, the third change seems reasonable and not necessarily need to be
> > blocked for the other two changes.  I think separating the third change from
> > this patch series and upstreaming it first could also be a path forward.
> > Because the change is simple and sound, convincing me would be easy.  I'd be
> > convinced if at least some reasonable test results can be shown.  I'm not
> > saying we should drop the other two changes.  We can keep discussing those in
> > parallel.  Rather, upstreaming the third change first could help finding real
> > benefits of the other two changes, since the testing will be easier.  The
> > decision is up to Asier, of course.  I'm just sharing my two cents.

I'm also curious what you think about this.


Thanks,
SJ

[...]
