Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D1342CA9
	for <damon@lists.linux.dev>; Thu,  2 Apr 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143757; cv=none; b=QvBUkZ6izyaUHT1wmijxOgqvgomcdK67d4ioRdcNuapCyjjMG7UtzJ7g6gfb93Vqh7xWdHD+CKK59+URBualaG7fI0ISC0d39oPR0cJNAvjKs3AfP7q9FQZtpxbs3VcNyfJMRBNiPlnwv/UZ1KQ7DFmE5Azqj8anmD1aqFXI7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143757; c=relaxed/simple;
	bh=WabYirgQ6jpKqOZUKjPabn8CatL1+vtHOMtJQ68RdrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s67+CqdXt6DfJrIKCV74Kh1qVvL4+qAt6uqZb1OQrrHNR/fdBhmzSr+ZDkXW8TC2OUfNGfrbDkUZ+DVjUeI171/XWqziJ61jUy+E+6THNVHr4EfpX4/rl1KCtD1FxvP62KZgbiW2/pgSswU+pIp9h6FN9fgfbfeFJMF6C4HfSBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC4owcZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC4owcZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65227C116C6;
	Thu,  2 Apr 2026 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775143756;
	bh=WabYirgQ6jpKqOZUKjPabn8CatL1+vtHOMtJQ68RdrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tC4owcZCt67SHzbolydwGUIVVOZF0KUxKc4A3aKQSKZGp8c25oKVepJ5l9CvMdN4s
	 ed0auHEvD2pNZ2WdvZs1HZHpVShHsipz9Bkmz3lQrW26cZTZVS/+4OUKupQwVXc2SO
	 ALWXZiqn4qjvjdiv82SVzUflZqHNAPOmv4Mit42IuA0cPaU36eyT9ClmrWE3zDgXfC
	 02Qq7H3CNqaUD96x5pBuyBViwwpsTcLhGRe93qg5qHr7yRN6mF8QLZEXqIXEi/Hnmr
	 P+6i50KadqEjpuf1po8pZoBYHeVo2MVWo8sA+3XRTWFePNej3Sa+iQz529h9lalSlQ
	 LH92XurPX0YWw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon: validate min_region_size to be power of 2
Date: Thu,  2 Apr 2026 08:29:14 -0700
Message-ID: <20260402152915.75294-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402140314.74600-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Apr 2026 07:03:14 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu,  2 Apr 2026 13:37:56 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Problem
> > =======
> > damon_commit_ctx() checks if 'min_region_sz' is a power of 2. But if it
> > is not, kdamond will terminate unexpectedly due to the user's invalid
> > input.
> 
> Could you please further elaborate visible user impact of the problem and
> reproduction steps if available?
> 
> > 
> > Solution
> > ========
> > Add the same check to damon_{lru_sort, reclaim}_apply_parameters(), but
> > return -EINVAL immediately. This is to prevent user's invalid input
> > causing kdamond to terminate unexpectedly.
> > 
> > This patch is a follow-up to the discussion in [1], where we agreed that
> > the validation should be done on min_region_sz rather than addr_unit.
> > 
> > [1] https://lore.kernel.org/20260330233343.4083-1-sj@kernel.org
> > 
> 
> Should we add Fixes: and Cc: stable@ ?
> 
> If we should Cc: stable@, and if the changes for DAMON_RECLAIM and
> DAMON_LRU_SORT deserve different Fixes:, I think this patch is better to be
> split into two patches, one for DAMON_RECLAIM, and the other for
> DAMON_LRU_SORT.
> 
> > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> > ---
> > Changes from v1:
> > - Fix memory leak issue.
> > - Link to v1: https://lore.kernel.org/20260331073231.30060-1-aethernet65535@gmail.com
> 
> Seems you forgot the patch [1] before renaming of the subject.

Also, if you have posted RFCs or another different subject patches before,
please add full change log.

We are dealing with multiple patches in parallel, so I'm not fully following
entire contexts.  Please understand.

> 
> [...]
> 
> The code changes look good to me.
> 
> [1] https://lore.kernel.org/20260327062627.66426-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
