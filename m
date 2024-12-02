Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F831E521
	for <damon@lists.linux.dev>; Mon,  2 Dec 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142279; cv=none; b=HjTGMT0JtC3RcwkPQCYXF3MrG7JNcb1H/eQoIuDSwePec6KqxW8Oa2ylUUogLls5fyhgbILAEBygd4QHUCw7o6BZVRpqsFAMix1gSPYLXxZgNQrZBpP5C8NFMekXU4ZM4MfLT2Sdi6h9PXGsnwun7LRTSscMheq0VUHfFAQkBEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142279; c=relaxed/simple;
	bh=Z6WjTiVcOOSNh974wEe/2un4vPcr1xNC+jEJUcqKLKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ht3Vccm1x+Fy/cJIDUt67HC2vlSDVXSAx2DGB5O0RopBiLqiTb6AGNbxJlbcgMLiio+JJ7zXOUboEsyEQVVfWdRboSzd5a/zZsRLz7wgQ1f6NAlUxe5cuZ1E00P5kHL3froMkYSM7Qgs4PpQDucotQFUud5hqAQjH+6lYeRXVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-8c-674da6f9a571
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	kernel_team@skhynix.com,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH] mm/damon/core: accumulate applied size to quota->charged_sz
Date: Mon,  2 Dec 2024 21:24:05 +0900
Message-ID: <20241202122409.82-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241129195529.98532-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsXC9ZZnoe7PZb7pBtfXqlk8+f+b1eLw1zdM
	Dkwem1Z1snm82DyTMYApissmJTUnsyy1SN8ugSvj0ZONjAU7xCuOPm5ibmA8KtTFyMkhIWAi
	MfVONxOM/e3lOlYQm01ATeLKy0lgcREBRYlzjy+CxZkF6iTet/SBxYUFAiTaz98Fi7MIqErc
	a53GDGLzAs1pfrCbGWKmpsTj7T/ZQWxOAWOJmd8+sYDYQgI8Eq827GeEqBeUODnzCQvEfHmJ
	5q2zgXq5gHrfskqcfnyZEWKQpMTBFTdYJjDyz0LSMwtJzwJGplWMQpl5ZbmJmTkmehmVeZkV
	esn5uZsYgQG2rPZP9A7GTxeCDzEKcDAq8fB+qPRJF2JNLCuuzD3EKMHBrCTCu3y9d7oQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxt7zsltmq0tOOFji
	u6o23kiNP1JjbxFXhiHT0hDeyP9HX1yqqIsW6ozY3h91cf2XgsPO168ndh0PD/cIOn9g2xV9
	dtWd159d3Pmh9bxtTUbTCfbtftluGlp3Pl7etYDhvanFvYU5UksUPc58EvVSjVy38eDER3Fa
	6id73ths3vZ+1+zDRdn5WkosxRmJhlrMRcWJAMAbHPwsAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LhmqGlp/tzmW+6wZttQhZP/v9mtfj87DWz
	xeG5J1ktDn99w2Txe9sKNgdWj02rOtk8Xmyeyejx7baHx+IXH5gCWKK4bFJSczLLUov07RK4
	Mh492chYsEO84ujjJuYGxqNCXYycHBICJhLfXq5jBbHZBNQkrrycxARiiwgoSpx7fBEszixQ
	J/G+pQ8sLiwQINF+/i5YnEVAVeJe6zRmEJsXaE7zg93MEDM1JR5v/8kOYnMKGEvM/PaJBcQW
	EuCReLVhPyNEvaDEyZlPWCDmy0s0b53NPIGRZxaS1CwkqQWMTKsYRTLzynITM3NM9YqzMyrz
	Miv0kvNzNzECQ2lZ7Z+JOxi/XHY/xCjAwajEw/uh0iddiDWxrLgy9xCjBAezkgjv8vXe6UK8
	KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MmTd5btbPSVqr
	UtGguerVfKmVrStiDCTlSu7n/1wZlO1hy/Fz7Uw9q1TdWUs+vGx5m6/wRurLsabiStYTJpGT
	e/1EY4JqH7/yLg8QlNu5eulRM+cHlaF3psn2clVqZfbdMY4x+Jb0YteRVyHeXOsOzCu5KzYv
	Y8pVoxW/2rPVC5OdD6gWfzmuxFKckWioxVxUnAgAE0isFyECAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

Thanks for the feedback.  Please see my comments below.

On Fri, 29 Nov 2024 11:55:29 -0800 SeongJae Park <sj@kernel.org> wrote:
> On Fri, 29 Nov 2024 17:31:01 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > While testing DAMOS_MIGRATE_COLD action, Yunjeong found that the
> > quota->charged_sz is way less than actually migrated size.
> 
> You mean "more", not "less", right?

Correct.  I wrote it opposite.  quota->charged_sz is highly accumulated
even if zero pages are affected by the migrate_cold action.

> And, is it a problem for your use case?  Could you please share more details?

I think this is for general use cases.  I thought this is logically
quite straightforward but I will see if I can provide more details if
you need.

> > 
> > In damos_apply_scheme(), quota->charged_sz is used when checking whether
> > the quota exceeds the effective size.  The current implementation
> > accumulates the charged_sz with sz(region size), but many pages in the
> > region might be discarded by DAMOS filters.
> > 
> > In order to make the quota calculation more accurate, charged_sz is
> > better to be accumulated by the actually applied size, which is
> > sz_applied in the code.
> 
> This is an intended behavior.  Quota is for making a limit of resource
> consumption from DAMOS.

Sure. We know about the purpose of quota.

> Trying a DAMOS action consumes some of the system
> resource even if it was eventually filtered out or failed, so we charge those.

I would like to have more discussion on this.  Although trying a DAMOS
action consumes some resouce but it seems to be much smaller compared to
applying actions. (especially in migrate actions)

You might think it takes some resource, but it is more close to the concept
of time quota.  We just compare the size with esz when making decision
of quota usage so I'm not quite sure if we really have to accumulate
the size of discarded pages.

> We can consider changes of the behaior depending on problems and use cases, but
> it is unclear to me.  Could you please elaborate, as I requested above?

It might take some time to prepare for the backup data but I just share
what I have thought about it.

Roughly speaking, we found that quota->charged_sz increases 90 MiB for
each interval in our test, but we saw no migration happened when
applying the migrate_cold action.

Let's say that there is a region of 90 MiB and that consists of 23040
pages.  If there are 10 MiB of pages at the end of the region, but the
initial pages are not candidates because of filter setup.  In this case,
the current implementation may consume the most of charged_sz at the
beginning so it discards the last 10 MiB of pages that we are
interested because quota->charged_sz + sz is already greater than
quota->esz although no actions applied.

My explanation is not good enough, but hope this can be helpful.

Thanks,
Honggyu

> 
> Thanks,
> SJ
> 
> [...]
