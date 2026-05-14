Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1009140B6EB;
	Thu, 14 May 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769690; cv=none; b=B0xx5W1OcmbzXR26+LUoQjUxWFflJX/mCBtpCRvMVr/CcFUlSzZPHwlNf9dxYtZfkE+51UdaQm+E3vEOKsrw8VfbO1KgD+KRzzewhu0+RRz0pFSmILd7RUkmJIJ3tbRAe9fm/2wOxaqQ1U067uXmb/Yalnls+uwZvspmIRb7Dtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769690; c=relaxed/simple;
	bh=KtWX1a5+HImqtCKe3Jka4nlb3lpWuqaCAeSX6uYt13w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6pRYcU0goxOdhkeepAR/TnfLQQmS/l3ipRI3OWFrcUWAoFaLp13GQf0ysc7HxfKKsKYOa/tZd0nTAAeODN9XpeK4UvA0V7EydXgPwxyZ2DSJslN+6sT7C9KwQkQU+UOiJlUXIWhjvkm+FH4F5fVZ3GHILq/bvi+CZokasakcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUIJYMgR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUIJYMgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79155C2BCB3;
	Thu, 14 May 2026 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778769689;
	bh=KtWX1a5+HImqtCKe3Jka4nlb3lpWuqaCAeSX6uYt13w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUIJYMgRENypM1B0KnhPeo2fSIQOWNzFRHuzth1o0hjdQA0KJSsOloaIHlceXG1cd
	 0FeCoDfOxFzwzwoz9gBJlKBMPZsDEZQbsTlifpxbo1/2/x4c9IKjx5VlyEctNKPxsf
	 xT5z+vmnv1y6EylFxPV6b0TzEdiZRWELw9+Ve6R/nJp6guyiVuoZu1SOe7RYNR9WnP
	 ArwJB3OzlvX5FMFg/LVfmfLgwECtJZNLxuy3BLlrnTo02+pwOJm/Naspzha/qiWMed
	 TM4Z3m114XLlG/0Ks+pI5F292WUcMqSMQknraHNkiKoa5mhCBIOyvDy5w3+BYSR7uy
	 jRKk8hC8RllnA==
From: SeongJae Park <sj@kernel.org>
To: niecheng <niecheng1@uniontech.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com
Subject: Re: [PATCH] mm/damon/core: recalculate intervals tuning deadline on attrs update
Date: Thu, 14 May 2026 07:41:02 -0700
Message-ID: <20260514144102.120203-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7946CE4E0773AEF7+20260514074846.3258908-1-niecheng1@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Nicheng,

On Thu, 14 May 2026 15:48:46 +0800 niecheng <niecheng1@uniontech.com> wrote:

> damon_set_attrs() refreshes next_aggregation_sis and
> next_ops_update_sis for online monitoring attribute updates, but it
> does not refresh next_intervals_tune_sis.
> 
> Because of that, enabling intervals auto-tuning via an online attrs
> commit can leave next_intervals_tune_sis stale.  If a context starts
> with intervals_goal.aggrs == 0 and later updates attrs online to set it
> non-zero, kdamond_fn() can treat the tuning deadline as already expired
> and tune the intervals earlier than intended.
> 
> This has been possible since the intervals auto-tuning feature was
> introduced, because that commit initialized the deadline at kdamond
> start but did not refresh it on later attrs updates.

Good finding, thank you for sharing this!

But, the next_interval_tune_sis will be updated based on the updated
aggregation and sampling intervals, just before the next intervals tuning is
made.

In detail, the code flow of the kdamond_fn() main loop is like below:

- call kdamond_call()
  - call damon_set_attrs()
    - update aggregation and sampling intervals
- if passed_ample_intervals >= next_intervals_tune_sis:
  - update next_intervals_tune_sis with updated aggregation and sampling
    intervals
  - call kdamond_tune_intervals()

So, the old next_intervals_tune_sis will be used only once.  I agree not
everyone will think it is the best behavior.  But seems ok to me.  I'd like to
keep the current code in favor of less complexity.  What do you think?

Nevertheless, apparently the code can better be documented.  Maybe it is worthy
to add a comment about this.  For example, maybe it is better to add a comment
saying "next_intervals_tune_sis will be updated inside kdamond_fn()" on the
damon_set_attrs().  If you'd like to, please feel free to post such a patch.


Thanks,
SJ

[...]
