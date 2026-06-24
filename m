Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBF30C179;
	Wed, 24 Jun 2026 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260077; cv=none; b=gye8YusqAibpJ+ZhpgIsUwVLcY681Wwqx5u2jnByuN0HCwRpcOsKAeVlovESxZR43liCm5U2Zcy+tgEQo0+BGZk3MrFz+8eE0VWPlCmlhZG7uFtjKQIYkROJAeCw0uzL7lzhZx08LPj0BYNmCH1rH7/Cpu/uCCOSW6XJmpxWOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260077; c=relaxed/simple;
	bh=zPeIMo9OGO9MWSnACu7U007XLHjias6kwZstJVb3CvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+YEAe6IjzSpazBUA+sHaosPMAnHbYKpQFiUaiP5k3MJ6ODZ05i/l+cOe4uIlDa6LLr2AcNqNeovZBY8QRj0PV1mZdNG8oCHuMPHSAL/vXE2JBCrymzf92Fte9GnvELhmuAKmYd4X0GkdY6CLgkKu592XnxHIWNWrBwesNAbnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxhPaFGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxhPaFGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5781F000E9;
	Wed, 24 Jun 2026 00:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782260075;
	bh=SyDHUTRzyhbl3JgW6awlF0LENI6MedUpPmmBH2AA+70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZxhPaFGJIvneCPSiKZAgnT6ebQb/mknuS7UoMs6VbJICjq8f1AxNWrOJlibbvSrYA
	 1txgK1l+ul2qd3VTGjtuUlzJsDX3v9jlHwJS3ESgWtHsfyc0lWwN/2K4lJ7Gb0G2mT
	 rIeKVR/4ZoCS0UvmbWnocKEtxbYnpqumAJkUPJe5RMV6i1vvFQuCLzG1/9Mv++cp4q
	 geivMOH8PA7BkP4NkkEg/yFeLYxe/5x1aRJvz+rz83wvMdagGdx5jypSOUQlF8SRyS
	 RTQ2RGfiBvoP9m9fWNHAFyR6uGW7eBbBLbXET8GhvpI5ZnZtcQQ6hbXIhXHaO3vNEj
	 uOIf5MWU0QkRQ==
From: SeongJae Park <sj@kernel.org>
To: Zeng Heng <zengheng4@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
Date: Tue, 23 Jun 2026 17:14:24 -0700
Message-ID: <20260624001425.77489-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7d46a48c-8805-09e1-4818-807953898fb4@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Zeng,

On Tue, 23 Jun 2026 22:08:03 +0800 Zeng Heng <zengheng4@huawei.com> wrote:

> Hi Ravi,
> 
> On 2026/5/30 0:56, Ravi Jonnalagadda wrote:
> > This series introduces a vendor and PMU-agnostic substrate inside DAMON
> > that consumes hardware-sampled access reports through the standard
> > perf-event interface.  Userspace selects the PMU through sysfs (raw
> > type/config knobs), driving either Intel PEBS L3-miss sampling or AMD
> > IBS Op sampling.
> > 
> 
> [...]
> 
> > 
> > Ravi Jonnalagadda (6):
> >    mm/damon: add struct damon_perf_event{,_attr} and per-ctx perf_events
> >      list
> >    mm/damon/sysfs-sample: expose perf_events configuration via sysfs
> >    mm/damon/sysfs: install perf_events on apply
> >    mm/damon/core: per-CPU SPSC ring drain and damon_perf_event lifecycle
> >    mm/damon/vaddr: implement perf-event access check
> >    mm/damon: add damos_node_eligible_mem_bp tracepoint
> > 
> >   include/linux/damon.h        |  80 +++++
> >   include/trace/events/damon.h |  49 +++
> >   mm/damon/core.c              | 403 ++++++++++++++++++++----
> >   mm/damon/ops-common.h        |  39 +++
> >   mm/damon/sysfs-common.h      |   6 +
> >   mm/damon/sysfs-sample.c      | 579 +++++++++++++++++++++++++++++++++++
> >   mm/damon/sysfs.c             |   3 +
> >   mm/damon/vaddr.c             | 267 ++++++++++++++++
> >   8 files changed, 1370 insertions(+), 56 deletions(-)
> > 
> > 
> > base-commit: 4c8ad15abf15eb480d3ad85f902001e35465ef18
> 
> I wasn't able to apply this patch series to the linux (and linux-next)
> mainline branch, and also had trouble identifying the source of the base
> commit.
> 
> Would you mind sharing where this baseline is from?

TLDR: I pushed [1] a tree having this series applied on top of the baseline to
GitHub.  Please feel free to use it.

I think the baseline was a commit on damon/next tree [2].  Because damon/next
is continuously rebased, we cannot get the commit in a simple way.  Fortunately
the commit is still available on my local tree.  So I applied this patch series
on top of the commit and pushed [1] to a branch of DAMON kernel tree at GitHub.

Note that the branch is not guaranteed to exist there for long term.  But
hopefully this series will be merged into the mainline before that.

[1] https://github.com/damonitor/linux/tree/ravi_hw_sampled_access_reports_rfc_v1
[2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
