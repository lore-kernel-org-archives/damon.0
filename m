Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA22EC57C
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782365137; cv=none; b=B4tDQM84F7V0cvioFfTN8pqRiupQONMmXzQpd/jONJreLB+EQh6snWxj4BW6pVMiLMOzbkjpfi1MDhKUBlEE9b0adqGP8EGrowLXBfk2nVSGlYdXf/loOxwNh8+Zsc3nIa4LIl+bjlqcqAdq0BScr+D3Q0bJ6k+UHu3f77i5k/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782365137; c=relaxed/simple;
	bh=M/8nPvQXO6LiZ4xdWaVFs7yGxq1nwYE+9ZmYuVr/1DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vh6NwFM4Ta5Cnmf5GmCFFU54r/JckbGckssOzB7WSoMzvV+60RYuVY+JLCpjXUkMynJC9xXQAbJrFKbC3COnwDedETx99ng7/rmlwYxzop5O0FqJgERWytDbeebM6BItfpXogv7tEFzgNmmm6Nc/z76HXEyPcz+6xCiaZTiXoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrYbcyRS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrYbcyRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A301F000E9;
	Thu, 25 Jun 2026 05:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782365135;
	bh=yDfqOrnClq3YZyN0+dcIY317LkD9GEJEAc9Vcak6nfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HrYbcyRSYQGL1C5fDXl+dMKczZaHGndK7TkUFQGLiGrbrCGLl/LVt2nl53Avb6a8u
	 J37/AdOZpwLAjU0wccOvoHbp3PkmdEiR1SRR+9/RCdO+rpQQgm9yyulbPuUi+fn196
	 qy2QxL/ZY0udwRpadGqwssLiBDx/Uzmy4IduEzwhbKx6hkr8+3iElNbEZJsNBo+GmE
	 W7wsH6hk8wo3qcAOzhaPu2mZF/3+SaM4hkJr/AcGzWVNCwnsHxTsvEQ7iiZOYCWuql
	 UXjafU5YvD8QTTT6wFx4cYXv16ORQG145O9n7xLILch2SGJh/eMc18Fb5NipunK/Ca
	 rmdmo6ydQZfuA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 02/11] Docs/ABI/damon: document probe files
Date: Wed, 24 Jun 2026 22:25:19 -0700
Message-ID: <20260625052520.92614-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625051413.972291F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Jun 2026 05:14:13 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incorrect sysfs value 'memmcg' and typographical errors in DAMON probe ABI documentation.
> --
> 
> commit 0777dacf66fdc3cce9315b7348cc989aa1d048f8
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/ABI/damon: document probe files
> 
> This commit updates the DAMON ABI documentation to include the new DAMON
> probe sysfs files, defining directories for probes, filters, and attributes.
> 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > index b73e6bc28ea5f..2815f6bc05c18 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> [ ... ]
> > +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/path
> > +Date:		May 2026
> > +Contact:	SeongJae Park <sj@kernel.org>
> > +Description:	If 'memmcg' is written to the 'type' file, writing to and
> > +		reading from this file sets and geets the path to the memory
> > +		cgroup of the interest.
> 
> [Severity: Medium]
> Is the expected type value documented correctly here? The documentation
> instructs users to write 'memmcg' to the type file, but the underlying kernel
> code strictly expects 'memcg'. If userspace follows this documentation, will
> the kernel reject the input with an -EINVAL error?
> 
> Also, this isn't a bug, but there is a typo in this sentence where "geets"
> is written instead of "gets".

Good catches.  Those are typos.  Somehow nowadays my computer shows lags at
multiple things including BT keyboard input catch...

I will fix these in the next revision.



Thanks,
SJ

[...]
