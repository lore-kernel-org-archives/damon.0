Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80528214A96
	for <damon@lists.linux.dev>; Wed,  5 Feb 2025 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791657; cv=none; b=KgQOr4lQTOPoD0NTnYpDyTJmfo5UnIw4fNVxcmB9o2EptzrforemprtGGnmNTlT/ezVd3O4O/aMJEjb+EYT5iN3geXJ+fn9ufLpVK6HuEe7F21AwQbhcnLtbj8CA2Vd8JTZoe8R4EzJQ/gubZnC+qA0CTWK02CnUyH29KB2PAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791657; c=relaxed/simple;
	bh=JEUq1A020TkN5K0OxyI0VRv9LsAeZOuxW1dmqB76WuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klYAqlEHBdWXSY3T2XMxcyn23pabzVwwEcIptXI//pRqiyflJlPrstlgjwMNaRXmNv10roj9CWPqs5hNsw6UGg6aKkQwZosCq6bOJfrxNzUgJ5oDGZQV9gzM6LI4y2/WsMuSjL+hQbRKymZiHQMFwMjjoD10p3Z+AB9wLApTHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEjEo0dQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEjEo0dQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FCCC4CED1;
	Wed,  5 Feb 2025 21:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738791656;
	bh=JEUq1A020TkN5K0OxyI0VRv9LsAeZOuxW1dmqB76WuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEjEo0dQgVt2VVZysZ4N+y++oF64/bcWaybw1lJZxnshny0+D655lVaD9UgphzJcu
	 b1csIDkRGJbTBOKcnzYuoEM8jlmYMZETbxQiddur3VUJknjZxoHXe5IHxn589VxZam
	 CD/Ibe4qPiGcbKf5X5guBSYyAjMnVlO7eJRmjBgoecTy/iYkqW5EOtVyUZ5+YMBhi+
	 mxXGgE7TlKguAvXbteFjyDG9cgnN5vOKNecMRAVRQH5FaqrNhFF5om2S/sROw0k/cM
	 uPgmfdGJfmRylXW6pGicyzgcfZ+/j0XkTJ3u7b6AuVMPFgES1Vqsk5y2WXm5KxeJFh
	 0R7e5uvvIJlCw==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 2/6] mm/damon/paddr: use damon_get_folio_in_region to obtain folio
Date: Wed,  5 Feb 2025 13:40:52 -0800
Message-Id: <20250205214052.60099-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <c1902ae7-4664-4891-baa0-cd895aa62fce@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Feb 2025 12:46:39 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> On 04/02/2025 23:06, SeongJae Park wrote:
> > On Mon,  3 Feb 2025 22:55:29 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> > 
> >> This is introduced for larger folios. If a large folio has subpages
> >> present in multiple regions, it will be considered multiple times.
> >> This can be when checking access
> > 
> > I think this behavior makes sense.  If a 2 MiB address range is known to be
> > accessed or not, treating DAMON regions in the address range as all accessed or
> > not aligns with the DAMON's region definition and makes sense in general, to
> > me.  Note that DAMON's adaptive regions adjustment mechanism will make the
> > DAMON regions in a large folio to be merged in near future.
> > 
> >> or applying DAMOS schemes. For e.g.
> >> in pa_stat, folios split across N regions will be counted N times,
> >> giving inaccurate results.
> > 
> > Nice catch!  I agree this could be a problem.
> > 
> >> Hence, only consider a page for access check/DAMOS scheme only if the head
> >> page is part of that region as well.
> > 
> > For access checking, this seems wrong to me.  This change will unnecessarily
> > mark some DAMON regions as not accessed.
> > 
> > Even for DAMOS, this seems not very optimum.
> > 
> > 1. DAMOS will unnecessarily repeat PAGE_SIZE skippings on second and later
> >    DAMON regions of a same large folio.
> 
> Hi SJ,
> 
> Thanks for the reviews! Just a small point on 1. below, but most is addressed at
> the end.
> 
> If needed, we could add another arg in damon_get_folio_in_region to return the size
> of folio if head page was not part of the region to skip by that size instead of
> PAGE_SIZE.
> 
> > 2. If only a small part of the large folio belongs to the first DAMON region,
> >    and the DAMON region is not eligible to the scheme, while the second region
> >    is, the scheme action will not applied to the second region.
> >
> > Also, I think this problem can happen on vaddr case.  Hence, making the change
> > on core layer makes sense to me.
> > 
> > That is, let damon_ops->apply_scheme() inform the caller (damos_apply_scheme())
> > how much bytes of the next region should be ignored at applying the action.
> > Due to the complicated implementation of DAMOS core logic, this might be not
> > very simple.
> > 
> > I think the additional complexity might outweigh the benefit for following
> > reasons.  First, adaptive regions adjustment mechanism will make DAMON regions
> > in same large folios to be merged soon.  So the problem will be not significant
> > in common case.  Second, any threads could collapse any parts of memory into
> > large folios while DAMOS is traversing DAMON regions.  So this problem cannot
> > perfectly be solved unless we make DAMOS' DAMON regions traversal exclusive
> > with any large folios collapsing.  Which would add more complexity.
> > 
> > And given DAMON's best-effort nature, keeping the issue until we get a simple
> > and effective solution is ok to me, unless a real significant issue from this
> > is confirmed.
> > 
> > Usama, what do you think?
> > 
> > 
> 
> So the reason I added this patch was when testing out the series on a VM that was only
> running a C program continuously accessing 200M hugepages, DAMON was reporting more
> than 200M of hugepages everytime, it was usually around 206-208M,
> but sometimes quite high. I have added an example at the end showing 266M of hugepages,
> which is more than 25% off.
> Since this is page level attributes and not sampling based, I believe we should report
> accurate results everytime, even at the start.

