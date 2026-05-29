Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476A38F250;
	Fri, 29 May 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070435; cv=none; b=pW90u0MQ+WF0jCTHg9QWdJHZjTE4gP8mz6XwhNIYi8+9MAEyOyobr/IEOHrXdL4JKEKZBWuAWBQOFW6vnaZZy02J5mAXZAmubWVYpqC/Vku5fjr1ncp0O+VoqK2PesCrMTKO+Tg2p7YPTUlc48X0vdiL+aAJkzmIosy8rs3yrMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070435; c=relaxed/simple;
	bh=WTD0fv78tOS9SwrhWVXui535NHykSF39tNx6ynFVpzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzifisYFfEzpVRARA40QJB1cR1731qceTRyWaWqiG4ZQt+gbE1T4EZYWmj6PjlgcKH1K691jCCeZjIC/fpcmqN8IYMrKJnGPs/sNiamt1PROsq4WeDsntU4aJB5hTw/u+PpvrzREncilvQfE/gDaRkYX7eyTL5QN3nFhB9kF6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrhyuAPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrhyuAPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B701F00893;
	Fri, 29 May 2026 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780070433;
	bh=swbfRtX5liCUiybXlbewNQ/G2rwqPA7yjLKy/i2mBTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IrhyuAPRj38zdilHD+aEEqVIYR4DydAimWaw0gU7zHdNCtaQ+pP0t/QOE1q8qqEAg
	 GzL9BctiAudP1mzgkXWbVJfynffpMnD9ckCdFr+hrjjmih//NGs3Wkl8Y3NmTDg4tg
	 qg4pbV+5X/SlmR5BKF2H7YvboSVJMDlaS3l2ReeL4FdV5x0pFZoCwPs7Iw2hrkQxjr
	 9HJmMhxi8PyYN5xxTwiBDMsIZpoE/8Xu5VBmEQP+wHM7pPYAFtqdhE32Z+tzq2Z+nO
	 vwrYWSHJeCDPjyFfm2PZbD8fTOGI6Y7DLphtDHsNcGyZa+vWvE6h3/ux9QQdNkh02O
	 LygtWi0jUdEvg==
From: SeongJae Park <sj@kernel.org>
To: =?UTF-8?q?=EC=B5=9C=EC=9C=A0=ED=98=B8?= <dbgh9129@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon/stat: roll back context on damon_call() failure
Date: Fri, 29 May 2026 09:00:29 -0700
Message-ID: <20260529160030.85303-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CACrCO_XCxTDk7b8wo66CrxzfOXG50-uCxdE9tjJppH_ei5Wo+A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 11:17:01 -0400 최유호 <dbgh9129@gmail.com> wrote:

> Dear SJ
> 
> On Fri, 29 May 2026 at 10:44, SeongJae Park <sj@kernel.org> wrote:
> 
> > But, having one damon_ctx object in the memory is a real problem?  Why?
> 
> I agree that keeping one `damon_ctx` is unlikely to be a serious problem.
> My intention was not to address memory pressure but to maintain
> failure-path consistency. If initialization fails after the context is
> created and started, the internal state remains in place despite the
> operation returning an error. The cleanup is then deferred until a
> subsequent retry.
> 
> For this reason, I think this is worth fixing as a correctness issue.
> That said, if you feel the current cleanup is sufficient, I can drop
> this patch.

Thank you for clarifying, Yuho.  I think the current cleanup is ok, but I
understand it is confusing to read.  Apparently that confused you at least, and
that's not ok.  What about adding a comment explaining the context?


Thanks,
SJ

[...]
