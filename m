Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18399306486
	for <damon@lists.linux.dev>; Wed, 18 Mar 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859414; cv=none; b=bSdu9gELrCiieTl+OryPb3c4RrkykORQ41rm+tvGRMPQMs4rdIPBpwvNuEMFUhqjePtoY8tmDKWbtQYozGr4bwxzGkpOC0ff1R7+Pra9Chy9uAAh1+sk3qHw0RIvRkqC5TqF35ARI6Pb0hTohLNt2KDAGWxi95HyDdHAkH/aa50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859414; c=relaxed/simple;
	bh=N5/gNC5jEdmJTXnYyiKutbrf0R9pR2HX7NMkcL602uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGflxfuR8SqS8OFnXYlXD+fDaqTMkXxJ+umRqVIYb5fRKL1TUyyjTpE7MPJd6yJWSHD1/xJ8ynH7s7Ag/hrFfHP+C06xi9/GvEt1HRdn+yUANFMVAFEr7HPYvKHV4/7FFdJBV/RypfQYNxdCeFsH3ahhde/bARpu2MNRuwZubOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZYFZbqw; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZYFZbqw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773859411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LLuwZyVPb4DIfD3OwJqRPWzOEte8XfXwj623so/hWSk=;
	b=sZYFZbqw0NFkNJJs4h3OW3sfT/5b0k2n6B54JA+VmkAtCnifOKDKcrnDlxA3titJxcQFZi
	QnmI0psOEfGeUZwf7/v9fA+3rF6PZBf3VOF8jkjmI945YbtLl/eWQWDFhAKuenisXL1yn9
	DhF6FUr5PR0jXzPxj+HEbjlIp17SOZw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Theodore Ts'o <tytso@mit.edu>,  Guenter
 Roeck <linux@roeck-us.net>,  Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>,  Chris Mason <clm@meta.com>,
  elkin@google.com,  Christian Brauner <brauner@kernel.org>,  Dmitry Vyukov
 <dvyukov@google.com>,  Sasha Levin <sashal@kernel.org>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
  Sean Christopherson <seanjc@google.com>,  Ian Rogers
 <irogers@google.com>,  damon@lists.linux.dev
Subject: Re: Introduce Sashiko (agentic review of Linux kernel changes)
In-Reply-To: <20260318150051.93173-1-sj@kernel.org> (SeongJae Park's message
	of "Wed, 18 Mar 2026 08:00:50 -0700")
References: <20260318150051.93173-1-sj@kernel.org>
Date: Wed, 18 Mar 2026 11:43:24 -0700
Message-ID: <87eclhugfn.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

SeongJae Park <sj@kernel.org> writes:

> Hello Roman,
>
> On Tue, 17 Mar 2026 15:31:11 +0000 Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
>> Hello,
>> 
>> I'm happy to share something my colleagues and I have been working on
>> for the last several months:
>> Sashiko - an agentic system for Linux kernel changes.
>> 
>> First, Sashiko is available as a service at:
>>   * https://sashiko.dev
>
> Great work.  Thank you!
>
> There are many similar tools but this is the first free web service I know.
> I'm still feeling uncomfortable or not prepared for running some AI tools on my
> own.  Therefore I was only waiting for some nice people sharing their AI review
> results (some people including Chris Mason did, and it was really helpful,
> thanks again), or the arrival of this kind of public and just working service.
> This feels like the chat-gpt moment to me.

Thank you!

