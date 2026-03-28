Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F5249E5
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707205; cv=none; b=OALoevOzU0GcE1sZ9kKkcJWSORUbXU7l5XIepGYZXgUpSnh4mss41L7nMKbY4bykc4/8l3EiIAlYRstRFXu6TbH8h3/c/2mLLUyvaT6Affpm9ccVIR77AoVUg7vyi/6PjP6iQ+7YBfN8A2iMcpJYQoTILEHUPcNtBcPvy55T48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707205; c=relaxed/simple;
	bh=fmCYbzGjhlcCuEkV1MgP++GQDUCnffzSmzBNprCRYt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfBlET27dU8KV5r9efU9p5qA94cjKw7b6LR+O+mjnS8cECQ+p/WOAiv/8bBM3pJi6wg4qaK3v3micPFsxLoJijVMSLAeLRosxjB/c70yCzRFZe+a7ewpMpxsLxW+JHSH7+y87nNQ88+sa1a1Hrjq6cs6uBEV71RYV0RPUDAoMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3GFE9C6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3GFE9C6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C51CC4CEF7;
	Sat, 28 Mar 2026 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774707205;
	bh=fmCYbzGjhlcCuEkV1MgP++GQDUCnffzSmzBNprCRYt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3GFE9C6d3w5gL3tGUfmdYYzvBiPWbbkhYEe+CRSAwLByGI7gqlnpT+I7wuZbbHiQ
	 2KDyY6thwP/IXilJoSukBLgYT11v4rEM0NghycahRJZSfNJmvt+UfUq0cCts+aiDMd
	 bKnl92G3ieB2wuV8EEpOH1RRz3mv9Spgc0/xs267OA4VAM3qjapoEKyOq5o7ijgvCo
	 Rv9Yd2Z0HRyJP+8sKmPLJ07KwN3vVeB6dePLW2sjJV/hyUPef1MTtKXVO2+FmpWGzn
	 xRNSGQm0gmbssCUQmjdz8H67OmGuv/JGr5KWE95V61Szk/GdkF9tXtPt7KXXW41a8p
	 W+G++FdMVf5TQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Sat, 28 Mar 2026 07:13:23 -0700
Message-ID: <20260328141323.10540-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328132937.9580-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 28 Mar 2026 06:29:37 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat, 28 Mar 2026 10:26:51 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> [...]
> > Just to make sure I captured the full context, in my earlier follow-ups
> > [1][2] (in case they got folded in your email client):
> > 
> > - Does the current kdamond termination on invalid user input align with
> >   your design goal mentioned in [3] (stopping only for "internal
> >   errors")?
> 
> No.  I still think it would be better to avoid wrong input-caused termination.
> But in a simple way.  Also, it would be better to be consistent.
> 
> > 
> > - Would a lightweight fix be acceptable? For example, performing
> >   validation at the very beginning of damon_commit_ctx(), and returning
> >   -EINVAL before setting 'maybe_corrupted' to true. Since no
> >   modifications to 'dst' would have occurred, kdamond could safely
> >   continue with its old configuration.
> 
> I suggested you to try something similar to what DAMON_SYSFS is doing.  But I
> didn't get your response to the idea yet.  Could you please let me know what do
> you think about the approach?

I was thinking this one more time.  So you want to ensure DAMON_RECLAIM and
DAMON_LRU_SORT not passing wrong addr_unit to damon_commit_ctx(), right?  And
that's required because exisitng inputs validations of DAMON_RECLAIM and
DAMON_LRU_SORT are not checking that.  Why don't you add the just one more
check there?

I remember I was saying this kind of change would be a kind of whack-a-mole and
therefore prefer DAMON_SYSFS type damon_commit_ctx() based checking.  But
that's not a small change.  Just adding yet another simple check on existing
validation logic should be fine and small.


Thanks,
SJ

[...]
