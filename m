Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D13BE659
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762802; cv=none; b=EUpMi498pCDu9TIg9Y4nAYY4tMjWQp1x65a/BtMsIwZsEluzJd1+4wE9SS578hTTS9D4JK8F/OBx8fDGQxBt+XwrtrmMK5FzqBAf8WFHrYYcQMoA0azB/Ziz+ZBxN3MstjuviwUhNe3s7pTuWJky26u+zt3Qm/OAFTjwpl6OT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762802; c=relaxed/simple;
	bh=mofP0d9aSD+OpNGToQGH+yDPvDSzY+NlHOoUDf5Ui2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9FRrUMP9VZkQ6ymZYR98iMoyN41xWpOCM3jUjfCrGwZvo55kmIjX46wKEFM9544lMVB8Xc7XoW3tTuxqVf8mr/xIb/vTQ762zfR/Nfq2dXWpg12lWZB/uOaBdORKVqUsdVvHNMIgWn3oUgQQoEaSYa7eKtJSNuvYXfS1UiDa+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj3ILlqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj3ILlqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15821F000FF;
	Wed, 30 Sep 2026 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762801;
	bh=ssS8y3B3kqIDyz7wEKxybMEA9ng52lOuLqggEG6QDOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nj3ILlqIExdLtxppruSsK0XfxzKVWX6g5m5E8tNsOVtgjww6BggsY4bktW3vgeNoz
	 kpsEJKgJyp029U0LtoDgGx/THj4tDb+nt4eF3lPt0LVS55yP3Fp9M2p7Z8CjF2yVZV
	 BTK4WB1bNykjkidfdv3av7Cyu+gLgNUY6y0IBf75WfIfyOSAsemZp5Q7lSGIHNOCeY
	 67UzvgrnZ0/5nH51+qp4QTunL88OVPGSUbBI6w5XiVdpUhHdcZZxfkSI6NLRRK+g5q
	 2ZsWNrfiYaMO868hbfYbMjfR1w5T2ueiljSWYkclx0C3YAtqSj7ZEoFJHZJQibvjUu
	 SGQA9ltEEkMbQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.6.y] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 03:06:36 -0700
Message-ID: <20260930100637.53340-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930095442.264EF1F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 09:54:41 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] mm: invalid list head dereference if damon_split_region_at() fails
> - [Medium] mm: scheme state leak due to early return for small last region
> --
> 
> commit ae1e4dc8429f6a152575d9c64a1876f9dfb3b7ad
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: fix unconditionally skip last region
> 
> This commit modifies damos_skip_charged_region() to only reset the charge
> state when the last region is reached. It ensures the last region is skipped
> only when it is applied or cannot be split.
> 
> Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 0713fda22682c..5ede1733369f5 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> >  		if (quota->charge_addr_from && r->ar.start <
> >  				quota->charge_addr_from) {
> >  			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
> >  					r->ar.start, DAMON_MIN_REGION);
> >  			if (!sz_to_skip) {
> >  				if (damon_sz_region(r) <= DAMON_MIN_REGION)
> >  					return true;
> 
> [Severity: Medium]
> Does this early return for a small last region bypass the state clearing at
> the relocated out label?
> 
> If damos_skip_charged_region() processes the last region in a target and it
> is smaller than DAMON_MIN_REGION, the code executes return true early. This
> bypasses the out block that clears quota->charge_target_from.
> 
> In the subsequent window, the scheme could again skip all targets until the
> saved target, evaluate its last region, and hit the same early return,
> potentially skipping targets endlessly across windows.

Good catch, I forgot converting this while backporting.  I will send v2.

> 
> >  				sz_to_skip = DAMON_MIN_REGION;
> >  			}
> >  			damon_split_region_at(t, r, sz_to_skip);
> >  			r = damon_next_region(r);
> >  			*rp = r;
> 
> [Severity: High]
> Can unconditionally advancing the region pointer after a potentially failed
> split on the last element cause list head type confusion?
> 
> When damos_skip_charged_region() processes the last region of a target and
> attempts to split it, it calls damon_split_region_at(). If the split fails
> due to a memory allocation failure, the region is not split and remains the
> last element in the list.
> 
> The subsequent call:
> r = damon_next_region(r);
> 
> will dereference r->list.next, which points to the list head
> (&t->regions_list), returning a type-confused pointer.
> 
> Passing this bogus pointer back via *rp = r means that subsequent calls to
> damos_valid_target() and damos_apply_scheme() will dereference it, which
> could lead to a heap out-of-bounds access.

Good catch, but pre-existing issue.  Maybe a fix that made upstream should be
applied here.  I will separately work on this.

> 
> > +			skip = false;
> >  		}
> > +	}
> > +out:
> > +	if (r == damon_last_region(t)) {
> >  		quota->charge_target_from = NULL;
> >  		quota->charge_addr_from = 0;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930093707.48739-1-sj@kernel.org?part=1


Thanks,
SJ
