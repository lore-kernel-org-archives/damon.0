Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906824634F
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278974; cv=none; b=E0UTDvHNws9tAyayQ72iz1Obo7WJoU6oLz0CLlGxLdIuhVdTpmP3xkmoRBmrhHaYTN+1BTNZxs9mEvZIyPEr5PtQ6dMhTKUKj3xEKbrFMLqjhzsr0PzfvQQXihp1MPBSppyFw3D5SbzTarp6z2yF7VJZoNmILHFLEV/NTNTNyWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278974; c=relaxed/simple;
	bh=rdbRhrKbHgPbTB2eBO7rPqqHzWm6kls466VYWyJawKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAnFuQq1U8gcNpYJMG1PbFzm/F6X9G3krR3iakXztZCUQ4gVgbMXOOD3COqt7ks2Td9Z902pRzxdZAfiK34JNHo4M3BKHmw+Xly9r3Aq5HDCIfbDMbXbtaNBx72McpE00IsOwIV4gLLu/bAscBJgMfvnWJ8Qz+0/9IEMJsfrD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuBfxsmj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuBfxsmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324B7C2BCB1;
	Mon, 23 Mar 2026 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774278974;
	bh=rdbRhrKbHgPbTB2eBO7rPqqHzWm6kls466VYWyJawKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuBfxsmjLxbFgFWYVtf/btgoy7qNqLJvpYKEUxhbxEREXuWedtGIOvofsBVEtuuAE
	 p1WGwzHpb6B1c0wjTr2tegrC0uJ7OF7JLXuLTQeo5YAHbCpUmRpuZJm+JhMBMV3ymQ
	 mErs2aF9RDwVEeAevgSwC+IDsUcM4frXP9tUYbcz+ZxgI4kpztC94TIEvaNoKoaM0h
	 SwpUX8J7m/XFs8FspLbulnkAorpu6iMxX1rfm5XftzB48jcyIb3UNjRmoB0uB52UMC
	 3/k78opIpuZZSrKHp+kNtSlj6fEhg0xwqalyYTz6oS6JK42BP+KIy0AJrSg34j42Rp
	 E59DZqMhjRrlg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v4] mm/damon: add synchronous commit for commit_inputs
Date: Mon, 23 Mar 2026 08:16:10 -0700
Message-ID: <20260323151611.81358-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323141955.20535-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 22:19:55 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> Follow-up on my previous email regarding the locking concerns.
> 
> > I admit I don't have an elegant solution yet. Here are my current
> > thought:
> > 
> > Add a timeout to wait_for_completion() (e.g.,
> > wait_for_completion_timeout()), using 'damos_watermarks.interval' as the
> > upper bound. This prevents indefinite blocking of 'param_lock', though
> > it still holds the global lock for up to several seconds.
> 
> After further analysis, I realized that since both 'commit_inputs' and
> 'enabled' module parameters are protected by the global 'param_lock',
> stopping kdamond gracefully (via enabled=N) is serialized with
> 'commit_inputs' writes. Therefore, a classic deadlock scenario should
> not occur in normal operation.
> 
> However, I'm considering edge cases where kdamond might terminate
> unexpectedly. In such cases, commit_inputs_store() could hold
> 'param_lock' indefinitely, blocking other module parameter updates
> system-wide.
> 
> To mitigate this risk defensively, would you accept adding a timeout to
> wait_for_completion()? This ensures 'param_lock' is eventually released
> even if kdamond fails unexpectedly.
> 
> Please let me know your preference. :>

As I mentioned on the reply to the original mail of this mail, I think such
infinite wait will not happen because damon_call() is aware of the kdamond
stop, and therefore the timeout is not needed.  Please double check and let me
know if I'm missing something, though, as a reply to my reply.


Thanks,
SJ

[...]
