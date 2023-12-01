Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A434A9B2
	for <damon@lists.linux.dev>; Fri,  1 Dec 2023 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaBiOJUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A662BC433C8;
	Fri,  1 Dec 2023 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701451874;
	bh=wA+Ueq448VkzLDqFZSym3+gEJt7y1F440M6KTvullms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FaBiOJUwzapgllxu6aBcQv9MtKgB3w5QJQp3VFfeXWbuu7MxKNe7y713pMHoSGe/3
	 3u94ST2R/3bQjGwrRzl/NY659HngxTVBfOKQhuhkW+bzHIYayQtbnd7xmqlPCSGhpv
	 xSLkpe2yNqvSBoTd1hXtMClbyDKV6jy7hYxIhhe3HIQyqpogDPfbCEjVfnFazgnsV7
	 9LqsJU24u9FimiiUjMLeCyQlb/6dmMIfcdPoNK1rlfU5+6RSjSn8qqRjvdfutLvaVt
	 47+qclvmKRrfMS8gLsY5h4ro3KE5tFk0Bv/bVj32hfhfgzApyxbqtYQkV37Yyfw4Fc
	 gu/Uxz5UifSNA==
From: SeongJae Park <sj@kernel.org>
To: cuiyangpei <cuiyangpei@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date: Fri,  1 Dec 2023 17:31:12 +0000
Message-Id: <20231201173112.64300-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201122507.GA15806@cuiyangpei>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Cuiyangpei,

On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > Hi Cuiyangpei,
> > 
> > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > 
> > > Hi SeongJae,
> > > 
> > > We also investigated the operation schemes you mentioned, but we don't
> > > think it can fit our needs.
> > > 
> > > On android, user will open many apps and switch between these apps as
> > > needs. We hope to monitor apps' memory access only when they are on
> > > foreground and record the memory access pattern when they are switched
> > > to the background. 
> > > 
> > > When avaliable memory reaches a threshold, we will use these access
> > > patterns with some strategies to recognize those memory that will have
> > > little impact on user experience and to reclaim them proactively.  
> > > 
> > > I'm not sure I have clarified it clearly, if you still have questions
> > > on this, please let us know.
> > 
> > So, to my understanding, you expect applications may keep similar access
> > pattern when they are in foreground, but have a different, less aggressive
> > access pattern in background, and therefore reclaim memory based on the
> > foreground-access pattern, right?
> >
> 
> Different apps may have different access pattern. On android, the apps will
> join in freeze cgroup and be frozen after switch to the background. So we 
> monitor apps' memory access only when they are in foreground.

Thank you for this enlightening me :)

> > Very interesting idea, thank you for sharing!
> > 
> > Then, yes, I agree current DAMOS might not that helpful for the situation, and
> > this record feature could be useful for your case.
> > 
> > That said, do you really need full recording of the monitoring results?  If
> > not, DAMOS provides DAMOS tried regions feature[1], which allows users get the
> > monitoring results snapshot that include both frequency and recency of all
> > regions in an efficient way.  If single snapshot is not having enough
> > information for you, you could collect multiple snapshots.
> > 
> > You mentioned absence of Python on Android as a blocker of DAMOS use on the
> > previous reply[2], but DAMOS tried regions feature is not depend on tracepoints
> > or Python.
> > 
> > Of course, I think you might already surveyed it but found some problems.
> > Could you please share that in detail if so?
> > 
> DAMOS tried regions feature you mentioned is not fully applicable. It needs to
> apply schemes on regions. There is no available scheme we can use for our use
> case. What we need is to return regions with access frequency and recency to
> userspace for later use.


Thank you for the answer, I understand your concern.  One of the available
DAMOS action is 'stat'[1], which does nothing but just count the statistic.
Using DAMOS scheme for any access pattern with 'stat' action, you can extract
the access pattern via DAMOS tried regions feature of DAMON sysfs interface,
without making any unnecessary impact to the workload.

Quote from [2]:

    The expected usage of this directory is investigations of schemes' behaviors,
    and query-like efficient data access monitoring results retrievals. For the
    latter use case, in particular, users can set the action as stat and set the
    access pattern as their interested pattern that they want to query.

For example, you could

# cd /sys/kernel/mm/damon/admin
#
# # populate directories
# echo 1 > kdamonds/nr_kdamonds; echo 1 > kdamonds/0/contexts/nr_contexts;
# echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
# cd kdamonds/0/contexts/0/schemes/0
#
# # set the access pattern for any case (max as 2**64 - 1), and action as stat
# echo 0 > access_pattern/sz/min
# echo 18446744073709551615 > access_pattern/sz/max
# echo 0 > access_pattern/nr_accesses/min
# echo 18446744073709551615 > access_pattern/nr_accesses/max
# echo 0 > access_pattern/age/min
# echo 18446744073709551615 > access_pattern/age/max
# echo stat > action

And this is how DAMON user-space tool is getting the snapshot with 'damo show'
command[3].

Could this be used for your case?  Please ask any question if you have :)

[1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n
[2] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions,
[3] https://github.com/awslabs/damo/blob/next/USAGE.md#damo-show


Thanks,
SJ

> > [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions 
> > [2] https://lore.kernel.org/damon/20231129131315.GB12957@cuiyangpei/
> > 
> > 
> > Thanks,
> > SJ
> > 
> > > 
> > > Thanks.
