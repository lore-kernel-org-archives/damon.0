Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5453BBFDF;
	Fri,  5 Jun 2026 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620628; cv=none; b=eiIAuGcUBHLNla7z9ny8vTIKTT/yhqYSmA0LvdNIeUDfSUYJRgQ8PWpEGMgze2j//h2lIiXqQwy9GS/B9hr3D55so0LlTeY/SrcmLtXs5Ux4laTE9oFJza/vJT3PlY0Uhw8XjpPtRtZ02rmESFAbUdoCdhCyX7PnE4zD/nKBGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620628; c=relaxed/simple;
	bh=b3t6+6AejNPgqoJIkZBaYfVRozsvb2baMXoi/JgVwXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bus8mUoQSS/jeG6PyjpestSO73kxPKCnogXUjIYtwjFaSZCIUDWXEeEVVHQVFSSoyZFL65bq+yI1z1oj1twxZYHY1AL5FARC/4mVvK9DF/qAsOOloFRear274L8EcFRBW1yS6/aF1D8bPhnOI9sYu4x4eLePHzBPs7Qev0Q1sWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBZmZlfF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBZmZlfF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C300D1F00893;
	Fri,  5 Jun 2026 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780620627;
	bh=aDnCUPpoLZgUbgYz+bZGmLvJQT8tB7FcJjGeZKgm4hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NBZmZlfFcoV0LGn8j1wV45Gn3eVLJ6bvQwvt+IS9VG7rciMqpnAoC7Kg2SZ0G2rCC
	 UCroVgi362p3I90GsFhaDMVYpimXF3S4M6LHiMR3Qtsxbfmd8ygLLJUDSh/gYLaL4u
	 qAB7TztmvRQLKRlcZfRkqX51ZwqDUahwK37FDMEG5APhffiWOXxpskdSgzi/OlIUWY
	 yvmqP7MRnyh0Fs3yDFc5SyCRnJ2WOzbD/MlDCZJ3emMFJtkyc+qzd7mwMJa1ZunB13
	 B0NOgBlhXzAjWEU28qhJnCCXeF7PG5CrzUjdhSLksQETqFNnHjI8FpATPkMpqLtDNr
	 O/hphuY/b4yLQ==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
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
Subject: Re: [RFC PATCH v3 2/4] mm/damon: Generalize ctx_target creation for damon_ops_id and add vaddr support
Date: Thu,  4 Jun 2026 17:50:21 -0700
Message-ID: <20260605005023.82747-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604150338.501128-3-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 4 Jun 2026 15:03:35 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch adds a new function damon_modules_new_vaddr_ctx_target.
> Since ctx_target creation for vaddr and paddr is almost
> identical, the logic is extracted to a new function,
> damon_modules_new_ctx_target, and vaddr and paddr functions
> are left just as interfaces.
> 
> This change was suggested earlier1 and it is needed to allow
> developers to create DAMON modules that use DAMON_OPS_VADDR targets.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Suggested-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/modules-common.c | 31 +++++++++++++++++++++++++++----
>  mm/damon/modules-common.h |  3 +++
>  2 files changed, 30 insertions(+), 4 deletions(-)

This change is for the sample module that will be introduced by the third patch
of this series, right?

I'd like sample modules to be simple and completely isolated under sample/
directory.  Is this change really required for the sammple directory?  If not,
could we please drop this patch?


Thanks,
SJ

[...]
