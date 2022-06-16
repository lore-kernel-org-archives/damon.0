Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E7C2F42;
	Thu, 16 Jun 2022 22:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCAAC34114;
	Thu, 16 Jun 2022 22:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655419389;
	bh=kfQarxH/56UT/XY118hOydrKuncAQiLkLupR53PFGck=;
	h=From:To:Cc:Subject:Date:From;
	b=XM/dze1GtQVrVsN2MD2FyK3sEW3Qv6oy6PvPJPdBbvr+LtmbHCSrKJpYygpMWrPeS
	 VWLtmU/OnSSAUz2TBfyUjnYc/Q4VQqH71CvMbuCYiOuJRVDVh9TqXQ8aXcBIv50kLq
	 aCr5xISTdd+sSKQqRDKIRXn88yxHBdbHT1lDuXocYR4vRkQdmv1PsQwZ9XfnicEy9y
	 CEoUyN+aYUlivl5+eX5TK/ZDjNAIhe4e9d5pQRXaPHn3oDrYEJP0Wt30D4f+LRwMbO
	 Umba7WGdoI0gqaF10PJ5EE/2s4F9vImCJvhLMCW6DaVhyMYXXfrkpK8d6yHCSkG3vH
	 fjet+FLpzz/iQ==
From: SeongJae Park <sj@kernel.org>
To: ksummit-discuss@lists.linuxfoundation.org,
	ksummit@lists.linux.dev
Cc: linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [TECH TOPIC] Current Status and Future Plans of DAMON
Date: Thu, 16 Jun 2022 22:43:06 +0000
Message-Id: <20220616224306.92076-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,


I'm posing my Kernel Summit topic suggestion as below.  I will also submit it
on LPC site.


DAMON[1] is Linux kernel's data access monitoring framework that provides
best-effort accuracy under user-specified overhead range.  It has been about
one year after it has been merged in the mainline.  Meanwhile, we received a
number of new voices for DAMON from users and made efforts for answering to
those.  Nevertheless, many things to do for that are remaining.

This talk will share what such voices we received, what patches are developed
or under development for those, what requests are still under plan only, and
what the plans are.  With that, hopefully we will have discussions that will be
helpful for improving and prioritizing the plans and specific tasks, and
finding new requirements.

Specific sub-topics will include, but not limited to:

- Making DAMON ABI more stable and flexibile
- Extending DAMON for more usages
- Improving DAMON accuracy
- DAMON-based kernel/user space optimization policies
- Making user space DAMON policies more efficient
- Making kernel space DAMON policies just work (auto-tuning)

[1] https://damonitor.github.io


Thanks,
SJ
