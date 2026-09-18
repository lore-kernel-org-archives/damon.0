Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2724F5E17;
	Fri, 18 Sep 2026 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738521; cv=none; b=hxKBYaH+H2h26R7vo442TMY1qzk1TRYOqtb9HfBNudAggmm75K38NAvi/Q53xP+QdzDSINT1V2fQv1N0b/FGBs5zNd/bFDw45IN7k+31wklLsPg2egOHGX2CjsO0Jx3qIrcqf5Y3/6W9qNTRhhk8Ak4Q4wMvMqyAimMG7rvbwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738521; c=relaxed/simple;
	bh=nQLbi7xliQevoIYgrzYdUPyBtfofnuQ6eetP3q3m/H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLWVu9Eu+JPWYpVYeHTtgKxjR6JAD3YCVXfIjCSPBhYznoUj9slgyvIfO6WNuS4N4VR59f3V6JnxU+277Ak3wGBuOUhumfEK8rxMqPusGt/yqQNVWlByn2XoMeGSB1ia6XgCc10R151LtVIDcj0+BuwZ5iH07hVjHogcr/y1NiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFs+4SzP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFs+4SzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B341F000FF;
	Fri, 18 Sep 2026 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789738520;
	bh=cyQRiAE1NzNRzDvuosLUWEsOKuA4c97+gPKm3HyuGhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NFs+4SzP3Zxzh27IEibLV4nA2NjPaNTex8Yv8msHbXsxjYb2ro5LCgb044dh6KF5J
	 fRNsvQ0aBnxw9wxa72hLn2q4D7ZJB+BSIHe9lkLWHLccvNPBURe+ubn8ubCV+ITjov
	 7uHHiFF8FY+11JgkNAMY7+S9O3hdBLtLU7Y33aLoq30RB/5NRa6jl69Ug+o+D62sCn
	 3WZaGpcQEvAL3eSs1dHWmBT7a1AotKPKBtB9RsUXjXZgLd0LX1E3HtFEIjMG6njuB9
	 xldpItAz5jLOalBJjPcIjzyh8I9vcWXBT0fjx/OsfndFOwOFP+D2ocCHiy5EBJOkIM
	 GsBhwVE10dGaQ==
From: SJ Park <sj@kernel.org>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon: document that a zero sample_interval is accepted
Date: Fri, 18 Sep 2026 06:35:12 -0700
Message-ID: <20260918133513.26828-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918131301.75879-1-karthiproffesional@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Karthikeyan,


From the next time, please don't post a new version of a patch as a reply to
the thread.  Post it as a new thread instead.  Also please add a links to the
previous revisions in the changelog [1].

On Fri, 18 Sep 2026 13:13:01 +0000 Karthikeyan KS <karthiproffesional@gmail.com> wrote:

> damon_set_attrs() accepts sample_interval == 0.  This was reported as
> a bug in v1 of this patch (rejecting it in damon_set_attrs()).  A
> similar patch was already declined for the same reason: a zero
> interval is intentionally supported [1].
> 
> Document the behavior instead of changing it.
> 
> [1] https://lore.kernel.org/all/20260722094304.3132750-1-dayou5941@163.com/

The patch itself looks good to me.

> 
> Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [2] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

> ---
> 
> Hi SJ,
> 
> > I'd prefer adding a comment saying zero sampling interval is
> > accepted.  I think damon_attr kernel-doc comment is a good place
> > for adding that.
> 
> Adding comments instead of code changes.  Let me know if you'd
> rather the wording live somewhere else, or be phrased differently.
> 
> Changes from v1:
> - Dropped the damon_set_attrs() rejection and the KUnit cases that
>   tested it.
> - Added a kernel-doc note on struct damon_attrs's @sample_interval
>   instead.

Thank you for accepting my humble suggestion.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary
[2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees



Thanks,
SJ

[...]
