Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F729D27D
	for <damon@lists.linux.dev>; Sat, 31 Jan 2026 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824607; cv=none; b=g2PSHCeVslXHN7vIXvrw2kIpSI56A/j8LqkWkC/QJubFziwVwkkKFo0vSBNNAnipj73739qpI+wr2N5fMq7hcQoUT624F9CHstzy3UHsnfjkZHBqGKIqWslQ/u0efhF4F2eMcBBXP+FhHEV9jAl7nndcRobv/Tl6CDj+dzen4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824607; c=relaxed/simple;
	bh=TLqvCF4t7yFws2JJgVsnqE5uDHYvXZpXYYnuo6IsZgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrK8PCDiePsoDPwg6WhmyTkqiNltR0wbCcB0KEP/Oj9+OLYvcKvK1pdAjpZBPePdwK6cxitAdPQcnqTnftcNtZDtOdJ8/ZOdzID1x48VsT0avRBmiPkAwZnA0bNj3gDwooecWSlo5JBB2mK5guJIyPU0cAFD3jyDxApcObN4KLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImRH2ypy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImRH2ypy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04F0C4CEF7;
	Sat, 31 Jan 2026 01:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769824607;
	bh=TLqvCF4t7yFws2JJgVsnqE5uDHYvXZpXYYnuo6IsZgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImRH2ypyq96835K/c6I0GkZRWdgWuU5RwayIfD9PzrnnYomfw1lbf8p9zc8aCk/gW
	 IwfGt4Ko+7YPompvYRPPsFjQ6cTqluHxz5RInklq0ujPYlBEH0tiS4kvpJzL/0Vb0A
	 /gPQZ4fB8WV90i4C9rEcHqC7V9XhpTIQrZaIhKoCPQoOABzDJoUG6bH1eb1lAxSpGK
	 UiyCtF43nbLbz/FhFri4Ad4D5BODCYy1ZFBDqI5HTVCyQKwQn6RcJksGtoAkhBl0pC
	 DRt5/kFpyfUWdlB5F/7m7sT2A/bxwr08I/RV40a1A9HXfRwouwIbDE1q18TpLNR7mN
	 RrZN/v1ysHjgQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	sunnanyong@huawei.com,
	Enze Li <lienze@kylinos.cn>
Subject: Re: [PATCH] mm/damon: unify address range representation with damon_addr_range
Date: Fri, 30 Jan 2026 17:56:41 -0800
Message-ID: <20260131015643.79158-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130033847.52289-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 29 Jan 2026 19:38:45 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hello Quanmin,
> 
> On Fri, 30 Jan 2026 11:07:08 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
[...]
> > Actually, DAMON only actively searches for the biggest System RAM
> > address when the user does not set a monitoring region. In this case,
> > we always reset addr_unit to 1, which essentially restricts DAMON’s
> > monitorable address range to 0–UL. Therefore, the described situation
> > does not occur. For details, please refer to commit [1].
> 
> Again, you are correct.  There is no user scenario that can trigger the
> problematic situation in the real world.  Nevertheless, assigning
> 'resource_size_t' value to 'unsigned long' storage makes no sense, so I'm
> calling such things a bug.  Not impacting user world, but still a bug is a bug.

I was arguing it as a bug even though ABI users cannot trigger the overflow,
since damon_set_region_biggest_system_ram_default() is exposed to DAMON API
callers, and I was thinking a future caller of the function could trigger the
problem.  But I now realize the API function is safe from any call, since
damon_find_biggest_system_ram() is avoiding the case, by setting 'end'
parameter of walk_system_ram_res() as 'ULONG_MAX'.  Maybe it is not really
appropriate to call it a bug.

That said, I now think this as a room to improve for the readability of the
code.


Thanks,
SJ

[...]
