Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9D472F97
	for <damon@lists.linux.dev>; Wed,  5 Aug 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937896; cv=none; b=kwN3g8Uc4jAmDXDi1hprNAQl04xYKYTb9VDGAXg7nk2AnWoZDMrSgegsx2hXyNMVYQN7PMNgMpISVktLGJsoqs9rmXAt6qu8wSiEXZyq9MhXkZFjxtgNQGlaDtlS7hHcfTN/ztNE6k61zYslJYftfcEhFATHmu88+6Qst/RhcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937896; c=relaxed/simple;
	bh=wyy6w5dgYvN/3Fx3u5LUNXGoizn6tguSjMvkc68DTzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcGWn2IOuMMdbtndhrpsovOo2egL7SodulpsjP0Dgm3nfiK8mV1AEyH6+cwddOG4B9HHcW9GvluR/5S+Xh5ZoqEXIrcCheezxwB34CHp4KRwEL48oxp3xSIY1ZuUqzBsnL5azm3M9OAS31a085lrFqHb5E9YQst513L7iXWipVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP5/G0WW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP5/G0WW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9131F000E9;
	Wed,  5 Aug 2026 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785937893;
	bh=A55ICr5PoqB803qOLx5Egg13p9sfV6/wfqeAQSAkVsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TP5/G0WWd+nIsJt0gJ9Gr7EqVH6u+8Cu5Lr5BdVrwMZW56gBU2KTB41AIXm/FchtO
	 yY8133jsiqG/QqGTM9g/QOgnNl90fEA0cuRSLJbpp2wW3nnzil4eOLi9p7rgfQWPQv
	 +MNNYtHnMMfK/2dNCAbaKGLJeBoIJx28a8ztBJNV20WMxryYJNeRqlUP5Nc29UUcm0
	 YsO/0txrBW6HqAPutp5HccdhYsLteo6dUwY0AQruRx9MF5PaKn7/hNK8+/S4zhVGmF
	 laHGkQ5I37wruJrH0e8kZRULW5XeUbizORisvljjwvgr5W2blbNktKpJ17kI6ZX453
	 9dgzWNZSin0Mg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: introduce damos_sort_type for re-ordering regions list
Date: Wed,  5 Aug 2026 06:51:23 -0700
Message-ID: <20260805135124.88619-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805081246.39417-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  5 Aug 2026 16:12:46 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ,
> 
> First of all, I apologize for the noise, and I will drop this patch.
> Secondly, thank you for pointing this out, it made me realize that I was
> fixing a non-existent problem.

No worry, it was good to discuss the idea together!

> 
> On Tue,  4 Aug 2026 06:58:33 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > The recommended way is setting the min_age naive, and auto-tune it using DAMOS
> > quota or aim-oriented quota auto-tuning.  Have you considered using that?
> 
> > This sounds like very similar to DAMOS quota's regions prioritizing mechanism.
> > Have you considered using DAMOS quota?  If so, could you please add why
> > proposing this new mechanism, with some comparisons?
> 
> Yes, I have. And you are right; the existing mechanism is better. I
> wrote this patch because I misunderstood quota.min_score and did not
> even check the implementation of damos_adjust_quota().

Thank you for transparently clarifying these details, Liew.  This is very
helpful at conversations.

> 
> Whether when implementing dama [1] or this damos_sort_type, I failed to
> realize that min_age might not be such an important parameter on a
> long-running system, and there is really no need to introduce
> auto-tuning or a new mechanism for it.
> 
> > I to be honest feel this is too much for "just guess" based patch.  I'd like to
> > get clear reasoning of the change and/or test results before reviewing the
> > code.  So I'm holding the code review until the high level discussion is done.
> 
> Moving forward, I will ensure I am not "reinventing the wheel" or
> "fixing non-existent problem".

I appreciate that.  That will be super helpful.  But I understand we are human
that cannot "ensure" everything always.  Please try not to spend too much time
on unnecessary thing.  But don't be scared at making some mistakes, because we
learn from mistakes.

> 
> Thank you again for pointing this out. In the future contributions, I
> will try my best to avoid spending time fixing problems that do not
> actually exist.

Sounds nice.  And feel free to ask questions or help.

> 
> [1] https://lore.kernel.org/damon/20260628085155.20828-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
