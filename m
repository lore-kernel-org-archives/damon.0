Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0BB21B1B4
	for <damon@lists.linux.dev>; Tue,  4 Feb 2025 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710399; cv=none; b=Oipf4jMZmWc+F4kRb6N0/bAVxH0dSci/4lDMVJgJkXxKGGSPQOCoKgHKFpMiROr8FLJcproGrm8Fvw5O+jyDwRAk3Lmz5NcFrm8K7WGDpr/Uhfu/W1vDcqPih5QbTXhUOMA3GacWCXqwJCiYdGn2V1QOeNPhQ3l93GnKchJKAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710399; c=relaxed/simple;
	bh=5BkAsVQ0nPHirdPibg830SVNIrWkbzxA3OWt0ISmOCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQ3Agp+ByFMWQK9Xwfix0BSwmG1oxZyOmQkBQ0YAmFWf7GB0KuW4KgEWX0oVAvdtXzVimD94/KbR3LRoB/vmvNx0wrkcW6bw7Ne/WYSqXUgdqABKs54bi1emi3b7A+t/K/fVF1JcT2CHAiS3ewFRz5ujxvFp/m4Ba666emZEUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu/Cossp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu/Cossp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41756C4CEDF;
	Tue,  4 Feb 2025 23:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738710398;
	bh=5BkAsVQ0nPHirdPibg830SVNIrWkbzxA3OWt0ISmOCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tu/CosspCqzpdTu6dpjhSzl3bJoX1nDhsLiHrXBpC2HIpqdWacRi532OMeKCu8Xeq
	 f3vZnpS5nNE7rf0d6fIkIK0QU2bwQ+Kcq0b6oy/vBQSYkLqT4QVRTGRuJJs1HOkAfx
	 +ER246v+wz5iaxF0krVEnV8/tpmKmIcldz/liDwkgqWfiLPBH/ytYh8CQvFiWJPt4d
	 Nz937/jkg3nHle6Eg/rvjLs+B8y5KE91Jr85NYNxgHUBW9fRHOpZ20MjRWAyWCQ4Tk
	 M0Mjl/MCx8maA5ubb1VhnSTUKKmifGu57xUSbSn27SJjRpPhH8P9/dFVIVJFFptwtH
	 6UYZlNaB57MrQ==
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
Date: Tue,  4 Feb 2025 15:06:34 -0800
Message-Id: <20250204230634.2577-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203225604.44742-3-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  3 Feb 2025 22:55:29 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This is introduced for larger folios. If a large folio has subpages
> present in multiple regions, it will be considered multiple times.
> This can be when checking access

I think this behavior makes sense.  If a 2 MiB address range is known to be
accessed or not, treating DAMON regions in the address range as all accessed or
not aligns with the DAMON's region definition and makes sense in general, to
me.  Note that DAMON's adaptive regions adjustment mechanism will make the
DAMON regions in a large folio to be merged in near future.

> or applying DAMOS schemes. For e.g.
> in pa_stat, folios split across N regions will be counted N times,
> giving inaccurate results.

Nice catch!  I agree this could be a problem.

> Hence, only consider a page for access check/DAMOS scheme only if the head
> page is part of that region as well.

For access checking, this seems wrong to me.  This change will unnecessarily
mark some DAMON regions as not accessed.

Even for DAMOS, this seems not very optimum.

1. DAMOS will unnecessarily repeat PAGE_SIZE skippings on second and later
   DAMON regions of a same large folio.
2. If only a small part of the large folio belongs to the first DAMON region,
   and the DAMON region is not eligible to the scheme, while the second region
   is, the scheme action will not applied to the second region.

Also, I think this problem can happen on vaddr case.  Hence, making the change
on core layer makes sense to me.

That is, let damon_ops->apply_scheme() inform the caller (damos_apply_scheme())
how much bytes of the next region should be ignored at applying the action.
Due to the complicated implementation of DAMOS core logic, this might be not
very simple.

I think the additional complexity might outweigh the benefit for following
reasons.  First, adaptive regions adjustment mechanism will make DAMON regions
in same large folios to be merged soon.  So the problem will be not significant
in common case.  Second, any threads could collapse any parts of memory into
large folios while DAMOS is traversing DAMON regions.  So this problem cannot
perfectly be solved unless we make DAMOS' DAMON regions traversal exclusive
with any large folios collapsing.  Which would add more complexity.

And given DAMON's best-effort nature, keeping the issue until we get a simple
and effective solution is ok to me, unless a real significant issue from this
is confirmed.

Usama, what do you think?


Thanks,
SJ

[...]
