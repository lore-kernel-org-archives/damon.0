Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DDA388E4C;
	Wed, 11 Mar 2026 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273349; cv=none; b=lIfoQvyPDrYaFpo5dUIuIpq1zf3guvzzGZeamtjvZ+Gl7gkpBs7mQaQe8AJ68+zk/n9am72g2cW3Z3OdMhjAOvAvChjmIllD641Y+yj3pk0lP7AgDpOiUwD8VvCEUYzFBgPgwj6b/kWhFgyzN9q+wW+VLONqHcaAHJdnGeE0Kkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273349; c=relaxed/simple;
	bh=SqqZK3fLnH0EXSor/M11rWVZrSeOmcU9VgZBss3FPWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5ERSQ5PuyBWNeq/uNwYlvurpge6A5VC02cTiEeT+Jg0en5bYrx2yhFXZVtp4zCgsk5JHhnRil3H3Uc/M3SU0I3U2ZIdT68XtTghf+45XrGcM2Lb1ar6zM8TJnVaKDhG/TOd7Muanr/z8foATq/QZIZ30/9IJclCRPdHXXZCWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC7IXli4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC7IXli4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2720C4CEF7;
	Wed, 11 Mar 2026 23:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773273349;
	bh=SqqZK3fLnH0EXSor/M11rWVZrSeOmcU9VgZBss3FPWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sC7IXli4fFSxodAZXvBBNWaXmlfiKo1prMfpjoR7amoYQUbIwLMi1V2H6IbEuMT/j
	 is7Xq3Q2DNhIQGnBye4+7OtSK9pnNDLkdINYa1z4EjTX8cE1iV/+ukpKLn3zs6R9z9
	 mJIFt4CW3U0BPsIdpST5zrejJsBhctsO4hZoGi9SPFBIaBJWnj2M5fsQCf76IyVUM8
	 nFohrN6vZi20t676UnSqgpEiPZbENuDmpER9rDMu/GgzsiRVwmAYooWiPpvizYEJYy
	 L2+4hKuDJzLH0Jd0anLgGPDCKBxMSbs2x0fkqLn3pfQbBVxyohT37F3Sf3c7aaH0RM
	 0lXR0jHw/9DKA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
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
Date: Wed, 11 Mar 2026 16:55:40 -0700
Message-ID: <20260311235541.99654-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311143912.96834-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Mar 2026 07:39:12 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 11 Mar 2026 16:08:56 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
> > Hi SeongJae,
> > 
> > On 3/11/2026 8:07 AM, SeongJae Park wrote:
> > > Hello Asier,
> > > 
> > > 
> > > Thank you for continuing this work!
> > > 
> > > On Tue, 10 Mar 2026 16:24:16 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > > 
> > >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> > >>
> > >> Overview
> > >> ----------
> > > 
> > > Let's make the legnth of the subject and the length of the underline same.
> > > 
> > >>
> > >> This patch set introduces a new dynamic mechanism for detecting hot applications
> > >> and hot regions in those applications.
> > > 
> > > Seems now you offload the hot applications detection to the user space.  If I'm
> > > not wrong, you should remove "hot applications and" on the above sentence.
> > 
> > You're right. I was not sure whether changing the RFC subject was right or not.
> > I will change it for the next RFC version.
> 
> It's fine to change the subject.  Please feel free to do so in the next version
> :)
> 
> > 
> > >>
> > >> Motivation
> > >> -----------
> > >>
> > >> Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
> > >> hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
> > >> fragmentation and memory waste. For this reason, most application guides and
> > >> system administrators suggest to disable THP.
> > >>
> > >>
> > >> Solution
> > >> -----------
> > >>
> > >> A new Linux kernel module that uses DAMON to detect hot regions and collapse
> > >> those regions into huge pages. The user supplies a set of PIDs using a module
> > >> parameter,
> > > 
> > > This sounds reasonable to me.
> > > 
> > >> and then, the module launches a new kdamond thread to monitor each
> > >> of the tasks.
> > >>
> > >> In each kdamond, we start with a high min_access value. Our goal is to find the
> > >> "maximum" min_access value at which point the DAMON action is applied. In each
> > >> cycle, if no action is applied, we lower the min_access.
> > > 
> > > So, this patch series introduces a sort of auto-tuning of the hugepages
> > > collapse hotness threshold, that implemented in the new module.
> > > 
> > > We already have a sort of DAMOS auto-tuning feature, namely goal-based DAMOS
> > > quota auto-tuning [1].  Have you considered using that?  Of course, it might
> > > not be able to be used as is.  Some extensions, e.g., introduction of new goal
> > > metric, may be needed.
> > > 
> > > Yet another approach would be implementing the auto-tuning in the user-space.
> > > Because DAMON parameters can be updated online, updating the min_access from
> > > the user space should be doable?  Given the fact the module anyway require
> > > user-space control for feeding the list of applications to apply access-aware
> > > huge pages collapsing, I find no problem at user space driven auto-tuning.
> > > 
> > > If the goal-based DAMOS quota auto-tuning or the user-space based auto-tuning
> > > are feasible, all the controls can be done using DAMON sysfs interface.
> > > Introduction of the new kernel module might not really be needed in the case.
> > > 
> > > We have DAMON modules in addition to DAMON sysfs interface for users who want
> > > to use DAMON for a given specific use case with only minimum or near-zero
> > > user-space control.  In this case, because it is already aimed to ask the
> > > user-space to feed the list of applications to apply DAMOS-based hugepages
> > > collapsing, it seems a new module is not really needed, to me.
> > > 
> > > But I guess your use case might have some special restrictions that really
> > > require use of the module instead of offloading the auto-tuning to the
> > > user-space or DAMON core.  Is that the case?  If so, can you share more details
> > > about it?
> > 
> > I haven't figured out how I can use goal autotune to change the min_access.
> 
> Indeed, it is not a very straightforward feature.
> 
> > Your suggestion about moving this to the user space sound good.
> 
> If it works for you, maybe that is best for you :)
> 
> > 
> > The idea was to stop lowering the min_access as soon as collapses occur,
> > since we don't want to lower so much that we start collapsing regions that
> > are not very hot.
> > 
> > Maybe you can suggest a better way to do it. Maybe with autotuning.
> 
> I will add more detailed suggestion soon, by tomorrow or a day after.

