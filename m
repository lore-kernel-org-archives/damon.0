Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3C183CC3
	for <damon@lists.linux.dev>; Sat, 23 May 2026 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779568319; cv=none; b=Q3bDcyOxFzn05kvu4OaQhMHhg/0E4s+SPPzNGoyOJ+NpENAsqdt1ZhKy7BDbXJDiKymM7SnRPD+zp4wZRy2LWss7jaeyxa12m/6m0cq36/1jq0MWpmGahDBxwuQWmz2mM6ILwyniItVDy47s9Lg7uj/AXdKJF9DGNiHxnvDq50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779568319; c=relaxed/simple;
	bh=FbzoVeYz7usicAWMErWI2YGg2/Joz1Kfsc0SCIrxl+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDmg140FeeDj8tVZILnvmHooEFvfMRWMFOZlcEWFMNTpZOQ/DM+jWdCh1mYWJQMIquqxV8OwtOH+tX1JDgQ2GrHIjebVPTSyuq3daQjPhM5V5nYErbasyjAz5wHJzDwWb0/9a+JUI8agS8lqu40enCPVv722nZyPM4zjoGummYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP0vaj+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP0vaj+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537121F000E9;
	Sat, 23 May 2026 20:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779568318;
	bh=7j28wyrKaDykDPQxumM6i3qLL4q2hfYz5DxqnAqfOkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TP0vaj+jViwfpUuEGARHmYphA7YDU1keIS/Nt0XQbbWHh4p3CX/9PGcp6LBlIzlaN
	 V+t4ED5TNClD4xhJdzCCKYIEsBPZpwQJHRTog+qCfihmPEvYEmQJcT5BDzsK0XTLNZ
	 2d9HKjUcrUzHncaCUv6TdR0ErJDCZSgPjboimpMftXP/cf91qX9AAY7edMyUaR0KMR
	 c91I1tPK5LbfmCOZR0j8Yeis+gAPa7FPnW0oft02eg6FFwFPBaK9B6sriTy31LYa31
	 eHVx4rYtVj9NgwJa65kEvsoZ9uoB9ZNLKmpOjsNYHoCqT/nZbYshTiKCVpQhKnNr9K
	 gP/Sj6ikzgPRw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Sat, 23 May 2026 13:31:42 -0700
Message-ID: <20260523203143.100014-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260523202608.99529-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 23 May 2026 13:26:07 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat, 23 May 2026 19:57:06 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Speculative folio flag access occurs before pointer re-validation, triggering VM_BUG_ON_PGFLAGS() on tail pages.
> > --
> > 
> > commit 119755fb3390d2b7d6c7f2278054cc95e95531c6
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/ops-common: call folio_test_lru() after folio_get()
> > 
> > This patch attempts to fix a potential VM_BUG_ON_PGFLAGS crash by removing
> > the speculative LRU flag check before trying to get a reference in
> > damon_get_folio(). It moves the LRU check after a successful try_get.
> > 
> > Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org
> > 
> > > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > > index 3a0ddc3ac7196..d3404615f9b75 100644
> > > --- a/mm/damon/ops-common.c
> > > +++ b/mm/damon/ops-common.c
> > > @@ -32,9 +32,9 @@ struct folio *damon_get_folio(unsigned long pfn)
> > >  		return NULL;
> > >  
> > >  	folio = page_folio(page);
> > > -	if (!folio_test_lru(folio) || !folio_try_get(folio))
> > > +	if (!folio_try_get(folio))
> > >  		return NULL;
> > > -	if (unlikely(page_folio(page) != folio || !folio_test_lru(folio))) {
> > > +	if (!folio_test_lru(folio) || unlikely(page_folio(page) != folio)) {
> > 
> > [Severity: High]
> > Does this sequence reintroduce the same bug the patch intends to fix?
> > 
> > By placing the LRU flag check before the pointer re-validation, C
> > short-circuit evaluation will evaluate the LRU flag first.
> > 
> > If the page was concurrently freed and reallocated as a tail page,
> > folio_try_get() might still succeed.
> > Evaluating the LRU flag on this
> > unvalidated tail page will trigger the VM_BUG_ON_PGFLAGS() in
> > const_folio_flags().
> > 
> > Should the pointer re-validation happen before accessing any folio flags in
> > PFN scanners?
> 
> I was initially assume folio_try_get() will always return a valid folio.  But I
> find no code to avoid Sashiko's theory in folio_try_get().
> 
> So, I think Sashiko is correct.  I will drop the above line change on the next
> revision.

But, I may still mark the folio_test_lru() as no more unlikely.


Thanks,
SJ

[...]
