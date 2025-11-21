Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D25157A5A
	for <damon@lists.linux.dev>; Fri, 21 Nov 2025 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692030; cv=none; b=uuONfc/ielrsNMMu0QzhpV/bE87Fk85GvASzDYFP9oAe51ONWo8fw7a1vx1xiW603WnUkwNDVvF5n5NGsaqWk52ykD8YiPjDMddtmLu6+gnHs9S+XYVkxkiqj/aARbCwm2/lANfIzP1rAm+95LxES3fm5t3NlCDZ9Gg7PUf3AS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692030; c=relaxed/simple;
	bh=mOd3L+VzE7HN86KMia2o3aoHwwJymju7EmznX6a9bBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLkU7FL0kgoRWB7JJviQNtHPAX1tnc1/3JCEvJEtmvteYMd0edPXvyeiQfs5mQk0LBcWScDdSI3q6YkJsrlACQJ8tYr9OHTLmn7JrxKYROA6qMIPT9sxcXASndE6zJ75i7D5cPLJQX460ekG7Z24QWpyKxkdjHH+WeHqPH0Shy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFoLdmQy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFoLdmQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4F8C4CEF1;
	Fri, 21 Nov 2025 02:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763692026;
	bh=mOd3L+VzE7HN86KMia2o3aoHwwJymju7EmznX6a9bBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFoLdmQybPjhFTl9NKDE3GA9XyRBFiDPFSm5OkaFO7L3719i5FOGXceWpqR540Szj
	 fqUhT70IKEFMzCUB8egzkyky3L5BCTtD/FIfwe9MAZ0kxcQOohwcCUrlWR7RZSj6V1
	 et76iFksUNpSzcdKXPbH7wx5Zc4QeDOQP08k/4WoBvGYMMNl6LMedDSoxvDQiPEeMu
	 25xNcGa9sk/e1bUPPuJwPR13rlY4Bo4XhCmDQ6W6xWBM9DMjMO7rqAW6+yKLjm1Xbd
	 gQsZd6fV+Uef9y2LL90egyg254zGJPPv1oYyHPRuVohx9imvG58v6wSxGzMlPyTaYG
	 glQk9d+Nd2Jmw==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	David Rientjes <rientjes@google.com>,
	kernel_team@skhynix.com,
	Davidlohr Bueso <dave@stgolabs.net>,
	Fan Ni <nifan.cxl@gmail.com>,
	Gregory Price <gourry@gourry.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Raghavendra K T <rkodsara@amd.com>,
	"Rao, Bharata Bhasker" <bharata@amd.com>,
	Wei Xu <weixugc@google.com>,
	Xuezheng Chu <xuezhengchu@huawei.com>,
	Yiannis Nikolakopoulos <yiannis@zptcorp.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [Linux Memory Hotness and Promotion] Notes from October 23, 2025
Date: Thu, 20 Nov 2025 18:27:02 -0800
Message-ID: <20251121022703.134685-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <98c0907c-0435-45d2-bd68-e97598b79d0e@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Nov 2025 20:36:59 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SJ, David, Ravi and all,
> 
> On 11/14/2025 10:42 AM, SeongJae Park wrote:
[...]
> > The memory capacity extension solution of HMSDK [1], which is developed by SK
> > Hynix, is one good example.  To my understanding (please correct me if I'm
> > wrong), HMSDK is providing separate solutions for bandwidth and capacity
> > expansions.  The user should first understand whether their workload is
> > bandwidth-hungry or capacity-hungry, and select a proper solution.  I suspect
> > the concern from Ravi was one of the reasons.
> 
> Yeah, your understanding is correct in HMSDK cases.

Thank you for confirming!

> 
> > I also recently developed a DAMON-based memory tiering approach [2] that
> > implementing the main idea of TPP [3]: promoting and demoting hot and cold
> > pages aiming a level of the faster node's space utilization.  I didn't see the
> > bandwidth issue from my simple tests of it, but I think the very same problem
> > can be applied to both DAMON-based approach and the original TPP
> > implementation.
> > 
> >>
> >> Ravi suggested adaptive interleaving of memory to optimize both bandwidth
> >> and capacity utilization.  He suggested an approach of a migrator in
> >> kernel space and a calibrator in userspace.  The calibrator would monitor
> >> system bandwidth utilization and, using different weights, determine the
> >> optimal weights for interleaving the hot pages for the highest bandwidth.
> 
> I also think that monitoring bandwidth makes sense.  We recently released a
> tool called bwprof for bandwidth recording and monitoring based on intel pcm.
> https://github.com/skhynix/hmsdk/blob/hmsdk-v4.0/tools/bwprof/bwprof.cc
> 
> This tool can be slightly changed to monitor bandwidth and write it to some
> sysfs interface knobs for this purpose.

