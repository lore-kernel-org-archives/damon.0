Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FD29405;
	Thu,  9 Jul 2026 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558348; cv=none; b=Kl61w2dYi2vONA8BWw5OOJzY4dpl+1OLa9bL2D4QrxmzoUver55ipLYhC8g8kWQALv5R0lwmOLPQvZbJFlveGJOmNatynbhApaI9vNlRixBzpofaqVepB13VlDtWuD2HbHH5gLGy41hFXD1Tj9w40ReisRbsflTxQpOXxE2Tk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558348; c=relaxed/simple;
	bh=fzzO0YwpnpxxUjhOE025PTPVR6neR9zPiq5yU6JzPg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVvRfUHIC4vazzOZE5whg0DRoyGrXGPqYnYh0xWhrRNNc9h0LWenMEatsFDkiqPox+bblbUovu7ktlSVc+K5sDgOjKO8Vw7fErFH+2nv7vYnWRZF02nHbls0RZccS8J6FOyX5PKghRbMF3aH9GiZUnYE6anLWqAfWbb4HThFCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIKCAC12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIKCAC12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECDE1F000E9;
	Thu,  9 Jul 2026 00:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783558347;
	bh=9kW6vnOtpcVYAgeY996D2IQsA70zg+YZWtPz9L5fIac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aIKCAC128TILAgoYJubwyzLEPBOdqLYKQDk038RB1Iic0DPEGQwsGmt3HEZ5YiHAn
	 ML+J5YZBmZXLhUanpeaalSZqMHdFPMDGyvZ/NBbHQcrnKKK5N3lI1ndI2HqWVRcfgx
	 HRvq3vCo54OKOW47duTInzgwQeKa+cA/mPkv8Fmf/LnDMtUil0U9r7PWOQEm4ju5G6
	 +4tqX0D80fkfBE6f0bEJgS4182rkENWLJZcRtoJQEkW6bt2YxHTKXYUX5VVKhkt6kQ
	 4V+9LA9cUAj4OZhDWsgyucQ9nchM/2tMfiCYXkK+xp8+t2vMQ5iKUYXiSnwvc4yYEX
	 6ygNWxhHclFEw==
From: SJ Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SJ Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Wed,  8 Jul 2026 17:52:23 -0700
Message-ID: <20260709005224.128135-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8b8cb8b6-41ff-4975-9be2-7256b180fcda@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 8 Jul 2026 17:50:57 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 7/8/2026 4:22 AM, SJ Park wrote:
> > On Tue, 7 Jul 2026 17:25:36 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
[...]
> >> I have no idea, to be honest. I will try to test with different databasesizes with temporal and consistent policies. The behaviour was weird to me,
> >> but I don't know if this was a TEMPORAL policy issue or I didn't set the
> >> DAMON parameters correctly.
> > 
> > Thank you for transparently sharing your thought.  And this is little bit
> > concerning me.  It feels like we don't really have a good theory about what
> > change will make what results for what reason.  It rather feels like we just
> > doing random experiments and showing the random results.
> > 
> > I understand having data first and developing the theory driven by data is also
> > a good approach.  But I feel like this is a time to step back and think about
> > what we're doing.
> > 
> > IIRC, your initial experiment results on the very early version of this series
> > looked promising.  But from a point, it looked like just random.  Maybe I gave
> > you wrong change request, or some test environment has unexpectedly changed.
> > 
> > How about summarizing what tests you did so far, what changes in the kernel and
> > the test setup has made for each iteration, and how the results have changed?
> > 
> > If it has been too long since the older tests, just doing the tests again or
> > dive deep into debugging of your current setup with the all mighty printk() on
> > core DAMON internall code can be an option.
> > 
> > Have you also monitored DAMOS stats while the tests are ongoing?  Maybe that
> > could also be a good debugging option for understanding what's going on as
> > expected vs not.
> The problem I've been having is inconsistent results. This may be due to thefact that I'm testing primarily with database, which contains a lot of
> variable data, like indexes that may be hit sometimes, and other times not,
> different data distribution, etc.

Makes sense.  Testing is another challenging area of arts.

If you find it is too difficult to have a stable test setup, I wouldn't mind
using more artificial test setup for test results on this series' cover letter.
I'd request it to be only makes sense and shows a sane and complete story.

It would be really great if you can apply this on more realistic environments
and share the wins.  But that's not necessarily a blocker of this series in my
opinion.

> 
> I've been trying to get a test as consistent as possible, pinning the
> database to a single NUMA node and the tests script to another one, avoid
> network traffic, etc.
> 
> I am almost done getting some consistent data.

Cool.

> 
> Maybe I can use perf to get DAMOS tracing. Would that make it?

Yes, that should work.

'damo' also provides a wrapper of 'perf' for tracing purpose.  If you want to
try it, I'd suggest something like below:

    damo report trace --event damon:damos_esz damon:damos_stat_after_apply_interval

[...]
> Thanks to you. I will keep testing and keep you posted in the coming days.

You're welcome.  No rush.  Take your time and fun :)


Thanks,
SJ

[...]
