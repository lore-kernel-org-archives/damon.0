Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22E397929;
	Sat, 17 Oct 2026 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254435; cv=none; b=YpcTVenYVLMzR5zxHD4cyYOIqSzgv6LonRX28OYs4TuNRdZHxxstADMD2pe7Ei//KyN792yI6GaO+2pD7fxbHOINfN0DNeMrAuGIB1HNoxeurBS04DlRRV1APwG55GNHU0oPDnOUYus3334APRdYPEtw70NpvtxIA8oiOwV1D/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254435; c=relaxed/simple;
	bh=AoC4eNIlO3LSIzyltldsosThUAlOnG2DKf2ALvd8tGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZJqEUULq1NXRuuYBpTpPghsStz/te1aaTMV2Lmi/QCupjzfDJQaQU9laODsWmLgLfM5d2yEZ1o1Ww3jFP0XUtlIwYTivdDdLcjp/EhEN7zKdMrF51B2zmyVqG7qtH4FTokbFE7bb1VAV0ejV1LvDY4C9MW8IU06+pQCK3xcSQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcXJLNUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcXJLNUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398261F000C5;
	Sat, 17 Oct 2026 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792254433;
	bh=EsWRQEfX03GTNdb56tV6nXJjKEivM5tx+oNkBb8EiW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcXJLNUAAE7A1QqxYvjonnyJ/dHuGFZZFHa+Fw/mJNHP09tddIrnZeEPGlfu/ruFK
	 qYTSYHjzR2CyxjvvwTqYHeLtXjj6r6kR40Y56TiM4JzTvv1ZEfQPpFz+HQwSmR5z2i
	 Cwpa/oAysGRTlJS6itL4TLmY3cvMHONyQakixRexzo9FdhxHvLUuGLso2Sjt+apYtH
	 0yXyygobq94FYENsTnKfmi8FE0HLRFGujY/tKEGT0XEnkK4TrVsrDUTnY5khrxrrBw
	 5DshkCSv5rCOlv27ZQb0aySFP8AcyVcgx/28CU5LmH4MAcB29DyiIAUzVW3RPotxOV
	 cO07tYtyxgzDw==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: Re: [PATCH] mm/damon/reclaim: improve grammar and style
Date: Sat, 17 Oct 2026 09:27:02 -0700
Message-ID: <20261017162706.103996-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c575314d3e52d5fcff3d6fc47d12dc118a24bd63.camel@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 17 Oct 2026 11:18:34 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Hi SJ,
> 
> On Thu, 2026-10-15 at 07:01 -0700, SJ Park wrote:
> > On Thu, 15 Oct 2026 10:06:23 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:
> > 
> > > Fix tenses. Replace 'set as' with 'set to'.
> > > Rewrite complex sentences.
> > 
> > Let's put two sentences in one line, while breaking it for the 75 column limit.
> 
> Will do.
> > 
> > [...]
> > > @@ -113,8 +113,8 @@ quota_sz
> > >  
> > >  Limit of size of memory for the reclamation in bytes.
> > >  
> > > -DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
> > > -window (quota_reset_interval_ms) and makes no more than this limit is tried.
> > > +DAMON_RECLAIM recordes the amount of memory which it tried to reclaim within a time
> > 
> > s/recordes/charges/  or s/recordes/records/ ?
> 
> For me charge is such a weird word exepct in 'charge a battery' or 'charge a fee'. And
> 'recordes' is a typo. Does this work:

'charge' in this sentence is somewhat like 'charge a fee'.  I personally don't
feel it is weird.  But 'record' also work for me.

> 
> DAMON_RECLAIM records the amount of memory which it tried to reclaim within a time

So this looks good to me, too.

> 
> I could do this in a second patch aswell.
> 
> > 
> > I'd prefer charges, but my English is definitely bad, so looking for your
> > suggestion.
> > 
> > > +window (quota_reset_interval_ms) and stops when this memory limit is reached.
> > 
> > I feel like readers might wonder what is stopped.  How about "stops trying
> > reclaiming memory when ..." ?
> 
> window (quota_reset_interval_ms) and stops trying to reclaim memory when this limit is reached.

Looks good.

> 
> > 
> > >  This can be used for limiting consumption of CPU and IO.  If this value is
> > >  zero, the limit is disabled.
> > >  
> > > @@ -125,19 +125,19 @@ quota_reset_interval_ms
> > >  
> > >  The time/size quota charge reset interval in milliseconds.
> > >  
> > > -The charge reset interval for the quota of time (quota_ms) and size
> > > -(quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
> > > +The quota reset interval of time is quota_ms and of size is
> > > +quota_sz.  That is, DAMON_RECLAIM does not try reclamation for more than
> > 
> > I think this change is just wrong?  quota_ms is not quota reset interval of
> > time.  Which part of the original sentence was difficult to read?
> 
> 'charge' again, and I think there is the verb is missing.

If use of the term 'charge' is really making reading difficult, we could add a
short definition of 'charge' as a separate patch.

E.g., 

'''
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -695,7 +695,9 @@ dynamic.
 To mitigate that situation, DAMOS provides an upper-bound overhead control
 feature called quotas.  It lets users specify an upper limit of time that DAMOS
 can use for applying the action, and/or a maximum bytes of memory regions that
-the action can be applied within a user-specified time duration.
+the action can be applied within a user-specified time duration.  DAMOS tracks
+(charge) the amount of memory that the action is applied, and stops applying
+the action once the limit is reached.

 To know how user-space can set the basic quotas via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`quotas <sysfs_quotas>` part of the
'''

Please let me know if you'd like to send such a patch.

> 
> > 
> > >  quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
> > >  milliseconds.
> > >  
> > > -1 second by default.
> > > +1000 (1 second) by default.
> > 
> > Isn't this (1 second in milliseconds is 1,000) easy enough to infer for
> > readers?
> 
> Ok.
> 
> > >  
> > >  quota_mem_pressure_us
> > >  ---------------------
> > >  
> > >  Desired level of memory pressure-stall time in microseconds.
> > >  
> > > -While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
> > > +While keeping the caps set by other quotas, DAMON_RECLAIM automatically
> > 
> > How about "caps that are set by ..." ?
> 
> Yes, this was my second choice.
> 
> > 
> > >  increases and decreases the effective level of the quota aiming this level of
> > >  memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
> > >  per quota reset interval (``quota_reset_interval_ms``) is collected and
> > 
> > 
> > Thanks,
> > SJ
> 
> I messed up the subject line, should be:
> Docs/admin-guide/mm/damon/reclaim: improve grammar and style
> 
> I'll follow up with a [v2], including Aveline suggestions.

Sounds good.  But let's finish the discussion about use of the term, 'charge'
before posting v2.


Thanks,
SJ

[...]
