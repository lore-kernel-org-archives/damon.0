Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73B19ABC6
	for <damon@lists.linux.dev>; Tue, 14 Apr 2026 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776127148; cv=none; b=S4P3HtLqCbrUV3Pw1MVzf3bUD9w59ub7vtt97eAQNp338u61JtcSQkd/Po0fsXEMMmjvOox5hK3Fl4rqQXd/vFYfuMKPEvZkferkjLQfj3ZF6JMfZVN+unGO2FijfUO+yHUxwR9hj1huR35ItMxGnxFO4Vpsuk84fdNH4pxFW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776127148; c=relaxed/simple;
	bh=0T9EJqjoj0FC1DEZoyXGcf1oSecBxT00S22yS7p28XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+O9WkMsBvAxC7aESKl90V1wTNRkJotDkctqYnLu7V9reY9J8k7fY+gYEheCYehE+gUDI4R6Bufd+li9l3T0K/OaJX2K9NMi8My7hezUKPtgcE7VMSR0s9XYLJBjGa3TgqZ0W2Bkaltsa2aL/Rivs3WyQ/BgGQkxiL2lumzkia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l79wa0HR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l79wa0HR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343F1C2BCAF;
	Tue, 14 Apr 2026 00:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776127148;
	bh=0T9EJqjoj0FC1DEZoyXGcf1oSecBxT00S22yS7p28XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l79wa0HRrVqmEmDQc9OjOwwXJN8MYyDuMQOz8/K+e+FE3w5+FbiPNd2LXktWrmq6h
	 W+t5y8WT79vZkAAjWG9PbvXFjezsinJDAhD1MEKIkW2DPU0XFskKdFSIqAbNDjJzf0
	 RNDu7r+lUrsyGXUfrLg47YWmw4l7HxmRtjD0JSlh/nRwizmmxqX+k6J/jZdSsN5pD+
	 mzW1mRDpHmuZaFLfemQBvoT5bmGXvApe+dtiPzymj9seDWUjDTEQpFk4PkJ3TQ1ejR
	 E/2unyzgkq6eiN8qqfxjZl5oIch1srWnKUAfQMel0vIKbKvfcTO8arE2vao7Xjrl9n
	 wX85iKr0xGTxw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Mon, 13 Apr 2026 17:39:03 -0700
Message-ID: <20260414003904.83824-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260413184845.5130-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Apr 2026 02:48:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Sun, 12 Apr 2026 14:37:19 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hi Liew,
> > 
> > On Mon, 13 Apr 2026 03:04:55 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > [...]
> > > > Next Steps
> > > > ----------
> > > > 
> > > > So, what to do?  Please prioritize series B, if you still willing to do.  It is
> > > > ok to keep doing series A, but only as the minor user experience improvement.
> > > > Clearly explain the whole context you are aware of.  Don't Cc stable@ for
> > > > series A, as it is only an incomplete fix of it.  The fix of the one trigger
> > > > point is just a side effect.
> > > 
> > > Yes, I absolutely want to continue contributing to DAMON.
> > > 
> > > I realize most of this confusion came from me misinterpreting your words
> > > or making assumptions without asking. So this time, I want to be
> > > explicit:
> > > 1. I will remove the Cc stable@
> > 
> > Please also make the description of the patch clear.
> 
> I've been thinking about what you meant by "make the desciption of the
> patch clear" for Series A.
> 
> Here's my current understanding:
> 
> "
> This patch only fixes the case where kdamond terminates because
> 'min_region_sz' is not power-of-2. Other causes of unexpected
> termination (e.g., memory allocation failures) are not fixed by this
> patch. [Seires B] will address the general problem.
> "
> 
> Is this what you had in mind? Or is there something else you think I
> should add or change?

To my understanding, you will make series B merged before this one, right?  If
that's the case, you may not need to add this description at all.  Rather, you
may better to clarify this is only a minor user experience improvement.

> 
> > I'd like to avoid delaying series B too long, though.  The bug is not very
> > critical, but better to be fixed sooner than later.  If you have no enough
> > capacity, please feel free to hand it over to me.
> 
> Yes, I have enough capacity. My exams are not until a couple of weeks
> later, so I can focus on Series B now.
> 
> If my schedule gets too busy later, I will let you know and hand it over
> as you suggested. Thank you for offering that.

Sounds good.


Thanks,
SJ

[...]
