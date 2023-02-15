Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F044D2E1
	for <damon@lists.linux.dev>; Wed, 15 Feb 2023 20:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2FBC433D2;
	Wed, 15 Feb 2023 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676492751;
	bh=os1l2QpY3JmJBjUKP58QMx61GxEfMBxX9wW/qhau3Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=se8sumWAp4cC6xYEvZm0k/vTiSQ5XuMVkJ5esfyL9vk8I7RlFF6ai7V1E3jZtBRLc
	 Bo3gpsa6aDzKYdqhFYfcVcwCotOIi6qZoeKMMUTMPUnbzPC5pnOB0dy74FSMfLij37
	 vHVqCj7ejNc1HvWWfKN/rkVt2NQim6+7Oab4AF9vbqcVCkg9ximutnuxZ0SB0hroOu
	 iol6UlKKhsGXSGaPMukXtraayv4cKe4cjvO/nk76IQRLkVC3ABAxMbIbj8mmWKoMlk
	 qZvnipkjfdfe6xjVAQkaI0vPIL0ELw3ZkLZE8nCE9GsFvxOG+QPHxDZwizBmgcz+RF
	 DYBmr2aIWSREQ==
From: SeongJae Park <sj@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	sj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	naoya.horiguchi@nec.com,
	linmiaohe@huawei.com,
	david@redhat.com,
	osalvador@suse.de,
	mike.kravetz@oracle.com,
	willy@infradead.org,
	damon@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mm: hugetlb: change to return bool for isolate_hugetlb()
Date: Wed, 15 Feb 2023 20:25:48 +0000
Message-Id: <20230215202548.92462-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <12a287c5bebc13df304387087bbecc6421510849.1676424378.git.baolin.wang@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Feb 2023 18:39:36 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
> care about the negative value, thus we can convert the isolate_hugetlb()
> to return a boolean value to make code more clear when checking the
> hugetlb isolation state. Moreover converts 2 users which will consider
> the negative value returned by isolate_hugetlb().
> 
> No functional changes intended.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
[...]
>  include/linux/hugetlb.h |  6 +++---
>  mm/hugetlb.c            | 13 ++++++++-----
>  mm/memory-failure.c     |  2 +-
>  mm/mempolicy.c          |  2 +-
>  mm/migrate.c            |  7 +++----
>  5 files changed, 16 insertions(+), 14 deletions(-)
> 
[...]
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3a01a9dbf445..16513cd23d5d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2925,13 +2925,16 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>  		 */
>  		goto free_new;
>  	} else if (folio_ref_count(old_folio)) {
> +		bool isolated;
> +
>  		/*
>  		 * Someone has grabbed the folio, try to isolate it here.
>  		 * Fail with -EBUSY if not possible.
>  		 */
>  		spin_unlock_irq(&hugetlb_lock);
> -		ret = isolate_hugetlb(old_folio, list);
> +		isolated = isolate_hugetlb(old_folio, list);
>  		spin_lock_irq(&hugetlb_lock);
> +		ret = isolated ? 0 : -EBUSY;
>  		goto free_new;

Nit.  I'd personally prefer to set 'ret' before entering this critical section
to keep the section short, but this would be just a mean comment that wouldn't
worth request respin.


Thanks,
SJ

[...]
