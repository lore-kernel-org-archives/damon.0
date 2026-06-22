Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB9B640;
	Mon, 22 Jun 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141884; cv=none; b=Tccg1lPrDhHlpnqJua2ztfidxyZOTWQti6RUad8GrS06rPtUD+gfdFO7YNDeKXPmc21AG/AZKd7MH2/TMtZfYb1zZR+LhV0rBgDaexGpZSCaafWQMV9VSHBMLNiPbA58ver6K0PVJd9fCWLlDZ+EfiSPS/fNJj0PsfQR9nBAPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141884; c=relaxed/simple;
	bh=GOqrwno8peDDCuPmOw0aLZQLfeS43smmrR9SHk4ERC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRS91z/dVVtSxWc2Lql2tNLGBFXsMcYz5sUQH6l8531lerbwceTwb12sBS8Tyc45lXOfIZpA/6PYnGYm7ViiqEppQt/qrZlhr2hRQi6+Je1N79krVFhOU8jAdeCm0x4JJLsEL7+7lum4TPDnmp0aLYnRWez7yogD8lymRHxlMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=capR852c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="capR852c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37031F00A3A;
	Mon, 22 Jun 2026 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782141882;
	bh=v/7JLpCVAOrmGznTvr/mcoaVuKnUl+ivQA+JolHqsiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=capR852cI47C9SpOoLeVKzi8B+YEOzzDrP4iN5DnPW2w7ZkX7WI+p1T64TN4wINuj
	 tMtb7cCbmX2rVLqAJheMcfQ8Jt55qg4tVQQIjIzkwPe7/AD4VQpcvzAKdux3Twvnwr
	 GiH3nQLaUO0csq2RtevjjPlGr5W7iVLWpP32eamsTy9k1WzmRqWp/YWn8GOfZIBJ1C
	 puqcWfJTf+6GvStaPaaFwB2XHGRv4EcMi7otpjPaHs405wV+Mzfj6QDc3qE+JlBaoz
	 AhUA6CgcnjZshEDv6oiKqAcZ84jcBzzYjmia7NeW1m5ddmCZ9jkbrCxFR0BJXSRLLJ
	 Cgry2tjgnYvBA==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	ravis.opensrc@gmail.com
Subject: Re: [RFC PATCH 0/2] damo: support perf event configuration
Date: Mon, 22 Jun 2026 08:24:32 -0700
Message-ID: <20260622152432.32788-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622134933.35773-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Akinobu,

On Mon, 22 Jun 2026 22:49:31 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This patch set aims to make it easier to specify the perf event settings
> proposed for DAMON by Ravi's hardware-sampled access reports patch set [1]
> from the damo tool.

Seems this patch is built on top of the per-CPU/thread/read/write monitoring
patch series [1].  We made a plan [2] to use another user interface, though.
The plan is, making the interface ready for page table accessed bits based
monitoring by LPC'26 (milestone 1), and implementing the perf event based
monitoring on top of it, by LSFMMBPF'27 (milestone 2).

So the eventual damo part change for supporting perf event based monitoring
will be quite different from this series.  I guess you are sharing this series
not because you aiming to merge it as is right now, but just for sharing the
code with other stakeholders like Ravis, not me?  If I'm not wrong, I will skip
this series for now, to focus on the milestone 1.

Please let me know if you want more of my feedback.

[1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org
[2] https://lore.kernel.org/20260525225208.1179-1-sj@kernel.org/


Thanks,
SJ

[...]
