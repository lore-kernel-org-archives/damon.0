Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DED4CC26A
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558563; cv=none; b=u39l5+RPfYcaOT3fU4ZLXl0srww5DDIlcPQUhDM18kYhUUDBAbOAnrIlNb8Vtd6fes6UEI85XkJf8McpJzJ5lxBtqiRQfx+mHcHACybt4Cfia3/SekW6Su4l33Bpj08PxTKuCiUsUI7QES9FFYpjRO/+V6VYw5RkInh12X9QqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558563; c=relaxed/simple;
	bh=iZdJ/a7zawOYaLGHZfLXDygWDPhYqOQv8iKSQ/Ehzbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9ZV0BAi5f7aJuUdNjMy81uDSwj4Oa0p8ez/NAsQjWY5ldUdC6klnxct3gCsyLQS/aimB+ZMwpRCxFlmM0ViHXyxMnes9jADpG1LiGmkf6819w5oju6BekGwa6L+GSmyMcJR1Yr+u6qCoZUT2IxyjUufa8dWav+oD2Dr98ZqlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAn3PNhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAn3PNhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5647D1F000FF;
	Fri,  9 Oct 2026 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791558560;
	bh=k92JavvsWvkpS3AT8i0nBDXG6TbziVDPd5iZT4QAtbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nAn3PNhrABxJMOlc6tT2lBLuqU5gPR4nPnFb4/i0URozQXCa889H0hmwbHvjS6dge
	 WFQYs1gFLMHpK/ZaVyGm61a5ZwW9Eq6qxnPpRhfbjwdMi7IpmjjMK7Mcd31XzlsLVw
	 9xlLgb3iRGIW98LdUHKMj2+U7zBTshuMpMUJR9IaEIYVJO+NbVJBiZv89nJKOMobTl
	 a1Wmh1WvIldiAP5w2EAStCJUjcd+fguwzu3umd18PRyJ2JIYvi88r0ZvfGRHWYhQKX
	 Oy7+EzVX12ypT8Pm/WDNhKYMeZ5EINXfZXq1XY7m/Ga1AhInYQoqy9k9+TmmnT+YKd
	 7Io4447746Asw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y v2 1/2] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Fri,  9 Oct 2026 08:09:15 -0700
Message-ID: <20261009150916.2650-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-165747@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 09 Oct 2026 14:56:56 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm/damon: double processing and skipped regions due to broken backport
> --
> 
> commit 18797502eb0b5cf3a96dbf53e3e238e6ea4158ce
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
> 
> This commit replaces the damon_for_each_region_safe iterator with
> damon_for_each_region in kdamond_apply_schemes. This change ensures that
> newly split regions from address filters are properly processed during the
> iteration.
> 
> Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 7afbc20833ea4..c65d2cbeea6b5 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -912,7 +912,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
> >  	}
> >  
> >  	damon_for_each_target(t, c) {
> > -		damon_for_each_region_safe(r, next_r, t)
> > +		damon_for_each_region(r, t)
> 
> [Severity: High]
> Does this change result in regions being skipped and double-processed?
> 
> The commit message mentions dropping the workaround in
> damos_skip_charged_region(), but in this stable kernel version, that helper
> does not exist yet and the workaround is still inlined in
> damon_do_apply_schemes(). Since the inline workaround wasn't removed in this
> backport, it appears to conflict with the new loop iterator.

Good catch.  I will fix this in the next spin.

> 
> If a scheme's quota->charge_addr_from check triggers a region split in
> damon_do_apply_schemes(), the local pointer is advanced:
> 
> mm/damon/core.c:damon_do_apply_schemes() {
>     ...
> 			if (quota->charge_addr_from && r->ar.start <
> 					quota->charge_addr_from) {
> 				sz = ALIGN_DOWN(quota->charge_addr_from -
> 						r->ar.start, DAMON_MIN_REGION);
> 				if (!sz) {
> 					if (damon_sz_region(r) <=
> 					    DAMON_MIN_REGION)
> 						continue;
> 					sz = DAMON_MIN_REGION;
> 				}
> 				damon_split_region_at(t, r, sz);
> 				r = damon_next_region(r);
> 				sz = damon_sz_region(r);
> 			}
>     ...
> }
> 
> Because r is reassigned locally within the inner scheme loop, subsequent
> schemes will apply their actions to the newly created second-half region,
> completely skipping the first half. 
> 
> Then, when damon_do_apply_schemes() returns to the outer loop in
> kdamond_apply_schemes():
> 
> 		damon_for_each_region(r, t)
> 			damon_do_apply_schemes(c, t, r);
> 
> The iterator will advance naturally to the newly split second-half region.
> This causes damon_do_apply_schemes() to be called a second time on the exact
> same region, leading to DAMON actions being applied multiple times to the
> same memory, double-charged quotas, and corrupted statistics.

This is an issue that exist in the mainline, too.  I will separately work on
it.

> 
> >  			damon_do_apply_schemes(c, t, r);
> >  	}
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261009144808.18317-1-sj@kernel.org?part=1


Thanks,
SJ
