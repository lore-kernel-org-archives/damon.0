Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB477A59;
	Fri, 20 Jun 2025 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750450920; cv=none; b=GZWJgwcjXwSaoijrZmdzMl8MS1VExudDfhnQ/i47pkP5BGYch0AnPk6PSyqX54KUGBjAu7JvRZ1Nn4jF66RhJRlYUhqWCwJoGLmCB01hgtCxV0bj53h+EL0zfVZzQ8k3oOtpvUZ8KD5BvUcycJa+afhKe6du4HPjZcTXQ//XgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750450920; c=relaxed/simple;
	bh=DSJoF1mmIlt0f+sq2JpaTh+bEPUAbP03ftsUdi/PiDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klUIJDgNscaAlZxgMJ0OHFfKyh1VBNLoKg/GKvms2R/G1XuBJa2RC8EyC1PoP9uBA4/C6L8Wd/5jlLmr8WdhAJn7RqK40fYYIk5KEnzArqm4FsIqAC8SE3M03OkCFGv4rb0OSHaGOqmLU268SgSou6nG3nGFyBs+K+ZqqnrzzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0lDXwoa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0lDXwoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C62AC4CEE3;
	Fri, 20 Jun 2025 20:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750450918;
	bh=DSJoF1mmIlt0f+sq2JpaTh+bEPUAbP03ftsUdi/PiDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0lDXwoaLY7y3wa9IueyszW7SzAJtLyNASt+zI7oSHK4CT1+NZjjnxu1DWtqempnq
	 dsghHnhRtAgQThuHTOUqXic5oYjdEaI7EplWKGHPxO8djv9QqSMK36QYbZU0dMdYcC
	 ial/nqvMsOLe87iJw2xDVi0DkSJLXDQwLrPispU/Zu/V2lBu4CxXWZB2MSubJnechE
	 xxuCcuNEBcYKOYUNj5eiF3r43moAfLWD5zrm+5I95/NpjDpCMMKuJL1VIjxwgsaUNe
	 0CiH3ibZ2VUNQY9kqaWFOHFR/G42pg0EfJwb02121h1Pn+1ae3Uvf5CcRf2kxc6wXU
	 m+WFPO7mMp9JA==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in migrate_{hot,cold} actions
Date: Fri, 20 Jun 2025 13:21:55 -0700
Message-Id: <20250620202155.98021-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620180458.5041-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bijan,

On Fri, 20 Jun 2025 13:04:56 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

[...]
> This patch set adds the mechanism for dynamically changing how application
> data is interleaved across nodes while leaving the policy of what the
> interleave weights should be to userspace. It does this by modifying the
> migrate_{hot,cold} DAMOS actions to allow passing in a list of migration
> targets to their target_nid parameter. When this is done, the
> migrate_{hot,cold} actions will migrate pages between the specified nodes
> using the global interleave weights found at
> /sys/kernel/mm/mempolicy/weighted_interleave/node<N>. This functionality
> can be used to dynamically adjust how pages are interleaved by changing the
> global weights. When only a single migration target is passed to
> target_nid, the migrate_{hot,cold} actions will act the same as before.

This means users are required to manipulate two interfaces.  DAMON sysfs for
target nodes, and weighted_interleave sysfs for weights.  I don't think this
coupling is very ideal.

Off the opt of my head, I concern if users could mistakenly forget updating one
of those, since the requirement is not very clear.  I think the interface
should clearly explain that.  For example, writing a special keywords, say,
"use_interleave_weights" to target_nid parameter sysfs file.  But, even in the
case, users who update weighted_interleave might foget updating target nodes on
DAMON interface.

I think letting DAMOS_MIGRATE_{HOT,COLD} to use all nodes as migration target
when the special keyword is given is one of better options.  This is what I
suggested to the previous version of this patch series.  But now I think it
would be better if we could just remove this coupling.

I understand a sort of this coupling is inevitable if the kernel should make
the connection between DAMON and weighted interleaving itself, without
user-space help.  But now I think we could get user-space help, according to
below.  Please keep reading.

