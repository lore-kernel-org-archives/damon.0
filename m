Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3540F743;
	Wed, 22 Jul 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729351; cv=none; b=E8c+I4/JjYvpQD3TebQVYCZy7hX0yoA92BHqx+5S0iEEHbVPLvWomSOZlATxGzfhFoYtIjyXWGZYkoiNbVPtdlwBcOMzrpPHbkl9hPi0kNSAFZSENA9bnPdWeeEQYvsVlpQT1d5lafyaXB2vilMaCRzK4xyJ+/LFbPNwJIoYLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729351; c=relaxed/simple;
	bh=YbNnV3a4P4x/aqBsjjtzQhD+uzPSibI5GGminfGOqCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDluA3xDhL7YvhKppzaFu703B8Y9ftm3ojogFMIjhtOURghQDFCKHhQFaHxDWjHjbWNJqADNWNgd3Yom8GPuTra0XMYUiFUtbMXCFfBoTFh+yq+n1mo4mO3VBmisuyGoar/TW2gMNBMV/cDq0Lvkz+8JvbBiww2j3hCBWGtPCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz3kRrJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz3kRrJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA9D1F000E9;
	Wed, 22 Jul 2026 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784729350;
	bh=MwsIFMPOJLP1rXOSs1f475mi2DZhSqUvSoRoP3+rwqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cz3kRrJ5L4WG+dsZ+kik0DlXJpH65xVvgsOF+JCN8tD7d33O1FbXzElMu/VMvV7V5
	 lqdD2NpqJb1hOzQupLGwkEOR7SfVQCqHO0ciaj06RB43MXjeJ7QcjsaZCfpVtU/Wam
	 /Kob4qnZLcz3AfKgyzKozC/nK0peFQH8O2F3n97cKz4fgxJNoYQ9ySz4IJ8zRullM3
	 zQDx69g0ss6vLPehobv/FOQnloBwFsXn20qoN/Hp3V7WBH4tqGjSsPD0AVy3SfTW7/
	 idqTQTzSQ4s4w8Wjlp3sa37hXxEYMB9th0MnCd84vVT8ssaTURvsel0+ZggC45iYK/
	 /WksPR1d/8IeA==
From: SJ Park <sj@kernel.org>
To: Cheng-Han Wu <hank20010209@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 0/2] mm/damon/core: remove unused helper functions
Date: Wed, 22 Jul 2026 07:09:01 -0700
Message-ID: <20260722140901.91476-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722113338.302603-1-hank20010209@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 Jul 2026 19:33:36 +0800 Cheng-Han Wu <hank20010209@gmail.com> wrote:

> Both damon_targets_empty() and damon_nr_running_ctxs() have had no
> in-tree users since commit 5ec4333b1967 ("mm/damon: remove DAMON
> debugfs interface") removed their remaining callers.
> 
> Remove the unused declarations and definitions.
> 
> Tested with:
>   make O=../linux-build-mm W=1 mm/damon

Nice catch and cleanup, thnk you!


I applied  this patch to damon/next [1] tree.  We are now quite close to next
merge window.  We (mm community) want to focus on making mm.git more stabilized
and therefore ready for the next merge window, rather than adding more changes
that are not really urgent.  I understand this series is not really urgent.
Hence, Andrew might not add this patch until next -rc1 release.  In the case, I
will request adding this to mm.git after next -rc1 release.  So, no action from
your side is needed for now.  Let me know if you think this is really  urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
