Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B71E834B;
	Thu,  5 Jun 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139891; cv=none; b=Nz9EhciJnxATfpLTBUvBGy5Q6YpVLeEqyMGh9yZvQGh8PZ86bLiF9/ffbqgBNoQTyIpUm9Pf+iKF2OTccT8mc03cA4wiHkGm+q1N/QFaw0snjNsJKBDLTwzkm+nK5FIlVkTIgaa1JcnBFpx0kcs4Eja0ZdtVp+Hgay7wrv1BV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139891; c=relaxed/simple;
	bh=E7VA2CPsBD+xZsq1Va/C0TK1ZuXdJAIigt4d1i/YPfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GRfkZUKt23mM/s7jd+2xSs3YpSkeAdoYAX1ap5MigD+UQhAN/y5xcKO3GIVcajXVeWKoKZ70d5+6XC8bjKXmw23RqA1uNxpZjSY+KDVKa47yFhIb1Zrx5DUZnfM77YBWL+xB9nH8fCM9VGQdM6SsooSCP65s5z5FcCNXhK6sdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY/uBsa3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY/uBsa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7C2C4CEE7;
	Thu,  5 Jun 2025 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749139891;
	bh=E7VA2CPsBD+xZsq1Va/C0TK1ZuXdJAIigt4d1i/YPfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pY/uBsa3EXGps7nkVHf6ZlFan87fzB+jEHAbV7I1VbGwvXPet2AechYidp/w9NIBL
	 0DdwUlJvEupi8vlu2KTKZy6gOO1ls60Ab8KXOPXK0zR8SnQ+mZyPhr7jfT7mmTYtJ8
	 aHq1sqwk5WkEJW6DeMDH7KoniALPUVbO9UcC5z17Z1F/03TuLu8KpUEOMv65eI+L+s
	 JBUkDF57OcmrwuXBNU2N3erkXquV3vR7Htz6EHEu+hnFQu2AvwyeOCWlzF8Fi8dpyx
	 DMZeSSfJhPLmR103c+oy6Iimw61akqox7AymWQUhfdCE2asX5Z73xLoiOElb5fFXQ+
	 y/RCccouvgSnA==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] mm/damon: introduce DAMON_STAT module
Date: Thu,  5 Jun 2025 09:11:29 -0700
Message-Id: <20250605161129.82107-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250605152508.3275113-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  5 Jun 2025 08:25:07 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Wed,  4 Jun 2025 11:31:24 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> Hi SJ, thank you for this patch! I have been looking forward to it : -)
> I had a few questions about the init function:

Hi Joshua, I'm more than happy to get your questions :)

> 
> [...snip...]
> 
> > +static int damon_stat_start(void)
> > +{
> > +	damon_stat_context = damon_stat_build_ctx();
> > +	if (!damon_stat_context)
> > +		return -ENOMEM;
> > +	return damon_start(&damon_stat_context, 1, true);
> > +}
> > +
> > +static void damon_stat_stop(void)
> > +{
> > +	damon_stop(&damon_stat_context, 1);
> > +	damon_destroy_ctx(damon_stat_context);
> > +}
> > +
> > +static bool damon_stat_init_called;
> > +
> > +static int damon_stat_enabled_store(
> > +		const char *val, const struct kernel_param *kp)
> > +{
> > +	bool is_enabled = enabled;
> > +	int err;
> > +
> > +	err = kstrtobool(val, &enabled);
> > +	if (err)
> > +		return err;
> > +
> > +	if (is_enabled == enabled)
> > +		return 0;
> > +
> > +	if (!damon_stat_init_called)
> > +		/*
> > +		 * probably called from command line parsing (parse_args()).
> > +		 * Cannot call damon_new_ctx().  Let damon_stat_init() handle.
> > +		 */
> > +		return 0;
> 
> I was hoping you could educate me about how damon_stat_init_called works here.
> I think my confusion comes from my lack of knowledge about kernel modules : -)
> In the cover letter, you wrote that DAMON_STAT is a static kernel module.
> My understanding was that this would mean damon_stat_init would always be
> called,

To my understanding, the function is called back only when the parameteer value
is being changed.  Such changes could be made in runtime via parameter files,
and in boot time via the kernel command line.  If there is not kernel command
line for setting the parameter, this callback function is not called.

> so I was wondering under what condition it would not be initialized.

The enabled parameter value is initialized at build time, based on
CONFIG_DAMON_STAT_ENABLED_DEFAULT.  So, the parameter value will always be
initialized.

> I see the comment you wrote above, but was still a little bit confused.

The kernel command line parameters parsing is called in pretty early stage of
the bootup, before slab is ready.  Hence, if enabled parmeter is set by the
kernel command line, damon_stat_enabled_store() is called in the early stage,
and fails from damon_stat_start(), since it needs slab, to initialize DAMON
contexts.  For more details of such failure, you could refer to a previous
issue report[1].

Meanwhile, damon_stat_init() and module init functions are called later, when
slab is ready.  We therefore check the case, and defer real handling of enabled
to damon_stat_init() in the case.

Thank you for this question, I find the comment has rooms to improve.  I'll try
to make this better documented or easier to read.

> 
> Also, should we perhaps call damon_stat_init() if !damon_stat_init_called?
> That way, the first caller would just eat up the time it takes to run
> damon_stat_start().

damon_stat_init() is a module init function, and hence it will be called in
boot time, regardless of enabled parameter setup on kernel command line.  In
other words, it will be always invoked once, with !damon_stat_init_called.  And
it will call damon_stat_start(), unless enabled is unset via
CONFIG_DAMON_STAT_ENABLED_DEFAULT or kernel command line.

So, the current implementation is working as you suggested, to my
understanding.  Please let me know if I'm missing something.

> 
> One other thought I have is that if this config checks for whether
> damon_stat_init was called, this can be moved to the beginning of the function
> before the other checks are run, but that is just my thought : -) Feel free
> to keep the input check first, since having this at the beginning of the
> function would mean incorrect inputs would be silently ignored.

In the kernel command line based parameter setup scenario, later
damon_stat_init() call should see the updated 'enabled' variable value.  Hence,
the user input value check should be done here, regardless of if this is called
before or after damon_stat_init().

So I find no needs to change the code for now.  Nonetheless, I believe this
code has many rooms to improve, and I'm always getting more than glad to get
this kind of improvement ideas.  Thank you, Joshua.  Please feel free to let me
know if you get another idea later.

I hope I answered your questions, but please let me know if I'm missing
something!

> 
> Thank you SJ! I hope you have a great day!

You too.  Friday is coming!

[1] https://lore.kernel.org/linux-mm/20220604192222.1488-1-sj@kernel.org/


Thanks,
SJ

[...]
