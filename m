Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB342054E3
	for <damon@lists.linux.dev>; Tue,  4 Feb 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738711207; cv=none; b=KBXZ3oWIRavUdVHpjb+dbXt/ji1SFMHv/Cs3ILPQaSI1+u/258dicZ5EBo3SOQPs7JCI+l62WNZG8VGbL5pjGEr0Zmpi3ZvKCxMaeIKO9WELKLUuwReU5rctTjJJhMDXq/IOMvQH2JhiBqhqEj7JlmZpf120g3RsQApc7pFaGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738711207; c=relaxed/simple;
	bh=qUJBcRU8IzR2g8eWA3vSTJFCSmJSY9exr/DxrolVxDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZSfBzpq6mO0Is9SRobXW2QW/TYpvRhb5EBT0CpACJUNXZjMdBH8GrjWe9QEUIhbscFCxtEzRDIR4XEcOXoFoBK8g5fVjAkkm/TcwrUU8FHFzPKCTytyra6iqFw8y6PcP8cHhthB7fj2n+VrS9ufcWfkOO8WQM7tPa+g/wyiX4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s04Mrvza; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s04Mrvza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCA1C4CEDF;
	Tue,  4 Feb 2025 23:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738711205;
	bh=qUJBcRU8IzR2g8eWA3vSTJFCSmJSY9exr/DxrolVxDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s04MrvzaBkgZ4Q4djHNy2uT4ydLPVjUHpv9OBsBiiPkS9psd4EJ7WrIjI+9Qh05rR
	 jbeBCbpT0Xmn6e8qghS5oywOQTy8RBvBYmIJk/kvclYRFlDg+ILlNJdcI/o5Na+iWd
	 RFqYh0z8b4aN9kLIEEitPLp19eWjatoTe343G5aVo+RwYGmyenKc/gSxA908Edmwsd
	 qXjzNOqGz7+t7cqx1cmljFwi2n+6kbsAB7S0UQ/+sfaeN5F/tvpu7nuIrWK+7Sew1k
	 G9yQtbBmW/4kjK4k42fWtIuPb1nqLo5q4h1Lrxi/Ls9H70QsgFto9U7za019C0AUs1
	 36dowCzpGanAA==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 0/6] mm/damon: add support for hugepages
Date: Tue,  4 Feb 2025 15:20:02 -0800
Message-Id: <20250204232002.2951-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203225604.44742-1-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Usama,


Thank you for continuing this great work!

On Mon,  3 Feb 2025 22:55:27 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This includes adding support for larger folios in damon for paddr,

nit.  s/larger/large/

> which means largers folios will have their access checked and will
> be considered for different DAMOS actions like pageout, prioritization
> and migration.

Technically speaking, 'paddr' was supporting large folios, but the support was
implemented in a very poor or broken way.  And you're not adding a support that
didn't exist before, but improving or fixing the existing support, right?  Can
we make the sentence more accurate in the way?

> 
> Patches 3-6 add support for DAMOS hugepage filter type. This is to
> gather statistics to check if memory regions of specific access
> tempratures are backed by hugepages of a size in a specific
> range. This filter can help to observe and prove the effectivenes of
> different schemes for shrinking/collapsing hugepages.
> 
> I have kept patches 1-2 as part of these series as the later patches
> are dependent on them.

I understand the two patches will make patches 3-6 more completely work, but
not necessarily a blocker of those.  So please feel free to split those out to
another series if you want.

Also I think the second patch need to be revised, but even in the case, it
might introduce unnecessarily huge complexity for small problem.  Please refer
to the comments on the patch and let me know if I'm missing something.

I'd also ask you to put logic and API implementation before sysfs
implementation.

Added more comments in detail to each patch files except the first one, which
already got my Reviewed-by: and not changed in this version.

> 
> The corresponding damo PR is at https://github.com/damonitor/damo/pull/20.
> 
> v3 -> v4:
> - Add support for large folios of all sizes, and not just
>   PMD mapped hugepages (David and SJ).
> - only get folio while checking access/ applying DAMOS
>   scheme if the head page is also part of that region.
> 
> v2 -> v3:
> - expose hugepage via sysfs even if the kernel is
>   built without hugepage support. DAMON will just
>   just return 0. (SJ Park)
> 
> v1 -> v2:
> - Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
>   CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)
> 
> Usama Arif (6):
>   mm/damon: have damon_get_folio return folio even for tail pages
>   mm/damon/paddr: use damon_get_folio_in_region to obtain folio
>   mm/damon/sysfs-schemes: add files for setting damos_filter->folio_size
>   mm/damon: introduce DAMOS filter type hugepage
>   Docs/ABI/damon: document DAMOS sysfs files to set the min/max
>     folio_size
>   Docs/admin-guide/mm/damon/usage: Document hugepage filter type
> 
>  .../ABI/testing/sysfs-kernel-mm-damon         | 12 +++
>  Documentation/admin-guide/mm/damon/usage.rst  | 17 +++--
>  include/linux/damon.h                         | 13 ++++
>  mm/damon/core.c                               |  3 +
>  mm/damon/ops-common.c                         |  2 +-
>  mm/damon/paddr.c                              | 75 +++++++++++++++----
>  mm/damon/sysfs-schemes.c                      | 54 +++++++++++++
>  7 files changed, 151 insertions(+), 25 deletions(-)
> 
> -- 
> 2.43.5

Again, thank you for continuing this great work!


Thanks,
SJ