First of all, as I mentioned on the above reply, if the approach of this patch
series (starting from high min_access and lowering down until some pages really
be collapsed) works for your use case, and you are ok at doing it in user space
approach, I think that should be the best for you, and I'd recommend going on
the direction.

But if you want to use the aim-oriented DAMOS quota goal auto-tuning, maybe I
can suggest following options.

Let me start from the basic background.  Using aim-oriented auto-tuning, the
user can set the aimed goal of a given DAMOS scheme.  Then, DAMOS automatically
increases the quota if the goal is under-achieved.  If the goal is
over-achieved, DAMOS decreases the quota.  More details are available on the
documentation [1].

So what you need is finding a proper goal.  In the hugepage use case, I expect
the goal is an amount of hugepages for the application.  Say, the goal can be
"making X% of the application memory hugepage".  DAMOS quota goal feature
supports multiple types of goals.  Unfortunately, there is no one for exactly
this example goal type.  There can be two options.

First, using 'user_input' goal type.  It allows users to directly feed the
current goal achievement to DAMON.  You can measure how much of the
applicastion's memory is hugepage and feed that inofrmation with 'user_input'
goal type.  If user-space approach is ok for you, this should also work.

Second, implementing yet another goal type for the use case.  No single quota
goal fits all, and therefore we are adding new quota goal whenever it is
needed.

But, again, if the approach of this patch series is proven to work for your use
case, and it is ok to implement it in user space, that should be the best and
fastest option for you.

Also I don't know your real use case.  Hence my quota goal based approach
suggestion might make no sense at all for your use case.  If you want, I will
be happy to learn more about your use case and suggest another option.
Nonetheless, I'm also only struggling at finding the best way for utilizing
DAMON for hugepages, and therefore trying to get some community feedback in
LSF/MM/BPF [2].

[1] https://docs.kernel.org/mm/damon/design.html#aim-oriented-feedback-driven-auto-tuning
[2] https://lore.kernel.org/all/20260211050729.69719-1-sj@kernel.org/


Thanks,
SJ

> 
> > 
> > > 
> > >>
> > >> Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
> > >> collapse synchronously and avoid polluting khugepaged and other parts of the MM
> > >> subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
> > >> which needs the correct vm_flags_t set.
> > > 
> > > This makes sense to me.  I expect DAMOS_COLLAPSE to have some advantages over
> > > DAMOS_HUGEPAGE for some use cases, similar to MADV_COLLAPSE vs MADV_HUGEPAGE.
> > > 
> > > From my perspective, this patch series is introducing three things.
> > > 1) hugepage collapsing hotness threshold auto-tuning, 2) the module for running
> > > the auto-tuning, and 3) DAMOS_COLLAPSE.  To me, it is unclear if the first two
> > > changes are really needed.  I will wait your answer.
> 
> Please answer the above questions when you get a chance.
> 
> > > 
> > > Meanwhile, the third change seems reasonable and not necessarily need to be
> > > blocked for the other two changes.  I think separating the third change from
> > > this patch series and upstreaming it first could also be a path forward.
> > > Because the change is simple and sound, convincing me would be easy.  I'd be
> > > convinced if at least some reasonable test results can be shown.  I'm not
> > > saying we should drop the other two changes.  We can keep discussing those in
> > > parallel.  Rather, upstreaming the third change first could help finding real
> > > benefits of the other two changes, since the testing will be easier.  The
> > > decision is up to Asier, of course.  I'm just sharing my two cents.
> 
> I'm also curious what you think about this.
> 
> 
> Thanks,
> SJ
> 
> [...]
