Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092653;
	b=YdBJbFongPvdXEqem4MpbDVWC6Z0GivDJcSmvqKy6j5qBe6U+6Iv0P/M8sCRtypiOuLZ
	 mjaoTutoVnJJGWYjk+6O70p5V8OE2sV/PIrwXtBc2vNqV9d5QFsNVInylxwK/xia56gjF
	 pAb5Wde4XxIEYwOCkE6w/7z7oMlfO6HVfXiHL/q0jLDYh8a16rMAJ9fNp4JYxOHSfCE3g
	 rxbrAxomjzaZOsrBZ4aMFhiupjNnVEbpYJ2mQtSJf24nJYdRNgh9N45j2Q63Qd4+0wemA
	 7OpxzZxbMYDUfrxfKiMmxtH5o8v5LIOkLyMrVCDaRDXUILjSeK44OtuBZgiK50iDe4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092653;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UKOheFdZkwgZbCvgxDw/KrEQq5eknMllMtNA2ffj/I0=;
	b=UoUTKtieHzfRClawbVeMcdtTOFxk3o+jKi/ych53m0ufwvDZBhNUsDL74bGA19r0Z9NW
	 OaTkxln5xzQH9W+aYwaQkrtUGsWTznKe41ZaqlG/mNCuccLSZD5tc52ts23NayYfNf+fy
	 ZWnp4rYeaen0tJ89lSKKAMVZWEObBb+YZKp9COwsy1prQU+wRm68HjEw5hZmxzcEbNUwa
	 t17TcZgynwcXfdKqedL+YoXKp9VyQnIzoTuE+MgXdpnvyGZ4eDkaTfg40R81IidIhwPsi
	 2IdQNAY1IqRgCQCvP08ysNCYJUuBRji3ocd3947dbOdMGjlIXzvt67wFZtsnJekQ1vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqXFDyDV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F58606A32C
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqXFDyDV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BDE1F0089F;
	Sat,  7 Nov 2026 23:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794092652;
	bh=UKOheFdZkwgZbCvgxDw/KrEQq5eknMllMtNA2ffj/I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lqXFDyDV9otA+OWWxyegWyB2sC0/phLyMCIu69a/z/18CcyyzQHkRiRwLNAU4uT9x
	 UHmK7u7+y6j1MNI/A2UQAN4HdnMDn8tCIO3z2TvFbK4XPsMn0aF+kZOlGS810H+alZ
	 oMI2C8UdG5ZSu1ET+OgQwZvDc8zZz+pZh9C9xwePCd/4hCJhqLtsmEOOCMVd0V4o9Y
	 x2lA6i6eCj0auShuv8ePOU+93xYhtm50RIIRHSDdX4M+7f2YjPok+TRGUXUtIFfcve
	 MIX548aVJMghxoE/I2gJz4+uUST8UZSgeeA0+laDNPVOk+Ceoe/W8N3NMlefqlC8jO
	 263bKfaqOVWqg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.1.y 2/2] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Sat,  7 Nov 2026 15:04:04 -0800
Message-ID: <20261107230406.340832-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-203374@kernel.org>
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

On Sat, 07 Nov 2026 23:02:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/damon/core: stale charge_target_from ABA reuse when scheme
>   is inactive
> --
> 
> commit 853b3e89da132f2ce03750bcf6dfc1f62a70d261
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: remove unreachable damos charge_{target,addr}_from
> 
> This commit adds damos_fix_stale_charge_pointers() to clear
> quota->charge_target_from and quota->charge_addr_from when the referenced
> target has been removed or no longer has any regions.
> 
> Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 9206737d05ae7..01f93146b92fe 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -860,6 +860,26 @@ static void damos_set_effective_quota(struct damos_quota *quota)
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
> >  static void kdamond_apply_schemes(struct damon_ctx *c)
> >  {
> >  	struct damon_target *t;
> > @@ -890,6 +910,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
> >  			damos_set_effective_quota(quota);
> >  		}
> >  
> > +		damos_fix_stale_charge_pointers(c, s);
> > +
> >  		if (!c->ops.get_scheme_score)
> >  			continue;
> >  
> 
> [Severity: Medium]
> Can quota->charge_target_from match a newly allocated target due to slab
> address reuse if the old target was freed while the scheme was inactive?
> 
> kdamond_apply_schemes() skips inactive schemes at the !s->wmarks.activated
> check before reaching damos_fix_stale_charge_pointers(), and
> damon_sysfs_set_targets() frees removed targets via damon_destroy_target()
> without clearing charge_target_from.  If an online commit removes the
> target stored in charge_target_from while the scheme is deactivated by
> watermarks and a later commit allocates a new target at the same address,
> damos_fix_stale_charge_pointers() will see t == quota->charge_target_from
> with regions present and leave the stale charge_target_from and
> charge_addr_from in place.  When the scheme reactivates,
> damon_do_apply_schemes() will skip targets before the new target and
> regions up to the old charge_addr_from.

Good finding but no real issue.  Occasionally starting quota charging from an
unexpected target is no real issue for DAMOS in my opinion.  So, no blocker.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261107224800.340250-1-sj@kernel.org?part=2
> 


Thanks,
SJ
