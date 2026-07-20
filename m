Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530BC435A80
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560313; cv=none; b=mRYSN7Dr1nAI4qYqS3GRjXn+6UosVVQ9n92s4kwkObeKc4P7gZiZt0PO/yjKo4HOZ2vRmPScAjw2q33EQbrmDu++q8bQfICzqW0c0wC2sYXu82MoxPsvg20t4J4+8b38ui4/rVJOpgvpm918FXsW5oJ/2TfCUzDFjsT3pKc0qrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560313; c=relaxed/simple;
	bh=mFb9jdPBVrss9q06qlsHZnMz93OG/HbdUAqqHLYtSW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5CqtmM98K23vviXKLGANampeiGAWaG/ZBMuXRA+SO8AiKp7sMlWW+WE9TL4307qJbzDQGMByu8s6LPgbw4qxzFznsY9MUVWGsuEKCZM3mrIBZ+BdjFz+x9WSeJdbJf/YuEANzu0ReqhzrMaj39sP1PmvZAqQXIwBkt2fsMjgwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3kKYMYt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3kKYMYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41DE1F000E9;
	Mon, 20 Jul 2026 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784560311;
	bh=II3ZvWti6Bi+9I3esjOsg7I4ZJWV70oA9rVblCP7QiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l3kKYMYtxk3aC6+5McIKXDlz8VG5ObmHDpSKFKKQeloLj2c4xVeJfTSpbGk3r+oAF
	 3Qc4b+h4/1T5w/IB4SLvtwGr+0o0HZDUJe7lXA0oHam5sExynHH/IizgdJZRXDp+B/
	 LNRGmuK2QYNJLWZmVJV6wKzKQNZWIMPylR5HLMsrys6ggCdkAU9UEbPyRa0V9TENNF
	 krbdNR1kQnERnx+1Br2nKXaNAWID0cosaEw4EVJP3NKtUlkwWZSFN7VznDreE0x2WK
	 Vyc+sbc8Ts/ZeDML4IZzV+XsrnIAb4DclZOImXbr4MLUUUnGarQOPzy6aBtVV124R9
	 9Ku7BucqS8fww==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Question on damon_sysfs_memcg_path_to_id() path resolution
Date: Mon, 20 Jul 2026 08:11:42 -0700
Message-ID: <20260720151143.83277-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c4cf2558-0516-417e-affd-9a5550ff32f8@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 11:35:06 +0800 Song Hu <husong@kylinos.cn> wrote:

[...]
> The only in-kernel PSI consumer today is DAMON, and it reads a single
> system-wide value - psi_system.total for memory (mm/damon/core.c,
> damos_get_some_mem_psi_total). There is no reusable in-kernel helper that
> returns per-cgroup, multi-domain (cpu/mem/io x some/full) pressure as a
> value (psi_show is a seq_file printer for the /proc and cgroup files, not a
> value-returning API), and no in-kernel threshold-trigger (psi_trigger_create
> is userspace-fd only).
> 
> I'm writing a node-level multi-domain (cpu + memory + io) resource
> coordinator for container/Kubernetes nodes - a small C daemon using libbpf
> plus PSI trigger fds. To attribute pressure to specific cgroups and act
> across domains it needs per-cgroup, per-domain PSI,

Sounds interesting!

> which today means
> open-coding reads of cgroup_psi(cgrp)->total[] the way DAMON does in-kernel.
> And I think DAMON's own per-memcg DAMOS quota goals would benefit from the
> same per-cgroup read if it existed.
> 
> So the idea is a small helper, e.g.
> 
>   /* per-cgroup, per-domain pressure; reuses update_averages() */
>   u64 psi_cgroup_total(struct cgroup *cgrp, enum psi_res res, bool some);
>   /* and/or an avg10/60/300 variant */
> 
> with DAMON migrated to it as the first in-tree user.

I'm sorry but I'm missing your points from here.  Could you elaborate why we
need the helper, and why DAMON should use it?

You're implementing your system in user-space, so I don't think you will use
that helper for your system.  DAMON has its internal implementation for reading
PSI.  What's the benefit of the helper compared to the current one?

Also that helper may be implemented inside PSI or cgroup subsystem and
maintained by the maintainers of the subsystems.  Are they willing to have this
and increase their maintenance burden?

> 
> Before I do anything: does this capability gap resonate with you - is
> per-cgroup PSI consumption something you'd want DAMON to grow into, or do
> you see it staying userspace-only? And if a helper makes sense, any
> preferred shape, or concerns about exposing the averaging/locking contract?
> I'd keep the first cut to just the read helper + DAMON migration; an
> in-kernel trigger callback I'd treat as a separate, later step and only if
> there's a second consumer.

Seems you have larger picture.  I don't clearly show what is it.  Could you
share it at a high level?  That might enlighten me.


Thanks,
SJ

[...]
