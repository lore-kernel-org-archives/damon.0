Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB135953;
	Wed, 30 Jul 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905762; cv=none; b=Xyor+pSY+gsyE02b84y18j4J62B1RAzKrzcvRPvr8y3/PLU/cH7k4v6hI9g7wGHK3CPqn9xs795ojG3IOCDIWBV3r5o2yzeEoKeCya3QGQHzUZLpLj0UV5XgiG6DwR7QvJ8WN4eqGWIt3Gk6SCAJkZ0qIp4h09TANr7V9aIgpUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905762; c=relaxed/simple;
	bh=dIsX0oxgpw98gKQ6TNOqvSsrt9blwqaLCC5pGxia6zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nVjobFtLhhNE8LwA9Zi0vIPgvowUk7u60ytq+7DizLxXc4B/P+GX/sEpVvCnnudry7QG4MXBolYwggOeQQBnqCwkVhSDUXitSMCRemgcj5ptv++nhW9ekX4Q2QX1ABHJW0m/BGfuN7eT2VjZJoFSCipCtc0xvQTNQ/hqSQ05GRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWq+eFBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWq+eFBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E44C4CEE3;
	Wed, 30 Jul 2025 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753905761;
	bh=dIsX0oxgpw98gKQ6TNOqvSsrt9blwqaLCC5pGxia6zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWq+eFBNOyR8w0I3ocYT703G24D1cY21SPPSy5rDUj1YKQuc5KYbexihbYwvICScD
	 iK55DJX7malZ+S3Btr6UZrTKkSeeF+Dio/+0nDAM9/7QbvXZ6A9lwch7U0YO9YTXTj
	 YDz5KtYSZ3XeUjOycBOMqEZRjU9JY15OWFUQzNsCtxYo7Pw2KlWcmXJwk9Urieqtut
	 EM0Jmxsrv01juDgQMMs3/6JdbgveBFXXjmELH75DWA/pAIQFA7e1XBAAVT084Y5Iof
	 zq3l/fS3g96SzmX+R8PJglg1ltZjLN/ag7h/7C925q4LKSgGx2Z7oaIPM6KAwIMCKz
	 r1RbgWIOK9kpA==
From: SeongJae Park <sj@kernel.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/damon: Add damos_stat support for vaddr
Date: Wed, 30 Jul 2025 13:02:39 -0700
Message-Id: <20250730200239.60984-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1753895066.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 10:19:54 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:

> Previously damos_stat only supoort paddr. This patch set adds support 
> for damos_stat for vaddr. Also all different types of filters are 
> supported. 
> 
> Functionality Test
> ==================
> I wrote a small test program which allocates 10GB of DRAM, use 
> madvise(MADV_HUGEPAGE) to convert the base pages to 2MB huge pages
> Then my program does the following things in order:
> 1. Write sequentially to the whole 10GB region
> 2. Read the first 5GB region sequentially for 10 times
> 3. Sleep 5s
> 4. Read the second 5GB region sequentially for 10 times
> 
> With a proper damon setting, we are expected to see df-passed to be 10GB
> and hot region move around with the read
> 
> $ # Start damon record
> $sudo ./damo/damo start "./my_test/test" --monitoring_intervals 100ms\
> 1s 2s

Above command is not really doing record, so the first line would better to be
updated, say, "Start DAMON" ?

Also, it is easier to read if you give prefix spaces for quoting commands as
well, to make it consistent with their outputs.  Fo for example, above could be
something like below.

    $ # Start DAMON
    $ sudo ./damo/damo start ...

> 
> $ # damon report
> $sudo ./damo/damo report access --snapshot_damos_filter allow \
> hugepage_size 2MiB 2MiB

Again, I'd prefer having prefix spaces for above commands consistent to the
following output.

Also, maybe the first comment could be more detailed, say, "Show
DAMON-generated access pattern snapshot" ?

>     heatmap:
>     # min/max temperatures: -600,000,000, 100,001,000, column size: 137.352 MiB
>     intervals: sample 100 ms aggr 1 s (max access hz 10)
>     # damos filters (df): reject none hugepage_size [2.000 MiB, 2.000 MiB]
>     df-pass:
>     # min/max temperatures: -400,000,000, 100,001,000, column size: 128.031 MiB
>     0   addr 85.373 TiB   size 745.555 MiB access 0 hz   age 6 s           df-passed 0 B
>     1   addr 127.608 TiB  size 877.664 MiB access 3.000 hz age 0 ns          df-passed 878.000 MiB
>     2   addr 127.609 TiB  size 219.418 MiB access 2.000 hz age 0 ns          df-passed 220.000 MiB
>     3   addr 127.609 TiB  size 316.613 MiB access 1.000 hz age 1 s           df-passed 316.000 MiB
[...]
>     memory bw estimate: 6.524 GiB per second  df-passed: 6.527 GiB per second
>     total size: 10.731 GiB  df-passed 10.000 GiB
>     record DAMON intervals: sample 100 ms, aggr 1 s
> 
> 
> $ # damon report again
> $sudo ./damo/damo report access --snapshot_damos_filter allow \
> hugepage_size 2MiB 2MiB

Ditto.

>     heatmap:
>     # min/max temperatures: -1,100,000,000, 2,000, column size: 137.352 MiB
>     intervals: sample 100 ms aggr 1 s (max access hz 10)
>     # damos filters (df): reject none hugepage_size [2.000 MiB, 2.000 MiB]
>     df-pass:
>     # min/max temperatures: -900,000,000, 2,000, column size: 128.031 MiB
>     0   addr 85.373 TiB   size 745.555 MiB access 0 hz   age 11 s          df-passed 0 B
>     1   addr 127.608 TiB  size 579.715 MiB access 2.000 hz age 0 ns          df-passed 580.000 MiB
>     2   addr 127.608 TiB  size 144.930 MiB access 2.000 hz age 0 ns          df-passed 146.000 MiB
>     3   addr 127.608 TiB  size 452.453 MiB access 2.000 hz age 0 ns          df-passed 452.000 MiB
[...]
>     memory bw estimate: 5.297 GiB per second  df-passed: 5.297 GiB per second
>     total size: 10.731 GiB  df-passed 10.000 GiB
>     record DAMON intervals: sample 100 ms, aggr 1 s
> 
> As you can see the total df-passed region is 10GiB and the hot region
> moves as the seq read keeps going
> 
> Revision History
> ================
> Changes from v1 [1]:
> - Follow David's advise to combine *pmd_entry() and *pte_entry() into
>   one. Also remove manually setting walk->action
> - Use vma_normal_page and vma_normal_page_pmd instead of damon_get_folio
>   to remove redundant folio_get and folio_put
> - Follow SJ's advise to only move damon_pa_scheme_has_filter to
>   ops-common
> - Change the command used in cover-letter for more natural illustration
> 
> [1] https://lore.kernel.org/all/cover.1753794408.git.pyyjason@gmail.com/
> 
> Yueyang Pan (2):
>   mm/damon: Move has filter to ops-common
>   mm/damon: Add damos_stat support for vaddr

I also left a few trivial comments to the patches.  So I find no real concerns
but asking for a few trivial cleanups.  Could you please make the changes with
next version, after waiting a day for giving others to chime in for things I
may missed?


Thanks,
SJ

[...]
