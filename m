Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778073;
	b=n5sTnEj4r/X3IKqc8HWD0b6Hxh1Q7Y749BvRLhRg3vSZpfNBLTv8pMrUIHTj+IgHchLY
	 h9Bk0Xcy1EiRMQfqGleu8aL7N4ZAnBHiM8JXvk1iweRbpudewco9COGtETfupUqRdDszz
	 rI5ljHCZsl3XjnvzTjIy/eFCgLucW+e26xb/N3NNfrz3EJV66aUsYlCtwlwG4MA19bOVw
	 WR8Uphhpv8tX5h9d+5utNCyxDCI0AQcFiMQOF3uhv4jMFCRrVkqKTb7Ws2iKO7Rgi9s8x
	 6kwecebd3Vc2CBgBRiJ65BoBiEIds8Y9Dk8ujr6KiBZketflvfpQCGbhn6B6NGUSlZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778073;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=S5CQ0U7AMIECPIk9f1fy3cqbdLwZ/RCPmglbZ5ldwRc=;
	b=XfGtaUn1E1kSAiMsgWTUf+0d7iCxi32lxErNU/9vT7M2CC0uyJSFI90EQwkTL7jdPi1E
	 +7x5dTetBSvvC3/E3AglxY1KIsRmLMzdWSxE/gPd4t39eQmM41iZNP9O14g2Fl3m6hgA9
	 KeHWt21BnGjD9xXBTmnNtWojTjytPPursemDNdxJcPaUE9vTAfDQACpeA8IwbBF5/aCNm
	 73mrYwvAsWiCSR54TiHDqBA1pQQ1IEc038wbGFsQuMDMAXpxmafELM58XpH1fAqpj1kL/
	 sffAwW6gJ8XHPbpwfF788jOpDMhO5A0VCvdbSVfWIWGflH2CXjsRjtUie6R40DqPlTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSoFvyOb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C0606A32F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSoFvyOb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024D31F000C4;
	Sun, 15 Nov 2026 21:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794778073;
	bh=S5CQ0U7AMIECPIk9f1fy3cqbdLwZ/RCPmglbZ5ldwRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oSoFvyObHbygpxj3QEGtSb7Kni9B0reawWgDDpdDLlNSmR7kBdl7cp+vSN26EuEPH
	 LupE/ITVZ/LTwrqTakJ3FAG0vaCbBOvS/fBI3jSc/1THNozus1DPBabfz7Bev9ideo
	 ctsma+NBr4JgnPl1vv+Dfwpzo7xi3MD63smVETm2mL60qOepHUb9XQ5RJLPBjl6zyY
	 0vQVvk40LHc7pY0T/zyNtpefbEoCXUL4MHwgbckwGSw6F0zD/qYrkQEUyjE4fS9ntF
	 hQpRpTm3SPggxTxloPSE/yW/vWMSvJ3F9xiZhsQDA6/E1uhdZmScHYkyVkPinCBseP
	 h+omNL4ZopqNA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 12/27] mm/damon/core: introduce DAMON_FILTER_TYPE_REPORT_MADE
Date: Sun, 15 Nov 2026 13:27:44 -0800
Message-ID: <20261115212746.101668-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-215843@kernel.org>
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

On Sun, 15 Nov 2026 20:36:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] mm/damon: missing report_type copy in damon_commit_filters()
> - [Low] mm/damon: missing kernel-doc for report_type in struct
>   damon_filter
> --
> 
> commit 4743cf0114c7407b0d8b853557595a3a4674cb82
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce DAMON_FILTER_TYPE_REPORT_MADE
> 
> This commit introduces the DAMON_FILTER_TYPE_REPORT_MADE probe filter
> type, adds report_type to struct damon_filter, and copies it in
> damon_commit_filter().
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index ca0135c6f6700..cce7d344c585b 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> 
> [ ... ]
> 
> > @@ -834,6 +836,7 @@ struct damon_filter {
> >  			unsigned long range_min;
> >  			unsigned long range_max;
> >  		};
> > +		enum damon_report_type report_type;
> >  	};
> 
> [Severity: Low]
> Should @report_type be documented in the kernel-doc comment for struct
> damon_filter to avoid a kernel-doc warning?

Nice catch.  I will add the kernel-doc comment.

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 06b85d00e38d9..c02c7fbc1d864 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1834,6 +1834,9 @@ static int damon_commit_filter(struct damon_filter *dst,
> >  		dst->range_min = src->range_min;
> >  		dst->range_max = src->range_max;
> >  		break;
> > +	case DAMON_FILTER_TYPE_REPORT_MADE:
> > +		dst->report_type = src->report_type;
> > +		break;
> 
> [Severity: Medium]
> Does damon_commit_filters() also need to copy report_type when allocating
> a new filter?
> 
> damon_commit_filter() is only called when overwriting an existing filter
> in dst.  When src has more filters than dst, damon_commit_filters()
> allocates new_filter via damon_new_filter() (which uses kmalloc_obj()
> without initializing the union) and runs a separate switch on
> src_filter->type:
> 
> mm/damon/core.c:damon_commit_filters() {
> 	...
> 		new_filter = damon_new_filter(
> 				src_filter->type, src_filter->matching,
> 				src_filter->allow);
> 		if (!new_filter)
> 			return -ENOMEM;
> 		switch (src_filter->type) {
> 		case DAMON_FILTER_TYPE_MEMCG:
> 			new_filter->memcg_id = src_filter->memcg_id;
> 			break;
> 		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> 			...
> 			break;
> 		default:
> 			break;
> 		}
> 	...
> }
> 
> Because DAMON_FILTER_TYPE_REPORT_MADE is not handled there, committing a
> newly added report_made filter leaves new_filter->report_type
> uninitialized.

Good catch.  I will add that.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261115202849.99134-1-sj@kernel.org?part=12
> 


Thanks,
SJ
