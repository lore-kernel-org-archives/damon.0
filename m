Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663FE33C2
	for <damon@lists.linux.dev>; Sun, 21 Aug 2022 17:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7EAC433C1;
	Sun, 21 Aug 2022 17:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661104338;
	bh=4p7yfjIq1tiv/g9ut0gygVgmob/tNi6cVnkLCUCXz10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkdQhCJR/uZHyTuzxZahcWiQtflHyk0dww9r8YWVQFIDxSanYudlw4B/HZQ3qmpf2
	 bVCsro16+QMYkszaBCg20ENA2E5TlH0d7VIojnosLTR4BjdmpfKu5uB5NXJzHa8NMg
	 7Vlu5pJGi6c2igKdd/irLW0PBoqvXcDAIbyJuI/D/8Sxxv0NUCkAHemN7LyJWDfn/T
	 CusgC/HcHiSOtboPo/jfwNZKV4drJoDZ2NCFK4g5Q7RyISK9Y/MzdkcF+p2CA9Lr1V
	 lc3Z/KKdjLnB96GwDEpjt5iRjzn+KOcd5JgqI1eIyup7yRTawRbdmv/hV+dujxT+Yq
	 5H4Meemt8OAUA==
From: SeongJae Park <sj@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	badari.pulavarty@intel.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/dbgfs: avoid duplicate context directory creation
Date: Sun, 21 Aug 2022 17:52:15 +0000
Message-Id: <20220821175215.152419-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YwEatUUtU8570PRV@kroah.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On Sat, 20 Aug 2022 19:32:37 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Aug 19, 2022 at 02:08:09PM -0700, Andrew Morton wrote:
> > On Fri, 19 Aug 2022 17:19:30 +0000 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > From: Badari Pulavarty <badari.pulavarty@intel.com>
> > > 
> > > When user tries to create a DAMON context via the DAMON debugfs
> > > interface with a name of an already existing context, the context
> > > directory creation silently fails but the context is added in the
> > > internal data structure.  As a result, memory could leak and DAMON
> > > cannot be turned on.  An example test case is as below:
> > > 
> > >     # cd /sys/kernel/debug/damon/
> > >     # echo "off" >  monitor_on
> > >     # echo paddr > target_ids
> > >     # echo "abc" > mk_context
> > >     # echo "abc" > mk_context
> > >     # echo $$ > abc/target_ids
> > >     # echo "on" > monitor_on  <<< fails
> > > 
> > > This commit fixes the issue by checking if the name already exist and
> > > immediately returning '-EEXIST' in the case.
> > > 
> > > ...
> > >
> > > --- a/mm/damon/dbgfs.c
> > > +++ b/mm/damon/dbgfs.c
> > > @@ -795,7 +795,7 @@ static void dbgfs_destroy_ctx(struct damon_ctx *ctx)
> > >   */
> > >  static int dbgfs_mk_context(char *name)
> > >  {
> > > -	struct dentry *root, **new_dirs, *new_dir;
> > > +	struct dentry *root, **new_dirs, *new_dir, *dir;
> > >  	struct damon_ctx **new_ctxs, *new_ctx;
> > >  
> > >  	if (damon_nr_running_ctxs())
> > > @@ -817,6 +817,12 @@ static int dbgfs_mk_context(char *name)
> > >  	if (!root)
> > >  		return -ENOENT;
> > >  
> > > +	dir = debugfs_lookup(name, root);
> > > +	if (dir) {
> > > +		dput(dir);
> > > +		return -EEXIST;
> > > +	}
> > > +
> > >  	new_dir = debugfs_create_dir(name, root);
> > >  	dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;
> > 
> > It would be simpler (and less racy) to check the debugfs_create_dir()
> > return value for IS_ERR()?
> > 
> 
> Yes, if you _HAVE_ to know if the code works properly (i.e. because your
> feature totally depends on debugfs like damon does), or you have a
> potential duplicate name like this, then sure, check the return value
> and do something based on it.
> 
> It's odd enough that you should put a comment above the check just so I
> don't go and send a patch to delete it later on :)

Thank you for the kind explanation, Greg.  I will revise this patch to simply
check the return value with a comment noticing it's really needed due to the
potential duplicate names.


Thanks,
SJ


> 
> thanks,
> 
> greg k-h
> 
