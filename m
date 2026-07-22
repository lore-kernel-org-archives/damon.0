Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7012701B6;
	Wed, 22 Jul 2026 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691530; cv=none; b=mRz6JcKLOcNHcFVi8vjtYdWWr1ywV58OXekykNovLwRyf/Tq1RBeI6AgeFzHXcKrcsTyn/WD2TkDpnsQpZ5qkZUojB5mpBdZDOhckLB/Gfy8y3T4f8yOHsxmzAjzGaLoJzhEzk/lrtYVKtmsghaGItcCuTb/ux1xLJZORpb6z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691530; c=relaxed/simple;
	bh=C7pnEv30UL2apIXoqhDGGpfTa1vk+xE/IQIDNNuTYNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVJLb89mXzbcj/DGubUIuhxlS9Iw9xzT/9gMXFJJvAERr2jlKI9j4lsti3VSVBSEFMdvJRAUDbZ5aESc3fzlzgaqfgJjBjmySGvcEfkWHe9fWjmXPrV1hHwIy1jQxk5MKkrJthzwiB/3hwN1cYrze55t52mF5DMztYl+6oaFgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1mHLtI7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1mHLtI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746F41F000E9;
	Wed, 22 Jul 2026 03:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784691527;
	bh=UAy98DxP2a6qgmrCD2pTqB0OlrzwMe79Zf/ee8Jin8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1mHLtI7CkASP+B1icQb/p3xQpyVMJh/OShuLI3OH7Co0vW0CTpwtf14zEbEDmiVr
	 rllH32jC/kP99DLN4xtgtVBzCcHzomRkkw9ALW3CjbbCltNtkz15fsnzRFosCxiqxD
	 EGKEyBx+Tt8STjZj18FIpuV3+mk0CHn/UvkAfRv3U+sRzSGgJYxBeGQsbIUSyf1HIy
	 3KG2dMLki3+hknDlTGPHkelQS6aDlmYU0HUtpLZmI1zQqTEnDBYNUZ2MN9spVJKzqo
	 +S5FJdCzDShQ3oEVrfeD1eMCzKaQPoLbYECwcXBhbOkORTfA2NzXi7acKx3ukU7YMM
	 nTcHKfJqfwOhQ==
From: SJ Park <sj@kernel.org>
To: Hari Mishal <harimishal1@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/damon/sysfs.py: clean up sh processes used for obsolete_target test
Date: Tue, 21 Jul 2026 20:38:43 -0700
Message-ID: <20260722033844.65932-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722012349.9738-1-harimishal1@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Hari,


From the next time, please don't post a new version of a patch as a reply to
the previous version.  Post a new version as a new thread, with changelogs [1]
including links to previous revisions.

Also, give others sufficient time, say, one day, to add comments before posting
a new version.  If someone publicly asked questions to your patch, please
answer the questions and keep the discussion in public until the discussion is
clearly completed, before posting a new version.

On Wed, 22 Jul 2026 03:23:49 +0200 Hari Mishal <harimishal1@gmail.com> wrote:

> The obsolete_target test spawns three sh processes and uses their pids
> as DAMON monitoring targets.  These processes are never terminated or
> waited on, so they are left running (or become zombies) as orphaned
> children after the test program exits.
> 
> Terminate each process and communicate() with it after the targets are
> no longer needed, so it exits and gets reaped instead of being leaked.

Makes sense to me.  Thank you for this patch.

> 
> Signed-off-by: Hari Mishal <harimishal1@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

> ---
> v2: Terminate each sh process directly instead of giving it its own
>     stdin pipe to close, dropping the stdin=PIPE changes and shrinking
>     the diff.

When you add changelog, please add links to the previous revisions.

Finally, please use mm-new [2] as the baseline of DAMON patches from the next
time.

This patch is applied to damon/next [2] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary
[2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
