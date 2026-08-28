Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258D3093C1;
	Fri, 28 Aug 2026 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877658; cv=none; b=itLbKRfcNCyXwjDZ9MXJQPRlFUvrCVMkUFcM0au3X5WT9AfoSZwCHqkAzhm+Gols6ALfvPuRBGqAX1FEu3b1ymHt6KEd7ZCNJAQ+JVHT+jcnsh+nl9rdsQep1DA7wHOhg1IwT9tvQrZGiyCw3WglTl9RwAqTi7CXi2htetS09QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877658; c=relaxed/simple;
	bh=/sqbOqBC2VV7YhvVIfvJyn4Cst9mP3+3SLC9Z70RTnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol+6Au6dEoaqUF9pF6BwNP/vCbMd3b715VCvc1COZ4jk9StwJ/QHdQjW5If8Kngk9W3yPiuaDnc35z+OkJ3h62zir+FOTxhXvHfLhsyiJR8s1kDp45k1D3uRuxFSLkKEQ4fR0HFoQuPfP/EIWG1rPK4AiFS5j+jKxoFXkkQKqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0v7eLd9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0v7eLd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6454F1F000E9;
	Fri, 28 Aug 2026 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787877656;
	bh=C3dYuQBwRk/xR09vNJREZ7Cj/0z5bTktPZ0KJHmO4nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O0v7eLd9EuTh23YcZbaWO4XrOIMVKWuFnMqXs9EyOKVDR16db5yb5hnCDj0jjGgaz
	 91cSy0G2tEhgOhtlwU/D9jwUIK4oEomYN3oLHX2anKUuG6GoP439kfjrCDCsOvb20z
	 7N4r4MHPD1jwFoESI6l9WYcpYp3Q2Nj9V2sVm1R/EhN1sc5pvRjyJwiA5ImoGtI15y
	 JytMYBFzprHqP/B/rvaoDLfywpsXO5C76QdkcEgdK+jABlbSkuWD+kthvWJgzyjSfR
	 apK1rR+JTfs/0SZuN8fO/Q+Esx9xxa0Ewi1vDHXe4C3ki4C3UnPkAyEETcBZbHxdyu
	 HsBH0IK5oKrrQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Thu, 27 Aug 2026 17:40:48 -0700
Message-ID: <20260828004049.62386-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827180822.4037-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 02:08:22 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Wed, 26 Aug 2026 17:44:38 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Wed, 26 Aug 2026 07:05:08 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > On Wed, 26 Aug 2026 18:24:13 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > > On Tue, 25 Aug 2026 06:54:57 -0700 SJ Park <sj@kernel.org> wrote:
> > > > 
> > > > > On Tue, 25 Aug 2026 20:46:16 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > > 
> > > > > > DAMOS uses charge_target_from/charge_addr_from to remember how far a
> > > > > > quota-limited walk has progressed.  The current implementation has two
> > > > > > problems:
> > > > > > 
> > > > > > 1. Once set, the cursor unconditionally skips and resets at the last
> > > > > >    region of the tracked target, so the last region can be skipped even
> > > > > >    when it has not been processed.
> > > > > 
> > > > > I don't fully understand this.  Could you please clarify more?  Maybe adding a
> > > > > realistic example scenario would be helpful.
> > > > > 
> > > > 
> > > > Problem: Unconditional skip of the last region
> > > > 
> > > > In the current damos_skip_charged_region(), there is this logic:
> > > > 
> > > >     if (r == damon_last_region(t)) {
> > > >         quota->charge_target_from = NULL;
> > > >         quota->charge_addr_from = 0;
> > > >         return true; /* Skip */
> > > >     }
> > > > 
> > > > Scenario:
> > > > 1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
> > > > 
> > > > 2. Quota is configured to process only 50 bytes per window.
> > > > 
> > > > 3. Window 1: Processes R1 (0-50).  Quota is full.  Cursor is saved at
> > > >    (Target, 50).
> > > > 
> > > > 4. Window 2: Skips R1 (0-50).  Processes R1 (50-100).  Quota is full.
> > > >    Cursor is saved at (Target, 100), which is exactly the start of R2.
> > > > 
> > > > 5. Window 3: The loop reaches R2.  Because R2 is damon_last_region(t),
> > > >    the old code unconditionally returns true, skipping R2 entirely and
> > > >    resetting the cursor.
> > > > 
> > > > Result: R2 is permanently skipped even though it has never been
> > > > processed.
> > > 
> > > Ok, makes sense.  The user impact should be not that big, though.
> > > 
> > > > 
> > > > To fix this, the patch advances the cursor every time a region is
> > > > walked, regardless of whether it is applied or filtered out.  This
> > > > allows DAMON to accurately track whether the last region has already
> > > > been visited, eliminating the need for the unconditional reset.
> > > 
> > > Sounds like a big change compared to the problem.  Why we cannot modify the
> > > last region case?  Have you also considered other possible simpler approaches?
> > 
> > For example,
> > 
> > '''
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2686,14 +2686,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >         if (quota->charge_target_from) {
> >                 if (t != quota->charge_target_from)
> >                         return true;
> > -               if (r == damon_last_region(t)) {
> > -                       quota->charge_target_from = NULL;
> > -                       quota->charge_addr_from = 0;
> > -                       return true;
> > -               }
> >                 if (quota->charge_addr_from &&
> > -                               r->ar.end <= quota->charge_addr_from)
> > +                               r->ar.end <= quota->charge_addr_from) {
> > +                       if (r->ar.end == quota->charge_addr_from ||
> > +                                       r == damon_last_region(t)) {
> > +                               quota->charge_target_from = NULL;
> > +                               quota->charge_addr_from = 0;
> > +                       }
> >                         return true;
> > +               }
> > 
> >                 if (quota->charge_addr_from && r->ar.start <
> >                                 quota->charge_addr_from) {
> > '''
> > 
> 
> Thank you for the example!
> 
> While your approach works, I am curious, why should the cursor be reset
> every time the function returns false (does not skip)?

It doesn't.  It resets charge_{target,addr}_from only once after the regions to
skip are all skipped.  Am I missing something?

> 
> In my opinion, a cleaner and more deterministic approach is to reset the
> cursor only after the target has been fully iterated through.

So I will be able to give you some comments only after the above question is
answered.


Thanks,
SJ

[...]
