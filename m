Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A3B67D;
	Tue,  1 Oct 2024 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742299; cv=none; b=teddnJ+iFR9bBFLAjF79UJ1ZwLUoqZmZKCOiLw7+6m0t61S6PJzhwivedGC6rxI2bzZfHrVo2wb1kzobW00L2cvts7LhOJWuIWHf7gWOSyEnCoNU5SL7dvbQIgwDX3D6vA2on5GHt2U9tcbLdJM/sNrrnoqzJlShrWhumWD+YRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742299; c=relaxed/simple;
	bh=uCi8FZAUBCp8PctpTkjzSSZRmnhrDQzi/kGGWkQE/8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rK9bzTIG6zQDkDsRRZ4qdic9xNLHGynd9a80DebSYXBPdV9jEfXr5PoftVQQZd0Fth3tWHGkFIzNePZw93RSCc+a2KTBrzGLK6sB9ujaCiWQF6bh4W7d3mDWnnmTJ1fDq9YZr0AGdNHLvaUYjAYAUhnobZ6jSH7kxdhrTcW9/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMyzXyjd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMyzXyjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C88DC4CEC7;
	Tue,  1 Oct 2024 00:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727742298;
	bh=uCi8FZAUBCp8PctpTkjzSSZRmnhrDQzi/kGGWkQE/8c=;
	h=From:To:Cc:Subject:Date:From;
	b=NMyzXyjd0PiLJMrdw8SO8ZrsYLWQEryDYYfQ19QoO72bA8ufT8udKC8deMBSpi2c4
	 su4g1NTDvk/+yAEJcbBfQxgZnkjPirTFMBXbl1Hz2etyu9CRzriBNSw4bSQsmlFhbY
	 4KzH7OTH56HgcsZ+Cm6jVoM5nU8Rb3ZW8qErROjV0xSafYg3A0ITLoAi569Bc0ZaGE
	 p2m4GuL8zbtYBNskCT5cLHKdFIndJ0KQTqnozqT3GX4BQqq0PINHSdp+oH39886q6A
	 ByFlja4ThSZ8uiE5b19Ciah81EFVkZi6wMyLnjuD6AjN9FhWFs0TL4h8GDyZokM4uO
	 dBSOjbE1cAwig==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Fwd: DAMON Quaterly News Letter (2024 Q2)
Date: Mon, 30 Sep 2024 17:24:48 -0700
Message-ID: <20241001002449.515043-1-sj@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


I just realized that I made a typo to recipients field for DAMON mailing list.
As a result, the original news letter has not saved on DAMON maling list
archive.  Forwarding the news letter again with correct recipients fields,
since being late is better than nothing in my opinion.


Thanks,
SJ

=== >8 ===
From: SeongJae Park <sj@kernel.org>
CC: SeongJae Park <sj@kernel.org>, damon@lists.linuxdev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: DAMON Quaterly News Letter (2024 Q2)
Message-Id: <20240701212244.52288-1-sj@kernel.org>
Date: Mon,  1 Jul 2024 14:22:44 -0700
Local-Date: 2024-07-01 14:22:44-07:00

Hello DAMON community,


Time flies.  The second quater of 2024 has passed.  Let me take a time to look
back what happened to DAMON community in the last three months and share my
humble summary with this quaterly news letter.

Highlights of Highlights
========================

DAMON gained a feature [10] for CXL-based tiered memory management.  HacKerMaiL
(hkml), a simple mailing tool that DAMON maintainer is developing, made an
official commitment [12] to support DAMON community.  DAMON has presented and
discussed with more people from OSSummit NA [4] and LSF/MM+BPF [7].  It will
again be presented and discussed with more folks in September [10,13].

Please read below for more highlights for each month.

April 2024
==========

DAMO v2.2.8 has released [1] with memory footprint monitoring feature.

DAMON news letter for 2024-Q1 has posted [2].

Using Oracle's awesome kernel configs comparison tool, we found some dsitros
that enable DAMON on their kernel [3].

DAMON has presented[4] on Open Source Summit North America 2024.  The third
in-person DAMON meetup has also held [5] on the conference.

May 2024
========

Access/Contiguity-aware Memory Auto-scaling second RFC idea with example
implementation is posted [6].

DAMON's status and future plans have shared and discussed on LSFMM+BPF.  LWN's
summary of the session is available [7].

Memory managment subsystem pull request [8] for Linux 6.10-rc1 that contains
DAMOS young page filter has merged.

Beer/Coffee/Tea DAMON meetup has extended [9] for reservation-based ones.

June 2024
=========

DAMON talk for Open Source Summit Europe 2024 has been accepted and
scheduled [10].

SK hynix' patch series titled "DAMON based tiered memory managment for CXL
memory" has been merged [11] into mm-unstable tree.

DAMON community got a simple mailing tool called HacKerMaiL (hkml), which is
officially committed [12] to support the development workflow.

A session for DAMON at kernel summit 2024 has proposed [13] .

Previous news letters
=====================

- 2024 Q1: https://lore.kernel.org/20240402191224.92305-1-sj@kernel.org

More Past DAMON News
====================

If you're interested in a humblie list of more DAMON events that happened in
past and curated by DAMON maintainer, please reach out to the project site's
news page [14].

References
==========

[1] https://github.com/awslabs/damo/blob/v2.2.8/USAGE.md#recording-memory-footprints
[2] https://lore.kernel.org/damon/20240402191224.92305-1-sj@kernel.org/
[3] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON
[4] https://sched.co/1aBOg
[5] https://sched.co/1cP4G
[6] https://lore.kernel.org/20240512193657.79298-1-sj@kernel.org
[7] https://lwn.net/Articles/973702/
[8] https://lore.kernel.org/20240517192239.9285edd85f8ef893bb508a61@linux-foundation.org
[9] https://lore.kernel.org/20240519163329.150340-1-sj@kernel.org
[10] https://sched.co/1ej2S
[11] https://lore.kernel.org/all/20240614185328.BA2C1C2BD10@smtp.kernel.org/
[12] https://lore.kernel.org/20240621163626.74815-2-sj@kernel.org
[13] https://lore.kernel.org/20240614175504.87365-1-sj@kernel.org/
[14] https://sjp38.github.io/post/damon_news/
