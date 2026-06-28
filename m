Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75F2DF3DA
	for <damon@lists.linux.dev>; Sun, 28 Jun 2026 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782666302; cv=none; b=jA+6vrcZL4B0+Xa7Y64T/IBtV6C5zJhMoOJHhwluBLmV9vIqZZ7ZTryZYwNDMPodPPyl5QbuWquqqarn5vmGe3Eu0rwi08fbOxTduBYIgEvwhYJZcxW1FC2nfGWq89S0eOZ/7qPmIww/S8G4EqOgDOL5ozZBkcXAw1cMXsehFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782666302; c=relaxed/simple;
	bh=7edhWxlAT7p3uGUAXujBkPV7O8n2yQgUDtRVQ62nP4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQl9fb78hEzMqfEtnOmZ7+nGymJo9RcUAV0utMnONae5rY9yYmi7YQmGD7UXtn5a6Oy6M8llzt0qk15gRat+BpWLqfYXZ3w1SJOOamBTR3Ln62EiqrRs/AOCauZDY+ympAYn0hCBVY+G2imoDWu0CXBTvqEpcBXfdfjm7aSLF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBVRzBQl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBVRzBQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985881F000E9;
	Sun, 28 Jun 2026 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782666299;
	bh=/ymacN+/8XLk9vgGgQDu7elYRViiHjsgkD4GV6NQOeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aBVRzBQlIrFuu2OUTsWUbIox+hZloXoDBTy2pGUmntedummE3L9kqa8ZfGuBBGr7Q
	 uYshUqMV/yFoM8+/atUm/RI/XgPlJQi2ba/siXveguUzhb5eUD1GhwSehIrTMQ/lOB
	 cvwjL5Ie+qOqKMYW4toDZ9Cua/RE+4A2QnlpX47+VMJgBhCpH3bzrfARSKFfNr/P82
	 YpH9wkVYtOFcOcnidfqvV7tq6hKjr8i6oGARSx3dyoJIihFOx4FJTENEu5sMDdEnxL
	 xrKnJWXOiCw3EdgO0u/3eoxXnSZNaPIiXM+PNmcjpyDwJMxvXUcVnriiFdfGJf5NoZ
	 Hj38E/WLv3Q5A==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/reclaim: add 'available' memory as an optional watermarks metric
Date: Sun, 28 Jun 2026 10:04:45 -0700
Message-ID: <20260628170447.88064-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628085547.21814-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026 16:55:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Sat, 27 Jun 2026 15:26:43 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > > I will drop this patch. I think controlling DAMOS pause/rusume
> > > separately might be better suited for execution in user space (such as
> > > controlling‘quota_ms’ and ‘quota_sz’).
> > 
> > For explicit DAMOS-only pause/resume, you may also be interested in
> > max_nr_snapshots [1] feature.
> 
> Thank you for the pointer to the 'max_nr_snapshots' feature!

Feel free to let me know if you have any question for the feature.

> 
> > > 
> > > By the way, I sent you an email about three weeks ago (Fri, 5 Jun 2026
> > > 20:28:00 +0800) introducing a userspace auto-tuner program I wrote for
> > > DAMON_RECLAIM's 'min_age', and asking for your thoughts. I am not sure
> > > if it reached you, could you please check? I would really appreciate
> > > your feedback on that as well.
> > 
> > I don't recall that mail.  Did you send that to damon@lists.linux.dev or other
> > public mailing lists?  If so, could you share the message id or lore.kernel.org
> > link of the mail?  If not, could you please resend?
> 
> I hadn't previously sent this to damon@lists.linux.dev or any public
> mailing list.
> 
> Since I have completely rewritten it (the email) and it focuses on a
> standalone userspace program/daemon, I have submitted it as a new
> independent RFC thread [1] to avoid biasing this patch's topic.

Makes perfect sense.  I will review.

> 
> > [1] https://lkml.kernel.org/r/20251216080128.42991-8-sj@kernel.org
> 
> [1] https://lore.kernel.org/damon/20260628085155.20828-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
