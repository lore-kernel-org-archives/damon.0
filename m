Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3F1870
	for <damon@lists.linux.dev>; Fri,  2 Sep 2022 16:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9350BC433C1;
	Fri,  2 Sep 2022 16:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1662135424;
	bh=Yl0CvY2cQDQb6yeL6TcfJK7/w0lVfZxtsJZIiQXq0fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LmBARlASMMFNtLL56hHrW9qMXLJF2LTMfWDy72+nXemQGz0G7X3gflzIbt4/coFwk
	 M57KPCk2OcuCRqSRXzza5lgPJmFkzXKe1MnJ/KpfFpbSSwlcK8DtXpjNNc7nYQuz/i
	 j5PJHfilgicicwOjdVQnRgtmolPdsnAa0xKYK8MY=
Date: Fri, 2 Sep 2022 09:17:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
 damon@lists.linux.dev, linux-mm@kvack.org, stable <stable@kernel.org>
Subject: Re: [PATCH] mm/damon/dbgfs: fix memory leak when using
 debugfs_lookup()
Message-Id: <20220902091703.dcee7737e7ce8857e3235fa7@linux-foundation.org>
In-Reply-To: <20220902125631.128329-1-gregkh@linuxfoundation.org>
References: <20220902125631.128329-1-gregkh@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Sep 2022 14:56:31 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  Fix this up by properly
> calling dput().
> 
> ...
>

Fixes: 75c1c2b53c78b, I assume.

> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -915,6 +915,7 @@ static int dbgfs_rm_context(char *name)
>  		new_ctxs[j++] = dbgfs_ctxs[i];
>  	}
>  
> +	dput(dir);
>  	kfree(dbgfs_dirs);
>  	kfree(dbgfs_ctxs);
>  

dput() is also needed if either of the kmalloc_array() calls fail?
Maybe something like

--- a/mm/damon/dbgfs.c~a
+++ a/mm/damon/dbgfs.c
@@ -884,6 +884,7 @@ static int dbgfs_rm_context(char *name)
 	struct dentry *root, *dir, **new_dirs;
 	struct damon_ctx **new_ctxs;
 	int i, j;
+	int ret = 0;
 
 	if (damon_nr_running_ctxs())
 		return -EBUSY;
@@ -899,14 +900,12 @@ static int dbgfs_rm_context(char *name)
 	new_dirs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_dirs),
 			GFP_KERNEL);
 	if (!new_dirs)
-		return -ENOMEM;
+		goto out_dput;
 
 	new_ctxs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_ctxs),
 			GFP_KERNEL);
-	if (!new_ctxs) {
-		kfree(new_dirs);
-		return -ENOMEM;
-	}
+	if (!new_ctxs)
+		goto out_new_dirs;
 
 	for (i = 0, j = 0; i < dbgfs_nr_ctxs; i++) {
 		if (dbgfs_dirs[i] == dir) {
@@ -925,7 +924,13 @@ static int dbgfs_rm_context(char *name)
 	dbgfs_ctxs = new_ctxs;
 	dbgfs_nr_ctxs--;
 
-	return 0;
+	goto out_dput;
+
+out_new_dirs:
+	kfree(new_dirs);
+out_dput:
+	dput(dir);
+	return ret;
 }
 
 static ssize_t dbgfs_rm_context_write(struct file *file,
_

