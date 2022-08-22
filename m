Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A62259C
	for <damon@lists.linux.dev>; Mon, 22 Aug 2022 17:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648C6C433C1;
	Mon, 22 Aug 2022 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661187903;
	bh=2RPwxK6mPiQ24V+dniyQlazWwH9XEnmeAVv55idNd7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z799LMiw+FL/IuHbi/9/reeai2+4hyyozmQmWlPVlykp+Hgy7vKNzLv1danQCEfiU
	 oH3hucNa2WJcQo3tovRQgpFhzcaXJNJazD5h/tNCjBZQbnlPfRSd+LmMLpXXyMS9EX
	 bdYGItA66XzG/Mgwqgiqsj4AJuxdG359istn8KUS5q0000a7aOkBkUQnwi2hvhvdey
	 wBvlN+H7/cIexx7n5jz7boF26n0fp32yNHGrfNuTkldGY1uxDUkkCJnueOg5NfGs2h
	 tsmx1aPgdi8WmsLaPkkpQoVNq9RBSL3oSG2qS8TaLH4oaXlk2XXKAP3aHj8uGNiBxJ
	 WQHn4ZVUWVzpA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>,
	damon@lists.linux.dev,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/usage: fix the example code snip
Date: Mon, 22 Aug 2022 17:05:00 +0000
Message-Id: <20220822170500.87712-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822165646.87524-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Aug 2022 16:56:46 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Kairui,
> 
> 
> On Mon, 22 Aug 2022 18:56:17 +0800 Kairui Song <ryncsn@gmail.com> wrote:
> 
> > From: Kairui Song <kasong@tencent.com>
> > 
> > The workflow example code is not working since it got the file names
> > wrong. So fix this.
> 
> Nice finding, thank you for this patch!
> 
> > 

Oh, I forgot saying that it would be good to have Fixes: here, like below:

Fixes: b18402726bd1 ("Docs/admin-guide/mm/damon/usage: document DAMON sysfs interface")

I wouldn't say this needs to Cc stable@, as this is just a document example
fix.  Nevertheless, if anyone has a different opinion, please shout out.


Thanks,
SJ

> > Signed-off-by: Kairui Song <kasong@tencent.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ
> 
> > ---
> >  Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index d52f572a90298..ca91ecc290785 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> > @@ -50,10 +50,10 @@ For a short example, users can monitor the virtual address space of a given
> >  workload as below. ::
> >  
> >      # cd /sys/kernel/mm/damon/admin/
> > -    # echo 1 > kdamonds/nr && echo 1 > kdamonds/0/contexts/nr
> > +    # echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_contexts
> >      # echo vaddr > kdamonds/0/contexts/0/operations
> > -    # echo 1 > kdamonds/0/contexts/0/targets/nr
> > -    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
> > +    # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
> > +    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid_target
> >      # echo on > kdamonds/0/state
> >  
> >  Files Hierarchy
> > @@ -366,12 +366,12 @@ memory rate becomes larger than 60%, or lower than 30%". ::
> >      # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
> >      # cd kdamonds/0/contexts/0/schemes/0
> >      # # set the basic access pattern and the action
> > -    # echo 4096 > access_patterns/sz/min
> > -    # echo 8192 > access_patterns/sz/max
> > -    # echo 0 > access_patterns/nr_accesses/min
> > -    # echo 5 > access_patterns/nr_accesses/max
> > -    # echo 10 > access_patterns/age/min
> > -    # echo 20 > access_patterns/age/max
> > +    # echo 4096 > access_pattern/sz/min
> > +    # echo 8192 > access_pattern/sz/max
> > +    # echo 0 > access_pattern/nr_accesses/min
> > +    # echo 5 > access_pattern/nr_accesses/max
> > +    # echo 10 > access_pattern/age/min
> > +    # echo 20 > access_pattern/age/max
> >      # echo pageout > action
> >      # # set quotas
> >      # echo 10 > quotas/ms
> > -- 
> > 2.35.2
