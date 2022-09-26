Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A573FE4
	for <damon@lists.linux.dev>; Mon, 26 Sep 2022 16:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CE1C433B5;
	Mon, 26 Sep 2022 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664209015;
	bh=8eb5D21gEF66inNnQouUMu41BDd99PJhj1rPt0/irjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X54TgucB4ynTbW6I5lDo2kqcvFqfnqPGLCg1VJGdA3DWKJBII72OyGbdEWp+8z5BX
	 2ntH3vaQqraTo1eBhNO159zpBhepDDRdGNu/uLvopzxNb8ve/cu7s9IWptr97Zfczl
	 uInaFtL/aC61c4vgJ5APIBapiyh0CffSk51pdIrJxNTLlshQHIuaaucmGTHo+Bie3S
	 Fcd31a4ojAcs3Jrf44+1mSUdyzyIYX3mLkGtObRIfkAVftnwnP9+E5a/ATXJkzezpG
	 a3EP8IIx7UcomyrFBo866AO6C8cvb6K6kKZarrcv2XvYzHWyOkvyKBa6Sww+x2EKaA
	 P34taTW/5X6bg==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/damon: rename sz_damon_region to damon_region_size
Date: Mon, 26 Sep 2022 16:16:53 +0000
Message-Id: <20220926161653.48710-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926071100.76379-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 Sep 2022 15:10:59 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Here, i rename sz_damon_region() to damon_region_size(), and move it to
> "include/linux/damon.h", because in many places, we can to use this func.

Good idea.

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/linux/damon.h | 1 +
>  mm/damon/core.c       | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index ed5470f50bab..21f4bfd0f41f 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -524,6 +524,7 @@ void damon_add_region(struct damon_region *r, struct damon_target *t);
>  void damon_destroy_region(struct damon_region *r, struct damon_target *t);
>  int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>  		unsigned int nr_ranges);
> +unsigned long damon_region_size(struct damon_region *r);

This name looks good enough, but I'd like to suggest damon_sz_region().  What
do you think?

Also, I'd like to keep this function 'static inline' and put the definition
just after that of 'damon_first_region()'.


Thanks,
SJ

> 
>  struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
>  			enum damos_action action, struct damos_quota *quota,
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4de8c7c52979..74ab45b2c2f1 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -864,7 +864,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  	}
>  }
> 
> -static inline unsigned long sz_damon_region(struct damon_region *r)
> +unsigned long damon_region_size(struct damon_region *r)
>  {
>  	return r->ar.end - r->ar.start;
>  }
> @@ -875,7 +875,7 @@ static inline unsigned long sz_damon_region(struct damon_region *r)
>  static void damon_merge_two_regions(struct damon_target *t,
>  		struct damon_region *l, struct damon_region *r)
>  {
> -	unsigned long sz_l = sz_damon_region(l), sz_r = sz_damon_region(r);
> +	unsigned long sz_l = damon_region_size(l), sz_r = damon_region_size(r);
> 
>  	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
>  			(sz_l + sz_r);
> @@ -904,7 +904,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
> 
>  		if (prev && prev->ar.end == r->ar.start &&
>  		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
> -		    sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
> +		    damon_region_size(prev) + damon_region_size(r) <= sz_limit)
>  			damon_merge_two_regions(t, prev, r);
>  		else
>  			prev = r;
> --
> 2.31.0
> 
