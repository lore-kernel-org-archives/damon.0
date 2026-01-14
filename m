Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD02D77F7;
	Wed, 14 Jan 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405590; cv=none; b=m94vZRV5Kn4jClIFR67XPPEZ131btGY0iunyEpnIwTSfxktZwWc9TujEvs2ke+JNjUQoTCJZ5UGidrCGHKA5TXkFSfBB0eUVAtPdiKfpCKeJ/Gn/suYGAW28RnTnG0rop56e552SiFRKcPucN+qzVBRg6jajRCQyuEHmKIi8ZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405590; c=relaxed/simple;
	bh=j2ky40jno61TnJrLoMTlC2emFFzgQJSeqNa7tzJbpMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY/uBOb8ftb90piXXD6K5ZjHmPFDd3VyxW5ZNRrVWsBzdcsvJMD8Q1yNdg53y3DRj2wid4GuBKrWYQnoMEthGmT34Vty4yBNYkzPcn3aq3cfOR09KHO2vtK0MFGpPSSFsmJnWFYulP+ie6ZcB5EFlI7DiAYnjVQWBW3ZjeFqeGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rs9IGEnt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rs9IGEnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391DFC19422;
	Wed, 14 Jan 2026 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768405590;
	bh=j2ky40jno61TnJrLoMTlC2emFFzgQJSeqNa7tzJbpMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rs9IGEnt0mEVXhJIpYAUo7LYNmJHYh8psDGVHFS+qmbNyYzpR12tFbsIYwBVBmoeE
	 JtKjTxlne79AnOLUPHJypfdsBK2FR70A8gZsytebi5Rugv1w1pIpGz1Ykuaz9BN0zx
	 TrACdWA6osRN+Wv93M+3nMR8iQy96ubYHUB+u6IMvGJdZF0p1mjHsdJuNA94HUbzaX
	 zjo6iFbABsrnLIt3dA3F04LeTKl3yGlhNv9H6qLWEOn/3drVyFnjhEmmUpn0L/Zk23
	 yChV/wTh76m6m4+ywO11qtnmYiWvwDP33ktWZFG6vbz8JxIk3U5+x5onqrlM0Z/MWW
	 FO4ejJZBtxhxw==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rgbi3307@nate.com
Subject: Re: [PATCH 1/2] mm/damon/core: modified and tunning damon_split_regions_of()
Date: Wed, 14 Jan 2026 07:46:21 -0800
Message-ID: <20260114154622.100466-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113121646.31441-1-rgbi3307@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello JaeJoon, thank you for continued interest in DAMON.

On Tue, 13 Jan 2026 21:16:42 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> Before modification:
>                                                              sz_region
>     |--------|--------|--------||--------|--------|--------|--------|
> nr_subs:     1        2        3        4        5                  9
> split random:    <----------- (*] randmon        LOST -------------->
> 
> When dividing sz_region at rand, the random value may be small, such as
> 1 or 2.  At this time, there is a problem that only the front areas
> corresponding to 1 and 2 are divided, and the remaining back area
> becomes too wide.  If the area is too wide, there will be many missed
> address access judgments.
> 
> After modification:
>                                                              sz_region
>     |--------|--------|--------|--------|--------|--------|--------||
> nr_subs:     1        2        3        4        5                  9
> split from   <------------ (sz_region / nr_subs) ------------------>
> 
> It is recommended to divide sz_region evenly in the ratio (sz_region /
> nr_subs) rather than using rand.  In this way, if you decide nr_subs well,
> you can logically match the number of divisions and their sizes.

I was thinking about how to reply to this patch.  Since it is taking unusually
long time, let me add short comments for direct future of this patch.

The existing code uses random() for a reason.  This change might break it.  Can
you further explain what was the point of the use of random(), and why this
change is not breaking it?

> 
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>

Unless you can give me a convincing answer to my above question,

Nacked-by: SeongJae Park <sj@kernel.org>

Same for your followup patch [1].  Btw, please send patches of same series as
one thread from next time.

[1] https://lore.kernel.org/20260113121731.31468-1-rgbi3307@gmail.com


Thanks,
SJ

[...]
