Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C147260B;
	Tue, 26 Aug 2025 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177571; cv=none; b=f7Ne907l0fAp6V4eXNQ8szl6AP7sTX0ye3T3iPFu8gyOaCr7l7NLQA3qk1h4GjIjBF4UPrnPZhDFJC4m9z3fXsQSNKeGLZluXPuZsdk53VfsijKkK4pD171U3l2W7PGjPB6OedputF2E6oobct8jpxHXOaIAgUpbqvWflkNgvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177571; c=relaxed/simple;
	bh=3e4hvzpDH6EODnkYI8p9FQ9wL3jJv36ugO7+Ag6HcVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OATC9lgH2cDY0OT8TmlUNT8xaH1rxi6LyQmLj0tz48W1UfWyp73qdTxj1R/pVLN7yXnUM0tiw7glPL1mlES7YeYCooMzloI4K/18bzXT6sTwcP8ju0W8zlNpZwEg5Zq0MHgbFFVJtqynUr9NKqt2eScYiScvYPzXl7ksbyzRTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1KYSH54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1KYSH54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE7FC4CEF1;
	Tue, 26 Aug 2025 03:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756177571;
	bh=3e4hvzpDH6EODnkYI8p9FQ9wL3jJv36ugO7+Ag6HcVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1KYSH54VdstYOlsRJ7bZRGckzrCWNXRvBKWbeYaET9GZnEar0BMrUxNQQv2UfKp0
	 UlH2DKwBqde+W/Y8njuZOdU/vZD+3O83g98NE/xqceYm6q0SR2dwe1Swl+fODTkJ7P
	 Pgc4mnskWH9RAGbDUnJatiXnHke7v8Is3VnEMpZ0HLzShRI0G9APMG3D6eBsZJ+jmi
	 2LUu8H3MGvcjxuspcag4ORR2lp9eeL+n129vez9wiFcPUyCSXVjRgBQ4cNsxJSal13
	 oekjc7lenkJOnt7w6hModY1ZLC2t+a4HBMkYNtZ1NFagqNQ1xlAYtgmRteGO/ul4fh
	 qorS4x0wx4wXA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2 04/11] mm/damon/paddr: support addr_unit for DAMOS_LRU_[DE]PRIO
Date: Mon, 25 Aug 2025 20:06:08 -0700
Message-Id: <20250826030608.44305-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250825151353.36392-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 Aug 2025 08:13:53 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 22 Aug 2025 17:34:12 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> 
> > From: SeongJae Park <sj@kernel.org>
> > 
> > Add support of addr_unit for DAMOS_LRU_PRIO and DAMOS_LRU_DEPRIO action
> > handling from the DAMOS operation implementation for the physical
> > address space.
> [...]
> > -	return applied * PAGE_SIZE;
> > +	return applied * PAGE_SIZE / addr_unit;
> >  }
> 
> This can cause __udivdi3 linking issue similar to the report [1] from kernel
> test robot.  Andrew, could you please add below attaching fixup?
> 
> [1] https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/

Hi Andrew, I posted three fixups for the __udivdi3 issue, and I see you picked
two of those in mm tree.  But this one is not yet picked.  Could you please
also add this fixup to mm tree?


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
> [...]
> 
> ==== Attachment 0 (0002-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_de_ac.patch) ====
> From hackermail Thu Jan  1 00:00:00 1970
> From: SeongJae Park <sj@kernel.org>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: damon@lists.linux.dev
> Cc: kernel-team@meta.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Date: Mon, 25 Aug 2025 07:45:24 -0700
> Subject: [PATCH 2/3] mm/damon/paddr: use do_div() on i386 for
>          damon_pa_de_activate() return value
> 
> Otherwise, __udivdi3 linking issue happens on certain configs.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/paddr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 09c87583af6c..6fb92ecc513d 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -236,7 +236,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>  		folio_put(folio);
>  	}
>  	s->last_applied = folio;
> -	return applied * PAGE_SIZE / addr_unit;
> +	return damon_pa_core_addr(applied * PAGE_SIZE, addr_unit);
>  }
>  
>  static unsigned long damon_pa_mark_accessed(struct damon_region *r,
> -- 
> 2.39.5
