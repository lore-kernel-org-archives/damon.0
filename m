Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1AB199385;
	Sat,  6 Jun 2026 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705494; cv=none; b=WXhypCgXqmBvPUOy3LHLxfuFyswTpW/DWn3bQhEDbyzfCIeGSfHB7+E7SIs1jlAPchjcs0F3DVpVOWVTqpy6tJmJD+bpi7KegTDof4RUgf6O0CI34n7YsO6V4SW5VZ/CA4A3kBRE7MJ3xHcmGaIvpH8sBO++6J5BqHFs9uoQzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705494; c=relaxed/simple;
	bh=Nma9v4rJJoJOge+ZXqCuBZ7vTNLIMoPXEfMY6Gj9vKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbR1b5PPnU1va6eZ/748ROWsxLjSMIqhXdyX/Wio/dfJCmKC/YvouGGek/uJy9wm886vPdUAj0P0xq1JAORL9ps3OF5OIp+gvqnAcstS52oiPYguHH/hJle7rttIP+u7nXBA0yrCPN3lQBwAuZFrM0/eERxMfu9l7CB2ee7zDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyEvHHTG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyEvHHTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B041F00893;
	Sat,  6 Jun 2026 00:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705493;
	bh=moshiuy8JwuZ3+oTcEsfObj1AtXF7PyldC/qvAt/mT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QyEvHHTGx2S8OfnbQBiJk8vrArJ0wxW/Av0tdx4+2ZBODe1njfPe0a0qu5U6c6NSi
	 t9t3AGBRb/Y+gnqn8t25ynFGdKFBQACbzmZxJSxWlZDHF19mkKv1c9qNiYKfTlYQo1
	 u3HOOQdIUkf8Hu5iBdJJBmR28Y8IMO1oJCDt25s675D4E73mTYqDx4Eoma8yrsKJM1
	 eTypb+Q2Nl7dOJJgqTru5dY+ySXAmsR16L2U1BBGlYdsWJFDvQ7sIK8D2OrN4zD6Ki
	 t0leWaUvMuwsKSSI/4JyaaZHi70xH4cYyBDX5s4BKcMfWK3zDaZK6imCI+PX09RBZK
	 K0vizNfCBjGeg==
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
Subject: Re: [RFC PATCH v3 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Fri,  5 Jun 2026 17:24:45 -0700
Message-ID: <20260606002445.88776-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9f9e2159-5a6b-496f-9633-fa06c0217948@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 5 Jun 2026 13:25:56 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 6/5/2026 4:34 AM, SeongJae Park wrote:
> > Hello Asier,
> > 
> > 
> > Thank you for revisioning this great patch!
> > 
> > On Thu, 4 Jun 2026 15:03:33 +0000 <gutierrez.asier@huawei-partners.com> wrote:
[...]
> >> Benchmarks
> >> ==========
[...]
> > Also, have you tried temporal quota tuner?
> 
> OK, I will give it try.

Sounds good!  These test results are great contributions for DAMON community.
Nonetheless I don't think those are blocker of this series.  You could run more
tests and share results even after this series is merged first if you want to.

[...]
> >> Patches Sequence
> >> ================
> >> Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE and autotuning
> >> Patch 2 -> damon_modules_new_vaddr_ctx_target
> >> Patch 3 -> Module that demonstrates how to use DAMOS_QUOTA_HUGEPAGE
> >>            and the new VADDR ctx creation
> >> Patch 4 -> Documentation
> > 
> > As I commented to each patch, patch 1 looks good except a few trivial things.
> > Patch 2 seems unnecessary.  I hope patch 3 to be much simplified and wrote
> > again following the sample modules' pattern.  Patch 4 seems too much for a
> > sample module.
> Thanks for the feedback, I will work out the patches.

I have a trivial comment about the 32-bit overflow issue, but everythinng
except that look good to me.

I feel like we are going on the right direction and this series is getting
closer to land!


Thanks,
SJ

[...]
