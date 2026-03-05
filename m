Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED026ED40
	for <damon@lists.linux.dev>; Thu,  5 Mar 2026 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772689317; cv=none; b=HEXKqEh/MVuGDAhRso53UMN1xhyoFBEHD7fr9h9FYxd28v9IF9i20LcYpyiru3GfiBsFl1o0O3o1bB1osLC+MdEE3W7uxzeg9FBcdxy6eW5pprjtqA4+KoU4ZgFowpduU0KWiDrtNo9OkUfEQm6XyNUjoNtNTB6emRGVMOYg8HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772689317; c=relaxed/simple;
	bh=DgFlkEpd+Giz7azYI3aH8In1nj1m0hihXdXV1v5sNvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rD6CQ25FW3xd2Ozo2ZYE8ies03srg+ID6gu+L0TynvdpG/FjhgQNV++ozbjUhB5zeGmLvoF7NQJgLwqrJXtCwAShYOJ0uhYZ33FV3Td7ReByMDnBLX92vEv8crC+aOKECrlhfMqtJ1O5bhXtD73mgq3qZrpZiv0k19cwTk//WHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKE2+GFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKE2+GFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A3DC116C6;
	Thu,  5 Mar 2026 05:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772689316;
	bh=DgFlkEpd+Giz7azYI3aH8In1nj1m0hihXdXV1v5sNvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKE2+GFzGngud+gQkocJpXpqBvNwgVq1jzEcGVFdqB1KZH9SrWmb37OCM8LYPv6Wi
	 548W+kyO43sr5fx2RCqHXIbYJ3LfW3JbdrlaEQjJyfCDGG0VAqwcsz16kFk0DvSq7a
	 oLT/SfVr3oxItuJ+Wx25WZkVoL3Jd9pyp8o4KS8NoQ6n/1mJ2XPsVyrCzJ5ImzXYSh
	 MSMjPsJoyrDuhA0P6OnsknQr1FtElium5b+DZX1JYhB3/t13jSkR9cqFyFagVmTah1
	 /oE406NMM5+ulhq9Jt/OQE7Qj4OIHbEq1d9T+X4V+Tdn0amF/Tga8HznPpVC8tWVxg
	 iph12gwOfa+vg==
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
Date: Wed,  4 Mar 2026 21:41:46 -0800
Message-ID: <20260305054148.83837-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131015643.79158-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 30 Jan 2026 17:56:41 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 29 Jan 2026 19:38:45 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello Quanmin,
> > 
> > On Fri, 30 Jan 2026 11:07:08 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> [...]
> > > Actually, DAMON only actively searches for the biggest System RAM
> > > address when the user does not set a monitoring region. In this case,
> > > we always reset addr_unit to 1, which essentially restricts DAMON’s
> > > monitorable address range to 0–UL. Therefore, the described situation
> > > does not occur. For details, please refer to commit [1].
> > 
> > Again, you are correct.  There is no user scenario that can trigger the
> > problematic situation in the real world.  Nevertheless, assigning
> > 'resource_size_t' value to 'unsigned long' storage makes no sense, so I'm
> > calling such things a bug.  Not impacting user world, but still a bug is a bug.
> 
> I was arguing it as a bug even though ABI users cannot trigger the overflow,
> since damon_set_region_biggest_system_ram_default() is exposed to DAMON API
> callers, and I was thinking a future caller of the function could trigger the
> problem.  But I now realize the API function is safe from any call, since
> damon_find_biggest_system_ram() is avoiding the case, by setting 'end'
> parameter of walk_system_ram_res() as 'ULONG_MAX'.  Maybe it is not really
> appropriate to call it a bug.
> 
> That said, I now think this as a room to improve for the readability of the
> code.

So, I sent an RFC patch for this:
https://lore.kernel.org/20260305053918.83786-1-sj@kernel.org


Thanks,
SJ

[...]
