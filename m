Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55617BCC;
	Fri, 14 Jun 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387708; cv=none; b=MhNWWhqIzGikOzXmJrCY3zHvYqcbg9KElDkkVv5gZ3T7LZl6sXxW7JQNcLIxqqsg2YL3AGwM7sSzliFI+n+YH7qcv+un9W4EmCsZilwqAIhDJPXk6PX06fEDxtuwGpLW7w+9S5j7DqJmXK6TvTxka6bQBEu0n/uJSEQZTvbNzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387708; c=relaxed/simple;
	bh=X7crwSjtAikzkXUXQq6L5MyYcvne07jWwyU6ygV+oZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hazzkr8RxAM14gtzQTQCIN6SSOJs0IVkPbP9bOTI83VuZ6XM2NfQjGbPs4zCGeWCLBsJgTV9MN1dbWUpF17y7dirETI+gCPJeH1EGsFfUiIUdXxaiDHLDC5CulnirdgEYKO2RwmqYtOPvZPS8Xm8Sc0BXtiXOV3vE1YId6bsstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFY9VHuj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFY9VHuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB08EC2BD10;
	Fri, 14 Jun 2024 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718387708;
	bh=X7crwSjtAikzkXUXQq6L5MyYcvne07jWwyU6ygV+oZE=;
	h=From:To:Cc:Subject:Date:From;
	b=cFY9VHujpqGCImIP5ckXr1PbMDiNWmbQcbocNCjWoCvHU02NezTKJ85c/Lsz9n1Id
	 IZ4H8jWf+2Ztjgrnui7+RCFX7aDMsox3FkGdFPaAYHlmGxW0E4o8p/b9EUjCT1j7c8
	 1MufaKIMwOZA7Wf6nFK2eqcK6DQqop3CUiTXjIuEuEH4xOHYtXHPqyUy2I37Qa1yjm
	 PhoaATLYIgKIro48jH26YssLUzCzENeUS1csY1RgL9fVpoNu8ZqR2qSf28i1KKE/BX
	 HIjJbpMXz6WBmY6FaOHMWHUWRQeGgbBW3ZddzK6+LSCG4fErX/YOdBYQsobHQgBj5c
	 pyrJyi7DlqrvA==
From: SeongJae Park <sj@kernel.org>
To: ksummit@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	inux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [TECH TOPIC] DAMON: Updates and Plans
Date: Fri, 14 Jun 2024 10:55:04 -0700
Message-Id: <20240614175504.87365-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
