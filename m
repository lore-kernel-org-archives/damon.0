Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4AD184;
	Wed,  2 Jul 2025 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414907; cv=none; b=Mq4NPE20LWrxe0bDcNUpUNk6uSKylAXojeO1eAg9RZCm9ZWvAtNSVpNUjlcVH+tUGEr8Z2supHt687zmAtfUEf3rua3W/G0XOh/YdRv2ufNpEkWZNG21RERQSJ5B7QZEMdhaMPSdOg52BytB/cDUDQkFDAln4j1F6jqF42V4Njc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414907; c=relaxed/simple;
	bh=zD8S9jJauT0QXlMA5lHxuX9ql9gNaW6+5GzexRtMDvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6pHzMW2XLps4O5ty0EahbPySTQWiVaymLwhyzZY3PGJrnsibyiRaywKoQG6wkNi/zzaI9ZH8gEdPUkRJ48rvBhO7aUTmt7FvqrSifTQ0E2A09787W3XVeJzfzgY02L3Mm7MzBP3BaMycfAvB84CXV2WhEXqHbAgWo8cJIOXaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeuRPQJ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeuRPQJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE76C4CEEB;
	Wed,  2 Jul 2025 00:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751414907;
	bh=zD8S9jJauT0QXlMA5lHxuX9ql9gNaW6+5GzexRtMDvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FeuRPQJ9Z1hQiM6FBo18cOIRE273ysx1hBehJhqIktYMs+f95n7Jn+/CjoMpT4ytg
	 NV8IFu+OY1apecMCxcLKCkGV/J72nrRF/sGC59q7YWv4U9FpJx+W6DMrvUpvXo77zQ
	 DzmzIClz5VZ2kVdAPGkRcTVJ+gH2yv+1vw6t8hZ1obONW2bb0C3C4ZnN4sihR24e3m
	 9StYOlcWsVG13pKsgKRp5IFtNLHjg37oJ0Tw1LT9CKrZWkjFQShnVQ+JwqWEum8qhU
	 OpefCTD5aSL3yUw5pnL+ny6WBW0Dk93FpoY2U0tkPEdBf0hutHx2Me+lcH0ld+hEjn
	 ymHkEmFN3lAfw==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [RFC PATCH 2/2] samples/damon: add `migrate_hot` and `migrate_cold` knobs
Date: Tue,  1 Jul 2025 17:08:25 -0700
Message-Id: <20250702000825.57587-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701085417.1734-3-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Yunjeong,

On Tue,  1 Jul 2025 17:54:17 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> This patch introduces two new konbs for promotion/demotion:
> `migrate_hot` and `migrate_cold`. It receives node ids for migration in
> a comma-separated format as `<src,dst>`. The usage is as follows:
> 
>     # demote pages from nid 0 to nid 1
>     $ echo 0,1 > /sys/module/mtier/parameters/migrate_cold
>     # promote pages from nid 1 to nid 0
>     $ echo 1,0 > /sys/module/mtier/parameters/migrate_hot

I understand you want to support some setups such as having a fast node of id 1
and a slow node of id 0.

Because mtier is a sample code, I think it's primary goal is to help developers
know how they can use DAMON API functions for writing kernel code that is
required for a situation similar to the sample.  Hence the sample should be
clean and simple enough to be understood.

The assumption of the two nodes (the fast node 0 and the slow node 1) is
arguably intended for making the code simple, in my opinion.  We could of
course make this kind of changes if it helps more experiments for understanding
the code, as sample code is not only for reading but also running.

> 
> Susggested-by: Honggyu Kim <honggyu.kim@sk.com>

checkpatch.pl found a typo: s/Susggest/Suggest/

> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> ---
>  samples/damon/mtier.c | 68 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)

But, I feel like this change is rather making code too longer and complicated.
Hence I would suggest dropping this patch if you agree.  Please let me know if
you have different opinions, or I'm missing something.


Thanks,
SJ

[...]