>> 
>> It reviews all patches sent to LKML and several other Linux kernel
>> mailing lists using the Gemini 3.1 Pro model.
>> 
>> I want to thank my employer, Google, for providing the ML compute
>> resources and infrastructure for making this project real.
>> 
>> Sashiko is written in Rust from scratch, mostly using Gemini CLI. It's
>> fully self-contained and does not rely on any CLI coding tools. It
>> supports various LLMs (at this moment mostly tested with Gemini
>> Pro/Flash and slightly with Claude).
>> 
>> And finally it's fully open-source:
>>   * https://github.com/sashiko-dev/sashiko
>
> Awesome.  I'm still feeling uncomfortable or not prepared to running some AI
> tools on my own.  But I will try to find ways to contribute.
>
>> 
>> It's licensed under the Apache-2.0 License, and the ownership of the
>> project was transferred to the Linux Foundation. Contributions are
>> really welcome using DCO.
>> 
>> Sashiko is based on a set of open-source prompts initially developed by
>> Chris Mason:
>>   * https://github.com/masoncl/review-prompts/
>
> Kudos to Chris!
>
>> 
>> But Sashiko leverages a different multi-stage review protocol, which
>> somewhat mimics the human review process and forces the LLM to look at
>> the proposed change from different angles.
>> 
>> In my measurement, Sashiko was able to find 53% of bugs based
>> on a completely unfiltered set of 1,000 recent upstream issues using
>> "Fixes:" tags (using Gemini 3.1 Pro). Some might say that 53% is not
>> that impressive, but 100% of these issues were missed by human reviewers.
>> Also, many of these issues (like tricky build failures, performance
>> problems, etc) are very hard/impossible to spot from reviewing the code,
>> so arguably 100% is not reachable. We started with low 30's a couple of
>> months ago; better models and improvements in the review protocol and
>> subsystem prompts pushed it to low 50's. With better LLMs and collective
>> effort on prompts we can push even further.
>> 
>> Measuring false positives is much harder, but based on manual reviews of
>> reviews, it's pretty good: it's rarely dead wrong, but sometimes it can
>> nitpick or find too many low-value issues. In many cases, it can be
>> improved with prompt engineering.
>> 
>> * What's next?
>> 
>> This is our first version and it's obviously not perfect. There is a
>> long list of fixes and improvements to make. Please, don't expect it to
>> be 100% reliable, even though we'll try hard to keep it up and running.
>> Please use github issues or email me any bug reports and feature
>> requests, or send PR's.
>> 
>> As of now, Sashiko only provides a web interface;
>> however, Konstantin Ryabitsev is already adding sashiko.dev support to b4,
>> and SeongJae Park is adding support to hkml.
>> That was really fast, thank you!
>
> hkml support was available owing to Sashiko providing the decent API, and b4's
> use of it is open source.  Kudos to Sashiko team and Konstantin.  I'm planning
> to make more integration into hkml, for my workflow and based on other hkml
> user feedback.

Thank you for doing this!

>> 
>> We're working on adding an email interface to Sashiko, and soon Sashiko
>> will be able to send out reviews over email - similar to what the bpf
>> subsystem already has. It will be opt-in by subsystem and will have options
>> to CC only the author of the patch, maintainers, volunteers, or send a
>> fully public reply. If you're a maintainer and have a strong preference
>> to get reviews over email, please let me know.
>
> I, as the maintainer of DAMON subsystem (damon@lists.linux.dev), do have a
> strong preference to get reviews over email for all patches that sent to the
> mailing list.  I'm already manually doing that.  I'm planning to extend hkml
> for doing this easier.  It would be nice and efficient if Sashiko can do this
> on its own.

Noted. I'll enable it as soon as we'll have it.

>
>> 
>> We also desperately need better benchmarks, especially when it comes to
>> false positives. Having a decent vetted set of officially perfect
>> commits can help with this.
>
> I'm also curious if there is a public channel for giving feedback about the
> reviews.  As you mentioned above, Sashiko sometimes says something that is not
> technically correct.  I'm wondering if there is a way to let Sashiko knows such
> things for improvement.

As of now, I suggest using Github issues. Later on, you could simple
reply to Sashiko's emails.

But also realistically I likely won't be able to look into every single
false positive, so I'd really appreciate some initial analysis: e.g. if
there is a common pattern or a number of similar reviews with the same
problem.

>> 
>> Finally, some subsystems have a good prompts coverage and some don't. It
>> doesn't have to be lengthy documentation (and it might actually be
>> counter-productive), but having a small list of things to look at - some
>> high-level concepts which are hard to grasp from the code, etc. - can
>> help a lot with both bug discovery and false positives.
>
> I found there is no prompt for DAMON.  I'm still convinced with Sashiko's
> current review, and have no idea for DAMON-custom prompts.  So that's fine for
> now.  I will consider adding something if I get some idea, though.

My suggestion is to read through a number of DAMON-specific reviews and
see if there are any common patterns of false positives or missed
errors. Once you have a feeling like "Damn, Sashiko doesn't really
understand X about the DAMON!" then you put it into the prompt.

Thanks!
