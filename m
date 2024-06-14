Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD125601;
	Fri, 14 Jun 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390568; cv=none; b=OZEbl+JzZXxNBpr0pmp+nvLVqIqWdqgyHLmfWBCqyq5uQJ8ZNAbLpDhHm0NN5GtDAYt9w4spvK7PpKBWM3zGdtz3B/mLL+m/opqUpQgryLzZTYDs3bi3/xbCq/U+QEu8OXhk0Llie3vzeD1v5HZoLhIlRL4trly0dar0S8ZQ6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390568; c=relaxed/simple;
	bh=r3V8uORqgOShk02c6OFxElT3YBFjzYzIlhjvqyeiKeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cT0aUcCQdHKJ/zhaCMD/sOVOUlGBwJs2wjEgAmR4bpW7MZhNSJh3Lb8J2yuXIU67H7jAzxC5f7cst/oNkuaD8Wwbt+5hFhVmSI3RNR37ZKHrNAMXcvvgh1U9+ElLs2e6dMBp80YvI1/8pfauDbfO6aaF/OeMVOip9LCQ+tq1fLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvU8f1C3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvU8f1C3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA22BC2BD10;
	Fri, 14 Jun 2024 18:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718390568;
	bh=r3V8uORqgOShk02c6OFxElT3YBFjzYzIlhjvqyeiKeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvU8f1C3HJ9SSrYwuhffp9UEDc4x9qJIVsqb6Os26CMYNefSixh2EtYTwr7O7VAWc
	 1dNaUxYLtJoDgPbpIcGdFSV6nJ/quG4kuIeP+VkvTslQjfoz5L5bjsPTsl2AjEW1/u
	 905s7Zo7dg8T1C1PBrgoLhELthL1rMv5bOKpsTuabukAUnVhMUguUGRPAy7x66C6Nw
	 c+MGbaELnbrs8ewiKPP6thQCJgtthNHS3Py9fdheQN0Y/n4HunywKw7hNK6BQ5l1Wb
	 Bch0NCjLskk9ii/XfStNKB6dCnKZ101b7h9HcRfoUsR6hWZdll1HG8XIzypiSmjaKu
	 FKKmtt/t891ww==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: ksummit@lists.linux.dev,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Fwd: [TECH TOPIC] DAMON: Updates and Plans
Date: Fri, 14 Jun 2024 11:42:45 -0700
Message-Id: <20240614184245.88080-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614175504.87365-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I made a typo on the mail address for linux-mm@, on the original mail.  So
forwarding to linux-mm@ as a reply-to-all.  Sorry for making noise.

================================= >8 ========================================

Hello all,


I'm posting my Kernel Summit topic suggestion below.  I will also submit it to
the LPC site.


DAMON[1,2] is a Linux kernel subsystem that provides efficient data access
monitoring and access-aware system operations (DAMON-based Operation Schemes,
a.k.a DAMOS).  From multiple use cases of it including multiple years of real
world products' usage, it is proven to be useful for improving memory
efficiency.

Like many other Linux kernel projects, DAMON is developed by the community.  We
proactively present the status and discuss future plans of DAMON with the
community.  As a major part of the effort, we had a DAMON session every year at
Kernel Summit[3-7].  Those sessions have been one of the most essential and
effectful fuels of the project.

This session will continue the sharing and discussion at the kernel summit of
2024.  We will share what feedback we received, what patches have been
developed or are under development, what requests are still in the planning
stage, and what the plans are.  With that, hopefully we will have discussions
that will be helpful for improving and prioritizing the plans and specific
tasks, and finding new requirements.

Specific sub-topics would include, but are not limited to:

- Fine-grained DAMOS control
- Automated tuning of DAMOS
- Tiered-memory management
- Access/Contiguity-aware Memory Auto-scaling
- Write-only monitoring and live migration

Based on the progress until the summit, some items can be added or dropped.

[1] project homepage, https://damonitor.github.io
[2] official doc, https://docs.kernel.org/mm/damon/index.html
[3] ksummit 2019, https://linuxplumbersconf.org/event/4/contributions/548/
[4] ksummit 2020, https://www.linuxplumbersconf.org/event/7/contributions/659/
[5] ksummit 2021, https://linuxplumbersconf.org/event/11/contributions/984/
[6] ksummit 2022, https://lpc.events/event/16/contributions/1224/
[7] ksummit 2023, https://lpc.events/event/17/contributions/1624/


Thanks,
SJ
