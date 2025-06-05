Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0199283FE0
	for <damon@lists.linux.dev>; Thu,  5 Jun 2025 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151527; cv=none; b=ldXAaBSbWWCmnZqHsbG5qvDfH2x9U/iG7/193veFQOPqlg4hcwgI2CJIevbNbP8DdYUV2Vgu17X1p0u0MpqhbPX+vQ0qhSpM/swpj9twSQpXHYdRWPMLAKac4ORGSuwv+PzeyXc8CNMtML4ObPiFXpdebLRd5FHHJLZUDVWjkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151527; c=relaxed/simple;
	bh=g1uSPY3ekxdDqUP1FiL97nkkGHxjamontIVvh7+SpJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrhurd9J6Tq9Maxy+W6t1cbXfY0uwGdNprpfskMB+BWkWIUjH7voxKRQZzacJwAqTrk5jDQ+LRvVjtMhGPmn6IZtWMG5HBnolJ8pZsHw4Be3fitSGNdNWgcUDEVlhYCPCc++HptLYecmTwKpNTq0+VgoiXjr4wDOxLv+y40Wzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZs4KV5R; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZs4KV5R"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e5d953c0bso16368247b3.1
        for <damon@lists.linux.dev>; Thu, 05 Jun 2025 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749151524; x=1749756324; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FprG7nruJwqKDxMeetenSg6au9m16AMAZ5r0mOGn5VE=;
        b=bZs4KV5RVfR62n/2OOO2bYbdw0XHHvb/eqJcyQLn+RAMBUOKDAAV40rHNV84ZC0Jc2
         M45ihic8sJ8oa4jf8ZtYeaUsKsQes+aLsdZwTwtZN66CNQg6iMz3MA+G1j2LUf7mU14X
         5OzxROYBW3ZCJ3PxIGD7jQFe3q5BqIe9TF20VUrnUIJ41XViNzBgSM/3CLcfDWOU3awq
         HkF39o+felkupULgTwyH0Cuet7XJYuwJbQXLM7WqrriHIxj1jwf0QmFmjbIKh2x7ZqsQ
         70UIbhpf1wgekWB2RBEasrygX02XKb0Z4uCLqgYhwtqq0N/4Rvpu2vgwaY7TvkGgvAD6
         UG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749151524; x=1749756324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FprG7nruJwqKDxMeetenSg6au9m16AMAZ5r0mOGn5VE=;
        b=rmowhU7j01NknO/48sOAtWw7aWi2i/f3TcIJbmbpvwv5JcdzJpa9+Euv6r2R2xYAFc
         DvuF2ScQ38ql3RpOU0hh9FL+VPEW+yx0qTFTvWtjaDug53THlZ4p/WuJhS29Xa/+jJhR
         v1UnqMsoAM/4rryGArePPqmzUucPhig5Nfi2diY2fGrml1RRO0zFpjinKImZjdppOxiC
         ZV+goQ4B2kkU1cECvFEqjX4bPVlTf7uvUWYXZ6v1zmHme467gSA/byC9Lgs6oR0ciu4h
         bqfIE+aFTMzV4m2PDGR4ZiB1YiSph0QR5Dgeys3G/r3iVmnIpYB9f+EZBVCQKO2O7ifR
         fHtg==
X-Forwarded-Encrypted: i=1; AJvYcCUevtTDSCt8aCwd9S8Y2OPIxRr6JKvVz3h/7IBZYY2O4mdxd4pSrDnJ+wkMfbiEjGU0gHMhJw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx47gR4BNKQzLX0/k4BIwujsoKQTB1q9WLkIy1BTHhQl3yDP31e
	7N09VVL+dr8kPOQHhgXWIhbpgmG7003/PfcuwDMgrhW9qk8l91xdRhh3
X-Gm-Gg: ASbGncv2Y5bfRJHyoaVbjJTC8WQU95AhfIiSZfU78JAnJfJLmUiHWjzi8nMMut63VZG
	t2uLT5GibOP97I2RP5zgdVDqkCbQue5bAa/tbz1qtJ1CZmLAERjuCfGzTtMWd9Wmlb6UUg1EQJF
	1JnXyFdOFZP7MCkOY43ogxumjg6uqOySrPlGvPFE2ndE77azVN0ZzDUunpGZ1vdS53T02wZnFz1
	qxoXaMk7Q+qz+BtlEADJNWYlLso2Mg0nIvxY7ghK47XIfEOysOYRY5Yi22/jJZ/IIg5w0cu5m52
	t+4cta4/CJB/Jh9XCVG2G7V25RSdZq+O0Qny1psCT5ikQj6kBmU=
X-Google-Smtp-Source: AGHT+IGk++Z15BxbtjJ9K7UZBhMrTiCpmJvFSUyXRDZkfKc9GS6MedIlLmJfAwhoGdBkkpcPFYk5Cw==
X-Received: by 2002:a05:690c:688b:b0:70d:f673:1412 with SMTP id 00721157ae682-710f751e254mr12464717b3.0.1749151524484;
        Thu, 05 Jun 2025 12:25:24 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8ad2439asm35895997b3.125.2025.06.05.12.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 12:25:23 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] mm/damon: introduce DAMON_STAT module
