Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB51DFD1;
	Thu,  2 Jan 2025 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841083; cv=none; b=HGCtJs1yOgLEW1wRZFsklLvX8le6RhX4d+aPtt6RalVJVRxQ4oSYJrXh972efKDGuqaQNwKrkVb7NDLGMsr14TV7NG5KNm0RAdgqAC+IG+h3caUREpclPBk6xmbl9VTmobu/5YyMGKd8oxiHfZdlfDoxB9lSU5+vVo/zt8JpiiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841083; c=relaxed/simple;
	bh=ubiE23LiyEg/BoVxOOBGn54QlSuEnb4AEJKXg6JsnLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6iPe7DTDc4+CzAmQ8ZeJrkyn6LG+8ftLXPDjTyQlSJtnZf/kW4SCrUmAJt/YODyUR/m0AEC367WuyhkpP3JUpdurGcVLhA8E5ALHO2HaH7ifa6xzua+TcCaxRSCdGTfKOTaMqrtoHZzaLCTwJGGUQc6DNCfvIWD4JnCFwLAI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+ewexxZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+ewexxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE69C4CED0;
	Thu,  2 Jan 2025 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735841083;
	bh=ubiE23LiyEg/BoVxOOBGn54QlSuEnb4AEJKXg6JsnLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+ewexxZq+ooDUyNDi9k2uUo+vxhDfwJVGOzKFDKyu3aC+03hw34dZwLf/bH9XBEY
	 nbely0luL7bgb0/iS8u6oOAa8hwt53wYLfNOCxIvuU8unhF3kUTbMK06OZoUQ/vcqB
	 VDI/4MuzquOKDOGO/FjOVLL7ew0anZutmHnnGHmGgmnetA6LNEwipiWUFkdl3hauTD
	 pOk6J2LlJeKFCc7sJc6G3mKRWvmLkMj35Rke5931vS132QHF+P/tSBYB5Aw/PU/MX1
	 R1dFiXk26PK7n/87G+D0Cz83m13YCYqxxBUXVKaqfPFHKKCLSJaaqkKVCppOhtxS1R
	 bcr/dTiuraYZQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Gregory Price <gourry@gourry.net>,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Raghavendra K T <raghavendra.kt@amd.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of Future
Date: Thu,  2 Jan 2025 10:04:39 -0800
Message-Id: <20250102180439.45429-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250102180019.45333-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Jan 2025 10:00:19 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 2 Jan 2025 10:22:14 -0500 Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Jan 02, 2025 at 04:09:38AM +0000, Matthew Wilcox wrote:
> > > On Wed, Jan 01, 2025 at 02:20:39PM -0800, SeongJae Park wrote:
> > > > Hi all,
> > > > 
> > > > 
> > > > I find a few interesting and promising projects that aim to do efficient access
> > > > pattern-aware memory management of near future, including below (alphabetically
> > > > sorted).
> > > > 
> > > > - CXL hotness monitoring unit
> > > >   (https://lore.kernel.org/20241121101845.1815660-1-Jonathan.Cameron@huawei.com)
> > > > - Memory tiering fainess by per-cgroup control of promotion and demotion
> > > >   (https://lore.kernel.org/20241108190152.3587484-1-kaiyang2@cs.cmu.edu)
> > > > - Promotion of unmapped page cache folios
> > > >   (https://lore.kernel.org/20241210213744.2968-1-gourry@gourry.net)
> > > 
> > > I'm not sure how DAMON can help with this one.  As I understand DAMON,
> > > it monitors accesses to user addresses.  This patchset is trying to solve
> > > the problem for file pages which aren't mapped to userspace at all.
> > > ie only accessed through read() and write().
> > 
> > DAMON can monitor physical addresses to, though the mechanism is
> > different.
> 
> Thank you for answering this, Gregory.  As Gregory explained, users can use
> physical address monitoring mode of DAMON for this.  For unmapped pages, DAMON
> sets and reads PG_idle to check if it is accessed or not.  Since PG_idle is
> respected by read() and write() use case to my understanding, DAMON should be
> able to check accesses to unmapped pages.
> 
> > I haven't assessed this as a solution, yet.
> 
> To quickly see this, I ran below simple test.
[...]
> the point of this test is that DAMON at least somehow react to accesses for
> unmapped pages.

Forgot clarifying this point, sorry.  My test shows DAMON can detect accesses
to unmapped pages, but not asseses if it is feasible as the unmapped pages
promotion solution.  More works and discussions would be needed for that.


Thanks,
SJ

[...]
