Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762E4C6D;
	Thu, 18 Jun 2026 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795296; cv=none; b=F4hQMh8fr1vwkdGHVZwuNWgQnODz96Q5BGakwq0bBL09GMk6LfrAvPXvIARTzqbW7WnC2X6w7xCEwvi99nE/9y5f1c/d6lAiczzKsJM6ihegm2p/23AsOYMBk0KzxM4JET/nCeHt+M67kyetodP3F3nJHU3j2AZrjDn5zAw0+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795296; c=relaxed/simple;
	bh=BxGB8QZuCL3ZdCOfyutbhbQ/Be+1aR6s86mm+SrOt+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ce6yUCIWEYi9qc/DpU80bhF9QERnYDkuIYx6Xi+UpcCvcwH5/ByJaS57akXmTQ8wHbpp9A+keWeB3bsuEJ0LJZCpe9Nj7PppDI27JXjGPHeiJYqzJ6TcSSHaExVy41xeq0EZdXm/mamHOXzsnGnCdzLyQ/rSfi1bNsILXHgkfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APXAJZyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APXAJZyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5E31F000E9;
	Thu, 18 Jun 2026 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795295;
	bh=ADzzepRVWs1vwXTC05UkLfdDEKwQsxVaPIoo0M8ryYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=APXAJZyHpcW+BxdLSoyVb7v4ZEHR1RrgW3ugOQFYVMEVErvF1fi22XxKELIMNa3i9
	 mnTLYHuchwHCqdJTBBhUMut/nd1TnVuXIqeJ+JGHWmuBOr5MBjnVVFtbEj/EqijHYw
	 Rs64F/MvMZU9ECYGrrP1uQgMlhc8IO4SPoRW9vF5IpBZjOzygrWpSweBAbmUu2lpt5
	 KVI9pUCeLQ2DKxCi6ySH6ODqzxA/JtIc46EMeT/osmjYG57DmHLB6OsmfNsiB+/1Th
	 xLN2iFTrFq+306Tpe15c36vNz5Ibst3rS1BR2MUcXQDtI9BUCB+j/KCvPNtGEEpIF+
	 /5AV10/8DvOHQ==
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
Subject: Re: [PATCH v1 2/3] mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
Date: Thu, 18 Jun 2026 08:08:05 -0700
Message-ID: <20260618150806.4633-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4cefc3af-67eb-4bde-89f6-8c3ea3c93588@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Jun 2026 17:59:36 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 6/18/2026 5:57 PM, SeongJae Park wrote:
> > On Thu, 18 Jun 2026 14:51:42 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> Hi SJ,
> >>
> >> On 6/18/2026 3:16 AM, SeongJae Park wrote:
> >>> On Tue, 16 Jun 2026 21:04:52 -0700 SeongJae Park <sj@kernel.org> wrote:
> >>>
> >>>> On Tue, 16 Jun 2026 15:03:15 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> >>>>
> >>>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>>>>
> >>>>> This patch introduces a new DAMON module (SAMPLE_DAMON_HPAGE)
> >>>>> which collapses hot regions into huge pages.
> >>>
> >>> As I mentioned on the previous version of this series, this sample module looks
> >>> much better than the initial shape to my humble eyes.  Much smaller and
> >>> simpler.  I really appreciate Asier's efforts on making this.
> >>>
> >>> However... I was asking myself if this module is really needed last night, and
> >>> still got not real good and confident answer.
> >>>
> >>> After all, this is a sample module.  The purpose is to show sample code thhat
> >>> helps people understanding how they can use DAMON API.  Maybe we can argue this
> >>> module can be helpful at understanding how DAMOS quota goal can be used.  But,
> >>> mtier is already showing that.  So I cannot say what new advantage this module
> >>> is really bringing.
> >> You are right, the main goal was to show how this quota goal can be used. 
> >>> Meanwhile, this patch adds ~200 lines of code.  It is a very small and simple
> >>> sample module, but still we should maintain it.  I, to be honest, getting
> >>> little bit concerned about the maintenance overhead now.
> >> I understand your concerns. I know code need maintenance, and DAMON is already
> >> growing significantly.
> >>> So, if Asier has a good reason to add this module that I'm missing, I'd like to
> >>> humbly ask to consider dropping of this module for now.  I'm so sorry for
> >>> raising this concern this late.  But, Asier, may I ask what do you think?
> >> So, are you suggesting to drop the module and upstreaming only the DAMOS quota
> >> goal stuff?> 
> > 
> > Yes, if you don't mind.
> Sure. I will do it a bit later.

Thank you for kindly accepting my humble suggestion, Asier!

> 
> Thanks a lot for your help reviewing the code so far.

I sincerely appreciate your contributions, too.


Thanks,
SJ

[...]
