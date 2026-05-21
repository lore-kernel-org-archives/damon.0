Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77933FE05;
	Thu, 21 May 2026 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406116; cv=none; b=mERhMTNzjq39+OgesFuUy1jaAzP+Da480Fy6E7YyXJcSuG9PAZB+5cSLr5falaDmb5uLQ39rbJXUUZXwqybY1tVFHfwrsu6qc3bpyFzA5h2bNPHy3DxZwAGtk7N9hLso8vkABPWzDCYuY5amy65RviGj5n1r4LIvIhpFt1l6Lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406116; c=relaxed/simple;
	bh=F6azzIOJrOeFiKt5ARIaK2Jxe5op2gHsaY+coK5PJqY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hEktl9AQpwhTJlQYgQPaC8zFGZFt9kZ2VoTJi439Zxwvtm+5vWeqMEBrLbF2Ru90LGCOPxGq14KMcKS7qbfqWzqT9F2DvAlv/c1+KNlWokNNfjBjcb6bF7kGkX4LnWHY/kfycobwBWgBZeW6o3Vn3ee+GDfE4oh7maAiY/E9U7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N500jdmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N500jdmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D581F000E9;
	Thu, 21 May 2026 23:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779406114;
	bh=DXwm4Z+lOKTf5jJnND+DA1ISntGmioZE3tfITHlp0PQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N500jdmuy2l3Yh1vlBN6mN19yeYCQxZGfi40jmvefZyO5xqJP+LzquyrEG+DoEL31
	 8Kqi3SrUGx1gfYXmIEpE3dOA9CH31yE1UDk2BAdrIdQ+6AWkO/f7qmWO8sBXkIm14d
	 WrhZE93/XqBOnaT5m36LnW9Q+bs8pd4h4G9S9UGI=
Date: Thu, 21 May 2026 16:28:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 17 . x" <stable@vger.kernel.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: trace esz at first setup
Message-Id: <20260521162834.d119e280e3f9c20cd596d197@linux-foundation.org>
In-Reply-To: <20260520150311.80925-1-sj@kernel.org>
References: <20260520150311.80925-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 08:03:10 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON traces effective size quota from the second update, only if a
> change has been made by the update.  Tracing only changed updates was an
> intentional decision to avoid unnecessary same value tracing.  Always
> skipping the first value is just an unintended mistake.
> 
> The mistake makes the tracepoint based investigation incomplete, because
> the first effective size quota is never traced.  It is not a big issue
> when the 'consist' quota tuner is used, because it keeps changing the
> quota in the usual setup.
> 
> However, when the 'temporal' tuner is used, the quota value is not
> changed before the goal achievement status is completely changed.  For
> example, if the DAMOS scheme is started with an under-achieved goal, the
> quota is set to the maximum value, and kept the same value until the
> goal is achieved.  Because DAMON skips the first value, the user cannot
> know what effective quota the current scheme is using.  Only after the
> goal is achieved, the effective quota is changed to zero, and traced.
> 
> Unconditionally trace the initial quota value to fix this problem.
> 
> Note that the 'temporal' quota tuner was introduced by commit
> af738a6a00c1 ("mm/damon/core: introduce
> DAMOS_QUOTA_GOAL_TUNER_TEMPORAL"), which was added to 7.1-rc1.  But even
> with the 'consist' quota tuner, the tracing is unintentionally
> incomplete. Hence this commit marks the introduction of the trace event
> as the broken commit.

OK, but...

> Fixes: a86d695193bf ("mm/damon: add trace event for effective size quota")
> Cc: <stable@vger.kernel.org> # 6.17.x
> Signed-off-by: SeongJae Park <sj@kernel.org>

The patch is marked for backporting but it assumes the presence of
"mm/damon/core: make charge_addr_from aware of end-address
exclusivity", which is queued for 7.2-rc1.

We can either redo this against current -linus and fix up mm.git's
"mm/damon/core: make charge_addr_from aware of end-address exclusivity"
or we can queue this for 7.2-rc1 and you get to deal with fallout when
-stable maintainers hit issues backporting this.

Preferences?
