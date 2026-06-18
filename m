Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4667083C;
	Thu, 18 Jun 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794666; cv=none; b=BjZKnh2NxaXZ3ov3PFBj3nq6FQmmW47rEX2OUZRpjT+UQH2qe7vc90N9ErvZVxWKZVH0yZtLDO9EgQAIhNBXIcJKmAEHN/jUNJFdYNdUkjncC4uNPZM+BMSwT1YwrAPXJ4D2llMASKHuuwYiLofVfhkS8u+giNaYS3NSYG1+mHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794666; c=relaxed/simple;
	bh=8hhA8ITKPnlh/tQ8seHGp/s0Zb5Z7ilfHGhqeZgJcZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfR7nz/BEItU4/98LARXdNASBjLzjXrJ+YagyFajCTu/GI8wzZ7OmiPnq8ZS/JY6W5vYRFb2qGxqe8WAVV00nUAgESdJcHOeeSHhCAtrrP1SZrgGBm1SGc4RDET1KlAs3dJ58+xrM6CaeDpopMcZn2stoxVqU3JrmwUB9mLtAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W12j0M6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W12j0M6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08291F00A3A;
	Thu, 18 Jun 2026 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781794664;
	bh=t3xL86x8nOC9fzP2/lF4I4AcTSvtSbWHAyLkAKm7fJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W12j0M6c5efqLeOHgmm52ei6B575a2P5WttXjWtU0UxQvtf6itxeR7+LYaMgP9Yqv
	 ZAuDfZSLK6O7cx2okyKByVpk96FhUUsVErBFrhG/aWPuJIQa6cDBmljptzKR5J1oRR
	 Mq5TRqKwNHwt/aDPRJGmDeBHxHQabUEuoKYSq2coLWmqspMT3/forDNLcRyv2I0BPe
	 QcZj9woH8oXxHLS5YUaywUdbTk+UPbsolqxgnR+uwIbgGTdX4WSgFjAv9y68UkFUyq
	 M2ZEAKMq3tcttfUcIh+UYkKzQxOIHbrZQkTrfDwna4sRsXiubZ+3xAZQ+wbw74LMTq
	 dHswWdJFcByUg==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
Date: Thu, 18 Jun 2026 07:57:33 -0700
Message-ID: <20260618145734.4477-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3565736e-f33b-4220-9978-a1461b6d4ee9@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Jun 2026 14:51:42 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 6/18/2026 3:16 AM, SeongJae Park wrote:
> > On Tue, 16 Jun 2026 21:04:52 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> >> On Tue, 16 Jun 2026 15:03:15 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> >>
> >>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>>
> >>> This patch introduces a new DAMON module (SAMPLE_DAMON_HPAGE)
> >>> which collapses hot regions into huge pages.
> > 
> > As I mentioned on the previous version of this series, this sample module looks
> > much better than the initial shape to my humble eyes.  Much smaller and
> > simpler.  I really appreciate Asier's efforts on making this.
> > 
> > However... I was asking myself if this module is really needed last night, and
> > still got not real good and confident answer.
> > 
> > After all, this is a sample module.  The purpose is to show sample code thhat
> > helps people understanding how they can use DAMON API.  Maybe we can argue this
> > module can be helpful at understanding how DAMOS quota goal can be used.  But,
> > mtier is already showing that.  So I cannot say what new advantage this module
> > is really bringing.
> You are right, the main goal was to show how this quota goal can be used. 
> > Meanwhile, this patch adds ~200 lines of code.  It is a very small and simple
> > sample module, but still we should maintain it.  I, to be honest, getting
> > little bit concerned about the maintenance overhead now.
> I understand your concerns. I know code need maintenance, and DAMON is already
> growing significantly.
> > So, if Asier has a good reason to add this module that I'm missing, I'd like to
> > humbly ask to consider dropping of this module for now.  I'm so sorry for
> > raising this concern this late.  But, Asier, may I ask what do you think?
> So, are you suggesting to drop the module and upstreaming only the DAMOS quota
> goal stuff?> 

Yes, if you don't mind.


Thanks,
SJ

[...]
