Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0A2F34
	for <damon@lists.linux.dev>; Sun, 29 May 2022 19:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B795C385A9;
	Sun, 29 May 2022 19:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653854055;
	bh=U4WtBUQqmLwSPaS3Q2b7mS+kiwzqod+0hKXdt5OYVM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=USDJzomqa66MUR3tvEUYYJUElO9/5/WTcd/3nLKuVeXlAGEmO7r+w0GQcxlcqUhsh
	 Dlc0zjxpxKfPKtBaXtIcUgNuq8UQVfFoj1OvjWBDesEYbByHSsYd3f34kM3SEVcR+0
	 UU92bjEYjBRFlNe7IkZt2Nf4mE2o/zDSGkGJt6oCNhsLr8q0olbL8flzPscN2MdY9S
	 Wm7vXHTXJA8wW/Cg1wfKazTSo6FLV9mGYAt5uGrDvp51xndjDyFE5bxVESPsRwkhn2
	 WCqIYgkUvIQNE5g3agznBMs1Nj9ugbV0fIbujNz9tk7/mz43809ijl041/f0j0ifTe
	 1Ed6fhfVBALcg==
From: SeongJae Park <sj@kernel.org>
To: sj@kernel.org
Cc: Barry Song <21cnbao@gmail.com>,
	"Rongwei Wang" <rongwei.wang@linux.alibaba.com>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Matthew Wilcox" <willy@infradead.org>,
	shuah@kernel.org,
	brendanhiggins@google.com,
	foersleo@amazon.de,
	sieberf@amazon.com,
	"Shakeel Butt" <shakeelb@google.com>,
	sjpark@amazon.de,
	tuhailong@gmail.com,
	"Song Jiang" <sjiang88@gmail.com>,
	=?UTF-8?q?=E5=BC=A0=E8=AF=97=E6=98=8E=28Simon=20Zhang=29?= <zhangshiming@oppo.com>,
	=?UTF-8?q?=E6=9D=8E=E5=9F=B9=E9=94=8B=28wink=29?= <lipeifeng@oppo.com>,
	xhao@linux.alibaba.com,
	damon@lists.linux.dev
Subject: Re: DAMON VA regions don't split on an large Android APP
Date: Sun, 29 May 2022 19:54:11 +0000
Message-Id: <20220529195411.102379-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427175049.50057-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Apr 2022 17:50:49 +0000 sj@kernel.org wrote:

> Hello Rongwei and Barry,
> 
> On Wed, 27 Apr 2022 19:44:23 +1200 Barry Song <21cnbao@gmail.com> wrote:
> 
> > On Wed, Apr 27, 2022 at 6:56 PM Rongwei Wang
> > <rongwei.wang@linux.alibaba.com> wrote:
> > >
> > >
> > >
> > > On 4/27/22 7:19 AM, Barry Song wrote:
[...]
> > 
> > I guess the cause might be:
> > in case a region is very big like 10GiB, we have only 1MiB hot pages
> > in this large region.
> > damon will randomly pick one page to sample, but the page has only
> > 1MiB/10GiB, thus
> > less than 1/10000 chance to hit the hot 1MiB. so probably we need
> > 10000 sample periods
> > to hit the hot 1MiB in order to split this large region?
> > 
> > @SeongJae, please correct me if I am wrong.
> 
> I think your theory makes sense.  There was a similar concern, so we made DAMON
> to split regions into 3 sub-regions when we don't see advance[1].  My current
> rough idea for improving DAMON accuracy is making it more aggressive while
> keeping the monitoring overhead low.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/tree/mm/damon/core.c?h=damon/next-2022-04-21-08-31-on-v5.18-rc3-mmots-2022-04-20-17-37#n1053
> 
> > 
> > >
> > > I'm not sure whether sets init_regions can deal with the above problem,
> > > or dynamic choose one or limited number VMA to monitor.
> > >
> > 
> > I won't set a limited number of VMA as this will make the damon too hard to use
> > as nobody wants to make such complex operations, especially an Android
> > app might have more than 8000 VMAs.
> > 
> > I agree init_regions might be the right place to enhance the situation.
> 
> 'init_regions' has developed for the purpose, where user space knows some good
> information for starting point of the regions adjustment, and thus want to hint
> DAMON.  Nevertheless, it might not work as expected, because DAMON
> automatically updates the target regions to cover all VMAs as much as it can.
> I have posted a patchset for the use case yesterday[1].
> 
> [1] https://lore.kernel.org/linux-mm/20220426231750.48822-1-sj@kernel.org/

FWIW, the patchset for the fixed virtual address space ranges monitoring has
merged in the mainline[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=98931dd95fd489fcbfa97da563505a6f071d7c77


Thanks,
SJ

[...]
