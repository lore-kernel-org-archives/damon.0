Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B23E1D05
	for <damon@lists.linux.dev>; Fri, 10 Apr 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840453; cv=none; b=jqEvcnnS6awoItlxXGnIHl4LRg3161CEN9KfgyOwnYpbW1AZseS7kIlzllOv0fET81onnvu/TBFOPQoR7KqwhK9V9bWTSXJ9Owi2dccMSptMrGl6sSbTFhnuulkV97kfFUe4N8bHM92h9DRsOeknWXU/ZMPlmFeysWbSfrfKeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840453; c=relaxed/simple;
	bh=U6eJt+lB9XtV2TYcmB/Cyxool90IKNFvE1dIXTnnx3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5I/LGeEzAVksd4MuISzAvdVB2eq0zP8oBhzi4q0yCMMWhy0lUNcBE8axJUm4MD3bru/5h3jiA2c7jaP21++0cZIHKmGC29uXJuVTf5L+d1gsGJ5RW+P063hFpyf3Nm505XhjUW5zLiMk9GsIBo9nIrBbSP8UnOTwGeCJhVwTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8SU44fs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8SU44fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E31C19421;
	Fri, 10 Apr 2026 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775840452;
	bh=U6eJt+lB9XtV2TYcmB/Cyxool90IKNFvE1dIXTnnx3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8SU44fsIhMHJ4svmNcyINgZUNbjcsINUv9z9dnk4ZkaKhNRJdGRHBQkn/a3MYRUt
	 kDGV0EDXQvGJVcgKb9yA485U/NqzvhosPQnOQt9pDieVqApBDBG4BVOemP1fD+rhBA
	 TxWpZLp7MjkCkxM4KexT45ETpvBxoUnDJG5H0b2eoN5ApKAn+necVCco5xiiDRMpud
	 N9qlU/RG8JeYOR4C7A/HaQU4Tw1+TG3NYPRMVfLwfLwp8HU51xpbrwnZUotUEL0Yiv
	 zE32hgbty2QHvtY5jU+BJ868LBwRo+ghkaQmgXcfgwu/sf6TNAv0AP1D4Q+ys6jL/8
	 RgOzYEQmOC4Jg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 10:00:50 -0700
Message-ID: <20260410170051.51008-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410164610.6764-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 Apr 2026 00:46:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Fri, 10 Apr 2026 06:55:00 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Fri, 10 Apr 2026 17:40:04 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > Sashiko found some issues.
> > 
> > Clarifying what is the following action for the sashiko finding would be
> > helpful.  For example, if you say "Sashiko found some issues, so I will post a
> > new versiuon soon", and if I'm busy, I can save my time by saying "Ok, then I
> > will skip or delaying review of this version and wait for your next review".
> 
> Okay, I will keep that in mind next time I foward a Sashiko's Review.
> Thank you for you suggestion.
> 
> > [...]
> > 
> > Agreed.  This was unclear to me in previous disucssions, though.  I still agree
> > it is out of the scope of this patch.  But now I think we need to let users
> > force-restart.  Adding this to my todo list.
> 
> Just to make sure - is this the same issue that my recent RFC patch [1]
> aims to address? I want to make sure we're not duplicating efforts.

Hmm, this makes me confused about how we ended up working on this series, then.

> 
> I'm still actively working on that patch, and I plan to send the next
> version next week. I've been holding off because I didn't want to send
> multiple patches in parallel.

Ok, seems I dropped a ball.  I was working like AI bot that only works with
limited and nearly fresh context for each mail that on my inbox.  I will work
on making another thing for tracking this kind of parallel works with good
context.  But since I already dropped the ball for this, I'd like to make sure
we are on the same page.  So I'd suggest below.

1. Let's hold this patch series.  Andrew, please don't merge this for now until
   this discussion is completed.
2. Please summarize your parallel works in progress with the context about how
   you decided to do that in the way, with summaries of our previous
   discussions.

Could you please do those, Liew?

> 
> [1] https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
