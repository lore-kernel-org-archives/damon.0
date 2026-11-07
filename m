Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794089053;
	b=Tjtbo5CsQkl/xzxM40VJgp1/ns5F4VSWxenWnjMougPU8rQuQ0L5VAck0/NF07MUglaA
	 pZNWmRALC93v36g1Iu5dvf+0yYw0EwOCsOS+63wWur/lvowJK7aHJ3O5BW16VBl0T0bOw
	 MDoC5xDy4NqCXPtk8Wrk91knmcOfqhTWFPGpHwB8OUaSuh4Vb0ySeXMF7/JPQ0Ro6amwE
	 PeMMR3JvC9knBiMH3qYWbfTu2gOyfNBhBfEHoeIGvNwq8LacfA6HJA4JbV/nFTkBKfmiB
	 Z+/VsB5q5voIpJclMnOVYi88AEZdsw25LuUenMmucYP3hMpR6isLAoie0iIzkrhAWKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Vg96+k20fvX/TZK2PjIoa9UHuV5nYVYzfPAN/mfvW+Y=;
	b=NJmJi+tMvHvuHbdw1mEmxzPJc/0ww2Hzw/+q3Vn4HnFdVkaKCM1oN9yQVDkAP8dHP1UT
	 4Nsr98c9cR2TaS/suIlTcJJuGwWkyhWddtkA+TsLA8yx5NqhV9NfmpM6ySr0FzJwbrBUW
	 o782yIHssfZ18/phKoJVkpiJMCuMONgLNpuSCYNzsynwQVH6OCrXSq2xgr61GXG5q8G/1
	 bqyIRBs6aw1KywRvrebvv3FJYHekKpn3an0XXBbkAcOslQqs4ZzfcevicdopAw41kmxtu
	 /kREqZBwiQjPFzw/AawDjGeanE3fI2IRdGOo1XtBs/cmz1k2+scQj2oz7vk5S1m4TcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZHJ3xEu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF6606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZHJ3xEu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E71A1F0089F;
	Sat,  7 Nov 2026 22:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794089052;
	bh=Vg96+k20fvX/TZK2PjIoa9UHuV5nYVYzfPAN/mfvW+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UZHJ3xEuIhHMsZtkYNVBHAy8+5oCG35WH89m+XvsWKCFP1u6UNCgFVJ745ypXfhZj
	 PtrYSvxFdg/DZT91rIUPRa49xRGLR/tSXr82PJ4F79UdIt2JA8hFa0gguN99tDLJpZ
	 S7MHgg81VsCXvGnBy5jDD+retWn6XTj/4I+YdDaHJ4dY7X+Y77yO6btFVyVCc1sStd
	 +R/ZU5CLl3UBPBGR6juZTFS8M10TyczjU/LlOVM1QFz1OL5O9aY1yP5jjgkq3uSCoc
	 GVnneDsuIqA9U2Kxjxk2eAW8fWlSgVpeVMVYbxufJ0kHas9Jph5qWphKZWIhz3fv/s
	 eW+qIeyVaWHLg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.12.y 5/5] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Sat,  7 Nov 2026 14:04:04 -0800
Message-ID: <20261107220405.305058-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-203351@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 07 Nov 2026 21:58:17 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/damon/core: dangling charge_target_from ABA reuse in
>   damos_adjust_quota()
> --
> 
> commit 6429d6d07b9e92711137f889d5332896002d4342
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: remove unreachable damos charge_{target,addr}_from
> 
> This commit adds damos_fix_stale_charge_pointers() to damos_adjust_quota()
> to clear quota->charge_target_from and quota->charge_addr_from if the
> target was removed or has no regions left after a runtime parameter commit.
> 
> Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 046c07b86a6e7..badd0628e5eb2 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1686,6 +1686,26 @@ static void damos_set_effective_quota(struct damos_quota *quota)
> >  	quota->esz = esz;
> >  }
> >  
> > +static void damos_fix_stale_charge_pointers(struct damon_ctx *c,
> > +		struct damos *s)
> > +{
> > +	struct damos_quota *quota;
> > +	struct damon_target *t;
> > +
> > +	quota = &s->quota;
> > +	if (!quota->charge_target_from)
> > +		return;
> > +	damon_for_each_target(t, c) {
> > +		if (t == quota->charge_target_from) {
> > +			if (damon_nr_regions(t) > 0)
> > +				return;
> > +			break;
> > +		}
> > +	}
> > +	quota->charge_target_from = NULL;
> > +	quota->charge_addr_from = 0;
> > +}
> > +
> >  static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >  {
> >  	struct damos_quota *quota = &s->quota;
> > @@ -1714,6 +1734,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >  		damos_set_effective_quota(quota);
> >  	}
> >  
> > +	damos_fix_stale_charge_pointers(c, s);
> > +
> >  	if (!c->ops.get_scheme_score)
> >  		return;
> 
> [Severity: Medium]
> Can damos_fix_stale_charge_pointers() match a different target if
> quota->charge_target_from is left dangling until damos_adjust_quota()
> runs?
> 
> When damon_commit_targets() removes a target via damon_destroy_target(),
> it frees dst_target without clearing quota->charge_target_from, and
> damon_commit_ctx() then calls damon_set_attrs() ->
> damos_set_next_apply_sis(), deferring damos_adjust_quota() to a later
> interval.  If a newly committed target reuses the freed slab address
> before then (or if damon_commit_target() overwrites dst_target in place
> with a different target), t == quota->charge_target_from matches the new
> target and leaves the stale charge_target_from and charge_addr_from in
> place whenever damon_nr_regions(t) > 0, causing damos_skip_charged_region()
> to skip targets and regions up to the old address.
> 
> Clearing charge_target_from and charge_addr_from directly in
> damon_commit_targets() when a target is destroyed or updated would avoid
> comparing a dangling pointer later.

Good finding, but this is not a blocker of this patch.  Occasionally starting
quota charging from unexpected target is no real problem for real DAMOS usages.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261107214525.304638-1-sj@kernel.org?part=5
> 


Thanks,
SJ
