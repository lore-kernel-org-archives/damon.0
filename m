Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6A241C8C;
	Tue, 18 Aug 2026 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787014474; cv=none; b=QVb4yNeF0tTDTVPv50akV+VjiMNc0lF/5XZM9O9XCvVJKkNbysOHJSgu28dIAmQ5F0OPkEn6G5+BfwQ2wwGhSVJF2PO0N/CtvO1IgV8y9JkNXJQcHFHcBFQB1uMMC4lt6FfCe0KHLcELHENTy3cVffvNtEqoehaq5rIKPhS6lBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787014474; c=relaxed/simple;
	bh=67v/HK3kSRSzxBDVcXSLCY0ywsqg4H9mKELAM9QfgZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvEsGHwiD4Bjp5jTtvWewoWWdBhUDoDPLIFHxr9dtYN7RUAxUABh1klnKPS/dHmsI3qnzWcHXkwsSS7GAmm2CXFlCfuhHmZB0XR9/w4nXzbxiMbhiEsCDjdovySLWUCr+IMJsGXPGvxF1a5ldhPJ0e9XrccBQSH/WsZlHeLyGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdH71YcY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdH71YcY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71391F000E9;
	Tue, 18 Aug 2026 00:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787014472;
	bh=kYxkamxtO++QzU30BmbUy5M+CCOHMm+4XKO25ln20BE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RdH71YcYgdqd9Sw7OT7AXDe5CrF3JW1Z5XkAA3ojRPCD0tk3ZbeXp5KwLbf7Z/FR+
	 fj2PeYU3EZprURD/X87BBxyDP2eNov6CUazX2UqyTSZVDgTZErEjUExEvJCB5zKH7D
	 EQPswksBr0e04vuokPNXb3NP3H06juZXu1equnq7p5t9PD9CC65KsrojulnHpypwWr
	 tsbBF3iSwqE3olfyLBdE3huLtlmRloZwc1iXmWzl7V7T2ayZ/xzHegZEe38w6u4zLA
	 7vug4Xg9FTSFCVwzS8VZf9jZ/FYSzYcQps+KO+mPjtBhQW1tvwydwPTcz7QpL4Gkee
	 HghZ44N0OyrUA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON (nano) Conference Schedule (was: "Re: [CFP] DAMON Nanoconference (aka BoF) at LPC'26")
Date: Mon, 17 Aug 2026 17:54:24 -0700
Message-ID: <20260818005425.88087-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260808162724.92408-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  8 Aug 2026 09:27:24 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed,  5 Aug 2026 17:33:57 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Hello community,
> > 
> > 
> > We will have a DAMON BoF session [1] at LPC'26.  Because it is a BoF, I want to
> > make it as casual as possible with many voices.  Hence inviting you.  You could
> > think this as yet another version of our bi-weekly Beer/Coffee/Tea chat meeting
> > series [2], or the first Nano-sized DAMON conference.
> > 
> > If you have any topics about DAMON that you want to present and discuss in the
> > session, please send an email to me.
> > 
> > Example of topics include but not limited to:
> > 
> > - Your DAMON work that is recently landed, in progress/plan
> > - Your DAMON usage and success/failure stories
> > 
> > Depending on the topic and number of proposals, I will try to give each topic
> > 5-15 minutes.
> 
> We already got plenty number of proposals.  I'm closing the CFP.  Sorry for not
> announcing an official proposal deadline in advance.  Please feel free to send
> any DAMON topic, though.  We could extend the session to hallway track, evening
> event or a later DAMON Beer/Coffee/Tea chat.  Also that will be helpful for
> planning the next DAMON Conference.

Now the complete schedule of the nano conference is avaialble [1] at the web
site.  Let me copy-paste it here for your convenience.

17:45-17:48
Opening

17:48-17:55
Breaking through Accessed Bit Limits of DAMON - SJ Park, Ravi Jonnalagadda,
Akinobu Mita

17:55-18:05
Beyond Weighted Interleaving: Bandwidth-Driven Memory Tiering with DAMON
- Ravi Jonnalagadda

18:05-18:15
DAMON for Huge Pages

Guiding THP Decisions with DAMON Memory Monitoring - Asier Gutierrez

Host-side DAMON Hotness under KVM/THP: Granularity Gaps and Evidence for
Demotion - Lian Wang, Kunwu Chan

18:15-18:25
DAMON in the AI Cloud: Monitoring Real-World GPU Workloads - Krishna Iyer

18:25-18:30
Joint QnA and Closing

Looking forward to meet you all at the first DAMON (nano) Conference in Prague!

[1] https://lpc.events/event/20/contributions/2453/


Thanks,
SJ

[...]
