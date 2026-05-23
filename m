Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB612472AE
	for <damon@lists.linux.dev>; Sat, 23 May 2026 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779567981; cv=none; b=HZ7RELoVw4rrZCfmuf7iarBeM6C0j8JOgtfdx1nJkoM61cd/9basPxyWlm/Wojnkq8J6RzoAzSimn3Tilxr6Xksauz5kT062mwmfRLqy74zvhVv8hfQEdsCKVMr4P3n3MSv/Hc9gX5uutD9ij6juCn0t/t9IF6NWswFqbYtuQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779567981; c=relaxed/simple;
	bh=wZEltsyISLzGxXwguUBSRWr/p3kskJVJ6I8FuGxZeNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvUmrJNKo+LzQuVXlsOA1j7RIJ48zdQvXOJ8h1y8rzeozIUvyo5jU7U1lqtkXCdpgZl5tzm0b10XVb+kCyx3NZRkVtmBJTM6pt99fETt/E9uxdI23zHsd+KAv3kqlpsWAZclptPkUt3c9VYhtZo91W8bW9GNi2sYHpm7PvkE0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR7PcWT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR7PcWT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C101F000E9;
	Sat, 23 May 2026 20:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779567980;
	bh=rrQt3Gwx2M2thPx2zNE9k37sALduTPQRG4YNHwjkC1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FR7PcWT3d7a0NF32+7IfEDBugU7jVsKpzGp7Mn6eVVG5+NjinHl7bXUEeDHAru83r
	 wS+zVkoRM8wRpfs4qorxx4cRVsMhY5HGuWVzkBvqPQZC68kBrhwrn5Wymq4bSjSQ+b
	 0afWmu+JZU6fVrPzGxgbubHls6Lepiy9ax3nzANlEQYQlueTPsxQyp14fVxGGPvlbC
	 4P7BKijlqUBzLW5LfSVqP31drfHOYPMWpoK48nEJvbhmeGSo7qHa9j9ODvJDWtYQ2s
	 LTC3JGc8CdLobilaAECOjdU1w1ka/LSozjFK88PdfRrQpMEg0cltFptXxtx1krH7KC
	 w7wMf/W/qhcDA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Sat, 23 May 2026 13:26:07 -0700
Message-ID: <20260523202608.99529-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260523195707.6CB2C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 23 May 2026 19:57:06 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Speculative folio flag access occurs before pointer re-validation, triggering VM_BUG_ON_PGFLAGS() on tail pages.
> --
> 
> commit 119755fb3390d2b7d6c7f2278054cc95e95531c6
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/ops-common: call folio_test_lru() after folio_get()
> 
> This patch attempts to fix a potential VM_BUG_ON_PGFLAGS crash by removing
> the speculative LRU flag check before trying to get a reference in
> damon_get_folio(). It moves the LRU check after a successful try_get.
> 
> Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 3a0ddc3ac7196..d3404615f9b75 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -32,9 +32,9 @@ struct folio *damon_get_folio(unsigned long pfn)
> >  		return NULL;
> >  
> >  	folio = page_folio(page);
> > -	if (!folio_test_lru(folio) || !folio_try_get(folio))
> > +	if (!folio_try_get(folio))
> >  		return NULL;
> > -	if (unlikely(page_folio(page) != folio || !folio_test_lru(folio))) {
> > +	if (!folio_test_lru(folio) || unlikely(page_folio(page) != folio)) {
> 
> [Severity: High]
> Does this sequence reintroduce the same bug the patch intends to fix?
> 
> By placing the LRU flag check before the pointer re-validation, C
> short-circuit evaluation will evaluate the LRU flag first.
> 
> If the page was concurrently freed and reallocated as a tail page,
> folio_try_get() might still succeed.
> Evaluating the LRU flag on this
> unvalidated tail page will trigger the VM_BUG_ON_PGFLAGS() in
> const_folio_flags().
> 
> Should the pointer re-validation happen before accessing any folio flags in
> PFN scanners?

I was initially assume folio_try_get() will always return a valid folio.  But I
find no code to avoid Sashiko's theory in folio_try_get().

So, I think Sashiko is correct.  I will drop the above line change on the next
revision.


Thanks,
SJ

[...]
