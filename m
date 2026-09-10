Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712252609E3;
	Thu, 10 Sep 2026 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999476; cv=none; b=RqkN6Fl36X7F0MSKNuYJJuHRi9v88SRbJQTqsJR9jLDHHZCuCBm+30P1hb5JZI3wOQEEYzQW80VbSDQllQg1TWa1bW+H8li8dT6wmsiH7jL4AAJnbDvlnjeLmHiwGDkY1iWRQ1a/ZFJT+WLIOcq0609497ryld/nFj+OqBKwni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999476; c=relaxed/simple;
	bh=4J88FcRFWb1CXdp4a2wDQbcHv41WB54o12dX99rBTZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoSWunTqR+/ERjX7Hui40x15BIZqyqc5wsoZn5+JhlXdPTOL2mdilrKhhLR820L7mWLuMXxZrxb5B2vm9zP+fmkzQFs/gKKtkwGLijLJt9aaDoP9BFT2HJFwac/gj5e3xyZ7lnXWco+yTzYYqQHk1c64UawXvVjXNRU5ZQaaHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDiIuga1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDiIuga1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769F51F000FF;
	Thu, 10 Sep 2026 00:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999475;
	bh=TW3K+AgSrwHemRWw14UWea9xECIj/k6NgLwb2UHRsPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XDiIuga1MVxrtxfrwhhYXePZoy0JGb+ujz65mh5hUYMY67pz0foKfM7Q5QkCL5v0n
	 lTfa0cCfiS2XfZuigBiP9U0iHcwdRhd2CUM46aewqoVtleZ9nOpf9n/TnU19pVtIA2
	 utUeA+R2k3MqADcMDel8YPg5y/UPtErXdi911fksXcgktppyMIvkEkrLuLBIFVW721
	 RSfj6A+rv2AiJzx7SRLLoqkfDUlSg9Kd+1ykynRnzDYAXahm39nr1ayxpyrCVgbZJU
	 SbdiADH8ni8BbnbdwSnfXengJkE6FhFqUH+qO/l72YS2CRY795lUa5AGNDljhhF/f6
	 gzdzh8H/kx7Jg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	damon@lists.linux.dev,
	david@kernel.org,
	liam@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rdunlap@infradead.org,
	rppt@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@kernel.org
Subject: Re: [RFC PATCH] Docs/mm/damon/design: clarify when qt_exceeds increases
Date: Wed,  9 Sep 2026 17:17:46 -0700
Message-ID: <20260910001747.110260-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909100913.30568-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  9 Sep 2026 18:07:33 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Tue, 08 Sep 2026 17:38:00 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Hi Liew,
> > 
> > On Wed,  9 Sep 2026 01:50:23 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> > > By the way, I found a thing in the design document that confused me.
> > > 
> > >     temporal: More straightforward algorithm. Tries to achieve the goal
> > >     as fast as possible, using maximum allowed quota, but only for a
> > >     temporal short time. ---> When the quota is under-achieved, this
> > >     algorithm keeps tuning quota to a maximum allowed one. Once the
> > >     quota is [over]-achieved <---, this sets the quota zero. Useful for
> > >     deterministic control required environments.
> > > 
> > > I'm not sure if "goal" was accidentally written as "quota" here.  Would
> > > this be better?
> > > 
> > >     When the goal is under-achieved, this algorithm keeps tuning quota
> > >     to a maximum allowed one. Once the goal is [over-]achieved, [...]
> > 
> > Good eyes!  Yes, seems it was only mistakenly written in the way.  Please feel
> > free to send a separate patch or include it into the next version of this
> > patch, whatever better for you.
> 
> I will send a separate patch.

Makes sense to me.

[...]
> > I think the clarification is better to be added to the 'temporal' quota tuner,
> > since this happens only when it is used.  Maybe the clarification could also be
> > shorter.  For example,
[...]
> I agree that would be better.  Although users might look up the
> definition of qt_exceeds first, they are also likely to navigate
> directly to the temporal section.
> 
> I will clarify at the temporal section in the next revision.

Thank you.  Looking forward to patches.


Thanks,
SJ

[...]
