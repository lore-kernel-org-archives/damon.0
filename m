Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091148;
	b=XwEwlx3BY1wHSTalcgoGSAnz39oNDrHqlQRFuWo1eHvHDLD5I98Wph1g57P4NI3ZOq2P
	 8tgSK8r9s1Sr+na/YA6bIf6JxKesbqE9/BDpxTq6FZTm+cZrkG0lPXuFIm+VRCu6IDu+x
	 sQSSffFupfB4nrtGqblGACbovG+YQ+2CFU7HctMemSpNft6lmrn6PqTyb5y+tQlLBDZT9
	 9K3zvmZHB/13dmCF3YpVBmUiJdEZtyoFRrHdhsA4WSCP6XV/hyprk0uomwxprRGpYPCUP
	 wQZLb2/w6pBD3QgFywzuHgJJtmuM9z/5v+SkMp320aDZI8kVYqadYu0zYcTnyrvLV0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091148;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XBd2FYBcaPk2XSMjlkWCU4wyPCzPsns5z6a0+wxgQxQ=;
	b=OIKyYok1Tg1vGpScKb41Kn84KbR1GAacROQdoA8sfTtMj0BjNplZxKRoqQ69rIFhWM4P
	 +yZlPRdsXdhVEdCB4kmbSDq2cyIbuSkxsN29OXEGV5plfQMOUyvzfTlkjm7YTwAG/Iewt
	 S/4dA65BitWOXKlcl0OuROpsulBcGNk1qBUiHm4DKg9kK3Z83ePlt2mmry1YJ9t18kUNY
	 BHDIU9qYvhD9K8VSVkjhsIHYsOogs+53SimVWAgI/KdsFlV2OXoPkfg+qiX+dFQPQwF+s
	 ZI25eKWEi5hHBn+Ax8CDw0duf40od8y9RlFZJ/rCkGIwBoD0D7uR2Buu3xyTfVUo/0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCcDT+0G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C0606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCcDT+0G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEB71F0089F;
	Sat,  7 Nov 2026 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794091147;
	bh=XBd2FYBcaPk2XSMjlkWCU4wyPCzPsns5z6a0+wxgQxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HCcDT+0GnbTtVC35bg2MEujcDKNUToAzzu/JC2oMHTUkxnHgRuaquPSvlxWT5vLC+
	 LvXtNOspfFPhxcP5VzJ6zOCxDRPRdXPaO7ip8WLixZdf22P+kXLNykH1OsYLI30Fjq
	 fVDdXLRYYL0NZTkl36lIS5u3+nCuHztP671ezDdmq8+m6Ri4CuXgjOh/1sNjXGZHP+
	 yvj2RhJGBugFX/qtBDbMurZxbrcWxz13NI/Okb6LJxvHhvEz20ttiLFxH4jOJgy03k
	 KJFQwDYS8EVwhcnCRrCb9nVNdl1a2xhXQ2Kb3ab2TkxRXgJwSR9CyxSFb5bzKJ6hWC
	 3WufiZG9rpxTA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.6.y 3/3] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Sat,  7 Nov 2026 14:38:59 -0800
Message-ID: <20261107223900.331929-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-203367@kernel.org>
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

On Sat, 07 Nov 2026 22:34:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/damon/core: dangling pointer ABA match in
>   damos_fix_stale_charge_pointers()
> --
> 
> commit f7e621ee98abae5b2fb7828ae72ea3e96d1173fd
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: remove unreachable damos charge_{target,addr}_from
> 
> This commit adds damos_fix_stale_charge_pointers() to damos_adjust_quota() to
> reset quota->charge_target_from and quota->charge_addr_from when the target is
> no longer in the context or has no regions.
> 
> Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 99e934a6d1ce9..61d45d40fc1d3 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1088,6 +1088,27 @@ static void damos_set_effective_quota(struct damos_quota *quota)
> >  	quota->esz = esz;
> >  }
> >  
> > +
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
> 
> [Severity: Medium]
> Can t == quota->charge_target_from falsely match a newly allocated
> damon_target if the old one was freed and its slab slot reused before
> damos_adjust_quota() runs?
> 
> When an online commit removes a target in damon_sysfs_apply_inputs(),
> damon_sysfs_set_targets() frees the damon_target via damon_destroy_target(),
> leaving quota->charge_target_from dangling, while damon_set_attrs() advances
> s->next_apply_sis past ctx->passed_sample_intervals so kdamond_apply_schemes()
> skips damos_adjust_quota() on that cycle.  If another target is added before
> damos_adjust_quota() next runs, kmalloc() can allocate the new damon_target at
> the same address, causing damos_fix_stale_charge_pointers() to return early
> and leave the stale charge_target_from and charge_addr_from values active in
> damos_skip_charged_region().  Clearing charge_target_from and charge_addr_from
> when the target is destroyed during commit would avoid keeping a dangling
> pointer.

Good finding, but no real issue.  Occasionally starting quota charging from
unexpected target is no real issue in real DAMOS use case in my opinion.  Also,
same behavior in the mainline.  No blocker for this patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261107222202.331476-1-sj@kernel.org?part=3
> 


Thanks,
SJ
