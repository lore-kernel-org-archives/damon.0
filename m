Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F17A23;
	Thu, 30 Jan 2025 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738208875; cv=none; b=rB+INolEPmOfJokiQEbYr1ZdaCqxSf86d65aHRS7MR2TFM9bwNzr6BlSttLMbPTSeHsCm3LtfhkV/42VJzckS9o3okm6ZLlxPq4RFhG0rtV+x3b78llfDQFYaIUW6/GB2zhlmw/GfnCoQJ6ZrQJjun+HRz+MTxGbd6v5mabowpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738208875; c=relaxed/simple;
	bh=pIkZbvbWGUeN/Ycv3ABKfmi4ASKA6ChqmpXCdQeUA34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtfdFv3zmASgQETIfj5xDM1t1SxxZMQdVB7gtrFCC/U7AtmlkDoDNBJctGSiq+FzYSVQtTHhPyOxDgPxOvQMb/LFb+B0tLlbKIceSDlcNV1kAKC/z7x8m9gfZOZiVmvT4VmG00reES5+e/Ut5iB6e2j92gAZBPYRAvyvZzu1eLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odFBvwdO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odFBvwdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA24C4CED2;
	Thu, 30 Jan 2025 03:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738208875;
	bh=pIkZbvbWGUeN/Ycv3ABKfmi4ASKA6ChqmpXCdQeUA34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odFBvwdOAAzBJZk8fcRUPX7qQ3QWNXoz08ePhvdLVtcc/ajobd3vOdM+saC1Fsmon
	 SFN0bGuySg7U9jqD134DY3goAJJPPQDTiTMVoQrolcZvcF/1bVqua/IDXAhbDJu/o9
	 Bvwe55RPaOK+DdfnNVtxEW7QoxVXo2tD905T+PFs5p58BjuLeiaiCxhDWqsFaHncGS
	 Z4JkQOGX1ZmAOsL0OXjrXmOpAxA9kifl1Qb8h9QiokWbAck7voR+jAd16X2pIop924
	 uDEZpNvIteqSbkgm29EV3uOlHVCSRl8on3uoGgorLUSVMdG9w4FghbCFNwu/5QRfHL
	 30jyhX1nEPfVg==
From: SeongJae Park <sj@kernel.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Raghavendra K T <raghavendra.kt@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of Future
Date: Wed, 29 Jan 2025 19:47:49 -0800
Message-Id: <20250130034749.49417-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAJj2-QF1y1XNRYy9sT5c5=pi20+67Duf9B2Amatnu01HLmw06Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yuanchu,

On Wed, 29 Jan 2025 18:15:08 -0800 Yuanchu Xie <yuanchu@google.com> wrote:

> On Mon, Jan 13, 2025 at 7:06 PM Gregory Price <gourry@gourry.net> wrote:
> > 5) Scarce resources
> >
> >    We need to be careful not to consume excessive amounts of resources
> >    in an attempt to track all these identifying mechanisms.  Even 1 byte
> >    per folio is 256MB on a 1TB machine.  This gets out of hand quick.
> >
> >    With task-work, I was able to add no additional resource consumption,
> >    but deferring to a fully async scenario and needing to track things
> >    like last-accessing CPU, timestamps, and etc.
> >
> >    We'll need to examine this closely if we decide to aggregate either
> >    of these mechanisms.
> My concern with physical address space monitoring is fragmentation. I
> ran some numbers on a few prod machines. Grouping by regions with the
> same memcg and ignoring any unmapped memory to be generous, machines
> with higher utilization can have a region/total pages ratio of ~40%,
> and even those with lower utilization (<50%) can also reach 20%.
> Accurately tracking these regions would require quite the region
> metadata, on the order of GBs.

You're right, if we need page level accuracy access monitoring and want to use
DAMON with its regions based mechanism for that, the memory overhead of
damon_region could be high.  That's mainly because DAMON's regions-based
mechanism has not designed for such usage.  It is more for a best-effort
tradeoff between the overhead and the accuracy.

Regions-based mechanism is not necessarily the only mechanism of future DAMON,
though.  If there are use cases that regions-based best-effort accuracy cannot
be used while exactly the page level accuracy is really required, we can think
about optimizing regions based mechanism or developing new one.

But, IMHO, the page level accurate access pattern is not always essential.  In
many cases, being able to distinguish some amount of regions agains others
based on access pattern is practical enough.  Indeed, DAMON has been used on
real-world products with physical address based moitoring mode for years with
no significant problem.  Also I think physical address space based monitoring
results[1] on a real server workload that I shared recently seems not very bad.

Of course your use case could be different from what I have experienced so far.
I'm curious if and why you really need page level accuracy.

[1] https://lore.kernel.org/20250110185232.54907-3-sj@kernel.org


Thanks,
SJ
