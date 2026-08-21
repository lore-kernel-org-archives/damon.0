Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B727AC4D
	for <damon@lists.linux.dev>; Fri, 21 Aug 2026 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355805; cv=none; b=kLN6zZeR223MP5bM88FEe3ALfw2T/5OPuycIdj920zPuqBANFe+zjDMZ+HsGDkQygGlrrc60tjeYu6ewSk3K7ybiXw+48vZSu1dWCA72GHZONBr4wWXedUeBsTOd31vO6U9LyeezQiW8NMDy1Kqt9RphsL0CWNBezb9u8itvNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355805; c=relaxed/simple;
	bh=x2EYAJ5veGM5doDhfcSn87Z5J1fNACaRaNNnIE1JCus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yx2TjS26VLX/tBujdjHADF4PbpenJqAucWxvucqd+6rJGOS5hvP+VT2hzNrCJBCiLTY4BtezH+nO6TVA2IfDfM33p6tolWiVkGnyPGP/j9WpHI73+0EwFEGeH+RaO2tVmfAWPjx6cKtMqFSb1JTJUzq0vN1yHfVH/Y6BRLb6jXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQhON7mO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQhON7mO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05FA1F000E9;
	Fri, 21 Aug 2026 23:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355804;
	bh=Rob2JksK7mVEytmz2auecaZEv9Vwn35NTkatzwt5/50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gQhON7mOck6bYEWCFYCGT72y+meWundyrsOXq+jnfL0RrvexuBbf7AkKfej1ppTF6
	 iHwnv2lUJjA8xyfalqTxTp/xZxu8D8vzNLiXywjhqdGtNk1hBfPHPdDToDVeWILzu9
	 RAoy3zuHcAzs0SY1w9tv1nhOYFzcuoMxNBOs3amwZXDTlaWW0VRein7lyJWTZg8lBp
	 cTmuy3vavLOPIb4A8X9mjptypvgRQK22gsNUIeu4CD99+gTQz+L5RR1xO+hcOUnWI5
	 W8xIUQsS6ho9jemxuqrRNseAz5D46T4dm2rxIzKFLMs0i+4N9vvYtWPHqXFFQmILjV
	 uhaLKgZqhkuew==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	gutierrez.asier@huawei-partners.com,
	linux-mm@kvack.org
Subject: Re: [RFC/Discussion] mm/damon: Helping with alternative for watermarks
Date: Fri, 21 Aug 2026 16:43:18 -0700
Message-ID: <20260821234319.87475-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821141654.203418-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Aug 2026 22:16:54 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Mon, 17 Aug 2026 06:57:42 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Mon, 17 Aug 2026 16:39:23 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > > 1. Why use Watermarks? And what was the problem?
> > > 
> > > I now understand why we do not need better Watermarks, so my answer is
> > > based on my previous thought.
> > > 
> > > I used Watermarks primarily because it is the only mechanism I know for
> > > stopping/running a Scheme.  The problem is it can only monitor MemFree.
> > 
> > Thank you for clarifying.  I'd like to go one step further.  What is the
> > initial problem?  Why you need the automatic proactive reclamation?  Do you
> > have some data showing the problem?
> 
> To be honest, I have not encountered any problems, and I do not have any
> rigorous data.  I simply using DAMON to try proactive reclamation, and
> see if it would cause any serious issues.  So far, it has not; it has
> almost no noticeable negative impact on daily use.

Thank you for clarifying.  Also appreciate your test of DAMON.  I'm curious if
you noticed any positive impact, too.

> 
> > 
> > > 
> > > 2. How exactly the page cache becomes a problem for you?
> > > 
> > > After prolonged computer use, the page cache can become full.
> > > DAMON_RECLAIM might then mistakenly assume there is slight memory
> > > pressure and reclaim those cached pages.  Unnecessary page cache
> > > reclamation can incur unnecessary overhead.
> > 
> > Thank you for sharing this.  I can theoretically understand the issue.  Maybe
> > you are concerned if page cache is too aggressively reclaimed and therefore if
> > file io becomes slow.  But I'm not really sure if it is only theoretical or
> > real.  Since the proactive reclamation reclaims coldest page first, and because
> > it works for not only page cache, the performance impact might not that big in
> > real.  Do you have some data showing the problem?
> 
> This is currently only theoretical.  I also think that the performance
> impact will likely be minimal.  I think adding a MemAvailable option
> provides certainty, if users know for sure that their devices will not
> lag when MemFree is low, but will when MemAvailable is low, then they
> can choose the option that best suits their device based on their own
> situation.

I understand it will allow users to tune the system for target MemAvaialble
value.  But, I fail at understanding what is the advantage of it, even in
theory.  It would be nice if we can have a clear example scenario that shows
advantage of MemAvailable based watermarks compared to MemFree based one.

> 
> However, since DAMOS Quota already supports checking current_value from
> user input, and I cannot yet prove whether this option can bring
> improvement in any workload, I think we can disregard whether to add
> this new option for now.
> 
> > 
> > > 
> > > 3. Has the MemAvailable based one solved your problem?
> > > 
> > > Yes, using MemAvailable as a watermarks/DAMOS Quota metric can avoid a
> > > lot of unnecessary memory reclamation.
> > 
> > Great to hear that.  I'm curious if you have some data showing the improvement.
> 
> While I do not have rigorous data to demonstrate any improvement yet, I
> appreciate your guidance on this.

I wouldn't say we can never add MemAvaialble based watermarks until we have
proving data.  But, I think we definitely need a clear theory to start a
discussion.

> 
> I will continue exploring DAMON on my end, and I might send out some
> patches later regarding a few logical issues I noticed in the code.

I'm looking forward to the patches!

> Thank you again for your time and answers.

Thank you, too!

> 
> Best regards,
> Rui Yan


Thanks,
SJ
