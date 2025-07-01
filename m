Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD924677B;
	Tue,  1 Jul 2025 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751413540; cv=none; b=gamFBloZbm6VVwfesBc9qULmAXBmcvv7PibaD5yEH+Us4FIsazy/smXhngT+q0Woz+JlEpPQ0iq9bojFuJn5M/x9a5ZFe9wmvVpCifGvF+XNFY5ctaHJfadDhro2/yEQxmTmyDDya8z7g5zM5Q5FQTpA3wnXtjjC4IPt5kmNFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751413540; c=relaxed/simple;
	bh=XYlsidoRUwVusXwpZreYOH7Z/kPmvluYj/9OEz9LeeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXkK5ZM4anBkOS2rFsVJDVc/9D3h/aaJGXLBJpXD4eCqEBkk9Da05k0NGKyItXT+PL+0fStSsEAP/zFPwYsh6IYRKF24jequ1NzVdcX0trUGYD4iPJGUvfkNllV9YPL4uRDX7hM+t2/+i236/hKWNIG5xhNIkoBm2QipfPjSaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSp5UT5g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSp5UT5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5FDC4CEEB;
	Tue,  1 Jul 2025 23:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751413539;
	bh=XYlsidoRUwVusXwpZreYOH7Z/kPmvluYj/9OEz9LeeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSp5UT5gL9TnmeHH1+LrZoqazZ9rGVw9BHXs3TdgoLyPujPSsh/bPyBYqqXjZ5oCI
	 saTqGr6v4WUF5Q+6STCehZBSltcKYW92W73iupdtW3rCPaMU4Ghkn6iIrXxZ74LH/A
	 /Wg81Oh2KCcsGcq1BQWTdxouHsiJSyJu/wHvGId0gczvEsZOttahMYvVhhqkot7tmR
	 R2UglDoPFtZ8HVgCG1p8FazKt2i7ic//dN211lBilTU0r+DfXuRa9z2Xgg+PQd5Kpe
	 inHO+aFxX5ww+T7//dkOciWESTGgnpLjY+NS/0GtRPZq7M7oxPjm/VeySoas8SvjPK
	 lX9fFnCoLeetg==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [RFC PATCH 0/2] samples/damon: improve expression of target region in mtier
Date: Tue,  1 Jul 2025 16:45:37 -0700
Message-Id: <20250701234537.57216-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701085417.1734-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Yunjeong,


On Tue,  1 Jul 2025 17:54:15 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> `mtier` module is a static module for migrating pages using
> damos_action: DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD. Currently,
> this module is built on the assumption that the system has two NUMA
> nodes, where node0 is the fast-tier and node1 is slow-tier. This
> patchset aims to make the expression of the migration target region
> more user-friendly by :

Thank you for your continued patches!  Let me clarify my humble opinions about
what is the goal of mtier, and what improvements it needs first, though.

mtier is not intended to be used as a solution for real world usages but a
sample module for helping developers understand how they can utilize DAMON by
calling its API functions.  If someone is looking for a real world DAMON-based
memory tiering solution, I think it should be under mm/damon/ directory like
DAMON_RECLAIM, not under samples/damon/ directory.

I hence think we should more focus on making mtier provides good example usages
of DAMON API functions, more than its user-space usages.  We could of course
improve its user-space interface if it helps experimental run of it for better
understanding of the code and DAMON API usages.  But in my opinion, it should
avoid a case that it result in adding more complicated code that makes reading
of the example difficult.

Please let me know if you have different opinions and I'm missing something.

From that perspective, I think the assumption of the fast node0 and the slow
node1 is not a particular problem but helps keeping the sample code easier to
read.  Of course it has rooms to improve, like having more documentation or
better names and cleaner code.

> 1) allowing users to specify just the node id,
> instead of physical address, and 2) adding two new knobs.
> 
> Patch 1 removes four knobs, `node#_start_addr` and `node#_end_addr`, which
> previously required users to input the physical address of the region.
> It introduces logic to conver NUMA node ids to physical address.

I think this is good change.  But even though mtier is a sample module, I'd
like to keep the old usages not broken if possible.  I'll leave more comments
on it as a reply to the patch.

> 
> Patch 2 introduces two new knobs `migrate_hot` and `migrate_cold`, which
> specify the source and destination node ids in a comma-separated format.

As mentioned abovely, I think the assumption of the fast node0 and the slow
node1 is particularly bad, so I'm sorry but I'm not really exciting with this
change.  I'll leave more comments as a reply to the patch.

> 
> Yunjeong Mun (2):
>   samples/damon: convert node id to physical address
>   samples/damon: add `migrate_hot` and `migrate_cold` knobs
> 
>  samples/damon/mtier.c | 108 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 93 insertions(+), 15 deletions(-)
> 
> 
> base-commit: db16fe88cdf83a1e7fdf75de282025b6ad61d08f
> -- 
> 2.34.1


Thanks,
SJ
