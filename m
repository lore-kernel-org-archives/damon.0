Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30529470E91
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554943; cv=none; b=t7NtSOg14smljIk2PyrPysq+L+dKhkPdEiMGo6Py04VhSeYlRxGl5LFR4HZW4HmVvAQtThkGNP/jOp9/96wk88uGxeh0IS9afsG2793u1eK6SttqTawEsVMAiXhZm0QYVbn5uTm0CLJxRge5yU7/xG29J+Pebn5vSpWBQlXwR1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554943; c=relaxed/simple;
	bh=M/xgkLOYriNCdud89oMy1PCf75QYmjnko/1MV2BKjTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbOcVzpj3SSqEJHo7dtaU0Q2jfTsIbXTEaD09TMnzbpDp1foWstCk0K1sCP2qLB1H6bsSed8WQ7iOwmdS8Fxwa2AePWLp6DB1lCJV/NkjxXGz9fMYVvbhRVzLbGdmJ8lAUFOcGKbaENUZ3IC1UKy7C4izcPS+R5V5LSLMa20Tf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw90sXgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw90sXgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3B21F00893;
	Fri,  9 Oct 2026 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554937;
	bh=vug5SohEANgecCQ4iF6CSV5lHrVzUFDS+GySLOn9jh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fw90sXgyk9KpRh5IsaYNKDgSQNKm8s5ueHiPf7tbcsk6JQRwzNoeHxp+N1/7K4ERu
	 hD1EhbEn1g+2yIxGPomDbZ2zg8NGjIum89K1ExbDM5wQCYC4si6UbKdfu8ak7dkbk1
	 yf2ZdVyvoekbusbQN3VLuRTBXl0Cx5OfgObN8cLjvOHX7voAeqhlRdh/aT180b/zAU
	 xg/g3eh54rR1rg75vVrcwxedYvZk89sGPQBeezbEUXGhBAZzc2o9yw6+l8P2wDBfor
	 YhHQWyTW9aSDOtgBpyqtWPMRw6tf8sTZseTom9FaNI8iRGKAMbvq3rf8tyn5IAdVFs
	 KRay4B8XWeKfg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.6.y v3 2/2] mm/damon/core: fix unconditionally skip last region
Date: Fri,  9 Oct 2026 07:08:52 -0700
Message-ID: <20261009140853.12092-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-165687@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 09 Oct 2026 14:05:09 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] mm/damon: dangling charge_target_from stalls schemes on target deletion
> - [High] mm/damon: missing charge_target_from reset when target has no regions
> --
> 
> commit 34b3a9a3bd49604e23a1fa56349694c2bc0db52b
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: fix unconditionally skip last region
> 
> This commit modifies the quota charge skipping logic to only reset
> charge_target_from and charge_addr_from when the last region is actually
> reached. It addresses a minor issue where the last region of a tracked target
> could be unconditionally skipped and reset even when it had not been processed
> yet.
> 
> Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c86cac855b9b0..c459eae4bbaeb 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -884,36 +884,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  {
> >  	struct damos_quota *quota = &s->quota;
> >  	unsigned long sz_to_skip;
> > +	bool skip = false;
> >  
> >  	/* Skip previously charged regions */
> >  	if (quota->charge_target_from) {
> >  		if (t != quota->charge_target_from)
> >  			return true;
> 
> [Severity: High]
> Does this logic stall the scheme indefinitely if charge_target_from points to a
> destroyed target?
> 
> If a target is removed during a sysfs commit, damon_sysfs_set_targets()
> dynamically destroys it:
> 
> mm/damon/sysfs.c:damon_sysfs_set_targets() {
> [ ... ]
> 		} else {
> 			if (damon_target_has_pid(ctx))
> 				put_pid(t->pid);
> 			damon_destroy_target(t);
> 		}
> [ ... ]
> }
> 
> However, damon_sysfs_set_schemes() merely updates existing schemes in-place and
> fails to clear the quota->charge_target_from pointer if it points to the deleted
> target.
> 
> Because this saved target was deleted and removed from the active target list,
> would this condition evaluate to true for all remaining targets, permanently
> skipping all regions and never reaching the logic to clear the dangling pointer?
> 
> [Severity: High]
> Does this also cause a stall if a target loses all of its regions?
> 
> If quota->charge_target_from points to a target that loses all its regions (for
> example, if all VMAs are unmapped and the task dies), damon_for_each_region()
> will execute zero times for that target:
> 
> mm/damon/core.c:kdamond_apply_schemes() {
> [ ... ]
> 	damon_for_each_target(t, c) {
> 		damon_for_each_region(r, t)
> 			damon_do_apply_schemes(c, t, r);
> 	}
> [ ... ]
> }
> 
> Would this bypass the invocation of damos_skip_charged_region() entirely for the
> charged target, preventing charge_target_from from being cleared, and causing
> all subsequent targets to be skipped indefinitely because they do not match the
> uncleared charge_target_from pointer?

Pre-existing issue that also exist in the mainline.  Hence no blocker of this
backport.  I will separately work on the issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261009134949.11507-1-sj@kernel.org?part=2
> 


Thanks,
SJ
