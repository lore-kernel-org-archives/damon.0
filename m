Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4F1E1A1A
	for <damon@lists.linux.dev>; Wed,  4 Sep 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472389; cv=none; b=kyEQpE+TcGVjE8YIOQ1Qvj+eOhIV5vZdYnnueTuevA5sFcq1KKQTaf53rQTuzVSFuMYj+8+TXICFD5531w87GfEuLCIHb17okLWpEwmTWYQsZSaYsE65beKZAWbdNxGvHYeJhDV7Pd2qmLmyvmpHDyAc94gcc6TeRfVcCHHqo3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472389; c=relaxed/simple;
	bh=ObmIiLRE12nTqVAZ4ElggAU0/yYFrjsx05Scy+qbC2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiZxPbXvX+YEMpRq4Dy+iq9laVClcYVFwX7bToJfxQ/UC6QQRj/R+9jb5sH9RDBF0tn30hOeHTd9Boo609KuMDqu7gw4N7/BF0KLJItaAw4cjbgWFB/wWJSMJfwnVnpHMscyy4Tymjb5wlCfcJvotq9eJ5gkI0jR68deMfNMGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGN5UdF8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGN5UdF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2107DC4CEC6;
	Wed,  4 Sep 2024 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725472389;
	bh=ObmIiLRE12nTqVAZ4ElggAU0/yYFrjsx05Scy+qbC2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGN5UdF8EDPEgFa3SNIMcC82+34OwV7NmA1Tcze88QJUU3xLDyjRYflO4ZB9QUY2y
	 Fl1SEuhqUBEZb3moNkIvjqW7/EBtBQb16J/3hZjDBOt/QrV2+OGmq7kyLd9FtrsXG7
	 Y3IN+7FrxZ9UjMBzgH2JcK0j8HSIRBtpos7WAEt6Dcm6gkOQ4FCtGSB9wPNLvY1zeK
	 bc/bIlobpTucQP9H59uBYpo+jDA9dLiQlS2Z7rX18is+n/JB6IOlhTa1KdTfs6WP+M
	 visq6wt6YHjn0EG5UWVpXrps+GG46DJKr157Vjm2BTKrh1VdVq1WkcjKr6HC+V5Kah
	 3wJ7ksy/UizLA==
From: SeongJae Park <sj@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Problems running DAMON kunit tests with spinlock debugging enabled
Date: Wed,  4 Sep 2024 10:53:06 -0700
Message-Id: <20240904175306.1862-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <53123051-3b53-4fbc-9e16-052481e6725f@roeck-us.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Guenter,

On Tue, 3 Sep 2024 19:46:44 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> On 9/3/24 19:24, Guenter Roeck wrote:
> > On 9/3/24 18:00, SeongJae Park wrote:
> >> Hi Guenter,
> >>
> >> On Tue, 3 Sep 2024 12:23:50 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >>> Hi,
> >>>
> >>> when trying to run DAMON kunit tests with spinlock debugging enabled,
> >>> I get the following error messages.
> >>>
> >>>      BUG: spinlock bad magic on CPU#0, kunit_try_catch/209
> >>>       lock: mm.13+0x40/0x840, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> >>>      CPU: 0 UID: 0 PID: 209 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00148-g178297ec52d6 #1
> >>>      Tainted: [N]=TEST
> >>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >>>      Call Trace:
> >>>       <TASK>
> >>>       dump_stack_lvl+0x9e/0xe0
> >>>       do_raw_spin_lock+0x63/0xb0
> >>>       damon_test_three_regions_in_vmas+0x121/0x450S
> >>>       ...
> >>>
> >>> This happens because damon_test_three_regions_in_vmas() calls
> >>> mt_init_flags() with MM_MT_FLAGS, which sets MT_FLAGS_LOCK_EXTERN.
> >>> Because of this, the spinlock is not initialized, which then results
> >>> in the error message when mas_lock() is called during the test.
> >>>
> >>> Unfortunately, replacing MM_MT_FLAGS with MT_FLAGS_ALLOC_RANGE |
> >>> MT_FLAGS_USE_RCU or just with MT_FLAGS_ALLOC_RANGE doesn't help;
> >>> it results in various "suspicious RCU usage" messages.
> >>
> >> Thank you very much for this report with the grateful detailed investigation!
> >> I was able to make and send a fix[1], thanks to the investigation.  Seems it
> >> may need some more revisions[2], though.  I'll continue discussion on the
> >> thread.
> >>
> >> [1] https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org
> >> [2] https://lore.kernel.org/jy6263g6em4jsdhp6tknmh2cljpuvq652kvcet4ko3z2xt7pym@ltc5h5twsszu/
> >>
> >>
> > 
> > Some more problems. I tried your patch on various architectures.
> > Unfortunately, that didn't turn out well. See below for some of the failures.

Nice finding, thank you for reporting this!  Just to be clear, seems this is
independent from the originally reported issue or the fix for it.  Please let
me know if not.

> > 
> > [ I am not sure I understand the code in damon_test_nr_accesses_to_accesses_bp(),
> >    especially
> >      .aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
> >    What happens if sizeof(int) == sizeof(long) ?
> >    Unless I am really missing something, .aggr_interval will be
> >    0 in that case.

I agree.  aggr_interval would be zero in the case.  And in this case,
damon_max_nr_accesses(attrs) in damon_nr_accesses_to_accesses_bp() returns
zero, so damon_nr_accesses_to_accesses_bp() will get a divide by zero problem.
That is, the problem happens when damon_nr_accesses_to_accesses_bp() is called
with zero aggr_interval, regardless of the architecture.

> > ]
> > 
> The diff below fixes the problem in damon_test_nr_accesses_to_accesses_bp().
> Obviously I don't know if this is the correct fix.
> 
> Guenter
> 
> ---
> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index 0cee634f3544..8072f83b2bba 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -309,6 +309,9 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
>                  .aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
>          };
> 
> +       if (sizeof(int) == sizeof(long))
> +               kunit_skip(test, "Test requires sizeof(int) != sizeof(long)");
> +
>          KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
>   }

So, above fix would work, but I think doing the skip if the resulting
aggr_interval is zero would make more sense.  Having more comments would also
be nice.

Nonetheless, if the issue can be triggered outside of the test, we may need to
think a better fundamental fix.  And seems it is the case.

Sharing current incomplete findings here first.

First of all, users can set the zero aggr_interval.  And the problematic
function (damon_nr_accesses_to_accesses_bp()) is called when user updates the
intervals while DAMON is running, with the old intervals attributes.  Hence,
users could trigger the issue by making DAMON to run with zero aggregation
interval, and then updating the intervals to any values.

Due to another complicatd logic behind the online intervals updates, trigerring
the issue seems not that simple.  In short, seems it can be triggered only by
using DAMOS watermarks together.  This is something bettr to revisit later.

So, I haven't confirmed if this is exploitable or not due to the lack of time
and other things to do, at the moment.  I will take a look further and share
more findings soon, hopefully within a couple of days.


Thanks,
SJ
