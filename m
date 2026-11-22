Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795367732;
	b=Z5nwWuntMyFjIFb1p6TwdMXx0SofjDstOrd82eiadoiJcuwXR3z1lN+OSmGsFtNwHx3+
	 oLzGk9fIWOE5QzI58s03nzKuLdg+um9Rp9AevvGHMITdMCNdaN3cb7txgFywXEB7x8KQO
	 8Fcpr3HBNWyx/jNaR/P9npXs9t3qjNI7P8kQGcvJd0kCnoOXhgxhKhtVI2BYXimVwu93i
	 vGxB/LLD1EJvp4x/XnrTn81pSadlZPAkp3+Nrf9RH/P5gfQqnRWyo/zjwJK4Q3esjy9Q/
	 f+Km0JFfOBnXUG1k5JoxxO0wgMXa5arQEiLCkWBurKozumz6TJhqcVwnBVqQgDv+9IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367732;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pav7W9CDhzw7qErKCvygpSHTcbOi5Wufp8OZPbyFOjU=;
	b=HyGFXmJcZZ4ALf4Sga4ZMlnU6CNcvLYN+q7gp1jRB0YEWooQnTz+bfWQvOBywsw9nWDC
	 ECaLdp4kFwhWIo8Si//X+hg1mGB3t+ybV2CLNedOwBSGlOSyQvcxrQaUXjl00h9rR1BAc
	 UlzZZPpdXAqi94wHs76STT/dLVL2g2IhXtKUsaUyXGjB+z0KqhSVNI6HVMRmSIAmwAdRc
	 IdXhaLnUizoWIWz2/iSM3+f/8RA3q5MamA7re6CYTmOJHomqb6aXSVmH0veC1dJPRlYeO
	 Y1a01cYJrTKO7dIMwvzqH6EyC7oXayV4GFzWuY4UOlTmreCTGXiJfgoi/NRIKM0XFLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7iODn4q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB688606A32A
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7iODn4q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217A11F000C6;
	Sun, 22 Nov 2026 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367732;
	bh=pav7W9CDhzw7qErKCvygpSHTcbOi5Wufp8OZPbyFOjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N7iODn4qTc/7SJ1+BUR7bjrDPdbDNURw2c7OPecOiS5GLpFgUanB6F2FmwvLgVVQj
	 ek34s54CMmXOcgRX9n/U9tS5Ww+WB6XqqlZXpX7kARJ6kZO8SnV0tWp/XylYb1on6/
	 vNTweFJ/2xiC0jRjLVsp3O229sH8N6IBdPP+G3EhoATuj0BmvwEYqu21kHV88u++fF
	 ChA6Qgt4WgI6JQR3UCm+765xdpB2Ung9bDEfYDqmspBEqCkwwTEFvqD2d4nh/ytGLQ
	 LhZ85rUCPoV7d44m1Pn4fpjIsa2NqqAIlKiM/NBs5QaEFo4uJDCp/onkD4sYsQWbsQ
	 nDcVuwaLSyRKw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 03/27] mm/damon/core: introduce damon_submit_report()
Date: Sun, 22 Nov 2026 09:15:24 -0800
Message-ID: <20261122171525.153150-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANOyQmH5FX18LmMW+QwAcvOiATgUqx5VH02S5DyfTg+qPMSX+A@mail.gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 23 Nov 2026 03:06:16 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ
> 
> On Sun, Nov 22, 2026 at 8:00 AM SJ Park <sj@kernel.org> wrote:
> 
> > +       queue = &damon_report_queue;
> > +       report->jiffies = jiffies;
> > +       lock_old_val = atomic_cmpxchg(&queue->lock, 0, 1);
> 
> If a submitter is preempted between these lines, it can enqueue its
> report after one with a newer timestamp. A lookup scanning backwards
> can then stop at the older report if it's outside the window and miss
> the newer one that's still in it.

Will that frequently happen enough to be a real problem?  I think missing a few
reports is no problem.

> 
> Could we move the jiffies assignment after a successful cmpxchg()?
> That would keep timestamps in enqueue order and better fit the
> meaning of "when this report is generated".

I agree this could reduce races little bit.  But it's too little bit to expect
meaningful change, in my opinion.

I find a few downsides of your suggestion, too.  It will increase the critical
section.  Also the jiffies becomes little bit late than when the user made the
report.  These would be negligible in the real world, though.

So both the advantage and the risks of your suggestion looks not big to me.  If
you don't mind, I'd keep this as is.  What do you think?


Thanks,
SJ

[...]
