Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5D21C17E
	for <damon@lists.linux.dev>; Tue,  4 Feb 2025 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710801; cv=none; b=NfGeTW9gK4goIx1aKK7BTSJHqVVCu42knWUyZ3EWQEr2Cc5mCLkLsgOP8O20wZ6YW5nB2pnGq403lnVZIKDRbBMlbNuu8rqOdf7j8v6hgjLWMp3q2ljenq35bQKouLAiQDxwGXTr4D8NYTgbAgpHOUru1GY9LDSaBSYJP1P9Jxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710801; c=relaxed/simple;
	bh=R9lwn0pw9rjiGj0YsubvrYETi4KfDQCldRwM0aTrKMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAtDIxqOvhR78sTuBsmrV9i6j6+1v2uiqf1KcAmfSZnH6qw9U1KLWQeDsOg+Rt2SObGOfHo0FU5CZewLXVL+Ip4MO7utp4BR7PdTe0n0hDr9ZBCTr9Rdfp7TXXmETs9FPd86DSr9iNoyCEbxce0EqkLqbUr5i/2Aq66I6WOVTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9abz0cO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9abz0cO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B59DC4CEDF;
	Tue,  4 Feb 2025 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738710800;
	bh=R9lwn0pw9rjiGj0YsubvrYETi4KfDQCldRwM0aTrKMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9abz0cOuDniHUFFtPUKAWdWV+q3kFuA7ivTN5uqcxCUMDaxpQuQZqlPgPpSCkwCP
	 lyyoGusw8hPPXNYUChyY0KnwWQM1PI+34s7wRMbuJEycqdpPRcIfF+fbI/URqrMAUr
	 NH8nksqN2FPUwY0+wlqxxPAFZZQk9oMN3kasLqutRmg5OTkd1yM2T/6MfB7byslxgN
	 8lrVfXi1BdGGa2PTvSno0siGSpx6FMS9WMjKZxesfwTjHfmO3FetKCY3jXEc4FP/Sk
	 VZOUFA2DJo3gqyP83X3SNVZ++s5IDgdGEyNTpQc7rqKt47yGSpZrJXI7NxgjkoC+Fr
	 nPFOU/+0Ecbig==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 5/6] Docs/ABI/damon: document DAMOS sysfs files to set the min/max folio_size
Date: Tue,  4 Feb 2025 15:13:17 -0800
Message-Id: <20250204231317.2794-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203225604.44742-6-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  3 Feb 2025 22:55:32 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This will be used to decide the min and max folio size to operate on
> for pa_stat.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Other than the trivial comment below, looks good to me.

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  Documentation/ABI/testing/sysfs-kernel-mm-damon | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> index b057eddefbfc..07daaae3dd16 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> @@ -345,6 +345,18 @@ Description:	If 'addr' is written to the 'type' file, writing to or reading
>  		from this file sets or gets the end address of the address
>  		range for the filter.
>  
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/min
> +Date:		Jan 2025

Nit.  It's February now :)

> +Contact:	SeongJae Park <sj@kernel.org>
> +Description:	If 'hugepage' is written to the 'type' file, writing to or reading
> +		from this file sets or gets the minimum size of the hugepage for the filter.
> +
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/max
> +Date:		Jan 2025

Ditto.

> +Contact:	SeongJae Park <sj@kernel.org>
> +Description:	If 'hugepage' is written to the 'type' file, writing to or reading
> +		from this file sets or gets the maximum size of the hugepage for the filter.
> +
>  What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/target_idx
>  Date:		Dec 2022
>  Contact:	SeongJae Park <sj@kernel.org>
> -- 
> 2.43.5


Thanks,
SJ
