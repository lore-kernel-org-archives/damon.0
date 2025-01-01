Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B7182BC;
	Wed,  1 Jan 2025 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735770054; cv=none; b=QEW7fjHvOth8ZuzkbZBTEzTWOH6hmODwzW9WfH8CAOBxYE0zgd6FQjFV2cEOvmnsbHMewN4NMOqhtxb7fxE0IoVbESa9KJsypM8FpfRINrHH4p6Qq7xHjN330jwElnueQliPZ5x2ykEzSV33Nmyv4RM7w1awaVRm+9C413rsZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735770054; c=relaxed/simple;
	bh=W13su0YM1CgChEuOWt5Lu5NzOYs8WjesLwcSoGRpfr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MaIyrKBGMvXNzbmzPTTBK6ztisH+HtiAi1vov4E/8fwsFeZ1Z7Jr72ZZenPHFR9s9nuKaCCC/o+mx7vpdW+gLY+MWkKGtLGBtrzgqKY1gNqgtIbP9URWmElCp+wNyTmIYYcibgWrFpd9fazvijyzW1iMKv3JNvcb/xrsI5AS+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1ijTjBp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1ijTjBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25677C4CECE;
	Wed,  1 Jan 2025 22:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735770053;
	bh=W13su0YM1CgChEuOWt5Lu5NzOYs8WjesLwcSoGRpfr0=;
	h=From:To:Cc:Subject:Date:From;
	b=h1ijTjBpVQlwJja1qWTO2wF5W0i1uY6D1t/ddebSG4D55o0MS7xAeN0PCsKwQez9a
	 JBrT0+iLaiBsRZRa0P3opXzS2vBenful+XaKHFG9KLjjUxt5deWDMuZjOvLNPiqrRR
	 2e2Ph5RTfgu3FJF/Q4UPtoSVI8sIQBlrgBE+GTrNwSHxoPxmvtIQj39UyEv/rbScNa
	 gf7u2Ve3mGY4l+YWeu0/y8Lhm8AXwOMu31kccLioaGYH6ZCyDV09teavDQQvkuhCCr
	 ES+XWhzKi6F2YmkVNrUXgsYIk+eW5fuOpXzFz0iq3mPIsBFBvZOxyeqKB1PFr1AK31
	 t7W2KNNqFagzg==
From: SeongJae Park <sj@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Raghavendra K T <raghavendra.kt@amd.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gregory Price <gourry@gourry.net>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of Future
Date: Wed,  1 Jan 2025 14:20:39 -0800
Message-Id: <20250101222039.74565-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,


I find a few interesting and promising projects that aim to do efficient access
pattern-aware memory management of near future, including below (alphabetically
sorted).

- CXL hotness monitoring unit
  (https://lore.kernel.org/20241121101845.1815660-1-Jonathan.Cameron@huawei.com)
- Memory tiering fainess by per-cgroup control of promotion and demotion
  (https://lore.kernel.org/20241108190152.3587484-1-kaiyang2@cs.cmu.edu)
- Promotion of unmapped page cache folios
  (https://lore.kernel.org/20241210213744.2968-1-gourry@gourry.net)
- Slow-tier page promotion based on PTE A bit
  (https://lore.kernel.org/20241201153818.2633616-1-raghavendra.kt@amd.com)
- Workingset reporting
  (https://lore.kernel.org/20241127025728.3689245-1-yuanchu@google.com)

The goal of DAMON is to help accelerating such developments by being a
framework that can reduce fundamental efforts for monitoring memory access
patterns and managing memory using the information.  AWS Aurora Serverless v2
and SK hynix are successfully using DAMON in the way for proactive memory
reclamation[1] and CXL memory tiering[2].

To further deliver such benefits for the ongoing and future projects, we need
to better understand what the projects really need, how DAMON can provide those
now or in future, and if there are alternatives better than DAMON.  Regardless
of the conclusion about DAMON, the works apparently have common parts, so the
discussion will benefit all.

I propose to have the discussion at LSF/MM/BPF.  In the session, I will briefly
introduce the works and possible DAMON usages, and continue the open discussion
for better understanding each other.  The discussion will not be limited to
DAMON and abovely mentioned projects but possible alternatives and general
access-aware memory management projects.  After the discussion, we will
hopefully find ways to efficiently collaborate, or at least do not disturb each
other.

[1] https://assets.amazon.science/ee/a4/41ff11374f2f865e5e24de11bd17/resource-management-in-aurora-serverless.pdf
[2] https://github.com/skhynix/hmsdk/wiki/Capacity-Expansion


Thanks,
SJ
