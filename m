Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D44501A;
	Fri, 25 Jul 2025 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753474953; cv=none; b=QpZRoRRSgy7+QL+LHYc//UQU0bgUlQcaVE40aC9tm8Fa/khMzUjhHCTWx7JtK3IykuKxX32a9P8qPw45eqE7GiI//TjjtCzxwcb0bWSt+xYg70XQsYarADHhxvLJvn2mabcfGTPhZ3Km2yUsERVAP5ppTD7OJ/IQ8EUiguXgabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753474953; c=relaxed/simple;
	bh=VQH99R6mUOjHSDPCGQ/ViR+7iWAEIcbC1txnGPFZ6/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiM7P67WCGHJcxYraoorhnbkhAW9WLWzOssRJ6QZeEUKlgiWDPaZbFfnjG3XRdckd8+7w/qtwUK6l0eDVNSPF7Mru6b1OOb1aCp3sVlqOo/JFDwLG4DKNRf6dRaq6AoQ9kMhCC0DQnUoZnqSZLQf8b+otxVROU4DhYL/aSj7leA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn3xpQKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn3xpQKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7431BC4CEE7;
	Fri, 25 Jul 2025 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753474952;
	bh=VQH99R6mUOjHSDPCGQ/ViR+7iWAEIcbC1txnGPFZ6/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xn3xpQKNtMQWwdNsTNuwnldzsyk6Cg6Io1WAhFbdDLx4l3vevNAC1PJEqz7sIPdEK
	 MJJah0xBI0a6LTP/LXoGzCId2Tba/QeRa8mmHTioJCAOKesx93dWnmoWfT930omNhc
	 nde22gF9Pga5Qs2XTl4FFcCXQNp5BHlrCeRGzYbCGspeVF+Kr8sguo5PJMsQxT1fWY
	 8QdIcR+Xt1BsWoLLo1Vo7nbRJ3giTcb8GAIuZXnbQ7XtosUVIAfVEIewEf81/u1xLu
	 ailRyi0u9QJWp6HFxcOmUYj6qEH3PS/vPEg9wGq6Px94H6wSaLBCbfWri9anFGvdTR
	 V0guoV8IlfdYA==
From: SeongJae Park <sj@kernel.org>
To: zuoze <zuoze1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring above 4GB
Date: Fri, 25 Jul 2025 13:22:30 -0700
Message-Id: <20250725202230.49995-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <a5c871c8-dc52-4245-8513-94ccc2b46c94@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 25 Jul 2025 11:15:22 +0800 zuoze <zuoze1@huawei.com> wrote:

> 
> 
> 在 2025/4/23 1:43, SeongJae Park 写道:
> > On Tue, 22 Apr 2025 19:50:11 +0800 zuoze <zuoze1@huawei.com> wrote:
> > 
> > [...]
> >> Thanks for the patches - I’ve noted the RFC series and user-space
> >> updates. Apologies for the delay; I’ll prioritize reviewing these soon
> >> to verify they meet the intended tracking goals. Appreciate your
> >> patience.
> > 
> > No worry.  Please take your time and let me know if there is anything I can
> > help.
> > 
> > I think we can improve the user-space tool support better for usability.  For
> > example, it could find LPAE case, set addr_unit parameter, and convert
> > user-input and output address ranges on its own.  But hopefully the current
> > support allows simple tests of the kernel side change, and we could do such
> > improvement after the kernel side change is made.
> > 
> > 
> 
> Hi SJ,
> 
> Apologies for the delayed response. We've verified your patch in our
> environment and confirmed it supports LPAE address monitoring.

No worry, thank you for testing that :)

> However,
> we observed some anomalies in the reclaim functionality. During code
> review, we identified a few issues:
> 
> The semantic meaning of damon_region changed after addr_unit was
> introduced. The units in damon_addr_range may no longer represent bytes
> directly.

You're right, and this is an intended change.

> 
> The size returned by damon_sz_region() now requires multiplication by
> addr_unit to get the actual byte count.

Again, this is an intended change.  damon_sz_region() callers should aware this
semantic and updated accordingly, if it could make a real problem otherwise.
If you found such changes required cases that this patch series is missing,
could you please list up?

> 
> Heavy usage of damon_sz_region() and DAMON_MIN_REGION likely requires
> addr_unit-aware adjustments throughout the codebase. While this approach
> works, it would involve considerable changes.

It has been a while since I wrote this patch series, but at least while writing
it, I didn't find such required changes.  Of course I should missed something,
though.  As I mentioned above, could you please list such changes required
parts that makes problem?  That would be helpful at finding the path forward.

> What's your perspective on
> how we should proceed?

Let's see the list of required additional changes with why those are required
(what problems can happen if such chadnges are not made), and discuss.


Thanks,
SJ

[...]
