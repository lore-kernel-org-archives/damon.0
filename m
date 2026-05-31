Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA37306752;
	Sun, 31 May 2026 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246767; cv=none; b=ClDyR+nh2tBJBOhoMJ7GSdHqtvQ4qWj2Kv/6S7my8p8LzF7mYFmI1FP8B5IO0IfeJuqJo3kG6m/QTfVRQ/I1hBBXRF8auhmn8we6S6HAjnA7S+YTxZsPCbMkWBZH2vW0CHfAxSASRygbBAkzmjZ/gZ6kqwo41Dd/miGCo/uOFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246767; c=relaxed/simple;
	bh=BBKNYQ7uwSI2FZ9Z+kVg1MCK+yNomuLo9hJMOqnQuZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SySwgbfwm4acynlBvFRI6Y9fgZoe/i0Wg8Wgwh7l+3ETO8S6s+BlTTU7dvG/gAVDZqvMePlFMgIj1ZEUsrnwglPBWYy5Waio1RcBk6jwjil+rl6Q4PjT92Dg457gSLxbZ3UfL6WnGpthwiw8QD9pdFosjCbOFfuwcyr2S2EHivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMsr4u3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMsr4u3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F071F00893;
	Sun, 31 May 2026 16:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780246766;
	bh=nrT+q/sFejGms772rTU3bPFIOL/KvZhb0vOS6qeCZ8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JMsr4u3hZLzTZFrTd6WQOzGuUNvqjWRPyTyjgyKhnaYW9wIaCnQVEkMvtMFsCHYmZ
	 QC5/K9t/6KKkHZKrZFzw4ZP4Nw8/pTs3jaS9MG8n3np9c7wQoe8JYI8ibIkV5zrHDL
	 Q9QwZpK1O757FvlkEBqgB4uGZ9n7+rOunVbz1k88uj6OLo/xPf+w9zSPEZcYLrl+RC
	 AOc+WhBYSDGPw5YpwHX1CUgHMWEluii8ttBMIvFJoyeMMI0Sdl4GdyDyYYHNGxeSHT
	 YumtZ55eaTLZ1cSpF3x8pl1FCMV27JWv5shf/05b4Lj1CP9f7SC1Q/NKOxW8HeUyPR
	 yHc54751Te4Pw==
From: SeongJae Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 5/5] selftests/damon: fix dead code, skipped checks, and broken lookups
Date: Sun, 31 May 2026 09:59:22 -0700
Message-ID: <20260531165923.99684-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531091724.84381-5-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 31 May 2026 17:17:24 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:

> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> 'hugeapge_size' in drgn_dump_damon_status.py was a dead elif branch.
> $fail_reason in sysfs.sh was undefined, silently emptying the error
> message.  'exit' instead of 'exist' in sysfs.sh skipped a file
> existence check.  'nohugeapge' in sysfs.py broke an action dict
> lookup.
> 
> Fix other wrong strings in the same files.

Good eyes!  Thank you for fixing these!

> 
> Co-developed-by: Wang Lian <lianux.mm@gmail.com>
> Signed-off-by: Wang Lian <lianux.mm@gmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Checkpatch.pl will warn as below, and it should be fixed.

WARNING: From:/Signed-off-by: email address mismatch: 'From: Kunwu Chan <kunwu.chan@gmail.com>' != 'Signed-off-by: Kunwu Chan <chentao@kylinos.cn>'

Other than that,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