[...]
> As a toy example, imagine some application that uses 75% of the local
> bandwidth. Assuming sufficient capacity, when running alone, we want to
> keep that application's data in local memory. However, if a second
> instance of that application begins, using the same amount of bandwidth,
> it would be best to interleave the data of both processes to alleviate the
> bandwidth pressure from the local node. Likewise, when one of the processes
> ends, the data should be moves back to local memory.
> 
> We imagine there would be a userspace application that would monitor system
> performance characteristics, such as bandwidth utilization or memory access
> latency, and uses that information to tune the interleave weights. Others
> seem to have come to a similar conclusion in previous discussions [3].
> We are currently working on a userspace program that does this, but it is
> not quite ready to be published yet.

So, at least in this toy example, we have user-space control.  Then, I think we
could decouple DAMON and weighted interleaving, and ask the usr-space tool to
be the connection between those.  That is, extend DAMOS_MIGRATE_{HOT,COLD} to
let users specify migration target nodes and their weights.  And ask the
user-space tool to periodically read weighted interleaving parameters that
could be auto-tuned, and update DAMOS_MIGRATE_{HOT,COLD} parameters
accordingly.  Actually the user-space tool on this example is making the
weights by itself, so this should be easy work to do?

Also, even for general use case, I think such user-space intervention is not
too much request.  Please let me know if I'm wrong.

> 
> We believe DAMON is the correct venue for the interleaving mechanism for a
> few reasons. First, we noticed that we don't ahve to migrate all of the
> application's pages to improve performance. we just need to migrate the
> frequently accessed pages. DAMON's existing hotness traching is very useful
> for this. Second, DAMON's quota system can be used to ensure we are not
> using too much bandwidth for migrations. Finally, as Ying pointed out [4],
> a complete solution must also handle when a memory node is at capacity. The
> existing migrate_cold action can be used in conjunction with the
> functionality added in this patch set to provide that complete solution.

These make perfect sense to me.  Thank you for adding this great summary.

> 
> Functionality Test
> ==================
[...]
> Performance Test
> ================
[...]
> Updating the interleave weights, and having DAMON migrate the workload
> data according to the weights resulted in an approximately 25% speedup.

Awesome.  Thank you for conducting this great tests and sharing the results!

> 
> Questions for Reviewers
> =======================
> 1. Are you happy with the changes to the DAMON sysfs interface?

I'm happy with it for RFC level implementation.  And in my opinion, you now
proved this is a good idea.  For next steps toward mainline landing, I'd like
to suggest below interface change.

Let's allow users specify DAMOS_MIGRATE_{HOT,COLD} target nodes and weights
using only DAMON interface.  And let the user-space tool do the synchronization
with weighted interleaving or other required works.

This may require writing not small amount of code, especially for DAMON sysfs
interface.  I think it is doable, though.  If you don't mind, I'd like to
quickly make a prototype and share with you.

What do you think?

> 2. Setting an interleave weight to 0 is currently not allowed. This makes
>    sense when the weights are only used for allocation. Does it make sense
>    to allow 0 weights now?

I have no opinion, and would like to let mempolicy folks make voices.  But if
we go on the decoupling approach as I suggested above, we can do this
discussion in a separate thread :)

[...]
> Revision History
> ================
> Changes from v1
> (https://lore.kernel.org/linux-mm/20250612181330.31236-1-bijan311@gmail.com/)
> - Reuse migrate_{hot,cold} actions instead of creating a new action
> - Remove vaddr implementation
> - Remove most of the use of mempolicy, instead duplicate the interleave
>   logic and access interleave weights directly
> - Write more about the use case in the cover letter
> - Write about why DAMON was used for this in the cover letter
> - Add correctness test to the cover letter
> - Add performance test

Again, thank you for revisioning.  Please bear in mind with me at next steps.
I believe this work is very promising.


Thanks,
SJ

[...]
