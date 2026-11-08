Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168467;
	b=W7PTqBKKO5m1b946UTIzViUj6eXCaekZOP6VsSFaGcU820fZ2rPSvdkU9c7zIXBdLF3D
	 64PUU2/GLXcMU0hvVsOhau08uJgk8TrHLZzsof4kQPq9UnDgBTFWvAQpyooT4NbqTcaMn
	 72cSvr269GIkoti3H5dEuudgD2S+4A9R7G0WLq/bMlL/5nZvCqfjeLU5oXLGK17PooChe
	 cxuA/XggMgFDF1mtNO+T1v+Nv7TguBw4IvQeexAfYEXyLiGmrJT0oJDbVoge5nZKttBeP
	 Hd7Abya3PZp1tWFIMGMWzBgX5EoiLAtt1VX66W0n0w9jtT1vLhEu+kfO49IE+X3FFcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168467;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2TO+CpsEMkIicevAnwrknqp+HSpjmNynu9r53SRPWuc=;
	b=q99VcVMmC4rhL1A5/VgmLSgZa3t3Xhpkwgr2lfvUHkqYwkDZZrDb42DF0fyL0cZMOTbj
	 ib/oe9Nl4SxJxC8GdHANRX8oxiNOGAaXjJGLrtj0hOtrWJ5PqInluwCF/k4Oe/zFc1AXD
	 VLZm8HY5q9AEZJCOqHbhZ2jYAdm//bBbhhgXta7MguwJ6CbOk7H4Gw6lg7rF8Df476pWN
	 mI/LrPkA9+DuDqcm+obZxBZhhtxP032f2lJoLnYPQYGo7BzHMsR6+FGZ+4u65z4j1hoxU
	 Za4zmNDu1yOe/ccfidAMp64rXCDGnM88FzbBVlkyjEAIKSQMIK7uhMqFkrXkZjxY8CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgRwkHww;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234EF606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgRwkHww
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A2E1F0089F;
	Sun,  8 Nov 2026 20:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168466;
	bh=2TO+CpsEMkIicevAnwrknqp+HSpjmNynu9r53SRPWuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PgRwkHwwOmAE2ueWzcsEYsrtwZZxIFcB2QYHHOQN15qQM43ZwDti1n3zhOrGbqixh
	 sGNZoR1ISIeGqbr89cNSvODGlFtogYezoGsOmDsVjetf3yvL6zuLz3JLUeZuvg2+y7
	 uch30Ku/7hh5fwy9s43S5p9JbR45T908c0Ni6/IGw/nV9A6y74QvNnyae9vPMUipi0
	 sM2aYCx6Nh2KCZYMppTuclvoixIoRt/joRxrIbKwV7MME6QQvt6ftUfO0XMFBqwFJO
	 fepI2Bnk/djZYaXlKHUjODQFFOq+dMtFdBd2xuskq5zrSCP/b1b3rHAWW69TWsG7Bu
	 OG7UitbI8h0qQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Usama Arif" <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.12.y 1/5] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sun,  8 Nov 2026 12:07:38 -0800
Message-ID: <20261108200739.116084-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-204000@kernel.org>
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

On Sun, 08 Nov 2026 20:00:20 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm/damon/core: inaccurate tried stats on split failure in
>   damos_apply_scheme()
> --
> 
> commit 2d3797cf5f053ac8bc0b4587f17ff69eb9813ce6
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: skip applying scheme if region split for quota fails
> 
> This commit updates damon_split_region_at() to return an error code on
> allocation failure and skips applying the DAMOS scheme in
> damos_apply_scheme() when splitting a region to fit within the remaining
> size quota fails.
> 
> Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
> Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
> Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 81d44e41de210..6ef77741b783b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1470,7 +1470,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  					DAMON_MIN_REGION);
> >  			if (!sz)
> >  				goto update_stat;
> > -			damon_split_region_at(t, r, sz);
> > +			if (damon_split_region_at(t, r, sz))
> > +				goto update_stat;
> >  		}
> >  		if (damos_filter_out(c, t, r, s))
> >  			return;
> 
> [Severity: Low]
> Does jumping to update_stat when damon_split_region_at() fails
> inaccurately inflate s->stat.nr_tried and s->stat.sz_tried?  At this
> point sz holds the non-zero remaining quota, so damos_update_stat()
> increments s->stat.nr_tried and adds sz to s->stat.sz_tried even though
> scheme application and damos_filter_out() were skipped.  Because
> quota->charged_sz is not updated on this failure path, any further
> matching regions that also fail to split in the same walk will
> repeatedly add the remaining quota to s->stat.sz_tried.

Trivial user impact issue that also exists in the mainline.  No blocker for
this patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261108195145.115792-1-sj@kernel.org?part=1
> 


Thanks,
SJ
