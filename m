Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DA216E24
	for <damon@lists.linux.dev>; Mon, 15 Dec 2025 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765840603; cv=none; b=ofdsFELxw45MfEyMYICt6vrIRcfmUwXxopJndMwfOxvegX/E2OtlU+aSiczMIa6yrDWHPLrdImeOof0vNMEpYJDzlK2KZlm51r7ncdfrmjeVrzwlpD/q6ueaytPS2I4AqmhP90fSlcD3pnA1rm36no4ot4TdrXCHOcG8IXLmU4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765840603; c=relaxed/simple;
	bh=PZ35LkCzpVRKzVKeLttzifl9x7vaCDcVkiyt89U3mCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3ElnsuFbBdw0oYWxcYX5XSYp158gUZJO+9lhQAlJI6ssC9AGri4SEmvfdsg/QUKf0GOev04+QGbnhjIIXd/Hdm6z4gk2ev/kIf+oDaWyHEQmjx3YiT4nI0pMgF63rGV/Qbefib7kfku0RYxqTm5ObQsH5HyvOGDe9VHs2PLt/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyzyNvcb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyzyNvcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4769FC4CEF5;
	Mon, 15 Dec 2025 23:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765840603;
	bh=PZ35LkCzpVRKzVKeLttzifl9x7vaCDcVkiyt89U3mCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyzyNvcbBEa5qXzKfUVDKZKRmJwP+PH9EmJ1xonOu2pAgkDZHuZgDDGlGNsDf6mB2
	 0KWP0pQ7YU3IabC6xCSZqMM/lIU9joxRb7xTDF2haoMSffKXb5ysad01DpPriwXAsg
	 TE3jsIh6FNit1U22giRHgmkuGVsEViExdy/r3Qj0MdU8I+wVWpN/cLhJ314K9kJO3V
	 HnC93YrQxcydJXiPuQ6aiGppYg0lsjcHEJ4+88ktZ3EfPZ2b3B9oSm//De/68YatqY
	 pgkmz5E4BhglxdaY6gVfn1AITsjdwM0vpU59LA2LjNn5F+b+1XMYIl4h3H7r36yW4m
	 xmcV9B75a/V1A==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
Date: Mon, 15 Dec 2025 15:16:38 -0800
Message-ID: <20251215231639.56448-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215142057.588500-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Enze,

On Mon, 15 Dec 2025 22:20:55 +0800 Enze Li <lienze@kylinos.cn> wrote:

> This patchset makes DAMON's advanced memory management accessible to a
> broader range of users through two complementary enhancements.  First,
> it exports the necessary DAMON core symbols to enable building loadable
> kernel modules.  Building on this foundation, it then introduces the
> 'prdm' module, which extends the concept from the DAMON sample code
> (prcl.c) into a production-ready, user-friendly tool.
> 
> The key strength of this module is its out-of-the-box simplicity: by
> simply specifying the PIDs of target processes and enabling the module,
> users can concurrently monitor memory access patterns across multiple
> processes and trigger proactive reclamation automatically.  This
> significantly lowers the barrier to using DAMON, allowing system
> administrators and regular users without deep kernel expertise to easily
> apply sophisticated memory optimization.

I agree your points about the problems and the direction for improving the
situation.  However, we have a module for such use case, namely DAMON_RECLAIM.
It was designed for a reason that very same to what you described above.  One
key difference between DAMON_RECLAIM and prdm is, to my understanding,
DAMON_RECLAIM works for the physical address space, while prdm works for
virtual address spaces.  Is the virtual address spaces proactive reclamation is
what you really need?  If so, could you please further describe your expected
or planned usage of it?

If the virtual address spaces proactive reclamation is really what you need, I
think extending DAMON_RECLAIM for the purpose might be doable and even simpler
than introducing a new module.  How about doing so?

And, even more importantly, why it should be a loadable module rather than a
static module?  Do you have a specific use case that requires it to be a
loadable module?


Thanks,
SJ

[...]
