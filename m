Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F703450F2;
	Tue, 19 Aug 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584839; cv=none; b=Vz9jG9pehu9Ddw6qZu7X8tsV9lujzMeYhctwQ5SxgnZsfDC6Yfo5L2Hyk7sFNf7gBvc1jZbYtT0SWFPxWpfASLrsKNYfw0YsgvuShRfI0iJ/vhSpgXgOx/SNaSsOKJklt3iAzE8pnqmngTLHiAwwNlZH6bZ/utvui/+caWd+GUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584839; c=relaxed/simple;
	bh=tGUbKm3vG28QqoO03TcU7moMB1ToJqITXHRyu+HZ6Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojK2ZGJ4UQQDiKSVBn8D/HGzDJFIshm1C6bhGGccO4uLnTmIeL5Bg10UOUW/02THdudgzFkLsK5J2hmbNwgOR247Ny6gvFN/WQ+HpiOrZV0RR+3TnQX5PU9E0l3RDeziIr/1G9X9aZ0cKs01UZid6fbDqiT8mqTZIaI4Hz0+5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkgfDrNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkgfDrNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEE6C4CEF4;
	Tue, 19 Aug 2025 06:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755584839;
	bh=tGUbKm3vG28QqoO03TcU7moMB1ToJqITXHRyu+HZ6Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkgfDrNmCI5m5MQ8CJzeZ08WPXo/5gPhRPxCM+K7lrqDUFlxakHVjU2jRvxoaIlxj
	 ZExmMnzJfog0a4Pkl1WfvE96ZftRxMHFKNLI/cDiyvobWob5qku54Pe9946T5dftxJ
	 r/EBAfF0YP7b3gBrIHYKx0W9/IqukyCV9esHSUKwataXfHqbcESRuYAHxEcIMCZFsT
	 uQhAhavZtZ3DfVtcFM5WmRD/M3uvfk0g6pDxS/+IhNZR75FhI5iDqSYxEdSMfOoajV
	 gczSa97Kdw0UYRebLnLMEP51gh3KVH+Kwqs0pSCYOb1oCwQiTAMhu6wb+0kHtAqqMN
	 dThBD1Mpp6r3w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 05/16] mm/damon/paddr: support addr_unit for MIGRATE_{HOT,COLD}
Date: Mon, 18 Aug 2025 23:27:17 -0700
Message-Id: <20250819062717.40168-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819062116.39593-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 23:21:16 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Quanmin,
> 
> On Wed, 13 Aug 2025 13:06:55 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> 
> > From: SeongJae Park <sj@kernel.org>
> > 
> > Add support of addr_unit for DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD
> > action handling from the DAMOS operation implementation for the physical
> > address space.
> 
> As I suggested on another reply[1], please squash attaching patch to this one
> when you post next version of this series.
> 
> [1] https://lore.kernel.org/0001-mm-damon-paddr-set-DAMOS_PAGEOUT-stat-in-core-addres.patch

Sorry for the above wrong link.  Plese use
https://lore.kernel.org/20250813170806.6251-1-sj@kernel.org instead.


Thanks,
SJ

[...]
