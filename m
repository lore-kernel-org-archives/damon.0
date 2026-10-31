Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793479771;
	b=QAokdLQ1ZnzJz66rTelhbZkpUsNfon1hYclK3aj5xbmKv7ZB9G7Q4QUgnrlCiiyesKNU
	 lD09VSWzzIGlrtHsbieSUgxZSpu7PM+lKbaDp9KbFHLsHDcbertdcId1nX+DAB7K7dTZY
	 +qD67QCXE7xihmDtbUIR+RvrvSRbNyL0HWaN0VZ+ts/Ka8hsJqIJL6tBa1FQWLS3+IOA8
	 FnOau9ZMwyYEQTXvzuUV/Ofnij/9X3uG8zS4J9D1ykz5YeAmvMImP7hIMaErw8binZmfm
	 tme6oumJwp/VZ778xw7Ls1QUnp00kGODUggHy4NDAqOp4/lwHfad2N9Kd4Qzba0MqgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793479771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GfcB9TvOu6Mjj8+qufOnmdae3K58sylRc4kNrDjGfQQ=;
	b=AX7y0CTqHnFRPCrgpgkpuWAww/b12UIcgpPeiMg10DWGcXEke/Wu6ZZO33Zq4ASZ6MM0
	 xD5aFKDBzkz55Vz1EL/C5dWESja/zdR1EXPLYXiDg16Gj3WOua/4yA/9oAI5CDH/cBG8F
	 WMxrn/Id+zDTuOsTlQAVfots0ySks/tq//0c1Lk56pmYgxz6gjqeUvG5gcC7wdwDeTL9C
	 IQCAisyt+SxFaPNS44Jqt8mIl4+7Eh1EknORn3ai0c944hS58Y8kYPEuW/MtVqQA61RdQ
	 cDHoZjrcQx7DhxiYNb0dMrTUv2IR3sVdiP9OvX1OnAiEJ7IBDvf+CiRxBuyKYXX3mkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NF3x9qzp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD52606A31A
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NF3x9qzp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5186E1F000C1;
	Sat, 31 Oct 2026 20:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793479770;
	bh=GfcB9TvOu6Mjj8+qufOnmdae3K58sylRc4kNrDjGfQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NF3x9qzpmt9KSRu9FegTUQncFR0lNXiplGIUK5tfIM7DStEB7TvANGiTkMivbrg1J
	 YY0E5M+pIUS+APOGc9F8vQOCmZ1bQ7wD571M8Fzoj40vPMJfGlx9ZIZPvwHKKNqLIS
	 59tK3arW76yF7DkUS4R+MI2EFUIp2J7ZfR8FCErTe8+N2zlJ2YAWuw3vNdChspJmsM
	 Wc/HC5mwBvVK+zCYpTvDN0tPiuS8BkGKfN52bb0y/7UzPsojMTkIY6qxvtbKK07+Gg
	 X7Kt78GRA+dj/jEVZjMiynqaQTa7yowLezXjGfGbXqvFvaYThFryjWiuVIqK6wK96D
	 DhWgdGJypBO0g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/6] mm/damon/core: handle invalid target in damos_fix_stale_charge_pointers()
Date: Sat, 31 Oct 2026 13:49:21 -0700
Message-ID: <20261031204923.96778-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-192118@kernel.org>
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

