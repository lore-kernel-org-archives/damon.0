Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168802;
	b=Q4VNUv1zFq0sCJ0r8rKauzIBvGv/jBIZa/1TofJEQ/A4fTpQZjJWBFYgqW79RMZY8/QB
	 JlzAQzNCiRtRXoA3DNKnw8u20zTk2HIHoA+jzsP+livJ0NgQT0o3YzHGs6Vmsr7fLhpsF
	 OdS64+UbQAyOXdzxwQ+3PPchDtLzwawB7+ag1jX6ZC+S+6nwPCAHZsGNcASoGKWbn5qNS
	 BgodHk+PkCfW6X0XCidRPDjHwbDUtrAAOuKXwOzanul3TKla+0ckXk+j7vI3yPt+wkpFT
	 vOhlkPa8b8IMJ0NB7iJmXUhpfYVXw1BKcZW0gEnhrvOoStldveIdIbA+SGAdzUsW//w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168802;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=j8+c5Xbh3DzXpViCvYHZV/a1sIh6FK99cPDHc6wG5Rs=;
	b=ja3LhwekLE1HHV3m6nNEUA1FqPE1FqF2DTe8Pi8S7V8rAkm3ipDJN+3u+ISNAea0r/8N
	 CJU8AyoRWQPr0wxMrQ9Alxz/qmVhIf/atbt8eIpEj231G9e9z0ocTUA98IJUh6DgtoEyc
	 CpoNS1rI8/noZjSIsv/beOCRkzkFnsaTGXZEnR2LXMqKdG/y0uHEJuREKxw2FLtUad92k
	 q/V+okBvV8znIDQ+oQvY3jiJDK5GULTwYZXTH6Fd37PmMU7xKmdOeXyCo8YWkawU+70mT
	 LraaRZVxH0i60gF2CA4PMABuN7cMP0y3tYPGIpYDV9/M+HkEEMSggy9BOG6KH1gbpcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8H96QFs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC5606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8H96QFs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704D31F0089F;
	Sun,  8 Nov 2026 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168801;
	bh=j8+c5Xbh3DzXpViCvYHZV/a1sIh6FK99cPDHc6wG5Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j8H96QFsFu0tIe1dXcGE9/ihf6kXtPI52ctqXqM3F9q457AuZPP6RPCrdWWxNGMHA
	 f8/afim4JGWPvGLum9RWkAvDCKI6oir9nRD52Lugnqo5fkSlcHPHOvab/yh5GDnJgv
	 Mf7H6AuUleQe+k91199kTRalcMA7jQ6dHLdvK6ZrsG1RvLeZUtGM30BcJ7ra0WIurd
	 ho5EQsL3SaFEqpf/rOF4tKgRLSVaB5fjIYsAQkuuWkJjL8e89npGW+3NRDNtA8i8I0
	 OGq7YAPgNmot1TmPso8FbH/hmt2+m7x2eBU3CrhQS7Fv0TJGQwv9ocHXpn4ZCKmPgu
	 iBuu0OIJ5EBlA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Brendan Higgins" <brendan.higgins@linux.dev>,
	"David Gow" <davidgow@davidgow.net>,
	"Quanmin Yan" <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	"Lian Wang" <lianux.mm@gmail.com>,
	"Kunwu Chan" <kunwu.chan@gmail.com>
Subject: Re: [PATCH 6.12.y 3/5] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Sun,  8 Nov 2026 12:13:12 -0800
Message-ID: <20261108201314.116356-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-204001@kernel.org>
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

On Sun, 08 Nov 2026 20:03:27 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/damon: integer overflow in damos_quota_score() on first
>   PSI round
> --
> 
> commit 6456f90a0b14251a6d548d6849beb9dd850f55e6
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
> 
> This commit initializes damos_quota_goal->last_psi_total to U64_MAX upon
> creation and commit, and sets goal->current_value to goal->target_value on
> the first PSI tuning round so the effective quota remains unchanged until
> a baseline PSI reading is recorded.
> 
> Link: https://lore.kernel.org/20260902002725.108635-3-sj@kernel.org
> Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 6ef77741b783b..52f01a6508b66 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1608,7 +1611,12 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
> >  		break;
> >  	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> >  		now_psi_total = damos_get_some_mem_psi_total();
> > -		goal->current_value = now_psi_total - goal->last_psi_total;
> > +		/* uninitialized last_psi_total; make no effect this round */
> > +		if (goal->last_psi_total == U64_MAX)
> > +			goal->current_value = goal->target_value;
> > +		else
> > +			goal->current_value = now_psi_total -
> > +				goal->last_psi_total;
> >  		goal->last_psi_total = now_psi_total;
> >  		break;
> >  	default:
> 
> [Severity: Medium]
> Can setting goal->current_value to goal->target_value overflow in
> damos_quota_score() when goal->target_value exceeds ULONG_MAX / 10000?
> 
> Unlike mainline where damos_quota_score() uses mult_frac(), this tree
> computes the score with unsigned long multiplication:
> 
> mm/damon/core.c:damos_quota_score() {
> 	damos_for_each_quota_goal(goal, quota) {
> 		damos_set_quota_goal_current_value(goal);
> 		highest_score = max(highest_score,
> 				goal->current_value * 10000 /
> 				goal->target_value);
> 	}
> }
> 
> When goal->target_value > ULONG_MAX / 10000 (for example, above 429,496 us
> on 32-bit architectures), goal->current_value * 10000 wraps around and
> produces a score below 10000, causing damon_feed_loop_next_input() to
> increase the effective quota on the first round instead of keeping it
> unchanged.

The issue impacts only DAMOS quota auto-tuning quality under certain setups.
No blocker for this patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261108195145.115792-1-sj@kernel.org?part=3
> 


Thanks,
SJ
