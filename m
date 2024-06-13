Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2579C8C7;
	Thu, 13 Jun 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287030; cv=none; b=s1YrFMJLburTTKcC5Ga4au9up11V1ALPnmQ4JVS6C4QmE/Gazx13+3G7OOugGG99qpTr+GREAyDJ6gm0mFxsN2w9xnwp0H6Nr/5ceI3D/UQRSG+o+s+rx18Xd7Nja0ov1GxJvHPhbOp+ggb1+6LHHDSAZgL/hQfydmQb3uutXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287030; c=relaxed/simple;
	bh=ObQi8NQBz2Y2ivnMx8cOhGMCyJoPmV4ZTrlIbXTx9Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=DQtBCPko9EdQ+eEg8zQWnd80BvVHwTYpGnuEOTYqNdicrCoeg6mFiCcqIAqWMijTyEZ5FjCGytwNc7J5kK30KtQiKy7F7TRuKgvMOIWIAd89NYkEMkG/KLiNbttG0fwNwzLIq8xU784m6p5v/NZ2aSd027dswkzUwtxbsNWI7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0b1XjhM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0b1XjhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2862C32786;
	Thu, 13 Jun 2024 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718287030;
	bh=ObQi8NQBz2Y2ivnMx8cOhGMCyJoPmV4ZTrlIbXTx9Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=a0b1XjhMsfH4Sqk6NUmSEhBElTllzhWkO6RxuD2Xx5kDWbfnL+BwAMOc5tYgTN0fk
	 cYM6R110WMdmH9pcG6X7bjdanPK1g9NAAnTplpB9AocDh5qervqUNf6ofnrCgrFolI
	 HIFqQPvBgeaRUzUtU6gyzUnLpEtlN/gzREeo+f3ZNArOm2l6Jxr54LXSCxew7+4Jc9
	 Rr+3vnFfRSf5CrxmlW4ATJibSy1WE8zRc4BhaBjrZQ993yZTyijs6NZT7vuwRffkYz
	 r5eQgHxIbDCXAB8Y3FJb96vVpvdSwJ7CWsvk+mO8tsDaXRNZCBZdh1l2gsHW05364M
	 lYf+sflfW8bpw==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH 0/8] DAMON based tiered memory management for CXL memory
Date: Thu, 13 Jun 2024 06:56:49 -0700
Message-Id: <20240613135649.26707-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240613132730.650-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

On Thu, 13 Jun 2024 22:27:26 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> On Thu, 13 Jun 2024 22:17:31 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> > posted at [1].
> >
> > It says there is no implementation of the demote/promote DAMOS action
> > are made.  This patch series is about its implementation for physical
> > address space so that this scheme can be applied in system wide level.
> >
> > Changes from RFC v4:
> > https://lore.kernel.org/20240512175447.75943-1-sj@kernel.org
> >   1. Add usage and design documents
> >   2. Rename alloc_demote_folio to alloc_migrate_folio
> >   3. Add evaluation results with "demotion_enabled" true
> >   4. Rebase based on v6.10-rc3
> 
> Sorry for making confusion, I didn't add "PATCH v5" tag for this patch
> series so please ignore and see the resent one.

Thank you for clarifying this.

Nonetheless, I don't mine resetting the version number of a patchset after
dropping RFC.  Actually, I personally rather prefer resetting the version
number.  Anyway, I don't care that much.  Please use any way that you feel more
comfortable :)  Please just keep the number monotonically increase.


Thanks,
SJ

> 
> Honggyu
