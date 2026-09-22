Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68C14CC261;
	Tue, 22 Sep 2026 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058540; cv=none; b=qlZX87tAp5uMOP4W7aOOJbH+wWT6LXcmW13fxryXp0lRZgyjwSPlCrHHTlErYKMaAiCZscqdjeX9NmdMg88IP9WL3l1eAzkhVVqNdBdpRgXgTADVummtH12598YG+PSxuJ+olY6Jwg3UzFRuJfd8hvVxLj0ta/FpZ+D9FPscwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058540; c=relaxed/simple;
	bh=IcYxJEgZuJM9fusDTu8OVMZeI7JRVZNX0SbSkTZbm14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wsn+qSr3nf0DXZgPOfqz3ozMJ5hwj0RvBWnljHP8EHkWGjO0xNTbWR/CXwfS2/g7mlO24Vh87kXgu3ljQis1u8AeeX5D3WFZjNPjGYDOKWTn1P6W6WLzQ6jksrLdEbtrH8zzPxg3w7M9K54OHq8fL/1WdF7rOgivF0mmAG7at5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjggewUa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjggewUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0C71F000FF;
	Tue, 22 Sep 2026 06:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790058532;
	bh=KjA0mTADx3qPlEwSKVVtyou7JKb+m4+dYOfU+1IXyeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NjggewUa2OW/a72buV+ty3YEX1MFFXvoolgOwh9ZjB4lLNQ6G4BvvqISxjw6HvDsD
	 tDRRE06ta1+TL+CPaAxBAO8ftW2LhJgfgevibZnFrVZGWtjY4O8lOpSNDtMPtREPb+
	 tP86oUglV47fuyh6r1jOjCjygHP9Xc0HgMguKMmGs6yInel/r5uvZjbHTOfAjG3TBr
	 yHcS1TsYuYWW6qyfOmUHnz+kgtsq3L8jlXwzHwB2/6m8W3MrNUcpRHyRf0hjHerVeW
	 atTXG0I0yxMLlDPd4cT3NNHGxx1ZeSm+D6GSUek+kossuNakz8X403hEIf6aDpBuxH
	 NsBnE5cDkauag==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/damon: preserve temporal quota state for unmeasured PSI goals
Date: Mon, 21 Sep 2026 23:28:47 -0700
Message-ID: <20260922062847.42316-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <arF2epnyKAdkwSG-@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 20:39:27 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> On Mon, Sep 21, 2026 at 09:47:48AM +0100, SJ Park wrote:
> > The patch 1 has wrong Fixes: tag, as I replied to it with two options to path
> > forward.  Speculatively assuming your preferrence is option 2 (adding this
> > series with fixed 'Fixes:' tag), I applied this series to damon/next [1] tree
> > with the suggested Fixes: tag modification.  Let me know if you want the
> > options 1 (squash it into the incomplete fix [2] before it is merged into the
> > mainline).
> > 
> > Unless you want option 1, and if this series is not added to mm.git in short
> > term (~1 week?) with option 1 update, I will ask mm.git maintainer (Andrew
> > Morton) to pick this.  So, no action from your side is needed for now unless
> > you want option 1.  If it seems I forgot doing that or you cannot wait for my
> > action, please feel free to ping me or Andrew.
> > 
> 
> Hello SJ,
> 
> Thanks for reviewing both patches!
> 
> I used b73198a47ffe in Fixes because that commit introduced the problem
> with the temporal tuner.
> 
> I thought a Fixes tag could also point to a commit that is still in a
> maintainer tree. The tip handbook describes that for tip [1], though mm
> may handle it differently.

You could do use a commit hash that is still in a maintainer tree.  I also
sometimes do so.  But in the case it is better to explicitly mention it is for
squashing on mm-unstable.  And if it was the intention, in this patch series,
you were better to split the kunit patch.

> 
> The hash can still change in mm-unstable, so the tag may need updating.
> 
> I also found this reply from Andrew [2]. He says he tracks these fixes
> by filename and folds them into the original patch before moving it to
> non-rebasing git.
> 
> Maybe squashing is indeed simpler here, also for backports.
> 
> So either option is fine with me. I'll leave that to you and Andrew.

Thank you for clarifying, Karl.  I was initially tempted to keep what I did
(option 2), but maybe that's only because I am too lazy.  Let's do squash.
Unless others raise other opinion, I will repost patch 1 with updated commit
message tomorrow.

I will keep patch 2 in damon/next and repost for mm.git merge as I explained in
the earlier reply.


Thanks,
SJ

[...]
