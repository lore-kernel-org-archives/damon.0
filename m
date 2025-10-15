Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419B26CE25
	for <damon@lists.linux.dev>; Wed, 15 Oct 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540834; cv=none; b=Xzd33uXIOrJ4ctX23tjekeB/U7tgbpGPLuxBlbrdsOpCh9HEmU955TPz7b8qxumBxUq4/1URyV5AM8jzQqUtSZA2Uf4edTeQfKNOCHkqp/LwfWwPTu1HQTkUIdMAqUnfgSDD0qVU1abi1NH2bi4lfNQ5AnCKbNNOwXbpKoTaIr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540834; c=relaxed/simple;
	bh=5hXx2RD+bmNSeJIwcoPLQR4SB2ipmLncmu2KyKpJLh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNDgGneuZwRAgxUhZVJR8MSmug+cQ4Wx4kTPg9REdJVKcqCcV0U8OgiaKEnKTSsUrUntWkx9cr/GtRddSJtbP1WfD7xSfJq7BeMfXDSc3VJu7iN42D/WnC2MXrrLUMBDZYHW3fhgkRQ3p5WiL+dBTOFiL3VaPcRwZ5QGUsrtFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwEM8WBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwEM8WBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F6EC4CEFB;
	Wed, 15 Oct 2025 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760540833;
	bh=5hXx2RD+bmNSeJIwcoPLQR4SB2ipmLncmu2KyKpJLh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwEM8WBmmycAcispyGwA3tgWT/07O+zjujTHq8qpSkO+jGrMofRhMHO7uGyPpscFS
	 HYKXJ61AFvd5hEVDut13Z5rHo0Sja60zeOzpADSijfkX3NQblD+x3c/lI9nY9MbZXy
	 70LFdB+1V9VAqOKh/b2vcsgwO2BsB1ADtbWDeW1cSCEEdPnzrQgXrpf5fY0Y3cLmRY
	 wMGVfooAiC94uiJPrkzLCpOMbYC0LbMqOCz9UuK93XbtP7wXZVe8kdYWcqFxPpwlFD
	 objtyTYuIAa7H8C58ksHGWBeFMrebIJrJmv6CDMN8CBcRk7WKer0ELHe1kRihoUSRb
	 9PhHQYIuivyBQ==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon/core: fix potential memory leak by cleaning ops_filter in damon_destroy_scheme
Date: Wed, 15 Oct 2025 08:07:00 -0700
Message-ID: <20251015150701.68087-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87jz0wg9uw.fsf@>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Oct 2025 10:46:47 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Hi SJ,
> 
> On Tue, Oct 14 2025 at 11:25:38 AM -0700, SeongJae Park wrote:
> 
> > On Tue, 14 Oct 2025 16:42:25 +0800 Enze Li <lienze@kylinos.cn> wrote:
> >
> >> Currently, damon_destroy_scheme() only cleans up the filter list but
> >> leaves ops_filter untouched, which could lead to memory leaks when
> >> a scheme is destroyed.
> >> 
> >> This patch ensures both filter and ops_filter are properly freed in
> >> damon_destroy_scheme(), preventing potential memory leaks.
> >
> > Thank you for fixing this!
> >
> > FYI the leak is not only potential but can easily be reproduced using the ops
> > damos filters.  For example, I was able to reproduce it using DAMON user-space
> > tool (damo), like below.
> >
> >     $ sudo ./damo start
> >     $ sudo ./damo report access --snapshot_damos_filter allow anon
> >
> > After the above steps I confirmed it leaks the memory using kmemleak.
> 
> Thank you for the review.
> 
> Considering that similar memory leak issues might occur elsewhere in the
> future, should we consider exploring the introduction of Rust for
> certain modules as a proactive measure?
> 
> My search through the mailing list archives didn't reveal similar
> discussions, though I might have missed them.

I also don't remember discussing Rust for DAMON on the mailing list.  You must
be right, or I also missed some :)

> Would you be open to
> sharing your insights on this matter?

In short, I agree adopting Rust for DAMON could be helpful.  As you mentioned,
rewriting certain buggy DAMON modules such as DAMON sysfs interface in Rust
could be a good idea.  There was also a private discussion about writing DAMON
user-space tool or library in Rust.  I think that could also be an interesting
idea.  So I'd say I'm open to Rust adoption on DAMON, not only in kernel space
but also in user-space.

Nonetheless, I know nothing about Rust, and having limited resource.  I
actually wanted to learn Rust and start writing a sample DAMON module in Rust.
I got the idea from the last year LPC, but still made no progress at all.  So
I'm open to Rust adoption in long term, but cannot guarantee something in short
term for now.

The user-space Rust adoption could be done regardless of my help, though.  That
is, someone could develop and maintain a new user-space tool or library for
DAMON with Rust, independent of 'damo'.  My poor knowledge about Rush shouldn't
be a blocker for such projects.


Thanks,
SJ

[...]
