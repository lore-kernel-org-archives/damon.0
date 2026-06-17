Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A045165F16;
	Wed, 17 Jun 2026 04:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781669730; cv=none; b=WoYXWMjrJ9KjIEfHex3R8t3u5dJ0OZtBlSONyhI6+zQkd6tFp9nGILkd0fsjdfRg22EOKhR6ETL6U1rHIWWCcHQK2nBounBH/rcBRYWJ6llHiv4dmksuKwAG1mSXVW/VxSTjgsBxwsS/le4fT+sul51oV7AWXvnRHBRU25FJ8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781669730; c=relaxed/simple;
	bh=8HKLfsrsiHiQVVfsF5rixcHlOrNS+GnRI0+kT+Fcy0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9KNVb0dS7WshZWH2W2oZ8qFAKXz0Uox6lzRm2GMRb9m7m60nzMBcmFvIDK9R2Tz5ghR9fwPB5v6KDqYPg2N0D4NwThsAlnFDsgWXru3+POF0uKXMylABtmYomBztvVrt36W4zgD8nv3DRggdRRIF17du6xPYSefJNpHfXnfHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgxuvPMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgxuvPMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1761F000E9;
	Wed, 17 Jun 2026 04:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781669729;
	bh=BfuesadEZFqHVxr2opemKIotkjaDSbngRhowoxbWpJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DgxuvPMJArHQR8/mJtBmswduDgt3ddI1m9LFJpgkUeKgi8tD7uRMrI9lEe0M57xMA
	 NxxI2jdP/xlKiXkRWfWaQBDcOKmQl3lPlTbIW1aK2WVYZxRJpGGM9Y0RV+wJ830y1A
	 0D4pqnlrr5vYzLCl9UrYFSIOSsCbqvQQWth22Wjz9C9e5Ca5Zj11g0HV+Q8l1mdVu4
	 9TRa6JUoVOlZbl2trxczAnZpr0r08FNV5KaCphLrhvC06OWLn3J/EbWteJHenlc3ZK
	 rvt1jFiZ57fteAvhasfZ+yGVL996u2+1RUUHha+9Eby7LkeNK+DbWVN8GNL3xkKtJG
	 aTAItJ/pMF4Vw==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	sashiko-reviews@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [PATCH v1 3/3] mm/damon/sysfs: support hugepage_mem_bp quota goal metric
Date: Tue, 16 Jun 2026 21:15:15 -0700
Message-ID: <20260617041515.98906-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6a2a30eb-2fd8-4ade-988e-9a9c93c09fe6@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 22:35:21 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 6/16/2026 6:21 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > 
> > New issues:
> > - [Low] The new `DAMOS_QUOTA_HUGEPAGE_MEM_BP` metric is exposed via sysfs but lacks required documentation updates.
> > 
> > Pre-existing issues:
> > - [Critical] Potential divide-by-zero in `damos_hugepage_mem_bp()` and `damos_get_in_active_mem_bp()` due to an unhandled zero denominator.
> > - [High] 32-bit integer overflow in `damos_hugepage_mem_bp()` and `damos_get_in_active_mem_bp()` when calculating memory ratios.
> > --
> > 
> > commit be304699fb94d4d73bd979237fb4d7b08b7216f7
> > Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> > 
> > mm/damon/sysfs: support hugepage_mem_bp quota goal metric
> > 
> > DAMOS has a new autotune policy metric: DAMOS_QUOTA_HUGEPAGE_MEM_BP.
> > This patch exposes DAMOS_QUOTA_HUGEPAGE_MEM_BP through sysfs.
> > 
> >> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> >> index 329cfd0bbe9f3..4b5429a5b4158 100644
> >> --- a/mm/damon/sysfs-schemes.c
> >> +++ b/mm/damon/sysfs-schemes.c
> >> @@ -1267,6 +1267,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
> >>  		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> >>  		.name = "node_eligible_mem_bp",
> >>  	},
> >> +	{
> >> +		.metric = DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> >> +		.name = "hugepage_mem_bp",
> >> +	},
> > 
> > [Severity: Critical]
> > This isn't a bug introduced by this patch, but exposing this metric directly
> > to userspace makes a potential divide-by-zero triggerable by users
> > configuring DAMON quotas.
> > 
> > In mm/damon/core.c:damos_hugepage_mem_bp(), the denominator is computed as:
> > 
> >     total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> > 
> > Due to per-CPU vmstat lag or an idle system, the free pages counter can equal
> > totalram_pages(), resulting in total being 0. This is then passed to
> > mult_frac():
> > 
> >     return mult_frac(thp, 10000, total);
> > 
> > This inherently computes thp / total, causing a strict division by zero and a
> > kernel panic. The same issue exists in damos_get_in_active_mem_bp() where
> > total = active + inactive, which can be 0 if the LRU lists are empty.
> > 
> > Should a zero-check on total be added before performing the division?
> DAMON is enabled after the system is fully loaded. total will not be 0 by then.

Could you please further clarify what "system is fully loaded" means, reaards
to what Sashiko is claiming, particularly the per-CPU vmstat lag?


Thanks,
SJ

[...]
