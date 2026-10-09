Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EA4772AC
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532909; cv=none; b=aTSK44kmJY0YhvBzjktAs29Aez8QkGUtibfxx3r7T9NZ9Uf52XCrk1ML7LfkoK96liG40ZKVYEf0m9cay9RfgUEm9N/GSyFVKXn5IPzhuheiTNbK/B5Fm1cVkiew5DhblDPICjWuKW5w1L9m+OTxqIq6B9WazyR0RtfRyV0hDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532909; c=relaxed/simple;
	bh=CTDE0IeYbvtetRcs3CDmoPHeK4kikR6EyeTAypve6xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaanclP7luzou2yMQg6UpWWkvLSGTiLLsic4FbML2YvqAk3N0KHzDMXdbLBLZ+m6n5TjcE6IxEFigDf+TtZKpxeDwngQtrLWS9O+/4iLgxUM3tKbJSOWp7tY2xkgYIp8bz3FYO2J51BPzNjX8dEPx2p0vnxwaZJdlZeUnQOxDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT+hhu45; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT+hhu45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6944B1F000FF;
	Fri,  9 Oct 2026 08:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791532903;
	bh=IMBpY4Ja4OxQaFfdpcju0OFEgyiZ03AkeppjckG5j0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TT+hhu454othJLmsJYnVm+7YlAMThU5/yMgzOlC9SAQXNtTuLoXlH970I5riKo60w
	 zb5uowt7VQPY5jb5JJ6aMcHIl1PDJXH58o2GTrWZCkJfWHeZm6QcVrPmr8BzZ+UvWe
	 G6LyHNJMCmEPp7iUecbRJ+vOLjbZtCsLFL1XKMG9DH9gryVbND6szqAZNxPqW6TWTM
	 13dIiAur6VaRHI4TqCsv7Nlzc88EDXhjRXcnyJxtxyD+XFO9OZRrAbwdnkpekrhyjl
	 3+k9BImW011cHtqoi0QV462qT1qZKhg7+GTA+sDFiifiS98vWn/WTjr/1BIHzSniAG
	 Fj5gWpN2I5PZw==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Fri,  9 Oct 2026 01:01:38 -0700
Message-ID: <20261009080138.41269-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008161621.45669-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  9 Oct 2026 00:14:54 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Thu, 08 Oct 2026 08:00:43 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Thu,  8 Oct 2026 21:44:19 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > On Thu, 08 Oct 2026 05:32:31 -0700 SJ Park <sj@kernel.org> wrote:
> > > 
> > > > Hi Liew,
> > > > 
> > > > On Thu,  8 Oct 2026 20:09:05 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > 
> > > > > Hi SJ,
> > > > > 
> > > > > Just a reminder, I think you might have missed the question I asked.
> > > > 
> > > > Could you please clarify what is the question that is not yet answered?
> > > 
> > > It seems I forgot to ask the question, my apologies.
> > 
> > No worry!
> > 
> > > 
> > > I would like to ask: after reviewing the reproduction, do you still
> > > think this is a real issue?  If so, I will start working on a fix.
> > 
> > I'm not good at reading the diff in your previous reply.  It makes me difficult
> > to understand what the issue is.  So I tried the commands on my system.
> > 
> > '''
> > $ sudo ./damo start
> > $ sudo ./damo args damon > damo_args_damon.json
> > $ sudo ./damo report damon --json > damo_report_damon.json
> > $ sudo ./damo stop
> > $ sudo ./damo start --kdamonds damo_args_damon.json
> > $ sudo ./damo report damon --json > damo_report_damon_aftr.json
> > $ diff -u damo_report_damon.json damo_report_damon_aftr.json
> > --- damo_report_damon.json      2026-10-08 07:56:04.979178016 -0700
> > +++ damo_report_damon_aftr.json 2026-10-08 07:56:27.717941609 -0700
> > @@ -1,7 +1,7 @@
> >  [
> >      {
> >          "state": "on",
> > -        "pid": "46402",
> > +        "pid": "46449",
> >          "refresh_ms": 0,
> >          "contexts": [
> >              {
> > '''
> > 
> > And still it is unclear what is the problem.  Could I ask your elaboration?
> 
> Thank you for testing this!
> 
> The reason it did not reproduce is that no DAMOS Schemes were configured
> during this test.
> 
> This is a bash script for reproduce:
> 
> '''
> #!/bin/bash
> 
> mkdir -p /tmp/config
> mkdir -p /tmp/output
> 
> ./damo args damon \
> --kdamond --damon_ctx --ops paddr \
>     --monitoring_intervals 5000 100000 1000000 \
>     --damon_target --regions 0-4096 \
>     --damos_scheme --damos_action lru_deprio \
>         --damos_sz_region 4096 max \
>         --damos_access_rate 0 max \
>         --damos_age 120000000 max \
>         --damos_quota_interval 1000 \
>         --damos_quota_time 0 \
>         --damos_quota_space 16777216 \
>         --damos_quota_weights 0 1000 1000 \
> > /tmp/config/lru.json
> 
> ./damo stop
> ./damo start --kdamonds /tmp/config/lru.json
> ./damo args damon > /tmp/output/damo_args_damon.json
> ./damo report damon --json > /tmp/output/damo_report_damon.json
> ./damo stop
> ./damo start --kdamonds /tmp/output/damo_args_damon.json
> ./damo report damon --json > /tmp/output/damo_report_damon_aftr.json
> diff -u /tmp/output/damo_report_damon.json /tmp/output/damo_report_damon_aftr.json
> ./damo stop
> 
> rm -r /tmp/config
> rm -r /tmp/output
> '''

Thank you for sharing this script.

However, issue reports in genral are better to clarify the expected and
unexpected behaviors of the repro together.  Please add such clarifications
from the next time.

And maybe because of the lack of such clarification, I still don't get what is
the problem.  Clarify, please?


Thanks,
SJ

[...]