Thank you for introducing the tool, I think that can be useful for not only
this case but also general investigations and optimizations of this kind of
memory systems.

> 
> >> If bandwidth saturation is not hit, only cold pages get demoted.  The
> >> migrator reads the target interleave ratio and rearrange the hot pages
> >> from the calibrator and demotes cold pages to the target node.  Currently
> >> this uses DAMOS policies, Migrate_hot and Migrate_cold.
> > 
> > This implementation makes sense to me, especially if the aimed use case is for
> > specific virtual address spaces.
> 
> I think the current issues of adaptive weighted interleave are as follows.
> 1. The adaptive interleaving only works for virtual address mode.

This is true.  But I don't really think this is an issue, since I found no
clear physical address mode interleaving use case.  Since we have clear use
case of virtual mode DAMOS-based interleaving, and I heard no problem from the
use case, I think "all is well".

By the way, interleaving in this context is somewhat confusing to me.
Technically speaking it is DAMOS_MIGRATE_{HOT,COLD} towards multiple
destination nodes with different weights.  And how it should be implemented on
physical address space (whether to decide the migration target node of each
page based on its physical address or its virtual address) was discussed on the
patch series for the multiple migration destination node, but we didn't find
good answer so far.  That's one of the reasons why physical mode
DAMOS-migration to multiple destination nodes is not yet supported.

I understand you are saying it would be nice if Ravi's general idea (optimizing
both bandwidth and capacity) can be implemented for not only virtual address
space but also for physical address space, since it would be easier for
sysadmins?  I agree if so.  Please correct me if I'm getting you wrong, though.

> 2. It scans the entire pages and redistributes them based on the given weight
>     ratios so it limits the general usage as of now.

I think it depends on the detailed usage.  In this specific use case, to my
understanding (correct me if I'm wrong, Ravi), the user-space tool applies
interleaving (or, DAMOS_MIGRATE_HOT to multiple destination nodes) only for
hot pages.  Hence the scanning for interleaving will be executed only for
DAMON-found hot pages.  Also the users may use DAMOS quota or similar features
to further tune the overhead.

Maybe my humble edit of the original mail made you be confused about Ravi's
implementation details?  Sorry if that's the case.

> 
> > Nevertheless, if a physical address space
> > based version is also an option, I think there could be yet another way to
> > achive the goal (optimizing both bandwidth and capacity).
> 
> 3. As mentioned above, having physical address mode is needed, but it makes
>     scanning the entire physical address space and redistribute them and it
>     might require too much overhead in practice.

Same to my comment to above reply to your second point, I think the overhead
could be controlled by adjusting the target page hotness and/or DAMOS quota.
Or, I might misreading your opinion.  Please feel free to correct it in the
case.

Anyway, my idea is not very different from Ravi's one.  It is just a more
simply re-phrased version of it.  In essence, I only changed the word
'interleave', which is not very clear its behavir on physical address to me, to
'migrate_hot' and gave more concrete example using DAMON user-space tool
example commands.

> 
> > My idea is tweaking TPP idea a little bit: migrate pages among NUMA nodees
> > aiming a level of both space and bandwidth utilization of the faster (e.g.,
> > DRAM) node.  In more detail, do the hot pages promotion and cold pages
> > demotions for the target level of faster node space utilization, same to the
> > original TPP idea.  But, stop the hot page promotions if the memory bandwidth
> > consumption of the faster node exceeds a level.  In the case, instead, start
> > demoting _hot_ pages until the memory bandwidth consumption on the faster node
> > decreases below the limit level.
[...]
> As I mentioned at the top of this mail, I think this work makes sense in theory

Glad to get publicly confirmed I'm not the one who sees what I see :D

> but would like to find some practical workloads that can get benefits from this
> work.  It would be grateful if someone can share practical use cases in large
> scale memory systems.

Fully agreed.  Buildable code is much better than words, and test results are
even better than such code.

Nevertheless, I have no good answer for the practical use cases of my idea, for
now.  I even have no plan to find it by myself at the moment, mainly because I
don't have CXL memory to test, for now.  So please don't be blocked by me.  I
will be more than happy to help for any chance though, as always :)


Thanks,
SJ

[...]
