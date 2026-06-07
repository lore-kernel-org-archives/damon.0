Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D02D3ECF;
	Sun,  7 Jun 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780851196; cv=none; b=ntW4eea+HpwbiGp0RX3oFj7HmjcEio286yT8BADysr8MsmgoZcvkvx8MXKyPZwr206CiHT/Vj69cwxw7Almou8BWL8jCqWjOEJJEbhuJg0PTzFgKx8BwY2b20qZyuAEfNWYbO3YNOSCiOQn7jK7DbJ+DFwFiOrsYzoYQy1oUruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780851196; c=relaxed/simple;
	bh=ljpIQFRFckflNVICmSEoqA2XPwt2FkOF12tQcjOfWDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjJ2hWk9GfZKJHYf3LcYC+JJ2jA/T7JoK6lMe75O55sZMyU2NK/Xw7Rc4uM1XlvkCBvSqxgIIsJXyQbx3eBosXIFURtUySK5/l8z12mol28XRiPUSrfoUKV4nfAxcZ8LHkLMJGyyZY3s9HsB1ufgzi38GQG7MI15xy35dqAfvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TohwrbPs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TohwrbPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CBE1F00893;
	Sun,  7 Jun 2026 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780851194;
	bh=BYvllh828OEo5YmAfffzBOwQRz1Nkklj1UYoBt49RSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TohwrbPsBtqeQhFfFgF52wyCgnviyVAWSuXKxFJHBiTIgWQQGzoK1EtNBoALbydkQ
	 51CGXRRReXS4xTJqnXXMvyegujt15YSLOGMhVPvbR/abYWVONUH4YMiN59qICa7la5
	 T7g7HmMt2xsWOjkir3BPTIRlPmC+pYIBgm33cY/Ea/w+sFfQuqI636qTXkpDBib2oO
	 9PfQC/cAyRa/0mBZ67r71ZUIL3gFbaniC8goOkJerlsN5H6FFLUw+5yO3TNd+vuSbD
	 uoFBJ2NPi143XzYeDWbA7cY3KDwX092Lbn620pfKDsNsLyhjTGIJ56aro2UdVhH0xk
	 E19kEcKLvnTsg==
From: SeongJae Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 02/10] mm/damon/core: add damon_new_region() debug_sanity check
Date: Sun,  7 Jun 2026 09:53:05 -0700
Message-ID: <20260607165305.93321-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d057097f-2efc-4f27-861b-ac076b93e34f@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Zenghui,

On Sun, 7 Jun 2026 23:24:27 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> Hi SeongJae,
> 
> On 3/6/26 11:29 PM, SeongJae Park wrote:
> > damon_new_region() is supposed to be called with only valid address
> > range arguments.  Do the check under DAMON_DEBUG_SANITY.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/core.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index f1a97e85824ac..0c1353164ec81 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -109,6 +109,17 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
> >  	return err;
> >  }
> >  
> > +#ifdef CONFIG_DAMON_DEBUG_SANITY
> > +static void damon_verify_new_region(unsigned long start, unsigned long end)
> > +{
> > +	WARN_ONCE(start >= end, "start %lu >= end %lu\n", start, end);
> > +}
> > +#else
> > +static void damon_verify_new_region(unsigned long start, unsigned long end)
> > +{
> > +}
> > +#endif
> > +
> >  /*
> >   * Construct a damon_region struct
> >   *
> > @@ -118,6 +129,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
> >  {
> >  	struct damon_region *region;
> >  
> > +	damon_verify_new_region(start, end);
> >  	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
> >  	if (!region)
> >  		return NULL;
> 
> This can be triggered with
> 
> 	echo Y > /sys/module/damon_sample_mtier/parameters/enabled
> 
> because both node{0,1}_{start,end}_addr are 0 if people forget to properly
> initialize them.

Nice finding!

> This can be avoided by checking the parameters right
> before damon_new_region(). But I'm not sure if this is the correct
> solution.
> 
> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index 775838a23d93..4a5d3fb12e1b 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -118,6 +118,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
>  	} else {
>  		addr.start = promote ? node1_start_addr : node0_start_addr;
>  		addr.end = promote ? node1_end_addr : node0_end_addr;
> +
> +		if (addr.start >= addr.end)
> +			goto free_out;
>  	}
>  
>  	region = damon_new_region(addr.start, addr.end);

Because mtier is just a sample module, and this doesn't cause a catastrophic
situation like system crash, I think this is very urgent.  But, given the
simplicity of the change, this looks good to me.  If you'd like to send a
patch, please feel free to do.

The real problem in my perspective is, however, the fact that DAMON core is
not providing a central parameters sanity check.  As a result, each DAMON core
API callers are implementing their own validation that often and repeatedly
turns out to be incomplete, like this.  I'm working on such central sanity
check and further refactoring DAMON API.  Some of work in progress [1] is
available at damon/next tree.  While the work is ongoing, adding this kind of
additional check should also be fine.

[1] http://git.kernel.org/sj/c/16a0e8ecd699f86b


Thanks,
SJ

[...]