Date: Thu,  5 Jun 2025 12:25:20 -0700
Message-ID: <20250605192521.306529-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250605161129.82107-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  5 Jun 2025 09:11:29 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu,  5 Jun 2025 08:25:07 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > On Wed,  4 Jun 2025 11:31:24 -0700 SeongJae Park <sj@kernel.org> wrote:
> [...]
> > Hi SJ, thank you for this patch! I have been looking forward to it : -)
> > I had a few questions about the init function:
> 
> Hi Joshua, I'm more than happy to get your questions :)
> 
> > 
> > [...snip...]
> > 
> > > +static int damon_stat_start(void)
> > > +{
> > > +	damon_stat_context = damon_stat_build_ctx();
> > > +	if (!damon_stat_context)
> > > +		return -ENOMEM;
> > > +	return damon_start(&damon_stat_context, 1, true);
> > > +}
> > > +
> > > +static void damon_stat_stop(void)
> > > +{
> > > +	damon_stop(&damon_stat_context, 1);
> > > +	damon_destroy_ctx(damon_stat_context);
> > > +}
> > > +
> > > +static bool damon_stat_init_called;
> > > +
> > > +static int damon_stat_enabled_store(
> > > +		const char *val, const struct kernel_param *kp)
> > > +{
> > > +	bool is_enabled = enabled;
> > > +	int err;
> > > +
> > > +	err = kstrtobool(val, &enabled);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	if (is_enabled == enabled)
> > > +		return 0;
> > > +
> > > +	if (!damon_stat_init_called)
> > > +		/*
> > > +		 * probably called from command line parsing (parse_args()).
> > > +		 * Cannot call damon_new_ctx().  Let damon_stat_init() handle.
> > > +		 */
> > > +		return 0;
> > 
> > I was hoping you could educate me about how damon_stat_init_called works here.
> > I think my confusion comes from my lack of knowledge about kernel modules : -)
> > In the cover letter, you wrote that DAMON_STAT is a static kernel module.
> > My understanding was that this would mean damon_stat_init would always be
> > called,
> 
> To my understanding, the function is called back only when the parameteer value
> is being changed.  Such changes could be made in runtime via parameter files,
> and in boot time via the kernel command line.  If there is not kernel command
> line for setting the parameter, this callback function is not called.
> 
> > so I was wondering under what condition it would not be initialized.
> 
> The enabled parameter value is initialized at build time, based on
> CONFIG_DAMON_STAT_ENABLED_DEFAULT.  So, the parameter value will always be
> initialized.
> 
> > I see the comment you wrote above, but was still a little bit confused.
> 
> The kernel command line parameters parsing is called in pretty early stage of
> the bootup, before slab is ready.  Hence, if enabled parmeter is set by the
> kernel command line, damon_stat_enabled_store() is called in the early stage,
> and fails from damon_stat_start(), since it needs slab, to initialize DAMON
> contexts.  For more details of such failure, you could refer to a previous
> issue report[1].
> 
> Meanwhile, damon_stat_init() and module init functions are called later, when
> slab is ready.  We therefore check the case, and defer real handling of enabled
> to damon_stat_init() in the case.
> 
> Thank you for this question, I find the comment has rooms to improve.  I'll try
> to make this better documented or easier to read.

I see, I think it makes more sense to me now. Thank you for explaining this, SJ!
I think my confusion came from my lack of knowledge. Please do not feel the need
to update the comment on this section, if you feel it is already enough : -)

> > Also, should we perhaps call damon_stat_init() if !damon_stat_init_called?
> > That way, the first caller would just eat up the time it takes to run
> > damon_stat_start().
> 
> damon_stat_init() is a module init function, and hence it will be called in
> boot time, regardless of enabled parameter setup on kernel command line.  In
> other words, it will be always invoked once, with !damon_stat_init_called.  And
> it will call damon_stat_start(), unless enabled is unset via
> CONFIG_DAMON_STAT_ENABLED_DEFAULT or kernel command line.
> 
> So, the current implementation is working as you suggested, to my
> understanding.  Please let me know if I'm missing something.
> > 
> > One other thought I have is that if this config checks for whether
> > damon_stat_init was called, this can be moved to the beginning of the function
> > before the other checks are run, but that is just my thought : -) Feel free
> > to keep the input check first, since having this at the beginning of the
> > function would mean incorrect inputs would be silently ignored.
> 
> In the kernel command line based parameter setup scenario, later
> damon_stat_init() call should see the updated 'enabled' variable value.  Hence,
> the user input value check should be done here, regardless of if this is called
> before or after damon_stat_init().
> 
> So I find no needs to change the code for now.  Nonetheless, I believe this
> code has many rooms to improve, and I'm always getting more than glad to get
> this kind of improvement ideas.  Thank you, Joshua.  Please feel free to let me
> know if you get another idea later.
> 
> I hope I answered your questions, but please let me know if I'm missing
> something!

Thanks SJ, it all makes a lot more sense now. Thank you for taking the time
to explain things!

> > 
> > Thank you SJ! I hope you have a great day!
> 
> You too.  Friday is coming!
> 
> [1] https://lore.kernel.org/linux-mm/20220604192222.1488-1-sj@kernel.org/
> 
> 
> Thanks,
> SJ
> 
> [...]

Sent using hkml (https://github.com/sjp38/hackermail)
