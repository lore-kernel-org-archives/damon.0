Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE22AD3C;
	Wed,  2 Sep 2026 04:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323033; cv=none; b=dU9jo86X7TBOPxQhgZWi3ljSftauuLrX1XU6hekIo7tt5hZenk1letGMVU1V6GA5MtrkJh+tr0hjraYW1Y3uCXu4lbQreDGA/sdfiBRGNpo94KU+w7OGy4CsVHbiLHoS0t5S5Iq63bJfxZhfHA7p+x5eqzTYgj2QxqNLoM+LgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323033; c=relaxed/simple;
	bh=FmRC+bS02q4Tj5mANzuEg08tT9VklDzM46SUj5JT8z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzHdbD7Kyb3MHEImhXfEtOLSLqyVAEEvIx0pvuHXyQENctrKnOvf6g5DRWJR+//QoqHC1WtjtAp9PawR5dALgdFht1Af7rudLpbsxO9WcTpr+bkVEBg8A63FSABH1KF4Ec83xazTR9l1h7pBEWeaVvvp/cGk73CXt9APzYJRCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efsMFi5D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efsMFi5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462301F000E9;
	Wed,  2 Sep 2026 04:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788323031;
	bh=k/BBp1rCaHO25EnmCw/gRO/quORSiIRxHq89BaWHrqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=efsMFi5DAOQl8K8tkDMkmeesth1Zr+E8qUFuw2SYFsiGrIU5k3mZKlRmHVjeoy5Up
	 Mh232iQJOWIKNzjvGZYNeoeShVNyaDTa6lGsyyoN5DD9V/Kv85+QJDoFcN/i/D1jIH
	 cCJGtC33GLJdrgibBOLbgxgMtziisfzeJY/Dk1K4+BNlLYGE4vznMbGd9JneORDsbl
	 StPSReyIi3VT4KJ0syn8fAblDFXb4Dt3K59p4zgx5HO1lByfwnekQb1A+q/CXHVK/J
	 DwPmaEabtuXNBgYMDcv5bKId6yA4W9hyeVShopEBuaww7OQsJN101tuGEQOcOO144E
	 KqSYVzKqpxv8A==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Tue,  1 Sep 2026 21:23:43 -0700
Message-ID: <20260902042344.83913-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902015616.57702-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 09:56:01 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> Hi SJ,
> 
> > Seems using MTHP_STAT_NR_ANON that is exposed as 'nr_anon' can be used?
> 
> Thank you for the suggestion.  I will study MTHP_STAT_NR_ANON and nr_anon
> further, and document what I find.  We can continue discussing it by email,
> and I will be happy to review any follow-up or updated patches.
> 
> > I'm curious if you and general reviewers need or prefer to directly be Cc-ed.
> > I was naively thinking people can search and review DAMON patches by
> > subscribing to the mailing list or using the archives via lore.kernel.org like
> > tools.
> 
> I subscribe to many mailing lists, including linux-mm and DAMON, and I also
> follow patches through lore.  Direct Cc is not required, but I appreciate it
> for DAMON-related patches.  Because I care deeply about DAMON, directly Cc-ed
> messages are filtered into my important mailbox, so I can archive and review
> them quickly.

Thank you so much for your interest in DAMON, Lian.  But, the problem is that
my memory is so bad. :'(

I am maintaing mm patches review status dashboard for people who want to find
patches that waiting for their review.  It also provides the review status for
each sub-mm components [2] including DAMON [3].  Maybe finding patches that
waiting for your review from the dashboard is also a way for you?

If having the mail directly in your important mailbox is what you need, I
believe adding mails filtering rule for DAMON patches wouldn't be that
difficult.  If you use hkml, it could also help you monitoring [4] those.

Yet another systematic and long term solution that I could suggest is keep
reviewing and posting DAMON patches one by one, build more tracked records and
trusts, eventually adding your name as DAMON reviewer or maintainer on the
MAINTAINERS file.  All patches sent with get_maintainers.pl will automatically
Cc you.  It would take time and require patience, though, of course.

> 
> I am very happy to contribute to DAMON, and I look forward to continuing our
> discussions and reviews by email.

I really appreciate your interest and contributions to DAMON.  I hope it to be
continued long term!

[1] https://github.com/sjp38/mm_git_dashboard
[2] https://github.com/sjp38/mm_git_dashboard/tree/master/summary/subsystem
[3] https://github.com/sjp38/mm_git_dashboard/tree/master/summary/subsystem/DAMON
[4] https://github.com/sjp38/hackermail/blob/master/USAGE.md#monitoring-mails


Thanks,
SJ

[...]
