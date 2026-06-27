Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB8800
	for <damon@lists.linux.dev>; Sat, 27 Jun 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782599211; cv=none; b=D0N6XijJGX06NE7JvXuttuRqJi9yoWrdSuBGK3tIBBdS3wXXZVzlNlAS8v8TS+NfqZPh/GcFFyRT12AJv2NZq1KrLAhzVpiT8Z8xfwF4cUQa/ZcnXeJARgTjFDRpMtcWgYvAiGej5w/VmP2zaFjg6WoTYmhy02Ntcc2Y9uIJJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782599211; c=relaxed/simple;
	bh=JSkw9Z0bKQNusSZTsQuEGrGYblHpHWEWikh7UfWmx1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFTMP7UZp9jBcwMG+pCAYIGLFrwO2bXga9dFCJ0InZK6uOnk4CPvnc3821oStTYfAo7HMbGJpOghpEhOCkbBjYq+e1nf3M7/Q0Xd1XROkBfCHavjDBk2uxkPG/P/yilQhnp15uzZOa+P0+jDIViIXjdS4BY+f22NrRba0N9wlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiaMHCNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiaMHCNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966F91F00A3A;
	Sat, 27 Jun 2026 22:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782599209;
	bh=ZNhuZf4EzNX+x+mPYeLipgASXqtM4sleYQ2JqrvbmuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BiaMHCNEgYRSLBK49xOzbr4x3ibBYZBjeim+jIKiXM3UaUyp59DAKUYWwC/JD4zHl
	 mEwhkniH8sqzOjM0s3PMVz/gl7DOCrN+83gtMKfKPz8lET3hQt/l31n+oHMpyeplxE
	 ePie9HaSLTJ6tKUQH8NFey5Zn4HLTU89UE3y/3cLAmzg65o7QE0FRBDiyEiE82E3W2
	 Ijg9mLfBH9lyevCUComaEMRSXPi4zIxLt6DsVlEhILgXiiN/3HUqAUc+HXG8oIFttJ
	 vOAO4L51ePXIoIUGWXNhBci3cUBtcD4exLgXR5c5TBjrCz5PNvX53F9WAEG/K0TjKj
	 Z8IM+G2iKaXnA==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/reclaim: add 'available' memory as an optional watermarks metric
Date: Sat, 27 Jun 2026 15:26:43 -0700
Message-ID: <20260627222645.26834-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260627213651.19000-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026 05:36:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> On Fri, 26 Jun 2026 07:18:18 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > How about using DAMOS quota with its aim-based auto-tuning, instead?
> > 
> > I developed DAMOS watermarks and quota as safe guards of DAMOS.  In more
> > detail, DAMOS quota is for restricting only resource usage of DAMOS.
> > Meanwhile, watermarks is for restricting resource usage of both DAMON and
> > DAMOS.  That is, when the watermarks condition is met, not only DAMOS but also
> > DAMON is completely paused.  Also, watermarks feature was considered smarter
> > than quota, because it is a kind of auto-tuning.
> > 
> > However, it turned out completely turning DAMON off is not a very good idea,
> > because it drops monitoring results when the watermarks condition is met and
> > therefore completely stops DAMON and DAMOS.  It drops the region shapes and
> > 'age' information.  Especially, 'age' of some regions commonly cumulated up to
> > hours or even days.  Dropping that was a problem in production use cases.
> 
> I looked at the code and noticed that kdamond_wait_activation()
> doesn't seem to free the regions, the data remains in memory.

Ah, you are correct.

> By "drops",
> do you mean the age information becomes stale/unreliable during the
> inactive period rather than being literally discarded?

I was just wrongly recall the detail ;)  But, yes, your representation is
correct and much better.

> 
> > 
> > Meanwhile, we introduced aim-oriented DAMOS quota auto-tuning (a.k.a DAMOS
> > quota goal).  It made DAMOS quota smarter and easier to extend than watermarks.
> > Nowadays, users can also pause and resume [1] DAMON/DAMOS without losing the
> > monitoring information when they want.
> > 
> > So, I personally don't encourage people to use watermarks.  Of course, I may
> > missing some problems in alternatives.  Hence I'm asking the question to you.
> > 
> > How about using DAMOS quota with its aim-based auto-tuning, instead?  If you
> > cannot, could you share more details?
> > 
> > I'll hold reviewing the code until this high level discussion is resolved.
> > 
> > [1] https://lore.kernel.org/20260427151231.113429-1-sj@kernel.org
> 
> Thank you for the detailed explanation. I now understand that watermarks
> pause the entire DAMON monitoring loop rather than just gating DAMOS
> actions. I agree this makes watermarks unsuitable for the Android use
> case I described.
> 
> I will drop this patch. I think controlling DAMOS pause/rusume
> separately might be better suited for execution in user space (such as
> controlling‘quota_ms’ and ‘quota_sz’).

For explicit DAMOS-only pause/resume, you may also be interested in
max_nr_snapshots [1] feature.

> 
> By the way, I sent you an email about three weeks ago (Fri, 5 Jun 2026
> 20:28:00 +0800) introducing a userspace auto-tuner program I wrote for
> DAMON_RECLAIM's 'min_age', and asking for your thoughts. I am not sure
> if it reached you, could you please check? I would really appreciate
> your feedback on that as well.

I don't recall that mail.  Did you send that to damon@lists.linux.dev or other
public mailing lists?  If so, could you share the message id or lore.kernel.org
link of the mail?  If not, could you please resend?

[1] https://lkml.kernel.org/r/20251216080128.42991-8-sj@kernel.org


Thanks,
SJ

[...]
