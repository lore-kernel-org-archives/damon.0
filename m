Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92A1DE4C3;
	Tue, 29 Jul 2025 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814103; cv=none; b=DQ61uqbYs/tWZ+3Sq0bC7FQQYIU9YFFshmznt7ajbYA8N0ahnTCWws7gFYG6F/QMksRcuDrCEIkGBH3EJyxIfNnqQrDja016kCxOxBgvIW/sCV4bwxW5B+HHNs++uj/v1E8WK8fa2AJd7EI4UZSygjCaNObb6oPpjz1i7+AsN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814103; c=relaxed/simple;
	bh=Ad+h/78ZxwD6mSt4jRq861L+6lQvlmuf+yPcWZOe2h0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQK0IuIC9VGsabggSKLcOvLr5DyMLdQR0fKODt8V0F6WGISnVLKnShFiH1Yzqy+y/clahYY+ezeiZyfnt/UnoyofJsVrp8plERXxyc5xyHM+f85Dt3+tbf00Sq5qC2AazJ1J+yxMJj/DoXcZ3NNpUd1UZiHp/WKi/ks2lpd2sYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqcTBmrz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqcTBmrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694C4C4CEEF;
	Tue, 29 Jul 2025 18:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814102;
	bh=Ad+h/78ZxwD6mSt4jRq861L+6lQvlmuf+yPcWZOe2h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqcTBmrzzYZcUzhXReID4UeShTvo4pQhNy/0QoDsD0t0I9owoNH47SutX7xO4TQn3
	 xUA++PYUb9hFYYVcJbmoYsyZfUYHHV+3mcsCsmErI8quymCd2i1YBnTDJLXh31bQ00
	 jUgJ1Cfr8ediO95VkPThcZuMZqH4AXiLGhLDFpiixssuvvgyobJTVaHyXDbdqvCXnc
	 suyTMmswiUIK7mOFQIHWdGjqQE4nSg8/UqxEDozjioML+egMuP4RcD8a6Tol937srf
	 HPVkLnKrYfxrCXtJPW2nPUS4FAIVj2EftUpWV7YrS5o49txRN6QV4fqLd4kkv34BOA
	 oe8uRgVLTPutA==
From: SeongJae Park <sj@kernel.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] mm/damon: Add damos_stat support for vaddr
Date: Tue, 29 Jul 2025 11:34:59 -0700
Message-Id: <20250729183459.56512-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1753794408.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Pan (Or, should I call you Yueyang or Jason?  Please let me know your
preferrence if you have),

On Tue, 29 Jul 2025 06:53:28 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:

> From: PanJason <pyyjason@gmail.com>
> 
> Previously damos_stat only supoort paddr. This patch set adds support 
> for damos_stat for vaddr. Also all different types of filters are 
> supported. 
> 
> Functionality Test
> ==================
> I wrote a small test program which allocates 10GB of DRAM, use 
> madvise(MADV_HUGEPAGE) to convert the base pages to 2MB huge pages
> Then my program does the following things in order:
> 1. Write sequentially to the whole 10GB region
> 2. Read the first 5GB region sequentially for 10 times
> 3. Sleep 5s
> 4. Read the second 5GB region sequentially for 10 times
> 
> With a proper damon setting, we are expected to see df-passed to be 10GB
> and hot region move around with the read
> 
> $ # Start damon record
> $sudo ./damo/damo record "./my_test/test" --monitoring_intervals 100000\
> 1000000 2000000

You can use 'start' instead of 'record' for this test purpose.

--monitoring_intervals receive more human-friendly format, so you can do
'--monitoring_intervals 100ms 1s 2s'.

> 
> $ # damon report
> $sudo ./damo/damo report access --snapshot_damos_filter reject none \
> hugepage_size 2MiB 2MiB

The --snapshot_damos_filter option means you want to make folios that not
having size 2 MiB not passed by the filter.  You can ask same thing in more
intuitive way, like below.

    --snapshot_damos_filter allow hugepage_size 2MiB 2MiB

> heatmap:
> # min/max temperatures: -900,000,000, 100,002,000, column size: 136.564 MiB

checkpatch.pl gives me below warning:

    WARNING: Commit log lines starting with '#' are dropped by git as comments

I'd suggest adding four spaces prefix to quoted command outputs like this.

> intervals: sample 100 ms aggr 1 s (max access hz 10)
> # damos filters (df): reject none hugepage_size [2.000 MiB, 2.000 MiB]
> df-pass:
> # min/max temperatures: -663,075,528, 100,002,000, column size: 128.037 MiB
> 0   addr 86.082 TiB   size 682.039 MiB access 0 hz   age 9 s           df-passed 0 B
> 1   addr 127.225 TiB  size 466.039 MiB access 1.000 hz age 0 ns          df-passed 468.000 MiB
[...]
> memory bw estimate: 3.615 GiB per second  df-passed: 3.615 GiB per second
> total size: 10.669 GiB  df-passed 10.000 GiB
> record DAMON intervals: sample 100 ms, aggr 1 s
> 
> $ # damon report again
> $sudo ./damo/damo report access --snapshot_damos_filter reject none \
> hugepage_size 2MiB 2MiB
> heatmap:
> # min/max temperatures: -1,100,000,000, 300,001,000, column size: 136.564 MiB
> intervals: sample 100 ms aggr 1 s (max access hz 10)
> # damos filters (df): reject none hugepage_size [2.000 MiB, 2.000 MiB]
> df-pass:
> # min/max temperatures: -800,000,000, 300,001,000, column size: 128.037 MiB
> 0   addr 86.082 TiB   size 682.039 MiB access 0 hz   age 11 s          df-passed 0 B
> 1   addr 127.225 TiB  size 10.355 MiB  access 1.000 hz age 0 ns          df-passed 12.000 MiB
> 2   addr 127.225 TiB  size 93.207 MiB  access 1.000 hz age 0 ns          df-passed 92.000 MiB
> 3   addr 127.225 TiB  size 414.262 MiB access 1.000 hz age 0 ns          df-passed 414.000 MiB
> 4   addr 127.225 TiB  size 706.695 MiB access 1.000 hz age 3 s           df-passed 708.000 MiB
> 5   addr 127.226 TiB  size 78.523 MiB  access 1.000 hz age 3 s           df-passed 78.000 MiB
[...]
> total size: 10.669 GiB  df-passed 10.000 GiB
> record DAMON intervals: sample 100 ms, aggr 1 s
> 
> As you can see the total df-passed region is 10GiB and the hot region
> moves as the seq read keeps going
> 
> PanJason (2):
>   mm/damon: Move invalid folio and has filter to ops-common
>   mm/damon: Add damos_stat support for vaddr

The changes look good overall, though I left a few comments for formatting and
unnecessary folio references that inherited from my original sin.  Looking
forward to more discussions and next version of this great patch series!


Thanks,
SJ

[...]
