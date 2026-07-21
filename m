Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CB37B028;
	Tue, 21 Jul 2026 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642646; cv=none; b=mCvWV0Gnkk07HKyRCmrVqiAVfUUUzCYwQrg2+YR8Zwy3Qek4R0X4JriV+4gUO2p6PqHZ39r925PDKGo1W9oADe5wbKMpgJzl9ZW4pPm/ZWzuVw13Rzi20t+TnlgeTEnyXLCjnUCI5m5bBYo/zrkdADthgjz4lqoj+nmdOnNzr0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642646; c=relaxed/simple;
	bh=Sm06Xy+vaFJg0F0XF8rEpFoME8TlyPy6vat58pdXHAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPwKuvN55O6/tYZHqXgnl3DB+pGWSFqbB9tfA61sSBLIMfrX/FiIkO2HaV3xEKrIjhhyw9V++7KjYKzD8OboPfX+g25htJigwUW/QSLwO1lN17aXelOCZX0r07dolpwQ20+Y6MS7p3rDvcnO+ma//3FwOBgosFUvYWQXHTJdwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bqj6B4f1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bqj6B4f1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933531F00A3E;
	Tue, 21 Jul 2026 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642645;
	bh=7qjAipW3arar2oQ1bixfWVKbsgwvHLobvM3s6CkTaig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bqj6B4f1oF4DqBBhsnzjrmT7J91T1r2gWW2gW8hJkAeQNwEJUZZ9A3hwxjCgTIlPq
	 +x4Qq55bZ/fK/Ivsj33dE2ScI7Jxj68SByysk4XQqy2EzHJtEATc18Dcs/9bF8e+R6
	 BY8H5ojUlW1XuZtTXDTsHe1gcr36+JMG1boop4cMBrjdRe9VD1Q6/EvKva1gTo7H2x
	 QqsD/NBxbz6HjVUCHA6WuaLN/BnFwXyfJ1jqMyLAflNosdbbFqq6vsLjJTw1J95+NC
	 3HZc/KjhpOLx5KjZbmweHPP4O5pAZN60bsiEMxz5A7dKf/9ujJTPj4KVeDCKdqlzID
	 QaaJ5CIGn9NKw==
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
Subject: Re: [PATCH v3 0/3] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Tue, 21 Jul 2026 07:03:56 -0700
Message-ID: <20260721140357.285826-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <524b7d2c-4136-4476-9a84-a3dedcd00c5e@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Jul 2026 15:58:13 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 7/21/2026 6:58 AM, SJ Park wrote:
> > Hello Asier,
> > 
> > On Mon, 20 Jul 2026 12:01:37 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> Overview
> >> ========
> >> This patch set introduces a new autotuning which allows to collapse
> >> hot regions into hugepages.
> > 
> > Thank you for making this series well done like this!
> > 
> > [...]
> >> Patches Sequence
> >> ================
> >> Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP and autotuning
> >> Patch 2 -> sysfs support for the new quota goal
> >> Patch 3 -> Document hugepage_mem_bp parameter
> > 
> > I'd prefer handling 'total' underflow and returning 10,000 instead of INT_MAX
> > from damos_hugepage_mem_bp() corner cases.  But definitely that is no blocker.
> > For the series,
> > 
> > Reviewed-by: SJ Park <sj@kernel.org>
> > 
> > This series is applied to damon/next [1] tree.  If this series is not added to
> > mm.git in short term (~3 days?), I will ask mm.git maintainer (Andrew Morton)
> > to pick this.  In the case, I will update patch 1 to do what I mentioned as
> > preferred change if you don't mind.  So, no action from your side is needed for
> > now.  If it seems I also forgot doing that or you cannot wait for my action,
> > please feel free to directly ask that to Andrew.
> > 
> > [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
> > 
> > 
> > Thanks,
> > SJ
> > 
> > [...]
> 
> Thanks a lot for your patience and help with the patch series.
> 
> I will work on the suggested minor changes once the this patch set
> lands into mm-next, if you don't mind.

As the change is so minor, let's do so as a followup if Andrew picks this
as-is.  If not and if you or I do resend this series, let's do that as a part
of the resend.


Thanks,
SJ

[...]
