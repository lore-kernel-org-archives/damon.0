Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2730D3E8
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669768; cv=none; b=BtzG649XiZmZNudyg9lcl3DL3QAUuTrlO5KjKOtx19B6WAy745ZYS03mTCi7vqBB9v7GbJwveKHw6n8/RQnH4kFV/o+7uWZylatz0lHSKetRlRMCP/V9edFZJ+7c0KjNDvWkT2kylcuuQ0WfsbksB7TltWmM8Pzlf2Lo07E07/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669768; c=relaxed/simple;
	bh=t+Qp5e2hhY/WUFwO/dVsLjAckIyMpGFVs01IRdu+5OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wgj6et7IEtkqsBWxmP6v6xmnEoKpAj+7fge99rZlvO5mr2KnJOWdngxvxxHXuJM7WWXY5lkTXWZs7G66oLhWoihdJIByn2sdy1XMbT52MtlxxxV854LmmFlBzh7KIsOlhQMi4X7LnWpPtPFFfJDnwcELz1Jq4S6NEvlcR+2VWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT3VAc9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT3VAc9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A32B1F000FF;
	Tue, 29 Sep 2026 08:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669767;
	bh=Bkuy2wyL6NU2tDvTm+bYtlg5g5oQZGls8Q226adIfrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RT3VAc9tpotogaj6l0wcIDaCur4pndxw8THdltvWwJT5E7XIpwEWtUklFbzGSmU9Y
	 iQjgYFCLer+Z23MmAc7MusCXuQLQV2n4hsbWVwCTEASGWS0iM1xu9MtyZSPDLKjpIK
	 Rxz5mWvqUCMLiClEaWUDZchYvTS8a1yT8aWLukk5gzwtTTO08/a3WFHdKIzHL5shYe
	 CNEb8V0SUM9OYtjt6TbiwGgp94MWOrkdDaltqs3XcSLl7Vnmd0UQ347sbb+iYsWriE
	 p+F4q24r0N/bKOyNAL2I5fwbiBGBkxlk3gW37xe3QrFztL31DvfJViMzyTVRS+su88
	 t4YnIrEXUeWTw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/8] mm/damon/core: introduce damos_quota_goal->complement
Date: Tue, 29 Sep 2026 01:16:02 -0700
Message-ID: <20260929081603.42230-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929081239.A69AC1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 08:12:39 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] damon: integer overflow in psi complement calculation on 32-bit
> --
> 
> commit 194cde60eb24e43a85afddadebba1bd09c82f1e0
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damos_quota_goal->complement
> 
> This commit introduces the complement flag to the damos_quota_goal structure
> to specify whether to use a complemented value of the goal target metric. It
> also implements the core logic to handle this flag during quota goal commit
> and metric retrieval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2960,10 +2961,18 @@ static void damos_set_psi_current_val(u64 now_psi_total,
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
> [Severity: Low]
> Does this calculation overflow on 32-bit systems?
> 
> On 32-bit architectures, s->quota.reset_interval is a 32-bit unsigned long.
> Multiplying it by the integer literal 1000 will overflow before the
> comparison and subtraction if the user configures a reset_interval_ms
> greater than 4,294,967 (around 71.5 minutes).
> 
> While such a high interval is atypical for DAMON's continuous monitoring,
> it is technically reachable via sysfs since the sysfs store function does
> not bound the value beyond the maximum unsigned long value.

Yes, it is atypical and extreme setup.  Sane users ain't use such setup without
testing.  I think it wouldn't be too late to revisit this after a report from a
user is arrived.  I will also consider making a better handling of the corner
case.  But not a blocker of this series.

> 
> > +			else
> > +				val = 0;
> > +		}
> > +		goal->current_value = val;
> >  		return;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260929080113.41708-1-sj@kernel.org?part=1
> 


Thanks,
SJ
