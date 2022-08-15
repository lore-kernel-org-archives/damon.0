Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FD539B
	for <damon@lists.linux.dev>; Mon, 15 Aug 2022 23:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649B6C433D6;
	Mon, 15 Aug 2022 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660606932;
	bh=58yaH86pz9K1ViOeBYMbEaj6JwLLYw1QuwMYWbFIqSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5tfJVQnWKVAG16qIRgqi3fCmE3mTSQw0KPhfX3Q6aJIooYnLto5EuCtluPfX7DAZ
	 Pr9ppSo8LDcHBOoy8cPr6L3pqYg3Qtj2dw17v1972R+12v/7HuZtLP+ScPG9jfixwW
	 PkPCrnlbx7g4PXj4hEkVpBa/F9sOJgvVXjk+poFANQBGkzM6V4os/7/Ufpz3aftUec
	 UPC+cGIfbQmMU2r5PfNihQB95A7s6P3flii9RewL0DG6m7AWY2kfhR0UQ6ngla+93L
	 HzjpIZNnQWfZQdytFtmg0gCzxv9cK1rP4pu3d79+IPJkIkNleLqWtQ7u9BeDUHfV0R
	 SvwSwFi80YRpQ==
From: SeongJae Park <sj@kernel.org>
To: "Pulavarty, Badari" <badari.pulavarty@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH] DAMON dbgfs_mk_context() error handling
Date: Mon, 15 Aug 2022 23:42:10 +0000
Message-Id: <20220815234210.95016-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DM6PR11MB39788257B26A38FCD9DA4F449C689@DM6PR11MB3978.namprd11.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Badari,


On Mon, 15 Aug 2022 21:51:04 +0000 "Pulavarty, Badari" <badari.pulavarty@intel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 350 bytes --]
> 
> Hi SI,
> 
> > Nice finding, thank you!  But, the return value of the debugfs call is intentionally ignored[2].  How about doing the duplicated name check in
> > dbgfs_mk_context() itself before the debugfs_create_dir() call?

Please don't unwrap wrapped message.  My monitor is not so wide :'(

> >
> > [2] https://lore.kernel.org/linux-mm/20210205155902.31102-1-sjpark@amazon.com/
> 
> How about this?
> 
> Thanks,
> Badari
> 
> 
> 
> [-- Attachment #2: damon-mkcontext-fix.patch --]
> [-- Type: application/octet-stream, Size: 858 bytes --]

Could you please don't send a patch as an attached file of the mail but put it
in the mail body so that we can easily read the patch and comment in line?

> 
> damon dbgfs_mk_context() should check to make sure there is no existing 
> context with the same name. Otherwise, it will cause failure when we 
> enabling the monitor.
> 
> Test case:
> 
> echo "off" >  /sys/kernel/debug/damon/monitor_on
> echo "abc" > /sys/kernel/debug/damon/mk_context
> echo "abc" > /sys/kernel/debug/damon/mk_context
> echo <pid> > /sys/kernel/debug/damon/abc/target_ids
> echo "on" > /sys/kernel/debug/damon/monitor_on  <<< fails 
> 
> Signed-off-by: Badari Pulavarty <badari.pulavarty@intel.com>
> ---

It would be good to put the changelog of this patch here:
https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

> --- a/mm/damon/dbgfs.c	2022-08-15 14:27:38.308806431 -0700
> +++ b/mm/damon/dbgfs.c	2022-08-15 14:33:31.661163048 -0700
> @@ -817,6 +817,12 @@
>  	if (!root)
>  		return -ENOENT;
>  
> +	new_dir = debugfs_lookup(name, root);
> +	if (new_dir) {
> +		dput(new_dir);
> +		return -EEXIST;
> +	}
> +

The change looks ok to me at a glance, but the attached file seems not an
appropriate patch.  Could you please repost this as a formal patch as suggested
for a better review?

Thanks,
SJ

>  	new_dir = debugfs_create_dir(name, root);
>  	dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;