On Sat, 31 Oct 2026 20:36:25 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm/damon/core: stale charge_target_from and skip regression on invalid target
> --
> 
> commit 3b1cac25b68197d5c2819d4a16dbde02446b2d07
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle invalid target in damos_fix_stale_charge_pointers()
> 
> This commit moves the DAMOS quota charge pointer fixup for invalid targets
> from kdamond_apply_schemes() into damos_fix_stale_charge_pointers().
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 73b571b429cb3..ce75db510a9d3 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3394,7 +3394,11 @@ static void damos_fix_stale_charge_pointers(struct damon_ctx *c,
> >  		return;
> >  	damon_for_each_target(t, c) {
> >  		if (t == quota->charge_target_from) {
> > -			if (damon_nr_regions(t) > 0)
> > +			bool valid_target = true;
> > +
> > +			if (c->ops.target_valid && !c->ops.target_valid(t))
> > +				valid_target = false;
> > +			if (valid_target && damon_nr_regions(t) > 0)
> >  				return;
> >  			break;
> >  		}
> > @@ -3513,15 +3517,8 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
> >  	max_region_sz = damon_region_sz_limit(c);
> >  	mutex_lock(&c->walk_control_lock);
> >  	damon_for_each_target(t, c) {
> > -		if (c->ops.target_valid && c->ops.target_valid(t) == false) {
> > -			damon_for_each_scheme(s, c) {
> > -				if (s->quota.charge_target_from != t)
> > -					continue;
> > -				s->quota.charge_target_from = NULL;
> > -				s->quota.charge_addr_from = 0;
> > -			}
> > +		if (c->ops.target_valid && c->ops.target_valid(t) == false)
> >  			continue;
> > -		}
> 
> [Severity: Medium]
> Can moving the invalid-target reset from kdamond_apply_schemes() into
> damos_fix_stale_charge_pointers() cause stale quota->charge_target_from
> pointers and alter round-robin target skipping across multiple targets?
> 
> First, in kdamond_apply_schemes(), damos_adjust_quota() (which calls
> damos_fix_stale_charge_pointers()) runs for all schemes before the
> damon_for_each_target() application loop.  For virtual address space
> monitoring, c->ops.target_valid(t) is damon_va_target_valid(), which
> checks whether the target PID still has a live task_struct.
> 
> If the target referenced by s->quota.charge_target_from is valid when
> damos_fix_stale_charge_pointers() checks it, but the process exits while
> damos_adjust_quota() builds the score histogram or while
> damos_apply_target() applies schemes to earlier targets, the target loop
> in kdamond_apply_schemes() will see c->ops.target_valid(t) == false and
> skip t without clearing s->quota.charge_target_from.  For all remaining
> targets after t in c->adaptive_targets, damon_do_apply_schemes() calls
> damos_skip_charged_region():
> 
> mm/damon/core.c:damos_skip_charged_region() {
> 	if (quota->charge_target_from) {
> 		if (t != quota->charge_target_from)
> 			return true;
> ...
> }
> 
> which will skip every subsequent target for that apply interval.

This race can happen even in the current code.  That is, the target could be
terminated between the current check and damos_apply_target() call.  The race
can happen more easily, but I don't think this is a regression.

> 
> Second, damos_adjust_quota() returns early before calling
> damos_fix_stale_charge_pointers() whenever damos_quota_is_set(quota) is
> false:
> 
> mm/damon/core.c:damos_adjust_quota() {
> 	if (!damos_quota_is_set(quota))
> 		return;
> 	...
> 	damos_fix_stale_charge_pointers(c, s);
> }
> 
> whereas damon_do_apply_schemes() calls damos_skip_charged_region()
> unconditionally.  If damos_quota_is_set(quota) becomes false while
> quota->charge_target_from is still set to a target t (for example, when a
> quota is disabled or its goal is removed via online commit in
> damos_commit_quota(), which preserves quota->charge_target_from, and
> quota->esz becomes 0), and t exits before kdamond_apply_schemes() reaches
> t, neither damos_adjust_quota() nor kdamond_apply_schemes() will ever
> clear quota->charge_target_from, causing damos_skip_charged_region() to
> skip all other targets permanently.

Good finding.  I will drop this patch from the next version of this series for
now.

> 
> Finally, when monitoring multiple targets [t0, t1, t2] where the previous
> quota window stopped at charge_target_from = t1 and t1 has since exited,
> kdamond_apply_schemes() previously skipped t0 via
> damos_skip_charged_region(), cleared charge_target_from upon reaching t1,
> and resumed applying the scheme at t2.  With charge_target_from cleared
> upfront in damos_fix_stale_charge_pointers() before the target loop
> starts, won't kdamond_apply_schemes() restart charging from t0 instead of
> advancing to t2?

Again, good finding.  This is only a corner case that happen only for one
cycle.  I think it is a reasonable tradeoff for code simplicity.  But since I
decided to drop this patch for now, I will think about this again, too.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261031202614.96036-1-sj@kernel.org?part=1
> 


Thanks,
SJ
