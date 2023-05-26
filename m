Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337EE24E96
	for <damon@lists.linux.dev>; Fri, 26 May 2023 19:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21280C433D2;
	Fri, 26 May 2023 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685129723;
	bh=hrXnPJh/IHKl7DDBAAfTeqFjAiG1/nHeuB1mCrXtIxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mw2R36mU/rvchgfsAwGQYlRZa8+xIa3vvVi9pcrJ8B0+yKO7PcH8+WFZDFc52UCWd
	 CPriTpOkoyx/RKHKD9TI6fubLQK5kngHwkKitATbfmUTZokHjsDmDYMYBD9z8FvOyy
	 /mUN87nG9OjpksX8kRieuRsfJp2Jy+olXVFOJoVXq200WQk923ycsVTe8LwSTiAp9j
	 Zmz5Th4Qw42sYKzNnPBWoFN7DlX6ukrhPHwkj6Dfg0FXgo7+Q34xPTc9KICMSH3CXu
	 4hr+I+dXx11QU0gDut72zqPcNGpd2ZdvexAB1z4zhP4L1V7zhN/9K7IRcZXdLJ5e2t
	 llEtA/HWdqjTQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	syzbot <syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [damon?] divide error in damon_set_attrs
Date: Fri, 26 May 2023 19:35:21 +0000
Message-Id: <20230526193521.162787-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526185409.92039-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 May 2023 18:54:09 +0000 SeongJae Park <sj@kernel.org> wrote:

[...]
> > > 
> > > divide error: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 1 PID: 13527 Comm: syz-executor.1 Not tainted 6.4.0-rc3-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
> > > RIP: 0010:damon_nr_accesses_to_accesses_bp mm/damon/core.c:491 [inline]
> > > RIP: 0010:damon_nr_accesses_for_new_attrs mm/damon/core.c:497 [inline]
> > > RIP: 0010:damon_update_monitoring_result mm/damon/core.c:506 [inline]
> > > RIP: 0010:damon_update_monitoring_results mm/damon/core.c:534 [inline]
> > > RIP: 0010:damon_set_attrs+0x224/0x460 mm/damon/core.c:555
> 
> Thank you for finding and reporting this bug!
> 
> The code of the problem is as below:
> 
>     /* convert nr_accesses to access ratio in bp (per 10,000) */
>     static unsigned int damon_nr_accesses_to_accesses_bp(
>                     unsigned int nr_accesses, struct damon_attrs *attrs)
>     {
>             unsigned int max_nr_accesses =
>                     attrs->aggr_interval / attrs->sample_interval;
>     
>             return nr_accesses * 10000 / max_nr_accesses;
>     }
> 
> The problem can happen when 'aggr_interval' is smaller than 'sample_interval',
> because 'max_nr_accesses' becomes zero in the case, and resulting in divide by
> zero.
> 
> Same problem is in damon_accesses_bp_to_nr_accesses().

This is not true, because the function doesn't divide something by
'max_nr_acceses'.  I was confused, sorry.


Thanks,
SJ

[...]
