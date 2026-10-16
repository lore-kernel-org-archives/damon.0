Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1B47535E;
	Fri, 16 Oct 2026 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159749; cv=none; b=Tib7yLynCUBScL/j1+pP3QUkGmKmcjWXP72Ed2WZaZ9LjiUE8HU0jp8S8OHswxAOIz4rSfuIhz3mAcGvRLE7DgZJLq3zkbugWg7ZXOiOIuDrVo9zOHgg1LQk4F2ELiYbRVQQRmea13pfkPXUU4xZPCCW3LqJKADQaUGwFyaoQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159749; c=relaxed/simple;
	bh=aPLBNDDitbneueJqadVq4CxFteCHVjpACU/lo3p0gCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKcyhvzFv6dGIvgf/1tN1XqnnJ7sOK5qc3o7maBQIZ3709ey2VkK86+Y0RHQLJitwHkMVChC+7ZUEKi0V8E7C8PZliHTPyNjSqfOibSQQUkRTgrSWhkxlvn/6nExKx15B1vRitZ5F6USkmWmPtt+eXNfyhSzrfrxZiyHMy1KYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGe+v27p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGe+v27p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEBA1F000C4;
	Fri, 16 Oct 2026 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792159747;
	bh=/rY+da4gZ/gT6x5YDiZjxmuF5eCELrbiaY4rx2johDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UGe+v27p90GzDxWWTa5dWIjd7PcDB2ayLWfH/O8Pnfw2ZQl1W6mNxyXCSMa9WOhyX
	 nbSo/WYdZbmdS02R3+6eiI8Uw5iYDt5WynvXdf7qVpVFMMjvTlqecHl8Yz5pMYFM8l
	 DeVjAvJ3YnE+W/u4AkDZkIB3IEaXeeslVPTczncGkMjsrHqkKqYySJuA0M/myrVNRM
	 p7u/1JzWgh39EI7wWAwWtVKAKXnlJHjhMLx+HrCcZm4iR39ddN1kBEwd3Xqnie5TyC
	 Oto7KE3HDp/jXN9a+4EDGbxN8eMxI8HFISKckDQEWXKmVy9qo5UwS/hQj3laK/G6QM
	 szuTh7q0wRHvQ==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid 32-bit overflow in idle percentiles
Date: Fri, 16 Oct 2026 07:09:00 -0700
Message-ID: <20261016140900.125937-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179214257862.2.17756454862637555633@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Oct 2026 17:22:58 +0800 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> On Thu, Oct 15, 2026 at 05:21:29PM -0700, SJ Park wrote:
> > This patch is sent as a followup of your previous bug report, right?
> > Unless it is very urgent, please make sure the previous discussion is
> > completed before making a followup action like sending this patch. As a
> > rule of thumb for DAMON, I'd suggest waiting for ~10 hours after the last
> > comment on the thread.
> 
> The patch was already prepared and additional tests were underway when
> your reply to the bug report arrived, so I went ahead and sent it.
> I'll leave more time for discussion before sending follow-up patches.
> 
> > What is 38?
> 
> 38 individual VM runs, forming 19 before/after pairs. The 20 same-image
> runs formed 10 control pairs.
> 
> > Do you have a plan to run more tests to be able to tell that?
> 
> I've run longer VM tests, but even same-kernel runs vary substantially,
> so the overall patch effect remains unclear. In a fixed-input 32-bit
> userspace test with 10 regions over 256 MiB, the median increase was
> 227 ns/call (+42%). The old code updated 15 entries, versus 101 with the
> fix. I haven't separated the extra updates from arithmetic cost.
> Maybe we could record region counts and sizes alongside VM timings to
> check whether both versions are doing comparable work.
> 
> > Any reason to use div64_ul() instead of div_u64()?
> 
> total_sz is unsigned long. div_u64() would truncate its divisor on 64-bit
> systems if it exceeds U32_MAX. div64_ul() preserves that width and maps
> to div_u64() on 32-bit.

All answers make sense.  Thank you.


Thanks,
SJ

[...]
