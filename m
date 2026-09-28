Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740F372B26
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588967; cv=none; b=guyW4sxWDeVzAC6H9pT7JGpIAKL/vDxTrIvoWTE+tqAkjdJw25Q+QIPXi9otCb9sToDNXIJ/4uq6/CbOpD0dK3XZYiHT5VKuNXQ5jY2ru0bA7bLXAihm63r3xnDGbPHXcgW95hmyvHQjEmj/hx0il21a5u16CGgNVJMvPeyKFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588967; c=relaxed/simple;
	bh=WMARBZscd9crwThe8hIvljIcSFA6lPBw73siIrJk6l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFCVNthbdp42dGR1uhCbMLyPp983oa8mQXzbULLnC4bBQhT3ZaUYR67jrUWqkbq1Dpg/KEUxB0ah5BpqDchgc3WhPXBG3kkqPd8Fe5NA5Xm7fkGUqIG2OZiUBTlCZOm3fFfJRLXVqijKQVTdkF4ubXru34ulUFe7wnL6229dwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G13HwRJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G13HwRJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254AE1F000FF;
	Mon, 28 Sep 2026 09:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588966;
	bh=kX7g56EspgOj6KrLuRhLz4zC1MhwVW2vV7VybPlDaoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G13HwRJP4/Vve+Oed8zktTAOk1VgT4es8zc6WoKmJ521iqvXuWf8QM3dBfccYawOi
	 uaUK3/W++MrH2zTfV370G6HmEs1kfZM3/5uDPtFP64COGoKpwtu5T45F9PYfsgVwB1
	 3zhrBn8zvX75eumR2WzMBespP4pQW4VcnvYIS91FR59umgRo9V4qPq/eJmG29Ls/8F
	 D2qLsmFmtCi+hE9JVkR8J2wIUXx3SPs5qPow+3VCHG+hxomUWI5vRa3RvuADzzqgSF
	 xR2DSDgiIvSyyLMZeDA43hEmwpMbDTENnkr2du9dbExMj9XTFxn3uy6m2D4ULfO9H6
	 zrWXlBfJ88i2Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v5 8/8] Docs/ABI/damon: update for quota goal metric complement sysfs file
Date: Mon, 28 Sep 2026 02:49:20 -0700
Message-ID: <20260928094922.17266-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928094400.5B0DF1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 09:43:59 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm: integer overflow in damos_set_psi_current_val() on 32-bit
> --
> 
> commit 5d7327c0afcb5fe144677a675b1eea685917f61e
> Author: SJ Park <sj@kernel.org>
> Docs/ABI/damon: update for quota goal metric complement sysfs file
> 
> This commit introduces a complement flag for the quota auto-tuning goal metric
> and updates the sysfs ABI documentation to reflect this addition. It also
> modifies the core DAMON tuning logic to support the complement calculation.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 733025b367457..86f13411b91fa 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2960,10 +2962,18 @@ static void damos_set_psi_current_val(u64 now_psi_total,
> >  		struct damos_quota_goal *goal, struct damos *s)
> >  {
> >  	u64 last_psi_total = goal->last_psi_total;
> > +	unsigned long val;
> >  
> >  	goal->last_psi_total = now_psi_total;
> >  	if (last_psi_total != U64_MAX) {
> > -		goal->current_value = now_psi_total - last_psi_total;
> > +		val = now_psi_total - last_psi_total;
> > +		if (goal->complement) {
> > +			if (val < s->quota.reset_interval * 1000)
> > +				val = s->quota.reset_interval * 1000 - val;
> 
> [Severity: Medium]
> Could this multiplication in mm/damon/core.c:damos_set_psi_current_val()
> overflow on 32-bit systems?  If reset_interval is configured to a value
> greater than 4,294,967 (about 71 minutes) via sysfs,
> s->quota.reset_interval * 1000 will exceed the maximum value of a 32-bit
> unsigned long.
> 
> This could cause the complement calculation to yield corrupted values or
> premature zeros, breaking the auto-tuning logic.

It is an extreme setup.  Also, sane users would test it before using the new
feature.  No blocker of this series in my opinion.

> 
> > +			else
> > +				val = 0;
> > +		}
> > +		goal->current_value = val;
> >  		return;
> >  	}
> >  	/* uninitialized last_psi_total; make no effect this round */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260928093342.16584-1-sj@kernel.org?part=8
> 


Thanks,
SJ
