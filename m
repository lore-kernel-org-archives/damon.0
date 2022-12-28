Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BB2CAB
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 17:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CC3C433EF;
	Wed, 28 Dec 2022 17:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672250106;
	bh=R4VIrBez7zH9MYP4YY6ze39/ChSx4hb6ppbwjxME1iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqhyqECtyME/yqrpVaueW9+tRVTRF1BCu4Nbc/P/tAGBhoK4f7RoSsC2IBkhs8pWh
	 VBpwm29g1Nl/oJ+JizOczncIh4WxMovAGvgNzds3M4FC0Xz87RkRRMOy4B/OaJWMWO
	 pzwQiflKbkpTpzf00zjQ16GGKVN10ZbePSvhABEn3G9nwh9eXXbRJL2bMBEbs/bA8V
	 9Xq2GZ2hso7X9dRDXtU7RVtwhVrzHWEMC3R35ZrenzIgxE3b7AyDFwuLCSpvx2OXPT
	 loxViyye08fiB6wsiSWNIBQOVOagkMzI90z2jZ+a1uwdkLhUuZ4s0PkVoPJ5/N5Ugu
	 c+nha9nNWbIxA==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	vishal.moola@gmail.com,
	willy@infradead.org,
	david@redhat.com
Subject: Re: [PATCH -next v3 0/7] mm: convert page_idle/damon to use folios
Date: Wed, 28 Dec 2022 17:55:04 +0000
Message-Id: <20221228175504.149395-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228113413.10329-1-wangkefeng.wang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kefeng,

On Wed, 28 Dec 2022 19:34:06 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> v3:
> - more thoroughly converting in page_idle_get_folio() suggested by Matthew
>   also do it in damon_get_folio().
> - address some commets from SeongJae
> 
> v2:
> - drop unsafe pfn_to_online_folio(), convert page_idle_get_page() and 
>   damon_get_page() to return a folio after grab a reference
> - convert damon hugetlb related functions
> - rebased on next-20221226.
> 
> Kefeng Wang (7):
>   mm: page_idle: Convert page idle to use folios
>   mm/damon: introduce damon_get_folio()
>   mm/damon: convert damon_ptep/pmdp_mkold() to use folios
>   mm/damon: paddr: convert damon_pa_*() to use folios
>   mm/damon: vaddr: convert damon_young_pmd_entry() to use folio
>   mm/damon: remove unneed damon_get_page()
>   mm/damon: vaddr: convert hugetlb related function to use folios

Thank you so much for your efforts on this work.  I found I forgot mentioning
some trivial typos in the first, the sixth and the seventh patches, so
commented.  I should have commented those earlier, sorry.

Other than those,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> 
>  mm/damon/ops-common.c | 38 +++++++++++++++-------------
>  mm/damon/ops-common.h |  2 +-
>  mm/damon/paddr.c      | 58 +++++++++++++++++++------------------------
>  mm/damon/vaddr.c      | 38 ++++++++++++++--------------
>  mm/page_idle.c        | 47 ++++++++++++++++++-----------------
>  5 files changed, 91 insertions(+), 92 deletions(-)
> 
> -- 
> 2.35.3
> 
