Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702714D718;
	Wed, 13 Nov 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515189; cv=none; b=ZG3eGxc4nMIj1tU1lD6PyXzRFD+679uflc0zQvlN1HLmnL250fPInf7bjTx4LwugG25bRRmrMinHv9YdmRzo8Ozc26MFLIM1RBYFslK/dErdhLOy0bHnHBB2/YDX8U8wieYWH85awnjRZNZcktCRXmhjj5WPd4rMUn/07uR2j5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515189; c=relaxed/simple;
	bh=lu4afOeyA3gjn2+gU9Vq22h9ysqBc+RxwLwDEiwVRQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FdVihimFsxS9142heMT5b9kpRmjoHTbRFrf1gQziDieQIVmbRDG4GNxN26HNtZL6WRptonp2cFyMVDZ3g2WqlVVmN5kVLO9GCYb+r3vu+0hp67PQT7sA/+x692pO0y5iG79XnQ3yjgKZENK/OROWMbv9XOsdBZp8Vk8tm94wRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmP7y63B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmP7y63B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD42EC4CEC3;
	Wed, 13 Nov 2024 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731515188;
	bh=lu4afOeyA3gjn2+gU9Vq22h9ysqBc+RxwLwDEiwVRQI=;
	h=From:To:Cc:Subject:Date:From;
	b=KmP7y63BBznDTA920Sv39mej0SzXYo58nzeNuX5D91qXDVQMFMBxwGDutuRbgmirL
	 h+8z5TLquoo7MP23Qzh+auw4PNdltxbTzITq1nG+i5rQ1WqxkKsnatuYTWCOyoFShj
	 RUWvnfn7Sx7ggIgYgBtA9wQIpY3TGdWyUYJaI9lt+oQNIdxOVCRcOVrNXVti/JY1hn
	 uBiPv3zl4VLHXe6dbExpECMKZXHuA+4v+fz/PTQKejc5gCa6agDRox4ZrACT2Jz6D+
	 ER/FYyAzZkM4/W3WdDC4wykyrp5FDNIelTydM/efBMjfXZaYejVaNe7bRjTTV/u3js
	 IP230N8fyu8Xw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 0/5] mm/damon: add sample modules under samples/damon/
Date: Wed, 13 Nov 2024 08:26:19 -0800
Message-Id: <20241113162624.48973-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON is a kernel framework that provides API for other subsystems or
modules in the kernel space.  The API functions have their own
kernel-doc comments, and DAMON modules including DAMON_SYSFS,
DAMON_RECLAIM, and DAMON_LRU_SORT can be used as a refernce usages.
However, kernel-doc is not very easy for beginner, and the existing
DAMON modules for real usage are bit complicated.  Add sample DAMON
modules showing basic usage of DAMON kernel API.

Note that some of the code for similar purpose that I used at kernel
summit 2021 DAMON live coding session[1] is reused here.

[1] https://linuxplumbersconf.org/event/11/contributions/984/

SeongJae Park (5):
  samples: introduce a skeleton of a sample DAMON module for working set
    size estimation
  samples/damon/wsse: implement DAMON starting and stopping
  samples/damon/wsse: implement working set size estimation and logging
  samples/damon: introduce a skeleton of a smaple DAMON module for
    proactive reclamation
  samples/damon/prcl: implement schemes setup

 MAINTAINERS            |   1 +
 samples/Kconfig        |   2 +
 samples/Makefile       |   2 +
 samples/damon/Kconfig  |  30 +++++++++
 samples/damon/Makefile |   4 ++
 samples/damon/prcl.c   | 138 +++++++++++++++++++++++++++++++++++++++++
 samples/damon/wsse.c   | 120 +++++++++++++++++++++++++++++++++++
 7 files changed, 297 insertions(+)
 create mode 100644 samples/damon/Kconfig
 create mode 100644 samples/damon/Makefile
 create mode 100644 samples/damon/prcl.c
 create mode 100644 samples/damon/wsse.c


base-commit: 981cf179b2760af4215419c67a801ec5d028a546
-- 
2.39.5

