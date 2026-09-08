Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB654DADC
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878111; cv=none; b=SQLJOUwXfTxvoKvWF2GylDDfVgyJXWfwun2Uw0u3SWW1wZ28sczORcR5LHNbna7aIu+dYUn7UCQ+3Y8J1Y8eKIq9R4bf9qeDQMBMwNujgdVpwjmWNSKhGQ44YMimXMg3MsWzjK7dXJukgJsjLpu2wuBWIfSrQuDS7/LKgWZTrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878111; c=relaxed/simple;
	bh=UOV3D+JKQom9LxNErC2aMRjfkFPGOwKK+Cf7ZNeMApk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5o59kkyM7jRPth5UcAwGqdeItguKGU0Cy5JZX5txb1qmqB3vGMeX+Sgwtx/Ai1uIrMju1ook7uzyxErix/F6v/phndbrBg6vdtYKj/fviBXDMf6WTjg+TEqcNWd1NoeQtzkZmLs76omvDQqbnCLZQ8in1ZAUBAxI4ibkKVlFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRq9X5uv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRq9X5uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8981F00A3D;
	Tue,  8 Sep 2026 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788878101;
	bh=RL7tLHFAhfpvTsI7HEDiRikX7HHkWZAondRZExIIDvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DRq9X5uvmy2z6o9TYljmgxyhgUJWj3cacEpc/w9owOGsrTFj0/pBFF6mQshd866LI
	 ejPKCGjH7iIFisbKHM/W4K6RSuUnSkXg3KkeVm4CQVIF/o5mB+WR4v+qH4KWMHNwn0
	 Uc6/H+59QmHaoZ5ZdxKL3TPZmJgNlnrWEj9wmtXO47NZzjycBsgU4iY2SlKOpEmk62
	 /2QVWORojojvKrVmp7YhD5PqqgmKP/t0CBpANmZ05QOSpv/AJrUP3wlbVjZfwF/OKJ
	 9OSzkZTQ7SdrMD5ZcPY34Zd+91eQa9OW3K0SCFZVgvYL/e1MdAOaRmFItJ9rnirlCC
	 QZhIHjxp5GUHg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v3] mm/damon/core: fix unconditionally skip last region
Date: Tue,  8 Sep 2026 07:34:52 -0700
Message-ID: <20260908143454.102867-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908140737.2022F1F00A3E@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 14:07:20 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Quota tracking pointer `charge_target_from` can get permanently stuck if its corresponding target becomes invalid, freezing scheme application for all subsequent targets indefinitely.
> --
> 
> commit 4d9a4144cc83637a927f5110bc1cc97f4064d9e8
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: fix unconditionally skip last region
> 
> This commit modifies damos_skip_charged_region() to only reset the quota's
> charge_target_from and charge_addr_from when the last region is reached.
> It ensures that the last region of a tracked target is only skipped if it
> was actually applied or cannot be split.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ce8c6f99106ed..89d1c77417450 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2452,36 +2452,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
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
> This isn't a bug introduced by this patch, but is it possible for
> quota->charge_target_from to remain stuck indefinitely if its corresponding
> target becomes invalid?
> 
> Looking at kdamond_apply_schemes() in mm/damon/core.c, if a target becomes
> invalid, it is skipped and damos_apply_target() is never called for it:
> 
>     damon_for_each_target(t, c) {
>         if (c->ops.target_valid && c->ops.target_valid(t) == false)
>             continue;
>         damos_apply_target(c, t, max_region_sz);
>     }
> 
> If the previous quota window ended with quota->charge_target_from pointing
> to this now-invalid target, wouldn't the 'return true' here in
> damos_skip_charged_region() cause all regions of all subsequent valid targets
> to be skipped?
> 
> Because the invalid target is never processed, t will never equal
> quota->charge_target_from again.
> 
> Does this mean the pointer is never cleared, freezing scheme application for
> all targets?

I'm working [1] on this issue.

[1] https://lore.kernel.org/20260907165529.98874-1-sj@kernel.org

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908134739.96919-1-sj@kernel.org?part=1


Thanks,
SJ
