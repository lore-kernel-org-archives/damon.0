Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29BA8F7D;
	Thu,  2 Jan 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735856603; cv=none; b=Benm/1eybwaYKxiGDVAYYczsBV/E/9TwhiVyi0xv0uVziOC5XUdWl7rBWMfk41N6wHmRMWF87T6YXwph9tFzIoa1Pt85nWlNHNgAVm4sUX4ugkMU9gijvT51myyCrsOV7CxRygRYc20q4VMIe1xY6yycHWDogzSyqr2vns5m/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735856603; c=relaxed/simple;
	bh=5dpatxo75bVUWHkvAOwBL+wDSKuB6MEXFYZ5+4svAE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CxxGu/R3hIhNIpIdzHLJZlYI0xhS1fdY99LcGSkiLkUtuAkn7bKILhII2UQl21wZbXFqcSkYy0VxIMReaL1Doix/0Bnwx/f5rSVddHtdPuLyhhwJrFn7//rzeDztcIcpxJAgZejaE/AgD3xk/eK+HrX6bcSSFovoVF8AI1NRynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfGnQxA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfGnQxA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243F0C4CED0;
	Thu,  2 Jan 2025 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735856603;
	bh=5dpatxo75bVUWHkvAOwBL+wDSKuB6MEXFYZ5+4svAE8=;
	h=From:To:Cc:Subject:Date:From;
	b=rfGnQxA9KTzxjb3iyIw6nES0qCOC2/iFxwlcQPqNZvzpSaCCpH+mPDhDWKMRZ4c4/
	 /MOTE521MNGSbLL+W19SaAVGNQqMUhyhmxEFVcTgsi0UkTKRgwP7QKVu8opIb3SA1u
	 s1ouwpm9BwlaLu7h4nBZO/qNWcH5XOF4XP8JR64tEB6OUadlkM8uzUjIwmhNc5hJIv
	 onEajrqwz+iDFNDdN0O36pMTBLqhNXvHYor4reb56nW4TQTcR4ZMDlBrOR0cPv6d+c
	 +shRqeOUbnqwXr/0zrQfWDiC9jjWZcTmCh0y540jwV77kiKCEa1eTm/EIDE/uorDB0
	 WmtHFLTVzqAOg==
From: SeongJae Park <sj@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [LSF/MM/BPF TOPIC] DAMON Updates and Plans: Monitoring Parameters Auot-tuning and Memory Tiering
Date: Thu,  2 Jan 2025 14:23:17 -0800
Message-Id: <20250102222317.48760-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,


We started sharing and discussing DAMON's current status and future plans from
LSF/MM/BPF 2023.  Thanks to the constructive feedbacks from the discussions, I
believe DAMON is continuing the evolution in right or at least not
controversial directions.  To continue getting the benefit and avoid it becomes
an unexpected "demon" in early stage, I'd like to share and discuss followup
updates and new plans for DAMON once again on LSF/MM/BPF 2025.

Major topics and currently expected materials to share on the session include
below.  Of course, some changes could happen.

First, followups on work items that we discussed on last LSF/MM/BPF.

DAMOS auto-tuning based tiered memory manamgent.  No many progress has made so
far.  But I recently gained an access to a tiered memory system, and setting up
test environment.  Hopefully I will be able to share early RFC implementation
and evaluation results by the session.

Access/Contiguity-aware Memory Auto-scalging.  No progress has made so far,
too.  I'm pivoting this into reliable huge contig memory occupation
mechanism, though, since it is smaller scope that we can make faster.  It can
also be used for not only memory hotplugging based auto-scaling but also
contiguous memory allocation.  Hopefully early evaluation of a part of the
work, probably access-aware partial compaction, will be shared by the session.

Please refer to last year LSF/MM/BPF slides[1] for details of the above two
projects.

And new projects that currently in their early stages.

Page level properties-based access monitoring.  We are extending DAMOS filters
that works in page level properties to further be useful for monitoring
purpose.  RFC patch series for the essential part[1] is already available, and
user-space tool support[2] is made.  By the session, hopefully the patch series
will be merged in mm tree, and I will be able to share followup plans for
making it more lightweight and useful.

Extending DAMON for memory bandwidth monitoring.  We aim to extend DAMON to
support not only access pattern snapshot generation, but more general access
pattern information, like memory bandwidth usage.  I expect only rough idea
will be shared on the session, to make early alignemnt of the future shape, or
abortion.

Please let me know if you have interest in status of other projects that I
shared on last LSF/MM/BPF session or somewhere else.  Depending on that, the
topics and time portions can be changed.

Note that I proposed[3] yet another LSF/MM/BPF topic for DAMON.  If both are
accepted, please schedule this one before the other one.  I believe this
session can make the other session deduplicated and faster.

[1] https://github.com/damonitor/talks/blob/master/2024/lsfmmbpf/damon_lsfmmbpf_2024.pdf
[2] https://damonitor.github.io/posts/damon_sz_filter_passed/
[3] https://lore.kernel.org/20250101222039.74565-1-sj@kernel.org


Thanks,
SJ
