Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4952BB17
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784251349; cv=none; b=LLPDqR4MXbPr/B7NUANBDxvokHlusju5HbxBkM8/uvnkoebUVnU5DDl0r8RFxpqhQrguPj2vKkEbFPsIW5q6VK4PyObyTj9jMPpOak1nkHgHMrG6Y++0Nn8rLSVOtzFi0voab98sBNkA9BaTJhZMrNQRpcbpwvPNV8VAf7cXumI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784251349; c=relaxed/simple;
	bh=ncH0SOI2ThEOvDSgXorMp+uVxYgTrL/B3CTo6yEdNuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m71ys1jVYrI9a+cxSlLCl1i8BJEnZKZ9//U2V4HnOibD4S6KfQ4Xq7KITPZdy+rXPrf+rbJg/4/imQvj4n/tIWNHoa5O7kFauOUtGpiLaaf5lWEyt41vRmoRmAwNaRmnGCcD9p26Yexx+e9P/ZMq3WYH+29oNs/vTypizTdkHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDuIxw+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDuIxw+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456F91F000E9;
	Fri, 17 Jul 2026 01:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784251347;
	bh=5OvcRcKHssnhS4wwrkC5tXoiKtkZRsxXpu3KbWLadrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDuIxw+SQwQ4m66U6VYOY4FYTop+IC3xQcUvSwWAfrerMmKkm7d0rsBoc0SsGncWB
	 ouHys4ZPdpBCE14pxSCF6OrB0MegEb0+NraUN/YzmNlc0LOafsMAnSCJ7wjwaFAsdd
	 MvBLm8YDQZRQTWJCVTP/64JsXi7SYxgjyQrTxRboVsQOPewWgtj1j1vSiI/87FDFM6
	 k1ktMEVQSBEhTe9vwRNerQEVJmetSldHzaTyuIeZAbQ1sXfbFY7uqT+PfPo9JabjN+
	 VnHceExbSpwXlIz/PvjWPeN+WDFsH0fFNdlRzNLH1e8zpGD2dWrFhx9pMzW/8rTFW9
	 W8Td1A0zRB+eQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 4/7] mm/damon/core-kunit: handle region split failure in filter_out()
Date: Thu, 16 Jul 2026 18:22:17 -0700
Message-ID: <20260717012219.120908-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717004605.9D8881F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 00:46:05 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch adds an early exit check `if (damon_nr_regions(t) != 2) goto out;` to prevent an invalid pointer dereference when the first region split test fails, but misses the exact same vulnerability in the second region split test directly below it.
> - [High] In `damon_apply_min_nr_regions`, if `damon_split_region_at` fails to allocate memory, the inner loop advances to the next list entry without inserting a new region, leading to an out-of-bounds read and write when it reaches the list head.
> --
> 
> --- Patch [4]: [PATCH 4/7] mm/damon/core-kunit: handle region split failure in filter_out() ---
> commit 705cf12a4e8501ec816031495df35460614c42c2
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core-kunit: handle region split failure in filter_out()
>     
> damos_test_filter_out() checks if damos_filter_match() of an address
> filter splits the region as expected. But the test continued regardless of
> whether the split succeeded, which could lead to dereferencing invalid
> pointers or corrupting memory. This adds an early exit check on the first
> test block to prevent continuing on failure.
> 
> Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 322a295ac2cec..bd3bbd421392f 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -1365,6 +1365,8 @@ static void damos_test_filter_out(struct kunit *test)
> >  	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
> >  	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
> >  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> > +	if (damon_nr_regions(t) != 2)
> > +		goto out;
> >  	r2 = damon_next_region(r);
> >  	KUNIT_EXPECT_EQ(test, r2->ar.start, 2);
> >  	KUNIT_EXPECT_EQ(test, r2->ar.end, 4);
> > @@ -1384,6 +1386,7 @@ static void damos_test_filter_out(struct kunit *test)
> >  	KUNIT_EXPECT_EQ(test, r2->ar.end, 8);
> >  	damon_destroy_region(r2, t);
> >  
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this second region split
> test have the same vulnerability as the one fixed above?
> 
> If damos_filter_match() fails to split the region in this second test block
> (e.g. due to memory allocation failure), damon_nr_regions(t) would remain 1.
> r2 would be assigned damon_next_region(r), which could incorrectly resolve
> to the damon_target list head.
> 
> Calling damon_destroy_region(r2, t) would then call kmem_cache_free() on
> this out-of-bounds pointer, potentially corrupting memory. Should another
> early exit check be added here as well?

Good finding.  I will fix this in the next revision of this series.

> 
> > +out:
> >  	damon_free_target(t);
> >  	damos_free_filter(f);
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but while looking at region splits, could a
> similar unchecked failure cause memory corruption in mm/damon/core.c?
> 
> In damon_apply_min_nr_regions():
> 
> 			while (damon_sz_region(r) > max_region_sz) {
> 				damon_split_region_at(t, r, max_region_sz);
> 				r = damon_next_region(r);
> 			}
> 
> If damon_split_region_at() fails due to memory pressure, it does not split
> the region. The call to damon_next_region(r) then erroneously advances r to
> the next element.
> 
> If r was the last region, it becomes the list head (&t->regions_list). The
> loop condition then evaluates damon_sz_region(r) on the list head, which
> reads memory 32 bytes before the damon_target struct allocation. If this
> difference exceeds max_region_sz, damon_split_region_at() could be called
> on the list head, which might subsequently write to r->ar.end, corrupting
> SLUB metadata or preceding objects.
> 
> Should damon_split_region_at() return an error code so callers can verify
> if the split actually succeeded?

Sashiko found this in a previous reply.  I'm gonna separately work on this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260717003022.119437-1-sj@kernel.org?part=4


Thanks,
SJ
