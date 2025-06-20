Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC40E56A;
	Fri, 20 Jun 2025 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461207; cv=none; b=a/cyZondp3EUEoq2hu60RmFx4sorsf+hK3k/cX7i0TCteferx0qr2+dP245c20WXAbsEYITNHcWFkH1HeSWdttf5P/Coii2AlSgqrmxg5NjCiN3HEJhvE5UJDBjP4CRhNkFnhaqMWnLi60eJjP/pcDWIbi/F7q0h5eHRF0xlCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461207; c=relaxed/simple;
	bh=1xpPvJzOsq9DyhQrcWjfxPukK6gyCTgayP5/Qcf3zaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twKmdGT0nxWWKb9atx67bGxik2f6f5FZddRiI13Kb06qW2vhYnDchUC1JVPeYja2qiLECzuFVmkKTzw5JA9PO3sDU/DbcL4n7EDddo84C+k52CoR0d38nWnytwPfLn/sJudsKQ+mkkSJiwlKwwHkGeoLVNBKgyqZ07R1ddnBfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7orA/bU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7orA/bU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DBDC4CEEE;
	Fri, 20 Jun 2025 23:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750461207;
	bh=1xpPvJzOsq9DyhQrcWjfxPukK6gyCTgayP5/Qcf3zaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7orA/bUeaj039gU6uXCNkJVJ+7HNLZK3/vXJVFbY/cEDDnp9fLkjucRqdaahjbYX
	 UHEgsdUTstMPOC6DPQoorO2CKuD+Wa1m2OXdgXbvhyh+OvMiymUa8fnifZEo7VAa47
	 TVhuStpQOJ/6DcdrHFcktuBJ9zYU4P2YKdJV7U/LQxOIBeo8IG81yOckZ07OfGh+Lc
	 pRSmDZTtW32XSxInOnbpsILSxfF7s1e7RDdKQwKMLW/WorFZflrstw4s+IH42W2QT7
	 8uIxZ66WqKeKPAT1MkdQeeWVtmE6GIn+b9xTQW3Ity2StRdJnv0glJSo+idiArFQra
	 moIrcsXrc33+g==
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
Date: Fri, 20 Jun 2025 16:13:24 -0700
Message-Id: <20250620231324.99607-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS4imbSprPPZ3dtPBK2i3DZPffYn3d4rASMoNwcTeHCWqg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 16:47:26 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> Hi SeongJae,
> 
> On Fri, Jun 20, 2025 at 3:21 PM SeongJae Park <sj@kernel.org> wrote:
> >
[...]
> > Also, even for general use case, I think such user-space intervention is not
> > too much request.  Please let me know if I'm wrong.
> 
> You are correct. The userspace tool would be coming up with the
> weights, so it would not be hard for it to write those weights to two
> places. I coupled the weights used in DAMON and weighted interleaving
> for this revision and the previous because I could not think of a use
> case where you would want to use different weights for allocation time
> and migration, so it felt silly to have two different places with the
> same data. However, I don't feel too strongly about this, so I'm
> willing to defer to your judgement.

Thank you for being kind and flexible about the decision.  One such use case I
can think off the top of my head is when users want to do memory tiering, and
there are multiple nodes of same tier.  For example, if users want to migrate
hot pages in a node to the upper tier, and there are multiple nodes for the
tier, users may want to do the migration with same weight, or in proportion to
their free space.

So let's push this way for now.  Nothing is set on the stone, so please feel
free to let me know if you feel differently later.

> 
> Also, our userspace tool updates these weights somewhat frequently,
> several times per minute, when it detects a change in the bandwidth
> utilization of the system to calibrate the interleave ratio. I am
> concerned about how frequent changes to the scheme via the sysfs
> interface will affect the effectiveness of DAMON's page sampling. From
> what I understand, updates to the sysfs aren't saved until the user
> writes to some sysfs file to commit them,

This is correct.

> then the damon context is
> recreated from scratch.  Would this throw away all the previous sampling work
> done and work splitting and merging regions?

This is how an early version of DAMON sysfs interface was working.  Your
concern was true for the version.  Hence, we implemented online tuning
feature[1].  If you use DAMON user-space tool, 'damo tune'[2] is the command
for using this feature.  So, as long as you use the feature, updating weights
several times per minute shouldn't make such issues.

[1] https://lore.kernel.org/20220429160606.127307-1-sj@kernel.org
[2] https://github.com/damonitor/damo/blob/next/USAGE.md#damo-tune

> I am not
> super familiar with how the sysfs interface interacts with the rest of
> the system, so this concern might be entirely unfounded, but I would
> appreciate some clarification here.

Thank you for asking.  Please feel free to ask any more questions as you need!

[...]
> > This may require writing not small amount of code, especially for DAMON sysfs
> > interface.  I think it is doable, though.  If you don't mind, I'd like to
> > quickly make a prototype and share with you.
> >
> > What do you think?
> 
> That sounds good to me! Having a prototype from you for the sysfs
> interface would certainly be helpful, but if you're busy, I can take a
> pass at it as well.

Great.  I will try to do this by this weekend.

[...]
> Thank you for your help and feedback!

The pleasure if mine!


Thanks,
SJ

[...]
