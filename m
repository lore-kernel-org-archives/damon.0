Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC353546EB;
	Sun, 31 May 2026 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246487; cv=none; b=In3Es1goAtR0x41C1x81G/WjaEXJcFzAoioXxZDqwhO2CdYKArAGsMILk7RPNtwJ4vrND21tzoFs4grlLRtqAOR2++/REj9B6+6jG5747YOQSVZ0nTCBR2GzVjDlLV9+pR4BJOpOpTJO7335aDpRy+yYQZTByJtZqX9+a5S03Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246487; c=relaxed/simple;
	bh=whf+LvG8vN5IgqK/zShnfRKq1s31SOdSn8V5EwdZkYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzKiKz0tK14WtVDd+ubjkIu6+xONiWPVrE8WcmgsQOyjbFMAgFthzCUyD5pCIbz0t1+6duVbE4o3aP5ppXI3mRoAZa0Xj8ij+5muQ+9PkpM3nKMHbdgSQZkmb4Vt9I+umeYlXd7oMYQa/vCs3PPus98XWKH1CSTOpZKEyZg0MJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHSnVtfW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHSnVtfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F94E1F00893;
	Sun, 31 May 2026 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780246486;
	bh=DxNfjlt8z6ra/rBSB/w2v0ydMZ2aKkX0YJFO0NVjmRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DHSnVtfWrjD47T/hXx9+C2HLPFW1gEiP+3fvg77a646RvPO5OVH/UshZcO60Vwhj/
	 h2qaXmpCXYhMCwutStXqyrzo2sR6P07O/xM+4oSUr98tT9wGhYcuUBYIsPF9E7RHLB
	 WjgsEOvn/ISIk5GosPPU2wC1nU26GZX3LPyPMnlUMN/IyuBOsOts+iRYN1QM8PrUdY
	 zDwmwDCnrmXWSwdxTrhqEaAGlaaZiNshzM6uPKnHSArATFYJTq3cxgxKFfrFh1r9Jg
	 VWFaqGOuO5g78m/pAxQOOpc29LvEZqGSvJR80sZ8vZmBHvi8kQSnonv1OObpLxq71B
	 r0LUX7qAcoOdQ==
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
Subject: Re: [PATCH 4/5] selftests/damon/damos_tried_regions: handle empty tried regions in early cycles
Date: Sun, 31 May 2026 09:54:36 -0700
Message-ID: <20260531165437.99410-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531091724.84381-4-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 31 May 2026 17:17:23 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:

> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> The test aborts if the initial aggregation cycles produce zero
> tried regions.  This can happen on slow machines, causing false
> failures.  Skip empty cycles and retry up to 200 times before
> giving up.  Also check that enough samples were collected before
> computing the 50th percentile.

I agree this will make the test be more reliable.  I'm bit concerned if 200
times retry can make the test run too long, though.

Also, could you further elaborate why this can fail on slow machines?  That is,
DAMON will check the access of 'access_memory_even' process every 5ms.  Are you
thinking the 5ms is too short for 'access_memory_event' to make the expected
access (accessing the 7 regins of 10 MiB size) within?  If so, should we
increase the sampling interval before retrying?

I also suspect if the unreliable results you seen is due to the fact that DAMON
is not flushing TLB, like we discussed before.  If that's the case, could we
increase the working set size of this test, similar to the wss_estimation test?

[1] https://lore.kernel.org/20260525144846.604907-1-kunwu.chan@linux.dev


Thanks,
SJ

[...]
