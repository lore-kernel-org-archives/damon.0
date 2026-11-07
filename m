Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085577;
	b=G26ahdW+xRkz/SyaLPqKFeTk4HOdsDiQraHUJ0minnZCMeMWmaz8FY96L62tAQorHs9f
	 suBz4Dic1D80P/hR7raiFD2wCIPosAhm3CFODfl6thWo1o1L0eurvLjlqnokA7dFhXc6P
	 GPJtdSoukNREi9aAZwwTA7E/Fy29NWS92rUfIvUd8SHdy7yFFmV2o3ljCPmj9KFe5sk4z
	 tzxiKZz8GV6SESilO/Xarvx9vpmOfUoDrOL9i6cLIu0Q2+ePtr4blEAN8ibC+It2wH66c
	 SOQeHPtGv57fQBf6Rbi7bU/W13kB+0WEw1EKibeIxav7rg/TrsI/z5BqYawGH1qEQsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085577;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rKOpXDTka6zsRI+o/WN9YYaFvky2KJDqfkcQZqbSnuk=;
	b=d+k4x8tOtiBudugnL0QsYI65oEEz/4g9wKrARIEq1wuw4s4UlYtFjLJ5Fy6P7lDBL+rr
	 adt04mUkt9IQUu0sp8ZXrzngXFAqbfE902qKCpOA3nAaYQW0NoYfUFM5oJszEHDAw9KR7
	 F6IXi+eSPFi31PmORaSGRqgnHWtB9TQT9j6unPdL9+o2/cg70Rg8d2InI1p6H1Z0E7tX9
	 01bVS3Su8xbFSdv7PyJJlgRtprbA3MbFghwCGlpSw6y2gDJyYsdvTAVOS+JIii8t9oWcN
	 4k1Z+m/0RPNj5BYrNW/6VfnwHg/rLrPWl9oKJ0X2GYm1/d3WkKaJ6uVoACzCU5DWCOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0HhVEsC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE8606A32E
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0HhVEsC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AE11F0089F;
	Sat,  7 Nov 2026 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794085577;
	bh=rKOpXDTka6zsRI+o/WN9YYaFvky2KJDqfkcQZqbSnuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a0HhVEsCCO989RwnIKRu0YCBkukRW5SoTDDJrsDOmtPFdYdN2GP3+kmQOBs/AVd2X
	 AWDWlh/spnyvqU2xCNEKf+OChocFfOc+KgynHefki9QebPyg2I0M1cSmHpxh47KAmg
	 TonPYIIqVjVMD/jQ2c0Qss1fkKnJVC6RMdMi3r3etcVgzOP9p0bN3fezOHkGG9jkur
	 gxD9w+LzkBi+Pm7cSjzHclviioQ9qNXiKdiIy/F0L3uG1ApFCvXuNgiBnwzbkjS8M7
	 X2qH1lzNWuifeXlfzVs1X2qemCMTpWB1YLyd7pGDdEylhXmhjnreWeOZyMU8KoOtVn
	 Srr38yUNYRbVg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Usama Arif" <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.18.y 1/5] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sat,  7 Nov 2026 13:06:08 -0800
Message-ID: <20261107210610.270916-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-203262@kernel.org>
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

On Sat, 07 Nov 2026 20:18:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm/damon: damos_apply_scheme() inflates stats on region split
>   failure
> --
> 
> commit dd2b638af6fec217ed7123ab31fe119102f17f78
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: skip applying scheme if region split for quota fails
> 
> This commit updates damon_split_region_at() to return an error code on
> allocation failure and skips applying the DAMOS scheme in
> damos_apply_scheme() when splitting a region to fit within the size quota
> fails.
> 
> Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
> Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
> Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 8fa788b0d709c..4c536a9b958e4 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2000,7 +2000,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  					c->min_sz_region);
> >  			if (!sz)
> >  				goto update_stat;
> > -			damon_split_region_at(t, r, sz);
> > +			if (damon_split_region_at(t, r, sz))
> > +				goto update_stat;
> >  		}
> >  		if (damos_filter_out(c, t, r, s))
> >  			return;
> 
> [Severity: Low]
> Does jumping to update_stat when damon_split_region_at() fails inflate
> s->stat.nr_tried and s->stat.sz_tried?
> 
> At this point sz holds the non-zero aligned quota remainder, so
> damos_update_stat() increments s->stat.nr_tried and adds sz to
> s->stat.sz_tried even though damos_filter_out() and c->ops.apply_scheme()
> were skipped.  Because quota->charged_sz is not updated on this failure
> path, subsequent oversized matching regions in the walk will repeatedly add
> sz to s->stat.sz_tried while allocation keeps failing.

Good finding.  But too trivial to block this patch, in my opinion.

It happens under small memory allocation failure, which should be very rare or
even could be argued as too-small-to-fail.  The inflation would also be also
capped to quota size.  Hence it is trivial.

Also, same issue is in the mainline.  I will consider fixing it in mainline
first and add Cc:stable@ tag.  I might conclude not to fix this, since the
user impact is quite trivial.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261107201001.206120-1-sj@kernel.org?part=1
> 


Thanks,
SJ
