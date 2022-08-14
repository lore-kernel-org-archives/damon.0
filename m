Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE81392
	for <damon@lists.linux.dev>; Sun, 14 Aug 2022 16:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C1BC4347C;
	Sun, 14 Aug 2022 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660494757;
	bh=K+V/saPPEc+WOP8oR9l0FSWA4cYcXwvC82LX7l+Tvx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xxz9eagHR1eQIn1IxyEg1CIPNfd0oOT6EJFI7ZKsanNgJpgTqAULbFGftvTTxPcCp
	 gmlPVCLYgBrCzD32k9Y8zFi6RGi8kD+KpJ0he3bxCRFUCswOYx35HZ6cFZfGJoGoCj
	 04c5EJ6eMLQaisZGvygKZ6X8zrmH8tX6szOJ7BHxvw8f+5rN9exZ3dMjdoGw8rErQl
	 XcSI/5KrJtSDspCJ+TRtyCGBm6LdS82omvjdCrmVA/V9tQjBV1p+X6ga9m1yqWDHHj
	 8tLcUdkCoDcwakSNtnKE4ZERIilmQTQqPLGETZNDH7qo3EUUrmw1AZnNdOOMqMNof9
	 UK4Oy6IWbIBGQ==
From: SeongJae Park <sj@kernel.org>
To: "Pulavarty, Badari" <badari.pulavarty@intel.com>
Cc: "damon@lists.linux.dev" <damon@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] DAMON dbgfs_mk_context() error handling
Date: Sun, 14 Aug 2022 16:32:34 +0000
Message-Id: <20220814163234.52190-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DM6PR11MB3978994F75A4104D714437379C679@DM6PR11MB3978.namprd11.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Badari,

On Fri, 12 Aug 2022 18:01:25 +0000 "Pulavarty, Badari" <badari.pulavarty@intel.com> wrote:

> damon dbgfs_mk_context() does not handle error from debugfs_create_dir() correctly.

Let's wrpa the body lines at 75 columns[1].

> 
> For example, if one tries to create a context with existing name, debugfs_create_dir() fails
> with -EEXIST, but dbgfs_mk_context() assumes the call is successful and adds another entry - which
> will cause failures when try to enable the monitor.
> 
> Test case:
> 
> echo "off" >  /sys/kernel/debug/damon/monitor_on
> echo "abc" > /sys/kernel/debug/damon/mk_context
> echo "abc" > /sys/kernel/debug/damon/mk_context
> echo <pid> > /sys/kernel/debug/damon/target_ids
> echo "on" > /sys/kernel/debug/damon/monitor_on  <<< fails to enable monitor
> 
> Signed-off-by: Badari Pulavarty badari.pulavarty@intel.com
> ---
> --- orig/mm/damon/dbgfs.c       2022-08-05 13:35:54.416831666 -0400
> +++ new/mm/damon/dbgfs.c        2022-08-05 13:44:25.121849930 -0400
> @@ -721,6 +721,9 @@ static int dbgfs_mk_context(char *name)
>                 return -ENOENT;
> 
>         new_dir = debugfs_create_dir(name, root);
> +       if (IS_ERR(new_dir)) {
> +               return PTR_ERR(new_dir);
> +       }

Nice finding, thank you!  But, the return value of the debugfs call is
intentionally ignored[2].  How about doing the duplicated name check in
dbgfs_mk_context() itself before the debugfs_create_dir() call?

[1] https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
[2] https://lore.kernel.org/linux-mm/20210205155902.31102-1-sjpark@amazon.com/


Thanks,
SJ

>         dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;
> 
>         new_ctx = dbgfs_new_ctx();