Thank you for kindly sharing the problem you show in detail.  I agree your
points, and now I believe this is definitely better to be more accurate.

> 
> I think it makes sense when you say that adaptive region adjustment will make the regions
> converge, but without this patch even after 20 minutes of running, I couldn't get 200M.

I think that's due to the random regions split mechanism, and it shows we have
rooms to improve the adaptive regions adjustment mechanism.  But as you
mentioned with page level monitoring's expectation, the hugepage handling also
deserves its own enhancement.

> With this patch, I get 200M everytime.

Great!

> 
> I agree with the points you raised and I thought of the same when trying to come up with
> this patch. The reason I did in both access check and DAMOS was I thought its best to have
> consistency throughout on how folios in damon regions are treated.

You're right.  I agree the consistency is important.  Nevertheless, the
monitoring behavior looks sane to me.  The core layer is asking if a two bytes
of a huge page which arises in different DAMON regions are accessed or not.
Regardless of if the two bytes are in same DAMON rgion or not, from 'paddr's
perspective, those are both accessed or unaccessed together.  Saying so makes
no problem to me.

For DAMOS, this is definitely a problem, though.

> I think the solution
> for this is probably some compromise between simplicity and accuracy.
> 
> I think we have 3 ways forward?
> 1. Try and improve current patch, where we ignore the folio if the head page is not part of
>    the region, for both access check and DAMOS. The way we treat large folios will then be
>    consistent for all cases, but there are other issues which you highlighted above.
> 2. Only do the approach in this patch for DAMOS schemes, i.e. use damon_get_folio_in_region
>    only for damon_pa_pageout/mark_accessed_or_deactivate/migrate/stat.
>    We dont do it for damon_pa_mkold/young.
> 3. Only do this approach for pa_stat.
> 
> My preference is going forward with option 2, as we wont do pageout/migration/etc repeatedly
> to the same folio, but I think option 3 is fine as well, so that we atleast get the right
> stats. Let me know what you think is the best way forward?

I also think option 2 is the best among these.  But, I'm not really sure if the
behavior is correct.  I listed two problematic case at applying this approach
for DAMOS.  You suggeested a practical way to mitigate the first case
(unnecessary 4K length skips), but I think the second case is still not solved.

So I think the core-ops collaborative solution I mentioned in the previous
reply makes more sense: "That is, let damon_ops->apply_scheme() inform the
caller (damos_apply_scheme()) how much bytes of the next region should be
ignored at applying the action."

I thought it is too much complexity, but your kind sharing of your case changed
my mind.  If you don't mind, I'd like to make and post that change.  May I?

I think this problem is definitenly need to be better handled, but I still
don't think this is a blocke for the rest of this patch series.  Pleease feel
free to post next spin whenever you want.


Thanks,
SJ

[...]
