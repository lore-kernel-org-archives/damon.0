Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546B1A9FB7;
	Sat, 13 Jun 2026 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781311153; cv=none; b=tvUUNWv6KJ3TExwd8/Ouv/H2oNSDCwjpjdKh2pbH4wxU3frgb3LnG8CVxP7C5RGM3zZbelCeTMHD6VEKrVy+NTj9/rNh0zDvjBdJPs2GXXoZOWLRA3Bl8PNYI8XX0WjOUhgVbtoIJnRaFWXU7MeA+8AiYiTKI/GZ35KtEjveh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781311153; c=relaxed/simple;
	bh=V7ivxE8Q6U6I5yIvW+G7FI0OwyM5ZgdYPkgMuZKYb/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1AkaA26o3ql4p5NtRMBg0q8DQ3fcGoo1JLvripAi55Lxmn57j26z7/fiIjTuxSEniwm3p+oj8xl4sUTJa2TZMcfDbeyNIrmQk0Jj2InQdpc8lZT5JDsz2ePdCue7J9iapznJXV8feePzA1kdiecp/v2bSvcohtzc1xKnmvT9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaB3KHbD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaB3KHbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDDD1F000E9;
	Sat, 13 Jun 2026 00:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781311151;
	bh=TEI/oYL96D6QPPjj82L55jjg/d8h3AkIL0OSLpC5t+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RaB3KHbDYrCrCpghgRrcfM7xtPFx2sUsgqe6B4GoO9Avmo+oVZwHtErMBqQo/xzlT
	 fXlAFyT7ds9gvCZd3bt/CtHxpMO/pPmRxD5Bxfn76NSFLlYNqSm1hDhilDWa21fTG5
	 ydnr/01AKEnZSclCf+X98zMvV4QYODluKYjvmDJsj1nvvST/YfZJSHP/D1rdH2h+hh
	 kNqLm5IVSfExkZpxpo9l7iY7CmCxejdfol/VwdRrm+GPTqYv2TtTqAd1v1qup8A1QY
	 8VESK4htyjib9pYl30SpCwNQVgCsNRQ1REp1lOpLYAogCvm5J8LvnNSMYvsjYY+CUH
	 hVmTmZCbIl4aQ==
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
Subject: Re: [RFC PATCH v4 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Fri, 12 Jun 2026 17:39:04 -0700
Message-ID: <20260613003904.1932-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <abc8acca-5145-4c16-aeb7-4127da234a62@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Jun 2026 22:36:11 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 6/12/2026 3:56 AM, SeongJae Park wrote:
> > Hello Asier,
> > 
> > On Thu, 11 Jun 2026 15:02:40 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> Overview
> >> ========
> >>
> >> This patch set introduces a new autotuning which allows to collapse
> >> hot regions into hugepages.
[...]
> > Also, I'm not sure if I asked this same question before, but ...  Could you
> > please share your future plans for this specific series?  What change you want
> > to further make before dropping RFC?
> I will review once again all your comments.
> 
> Since we are aligned, I plan to drop the RFC tag for the next revision.

Sounds good.

> 
> In the future, once this patch set lands in upstream, I plan to submit a new
> patch set to add cold page split in the sample module, so that we can have a
> full THP support.

Cool, looking forward to that!

> 
> Thanks a lot for your patience!

I'm glad to help!


Thanks,
SJ

[...]
