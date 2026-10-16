Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F6379ECF;
	Fri, 16 Oct 2026 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160971; cv=none; b=QNgFU4Dlv5J2EBcnqhgYqBCLrvDy8wvl15eLd4m6Xspp3ssNysJFMNkYIl+3yp1OmyVuoneqVvi5mg9qYCtxV4EsreAwKpiGG8zjsWGjvEOJQhxd/Aufds5LgSlSAy/pCTxA/LcN8eQbhaJMd35QWyQjfFm0rJG9i4Ju4jzZVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160971; c=relaxed/simple;
	bh=x3joWeRhn7XYuzLPg6BaRvt7XsMU+dTn8qrU6AyZcwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAQvyjGNUeWfqAX4oS6IibZ+qo1K37FaBa+6K3qFuGNYbzIiTe4d+pPCoKqcpCGmOF1l2PhnmTzmFM7RR1H4pv6l8JCq1BFe+2omD1OLS9XCPGKW+3B2NtEI7MTMWgFWz6pkwtCwyE5QyGyh95Ykvafzip6nXnP/IHEkgDXidd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q65In81g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q65In81g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62371F000C4;
	Fri, 16 Oct 2026 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792160969;
	bh=5HSzrUk8F8TN6B6+DOgVOUSWwHPV0RhSwS1OfeQB0K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q65In81gZDrVrtW5aeohcJVJLJobQ9C8yQuS2wcMlNBqD1FSgQ5ZjZswj5VFjEIhV
	 Uj3NJt5OF30kEGcVXt3+OijWD8/DJBwmwsVbLwDKW2TF8NWbmYfIBEKbj2O7sejVvG
	 +RSSLoAh3RIWYDA7pX6RCZ53f38uknskqpEXSpGwbaojB979hqlX4WK1wHRTxDeUjl
	 fCkunetpfr9SnSdoWyXIUOzbMYjOtJCc8R2NDlPyY2OOn8tBJwwHR+YgK8IZBflwOS
	 yHACdqKGG/K2PLFWfm9XS3S4Anf7UblSAKrhhiULhHwKm2lUEGosBhMHe5l3FqY53c
	 iJC2HQzQ0cVqA==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/reclaim: improve grammar and style
Date: Fri, 16 Oct 2026 07:29:21 -0700
Message-ID: <20261016142921.126622-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179215409165.864368.11903228864381211337.b4-reply@b4>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Oct 2026 20:34:51 +0800 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi Manuel,
> 
> A few suggestions from my view for you here :)
> 
> On Thu, 15 Oct 2026 10:06:23 +0200, Manuel Ebner wrote:
> 
> > @@ -30,12 +30,12 @@ guests could mitigate this problem.
> > -DAMON_RECLAIM finds memory regions that didn't accessed for specific time
> > +DAMON_RECLAIM finds memory regions that weren't accessed for specific time
> >  duration and page out. To avoid it consuming too much CPU for the paging out
> 
> "weren't accessed" fixes the grammar, but "page out" still doesn't
> agree with the subject. How about "DAMON_RECLAIM identifies memory
> regions that have not been accessed for a specified period and
> attempts to reclaim their pages.".

That's entire sentence rewriting.  We could consider doing that, but maybe
that's better to be done via another patch.  Let's focus on simple grammar and
style in this patch.

How about simply 's/page out/pages out those/'?

> 
> >  operation, a speed limit can be configured. Under the speed limit, it pages
> > -out memory regions that didn't accessed longer time first. System
> > +out memory regions that weren't accessed longer time first. System
> >  administrators can also configure under what situation this scheme should
> 
> "weren't accessed longer time first" sounds a little strange to me.
> Maybe "Within the configured speed limit, it prioritizes regions
> that have been idle longer for reclamation." would read better?

Let's do such rewriting with another patch.

> 
> > @@ -88,11 +88,11 @@ identifies the region as cold, and reclaims it.
> >  sampling and aggregation intervals. The auto-tuning aims to capture meaningful
> >  amount of access events in each DAMON-snapshot, while keeping the sampling
> > -interval 5 milliseconds in minimum, and 10 seconds in maximum. Setting this as
> > -``N`` disables the auto-tuning.
> > +interval to 5 milliseconds in minimum, and to 10 seconds in maximum. Setting this
> > +to ``N`` disables the auto-tuning.
> 
> Maybe "between 5 milliseconds and 10 seconds" would read more
> naturally here.

I concern if readers could confuse if the range is inclusive or exclusive.  I'd
prefer the current sentence.

> 
> > @@ -113,8 +113,8 @@ quota_sz
> >  Limit of size of memory for the reclamation in bytes.
> >
> > -DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
> > -window (quota_reset_interval_ms) and makes no more than this limit is tried.
> > +DAMON_RECLAIM recordes the amount of memory which it tried to reclaim within a time
> > +window (quota_reset_interval_ms) and stops when this memory limit is reached.
> 
> Agree with SJ that "charges" fits better here, since this is quota
> accounting. 

Makes sense to me.  What do you think, Manuel?

> 
> > -While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
> > +While keeping the caps set by other quotas, DAMON_RECLAIM automatically
> >  increases and decreases the effective level of the quota aiming this level of
> >  memory pressure is incurred.
> 
> Maybe "While respecting the limits imposed by other quotas," would
> be another option I think.

I feel like that's out of the scope of this patch.

If both of you agree to my abovely suggested/agreed changes ('s/page out/ pages
out those/' and 's/records/charges/'), I will update this patch in damon/next
tree with those changes.


Thanks,
SJ

[...]
